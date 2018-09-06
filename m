Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093120857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2093120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeIFRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:50:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbeIFRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:50:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DF5I0304901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:15:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DF42g304896;
        Thu, 6 Sep 2018 06:15:04 -0700
Date:   Thu, 6 Sep 2018 06:15:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8bdqv1q0ndcjl1nqns5r5je2@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        namhyung@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        wangnan0@huawei.com, mingo@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, wangnan0@huawei.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
          dsahern@gmail.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Add
 augmented_sockaddr_syscall_enter()
Git-Commit-ID: 24a6c2cd1dbd85bd5624a6d0b05de891d0f07696
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

Commit-ID:  24a6c2cd1dbd85bd5624a6d0b05de891d0f07696
Gitweb:     https://git.kernel.org/tip/24a6c2cd1dbd85bd5624a6d0b05de891d0f07696
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 Aug 2018 16:39:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf trace augmented_syscalls: Add augmented_sockaddr_syscall_enter()

From the one for 'connect', so that we can use it with sendto and others
that receive a 'struct sockaddr'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8bdqv1q0ndcjl1nqns5r5je2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 46 ++++++++++++++++------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 6dfead0be74e..5f417e528419 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -95,6 +95,31 @@ struct syscall_enter_newstat_args {
 
 augmented_filename_syscall_enter(newstat);
 
+#ifndef _K_SS_MAXSIZE
+#define _K_SS_MAXSIZE 128
+#endif
+
+#define augmented_sockaddr_syscall_enter(syscall)						\
+struct augmented_enter_##syscall##_args {			 				\
+	struct syscall_enter_##syscall##_args	args;				 		\
+	struct sockaddr_storage			addr;						\
+};												\
+int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
+{												\
+	struct augmented_enter_##syscall##_args augmented_args;				 	\
+	unsigned long addrlen = sizeof(augmented_args.addr);					\
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);			\
+/* FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK */		\
+/*	if (addrlen > augmented_args.args.addrlen)				     */		\
+/*		addrlen = augmented_args.args.addrlen;				     */		\
+/*										     */		\
+	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 				\
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
+			  &augmented_args, 							\
+			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
+	return 0;										\
+}
+
 struct sockaddr;
 
 struct syscall_enter_connect_args {
@@ -105,25 +130,6 @@ struct syscall_enter_connect_args {
 	unsigned long	   addrlen;
 };
 
-struct augmented_enter_connect_args {
-	struct syscall_enter_connect_args args;
-	struct sockaddr_storage		  addr;
-};
-
-int syscall_enter(connect)(struct syscall_enter_connect_args *args)
-{
-	struct augmented_enter_connect_args augmented_args;
-	unsigned long addrlen = sizeof(augmented_args.addr);
-
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-#ifdef FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK
-	if (addrlen > augmented_args.args.addrlen)
-		addrlen = augmented_args.args.addrlen;
-#endif
-	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, 
-			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);
-	return 0;
-}
+augmented_sockaddr_syscall_enter(connect);
 
 license(GPL);
