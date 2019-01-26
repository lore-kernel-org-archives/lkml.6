Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5010EC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2000B21726
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfAZKMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:12:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:12:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QACAeX514154
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:12:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QAC969514151;
        Sat, 26 Jan 2019 02:12:09 -0800
Date:   Sat, 26 Jan 2019 02:12:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0tjwcit8qitsmh4nyvf2b0jo@git.kernel.org>
Cc:     mingo@kernel.org, lclaudio@redhat.com, jolsa@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com
Reply-To: jolsa@kernel.org, lclaudio@redhat.com, mingo@kernel.org,
          wangnan0@huawei.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Fixup etcsnoop example
Git-Commit-ID: 1d59cb1bbd4cbe5a8f8032242cdacea5658129cf
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

Commit-ID:  1d59cb1bbd4cbe5a8f8032242cdacea5658129cf
Gitweb:     https://git.kernel.org/tip/1d59cb1bbd4cbe5a8f8032242cdacea5658129cf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 15:39:15 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:11 +0100

perf trace: Fixup etcsnoop example

Where we don't have "raw_syscalls:sys_enter", so we need to look for a
"*syscalls:sys_enter*" to initialize the offsets for the
__augmented_syscalls__ evsel, which is the case with etcsnoop, that was
segfaulting, fixed:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): gnome-shell/2105 openat(dfd: CWD, filename: "/etc/localtime")                       ...
   631.834 (         ): cat/6521 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
   632.637 (         ): bash/6521 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b9b6a2ea2baf ("perf trace: Do not hardcode the size of the tracepoint common_ fields")
Link: https://lkml.kernel.org/n/tip-0tjwcit8qitsmh4nyvf2b0jo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..1447993e1ee3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3854,7 +3854,8 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+			if (trace.syscalls.events.augmented->priv == NULL &&
+			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
 				struct perf_evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
