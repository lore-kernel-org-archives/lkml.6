Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547692188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547692188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeHROsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:48:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:48:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBfLoN1287760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:41:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBfLrs1287757;
        Sat, 18 Aug 2018 04:41:21 -0700
Date:   Sat, 18 Aug 2018 04:41:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-r6ba5izrml82nwfmwcp7jpkm@git.kernel.org>
Cc:     jolsa@kernel.org, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Wire up the augmented syscalls with
 the syscalls:sys_enter_FOO beautifier
Git-Commit-ID: 88cf7084f9b4b3744294b438884c2b7999b0200a
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

Commit-ID:  88cf7084f9b4b3744294b438884c2b7999b0200a
Gitweb:     https://git.kernel.org/tip/88cf7084f9b4b3744294b438884c2b7999b0200a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 7 Aug 2018 16:26:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:59 -0300

perf trace: Wire up the augmented syscalls with the syscalls:sys_enter_FOO beautifier

We just check that the evsel is the one we associated with the
bpf-output event associated with the "__augmented_syscalls__" eBPF map,
to show that the formatting is done properly:

  # perf trace -e perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.007 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC                 ) = 3
     0.029 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.031 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC                 ) = 3
     0.249 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xc3700d6
     0.250 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0xc3700d6
     0.252 ( 0.003 ms): cat/11486 openat(dfd: CWD, filename: 0xc3700d6                                  ) = 3
  #

Now we just need to get the full blown enter/exit handlers to check if the
evsel being processed is the augmented_syscalls one to go pick the pointer
payloads from the end of the payload.

We also need to state somehow what is the layout for multi pointer arg syscalls.

Also handy would be to have a BTF file with the struct definitions used in
syscalls, compact, generated at kernel built time and available for use in eBPF
programs.

Till we get there we can go on doing some manual coupling of the most relevant
syscalls with some hand built beautifiers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r6ba5izrml82nwfmwcp7jpkm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 06215acb1481..22ab8e67c760 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2042,7 +2042,10 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		bpf_output__fprintf(trace, sample);
+		if (evsel == trace->syscalls.events.augmented)
+			trace__fprintf_sys_enter(trace, evsel, sample);
+		else
+			bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
