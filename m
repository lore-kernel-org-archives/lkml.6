Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5977218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbeLTSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:25:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeLTSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:25:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIOtOH3685886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:24:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIOtN23685883;
        Thu, 20 Dec 2018 10:24:55 -0800
Date:   Thu, 20 Dec 2018 10:24:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lw3i2atyq8549fpqwmszn3qp@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
        lclaudio@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, lclaudio@redhat.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          hpa@zytor.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Copy 'access' arg as
 well
Git-Commit-ID: c48ee107bb387f76b089e0c30e1fed26e8d921f0
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

Commit-ID:  c48ee107bb387f76b089e0c30e1fed26e8d921f0
Gitweb:     https://git.kernel.org/tip/c48ee107bb387f76b089e0c30e1fed26e8d921f0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 11:59:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:18 -0300

perf augmented_raw_syscalls: Copy 'access' arg as well

This will all come from userspace, but to test the changes to make 'perf
trace' output similar to strace's, do this one more now manually.

To update the precompiled augmented_raw_syscalls.o binary I just run:

  # perf record -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB perf.data ]
  #

Because to have augmented_raw_syscalls to be always used and a fast
startup and remove the need to have the llvm toolchain installed, I'm
using:

  # perf config | grep add_events
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

So when doing changes to augmented_raw_syscals.c one needs to rebuild
the .o file.

This will be done automagically later, i.e. have a 'make' behaviour of
recompiling when the .c gets changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-lw3i2atyq8549fpqwmszn3qp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 6c5db6baeb3a..53c233370fae 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -55,6 +55,7 @@ struct augmented_filename {
 };
 
 #define SYS_OPEN 2
+#define SYS_ACCESS 21
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -119,6 +120,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
+	case SYS_ACCESS:
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
