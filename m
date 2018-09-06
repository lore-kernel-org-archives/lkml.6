Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08379C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57F020861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57F020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeIFRnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:43:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeIFRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:43:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D8H46303664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:08:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D8HG8303661;
        Thu, 6 Sep 2018 06:08:17 -0700
Date:   Thu, 6 Sep 2018 06:08:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-og4r9k87mzp9hv7el046idmd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        dsahern@gmail.com, mingo@kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com, dsahern@gmail.com,
          mingo@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Make the augmented_syscalls filter out
 the tracepoint event
Git-Commit-ID: 6ccc18a9a17a1189b8b157176ce4a58c458c9eee
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

Commit-ID:  6ccc18a9a17a1189b8b157176ce4a58c458c9eee
Gitweb:     https://git.kernel.org/tip/6ccc18a9a17a1189b8b157176ce4a58c458c9eee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 11:14:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Make the augmented_syscalls filter out the tracepoint event

When we attach a eBPF object to a tracepoint, if we return 1, then that
tracepoint will be stored in the perf's ring buffer. In the
augmented_syscalls.c case we want to just attach and _override_ the
tracepoint payload with an augmented, extended one.

In this example, tools/perf/examples/bpf/augmented_syscalls.c, we are
attaching to the 'openat' syscall, and adding, after the
syscalls:sys_enter_openat usual payload as defined by
/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format, a
snapshot of its sole pointer arg:

  # grep 'field:.*\*' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:const char * filename;	offset:24;	size:8;	signed:0;
  #

For now this is not being considered, the next csets will make use of
it, but as this is overriding the syscall tracepoint enter, we don't
want that event appearing on the ring buffer, just our synthesized one.

Before:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.007 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x216dda8, flags: CLOEXEC                  ) = 3
     0.028 (         ): __augmented_syscalls__:dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.031 ( 0.006 ms): cat/24044 openat(dfd: CWD, filename: 0x2375ce0, flags: CLOEXEC                  ) = 3
     0.291 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/passwd
     0.293 (         ): syscalls:sys_enter_openat:dfd: CWD, filename:
     0.294 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x637db06b                                 ) = 3
  #

After:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC
     0.005 ( 0.015 ms): cat/27341 openat(dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC                 ) = 3
     0.040 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC
     0.041 ( 0.006 ms): cat/27341 openat(dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC                 ) = 3
     0.294 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x482a706b
     0.296 ( 0.067 ms): cat/27341 openat(dfd: CWD, filename: 0x482a706b                                 ) = 3
  #

Now lets replace that __augmented_syscalls__ name with the syscall name,
using:

  # grep 'field:.*syscall_nr' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
  #

That the synthesized payload has exactly where the syscall enter
tracepoint puts it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-og4r9k87mzp9hv7el046idmd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 69a31386d8cd..10e7997ab481 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -49,7 +49,7 @@ int syscall_enter(openat)(struct syscall_enter_openat_args *args)
 	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
 			  &augmented_args, sizeof(augmented_args));
-	return 1;
+	return 0;
 }
 
 license(GPL);
