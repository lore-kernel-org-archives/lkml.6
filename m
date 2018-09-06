Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A5C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A25F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeIFSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:22:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeIFSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:22:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DjpS2310927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:45:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Djo2W310924;
        Thu, 6 Sep 2018 06:45:50 -0700
Date:   Thu, 6 Sep 2018 06:45:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jtsapwibyxrnv1xjfsgzp0fj@git.kernel.org>
Cc:     adrian.hunter@intel.com, yhs@fb.com, dsahern@gmail.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, daniel@iogearbox.net, namhyung@kernel.org
Reply-To: wangnan0@huawei.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          yhs@fb.com, acme@redhat.com, dsahern@gmail.com, hpa@zytor.com,
          jolsa@kernel.org, namhyung@kernel.org, daniel@iogearbox.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Check probe_read_str()
 return separately
Git-Commit-ID: 21d7eb9a24739cdc5ea19c90a79e5a585866ba35
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

Commit-ID:  21d7eb9a24739cdc5ea19c90a79e5a585866ba35
Gitweb:     https://git.kernel.org/tip/21d7eb9a24739cdc5ea19c90a79e5a585866ba35
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 3 Sep 2018 15:02:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 3 Sep 2018 15:13:33 -0300

perf augmented_syscalls: Check probe_read_str() return separately

Using a value returned from probe_read_str() to tell how many bytes to
copy using perf_event_output() has issues in some older kernels, like
4.17.17-100.fc27.x86_64, so separate the bounds checking done on how
many bytes to copy to a separate variable, so that the next patch has
only what is being done to make the test pass on older BPF validators.

For reference, see the discussion in this thread:

  https://www.spinics.net/lists/netdev/msg480099.html

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-jtsapwibyxrnv1xjfsgzp0fj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 1419a9186937..0decbcfa8b90 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -33,9 +33,9 @@ struct syscall_exit_args {
 };
 
 struct augmented_filename {
-	int	size;
-	int	reserved;
-	char	value[256];
+	unsigned int	size;
+	int		reserved;
+	char		value[256];
 };
 
 #define augmented_filename_syscall(syscall)							\
@@ -46,14 +46,15 @@ struct augmented_enter_##syscall##_args {			 				\
 int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 {												\
 	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
+	unsigned int len = sizeof(augmented_args);						\
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
 	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
 						      sizeof(augmented_args.filename.value), 	\
 						      args->filename_ptr); 			\
+	if (augmented_args.filename.size < sizeof(augmented_args.filename.value))		\
+		len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;	\
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
-			  &augmented_args, 							\
-			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
-			   augmented_args.filename.size));					\
+			  &augmented_args, len);						\
 	return 0;										\
 }												\
 int syscall_exit(syscall)(struct syscall_exit_args *args)					\
