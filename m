Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UlnRNsVDGVtZDAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A2400607E7; Thu,  7 Jun 2018 14:40:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB0FD601C3;
	Thu,  7 Jun 2018 14:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB0FD601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934485AbeFGOkb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40549 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932912AbeFGOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:27 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbv-0005Zm-BL; Thu, 07 Jun 2018 15:09:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002lQ-QQ; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Wang Nan" <wangnan0@huawei.com>,
        "David Ahern" <dsahern@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Bram Stolk" <b.stolk@gmail.com>, "Andi Kleen" <ak@linux.intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.188121986@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 066/410] perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC}
 with --delay
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit d3dbf43c56f9176be325ce1cc72a44c8d3c210dc upstream.

When we use an initial delay, e.g.: 'perf record --delay 1000', we do not
enable the events until that delay has passed after we started the workload,
including the tracking event, i.e. the one for which we have attr.mmap, etc,
enabled to ask the kernel to generate the PERF_RECORD_{MMAP,COMM,EXEC} metadata
events that will then allow us to resolve addresses in samples to the map, dso
and symbol. There will be a shadow that even synthesizing samples won't cover,
i.e. the workload that we start and other processes forking while we
wait for the initial delay to expire.

So use a dummy event to be the tracking one and make it be enabled on exec.

Before:

  # perf record --delay 1000 stress --cpu 1 --timeout 5
  stress: info: [9029] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9029] successful run completed in 5s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.624 MB perf.data (15908 samples) ]
  # perf script | head
      :9031 9031 32001.826888:       1 cycles:ppp: ffffffff831aa30d event_function (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826893:       1 cycles:ppp: ffffffff8300d1a0 intel_bts_enable_local (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826895:       7 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826897:     103 cycles:ppp: ffffffff8300c331 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826899:    1615 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826902:   26724 cycles:ppp: ffffffff8384c6a7 native_irq_return_iret (/lib/modules/4.14.0-rc6+/build/vmlinux)
      :9031 9031 32001.826913:  329739 cycles:ppp:     7fb2a5410932 [unknown] ([unknown])
      :9031 9031 32001.827033: 1225451 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
      :9031 9031 32001.827474: 1391725 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
      :9031 9031 32001.827978: 1233697 cycles:ppp:     7fb2a5410928 [unknown] ([unknown])
  #

After:

  # perf record --delay 1000 stress --cpu 1 --timeout 5
  stress: info: [9741] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9741] successful run completed in 5s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.751 MB perf.data (15976 samples) ]
  # perf script | head
     stress  9742 32110.959106:          1 cycles:ppp:  ffffffff831b26f6 __perf_event_task_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959110:       1 cycles:ppp: ffffffff8300c2e9 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959112:       7 cycles:ppp: ffffffff830231e0 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959115:     101 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959117:    1533 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959119:   23992 cycles:ppp: ffffffff831b0900 ctx_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
     stress 9742 32110.959129:  329406 cycles:ppp:     7f4b1b661930 __random_r (/usr/lib64/libc-2.25.so)
     stress 9742 32110.959249: 1288322 cycles:ppp:     5566e1e7cbc9 hogcpu (/usr/bin/stress)
     stress 9742 32110.959712: 1464046 cycles:ppp:     7f4b1b66179e __random (/usr/lib64/libc-2.25.so)
     stress 9742 32110.960241: 1266918 cycles:ppp:     7f4b1b66195b __random_r (/usr/lib64/libc-2.25.so)
  #

Reported-by: Bram Stolk <b.stolk@gmail.com>
Tested-by: Bram Stolk <b.stolk@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 6619a53ef757 ("perf record: Add --initial-delay option")
Link: http://lkml.kernel.org/n/tip-nrdfchshqxf7diszhxcecqb9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 3.16:
 - Don't set perf_evsel::tracking fields
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -140,6 +140,19 @@ static int record__open(struct record *r
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
 
+	/*
+	 * For initial_delay we need to add a dummy event so that we can track
+	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
+	 * real events, the ones asked by the user.
+	 */
+	if (opts->initial_delay) {
+		if (perf_evlist__add_dummy(evlist))
+			return -ENOMEM;
+
+		pos = perf_evlist__last(evlist);
+		pos->attr.enable_on_exec = 1;
+	}
+
 	perf_evlist__config(evlist, opts);
 
 	evlist__for_each(evlist, pos) {
