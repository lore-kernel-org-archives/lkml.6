Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629222077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdkrv2KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeIFCiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeIFCiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:06 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F2C20652;
        Wed,  5 Sep 2018 22:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185154;
        bh=yjdjdpNxb89Nyrv0jmX4CWa9+202tJP1jdNRZ8WTDD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mdkrv2KMCsMyqiBvxysCvZAX+US41XM97rJVgiOn2usP3zqqhHmg8aN0obUJeUyNN
         k9APMAkQlh/mUWzlGsaVIFg+keXHu7Qbw/VDkNzBsEDOMWQL5AQyHOYRLP+cG2tkTN
         W5hemQTdREZbrleJsEzAuRDRDunZ++n/xFQw5hxM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 23/77] perf trace augmented_syscalls: Rename augmented_*_syscall__enter to just *_syscall
Date:   Wed,  5 Sep 2018 19:03:46 -0300
Message-Id: <20180905220440.20256-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll also hook into the syscalls:sys_exit_SYSCALL for which there
are enter hooks.

This way we'll be able to iterate the ELF file for the eBPF program,
find the syscalls that have hooks and filter them out from the general
raw_syscalls:sys_{enter,exit} tracepoint for not-yet-augmented (the ones
with pointer arguments not yet being attached to the usual syscalls
tracepoint payload) and non augmentable syscalls (syscalls without
pointer arguments).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cl1xyghwb1usp500354mv37h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index bfa28eaf27b3..253b3ccbd17d 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -32,7 +32,7 @@ struct augmented_filename {
 	char	value[256];
 };
 
-#define augmented_filename_syscall_enter(syscall)						\
+#define augmented_filename_syscall(syscall)							\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct augmented_filename		filename;				 	\
@@ -60,7 +60,7 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(openat);
+augmented_filename_syscall(openat);
 
 struct syscall_enter_open_args {
 	unsigned long long common_tp_fields;
@@ -70,7 +70,7 @@ struct syscall_enter_open_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(open);
+augmented_filename_syscall(open);
 
 struct syscall_enter_inotify_add_watch_args {
 	unsigned long long common_tp_fields;
@@ -80,7 +80,7 @@ struct syscall_enter_inotify_add_watch_args {
 	long		   mask;
 };
 
-augmented_filename_syscall_enter(inotify_add_watch);
+augmented_filename_syscall(inotify_add_watch);
 
 struct statbuf;
 
@@ -91,13 +91,13 @@ struct syscall_enter_newstat_args {
 	struct stat	   *statbuf;
 };
 
-augmented_filename_syscall_enter(newstat);
+augmented_filename_syscall(newstat);
 
 #ifndef _K_SS_MAXSIZE
 #define _K_SS_MAXSIZE 128
 #endif
 
-#define augmented_sockaddr_syscall_enter(syscall)						\
+#define augmented_sockaddr_syscall(syscall)						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct sockaddr_storage			addr;						\
@@ -128,7 +128,7 @@ struct syscall_enter_bind_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(bind);
+augmented_sockaddr_syscall(bind);
 
 struct syscall_enter_connect_args {
 	unsigned long long common_tp_fields;
@@ -138,7 +138,7 @@ struct syscall_enter_connect_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(connect);
+augmented_sockaddr_syscall(connect);
 
 struct syscall_enter_sendto_args {
 	unsigned long long common_tp_fields;
@@ -151,6 +151,6 @@ struct syscall_enter_sendto_args {
 	long		   addr_len;
 };
 
-augmented_sockaddr_syscall_enter(sendto);
+augmented_sockaddr_syscall(sendto);
 
 license(GPL);
-- 
2.14.4

