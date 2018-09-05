Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF260C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9652E2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEoW242G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9652E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeIFChp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:44 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E722073D;
        Wed,  5 Sep 2018 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185133;
        bh=nnaSol8PjHTgHNMe4LHQtUuf5KuQcsHtsDHGnZGssUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEoW242GzcUjq37xJKx/P3oJs5I1p8fToj5/exLyu3S7Jc9vdBiMLY6mQHEHNbV5T
         EdOEIWg+Ii60l7zxx62fJeq9agFO2X9opWH6rmjFIpaWML7+FgXfQaRdXQTWrzdxMT
         9EzLPPvNvSjlUgnNWyITSnSgE1H6ZH/mp+qgMgxs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/77] perf trace augmented_syscalls: Add augmented_sockaddr_syscall_enter()
Date:   Wed,  5 Sep 2018 19:03:38 -0300
Message-Id: <20180905220440.20256-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

