Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA44C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CF72070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfACNK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:10:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:10:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DA6F21383676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:10:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DA5Lx1383668;
        Thu, 3 Jan 2019 05:10:05 -0800
Date:   Thu, 3 Jan 2019 05:10:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3ft5rjdl05wgz2pwpx2z8btu@git.kernel.org>
Cc:     wangnan0@huawei.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        lclaudio@redhat.com, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: jolsa@kernel.org, tglx@linutronix.de, lclaudio@redhat.com,
          acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Check if the
 raw_syscalls:sys_{enter,exit} are setup before setting tp filter
Git-Commit-ID: f76214f93783f9f902954cf6e57fd818c4bffe29
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f76214f93783f9f902954cf6e57fd818c4bffe29
Gitweb:     https://git.kernel.org/tip/f76214f93783f9f902954cf6e57fd818c4bffe29
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 19 Dec 2018 10:01:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 21 Dec 2018 09:42:46 -0300

perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter

While updating 'perf trace' on an machine with an old precompiled
augmented_raw_syscalls.o that didn't setup the syscall map the new 'perf
trace' codebase notices the augmented_raw_syscalls.o eBPF event, decides
to use it instead of the old raw_syscalls:sys_{enter,exit} method, but
then because we don't have the syscall map tries to set the tracepoint
filter on the sys_{enter,exit} evsels, that are NULL, segfaulting.

Make the code more robust by checking it those tracepoints have
their respective evsels in place before trying to set the tp filter.

With this we still get everything to work, just not setting up the
syscall filters, which is better than a segfault. Now to update the
precompiled augmented_raw_syscalls.o and continue development :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3ft5rjdl05wgz2pwpx2z8btu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ebde59e61133..6689c1a114fe 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2686,7 +2686,9 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	if (trace->syscalls.map)
 		return trace__set_ev_qualifier_bpf_filter(trace);
-	return trace__set_ev_qualifier_tp_filter(trace);
+	if (trace->syscalls.events.sys_enter)
+		return trace__set_ev_qualifier_tp_filter(trace);
+	return 0;
 }
 
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
