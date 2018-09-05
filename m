Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E372083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSCDugbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E372083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIFCha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058C52077C;
        Wed,  5 Sep 2018 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185117;
        bh=ASh+v5nnnlj82pAV2VHcQty992/UfKVUDDBNI6g4Zk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSCDugbBn+cpdGcAfp/NmTSgvljjboAsdx/rqdqVrc9J6xBiCafWqxZKqMyCAjdgc
         PldeiwxBjFfjQfRyeil0ZNgB/8CxllR+kFOKaqWSAgGebRfhTuUpwAyeoYfcZdXtUt
         hNj9FOhttobwbta6vyReh9iwqP+Lyq4jGeV2JfoQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/77] perf trace: Introduce augmented_filename_syscall_enter() declarator
Date:   Wed,  5 Sep 2018 19:03:32 -0300
Message-Id: <20180905220440.20256-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

