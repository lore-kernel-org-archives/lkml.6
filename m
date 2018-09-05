Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2491D20867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUH328xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2491D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeIFCkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeIFCkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E93220839;
        Wed,  5 Sep 2018 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185291;
        bh=2ccCmedq/akhotJr6EgqLmC5fee7v91d0BjkFlafK1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUH328xfwqP7QLn+GOh2KGeQYG18j6x8DzlUt2EZVR4ZDMrIoNL0MwbRVKTNUbk7v
         qJKUKATePqCBqjs0GuKobTrMBj2Tp+TjlUlAYWYaFHp/66pSIE1re38DIeEojeoFhN
         lXjtLqa3mWuYmzW0bbEOsSmvxWk62Samfg/2NEDo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 71/77] perf augmented_syscalls: Check probe_read_str() return separately
Date:   Wed,  5 Sep 2018 19:04:34 -0300
Message-Id: <20180905220440.20256-72-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

