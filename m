Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9465BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F43D206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F43D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeIFRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:47:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:47:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DBqBi304260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:11:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DBpVT304257;
        Thu, 6 Sep 2018 06:11:51 -0700
Date:   Thu, 6 Sep 2018 06:11:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ls7ojdseu8fxw7fvj77ejpao@git.kernel.org>
Cc:     tglx@linutronix.de, wangnan0@huawei.com, hpa@zytor.com,
        namhyung@kernel.org, acme@redhat.com, dsahern@gmail.com,
        jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
          jolsa@kernel.org, dsahern@gmail.com, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Introduce
 augmented_filename_syscall_enter() declarator
Git-Commit-ID: f6618ce6c024ec90b156700fc39eb313ec117881
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

Commit-ID:  f6618ce6c024ec90b156700fc39eb313ec117881
Gitweb:     https://git.kernel.org/tip/f6618ce6c024ec90b156700fc39eb313ec117881
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 13:44:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Introduce augmented_filename_syscall_enter() declarator

Helping with tons of boilerplate for syscalls that only want to augment
a filename. Now supporting one such syscall is just a matter of
declaring its arguments struct + using:

  augmented_filename_syscall_enter(openat);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ls7ojdseu8fxw7fvj77ejpao@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 78 ++++++++--------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 6ec327850a15..e8486e8597de 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -33,6 +33,25 @@ struct augmented_filename {
 	char	value[256];
 };
 
+#define augmented_filename_syscall_enter(syscall) 							\
+struct augmented_enter_##syscall##_args {			 				\
+	struct syscall_enter_##syscall##_args	args;				 		\
+	struct augmented_filename		filename;				 	\
+};												\
+int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
+{												\
+	struct augmented_enter_##syscall##_args augmented_args = { .filename.reserved = 0, }; 	\
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
+	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
+						      sizeof(augmented_args.filename.value), 	\
+						      args->filename_ptr); 			\
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
+			  &augmented_args, 							\
+			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
+			   augmented_args.filename.size));					\
+	return 0;										\
+}
+
 struct syscall_enter_openat_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
@@ -42,24 +61,7 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-struct augmented_enter_openat_args {
-	struct syscall_enter_openat_args args;
-	struct augmented_filename	 filename;
-};
-
-int syscall_enter(openat)(struct syscall_enter_openat_args *args)
-{
-	struct augmented_enter_openat_args augmented_args = { .filename.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
-						      sizeof(augmented_args.filename.value),
-						      args->filename_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
-	return 0;
-}
+augmented_filename_syscall_enter(openat);
 
 struct syscall_enter_open_args {
 	unsigned long long common_tp_fields;
@@ -69,50 +71,16 @@ struct syscall_enter_open_args {
 	long		   mode;
 };
 
-struct augmented_enter_open_args {
-	struct syscall_enter_open_args args;
-	struct augmented_filename      filename;
-};
-
-int syscall_enter(open)(struct syscall_enter_open_args *args)
-{
-	struct augmented_enter_open_args augmented_args = { .filename.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
-						      sizeof(augmented_args.filename.value),
-						      args->filename_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
-	return 0;
-}
+augmented_filename_syscall_enter(open);
 
 struct syscall_enter_inotify_add_watch_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
 	long		   fd;
-	char		   *pathname_ptr;
+	char		   *filename_ptr;
 	long		   mask;
 };
 
-struct augmented_enter_inotify_add_watch_args {
-	struct syscall_enter_inotify_add_watch_args args;
-	struct augmented_filename		    pathname;
-};
-
-int syscall_enter(inotify_add_watch)(struct syscall_enter_inotify_add_watch_args *args)
-{
-	struct augmented_enter_inotify_add_watch_args augmented_args = { .pathname.reserved = 0, };
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	augmented_args.pathname.size = probe_read_str(&augmented_args.pathname.value,
-						      sizeof(augmented_args.pathname.value),
-						      args->pathname_ptr);
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args,
-			  sizeof(augmented_args) - sizeof(augmented_args.pathname.value) + augmented_args.pathname.size);
-	return 0;
-}
+augmented_filename_syscall_enter(inotify_add_watch);
 
 license(GPL);
