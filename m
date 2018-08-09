Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECBC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F9F21C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwIIvoKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F9F21C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeHIIA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:00:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbeHIIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:00:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so2276960pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUVZraVYSlqqIRwCZ0bLejzyYZFNdfTPMp8RLGQyfZo=;
        b=WwIIvoKXC0SFnvJe3FUyuZQaOX/Zd15nPAEG6QJXTsqL+Dq3VTUAZKDwEFr4FF+dcd
         iCcbA/SsqiIx5WJ+jTVM85EqmXsZ1tE8X3N41E0TNPLAA4UbhOY88qV6z9fMUHasOTj6
         c3XsBdeGhIMdkIDnD0yJXbaECmvx+Tt+W4f4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUVZraVYSlqqIRwCZ0bLejzyYZFNdfTPMp8RLGQyfZo=;
        b=lm6WJYLIfc4GBLfmZgXeYPz1lw1aeF1cdJdMjl3G1GKh1JtagZC9Tksf44k5xElAwJ
         t01mNrnhIOJ1o7FZpFw9UTiBqFtGm0n1qNYo8VR6oGKrEQPhxJowLyUQDdqgHQquqWRZ
         2gD2lKrZXCjESaqPyCM0EiBbfz6MS+D0chHN270iIGOEhg12F+y69rzmpMGHA7MpFn2e
         NhLpnM11stCb6yjF8MV0LNOl+EaaqI0/ipRkc3n4EFhiibl9owhXXfJcA0ORCyeCUveG
         +4+C/PL5KABsFX3X/yvSGVHKaSdQuAAxqvyzD/Yqr5L/Qx/siktJXIry3K6Cb67zQcLi
         UPYQ==
X-Gm-Message-State: AOUpUlHBt8P5UShunteRbCvWd0KVukdnKY0eq24sKLKI7Uv9kMObuqzB
        3o8NAsf04uIkEQbya82UElWVuA==
X-Google-Smtp-Source: AA+uWPzaUy7/v1YbBwN7N4RlMSxb8dT7KCWKAYTo2V2EL0ugiYY0caNw/GDbIeOa+jWc4Pgtm3XxUA==
X-Received: by 2002:a63:121a:: with SMTP id h26-v6mr718889pgl.316.1533793042255;
        Wed, 08 Aug 2018 22:37:22 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r11-v6sm5826229pgn.62.2018.08.08.22.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:37:21 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] sh: Rename NR_syscalls macro to __NR_syscalls
Date:   Thu,  9 Aug 2018 11:06:43 +0530
Message-Id: <1533793005-4525-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533793005-4525-1-git-send-email-firoz.khan@linaro.org>
References: <1533793005-4525-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in SH arch-
itecture. One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the total number of system call information, which will
be used to update NR_syscalls.

The macro name also changed form NR_syscalls to __NR_syscalls for
making the name convention same across all architecture. While
__NR_syscalls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sh/include/asm/ftrace.h         | 2 +-
 arch/sh/include/uapi/asm/unistd_32.h | 2 +-
 arch/sh/include/uapi/asm/unistd_64.h | 2 +-
 arch/sh/kernel/cpu/sh5/entry.S       | 2 +-
 arch/sh/kernel/entry-common.S        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index b1c1dc0..968a9bb 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -5,7 +5,7 @@
 #ifdef CONFIG_FUNCTION_TRACER
 
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
-#define FTRACE_SYSCALL_MAX	NR_syscalls
+#define FTRACE_SYSCALL_MAX	__NR_syscalls
 
 #ifndef __ASSEMBLY__
 extern void mcount(void);
diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index 58f04cf..2c4f087 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -396,6 +396,6 @@
 #define __NR_preadv2		381
 #define __NR_pwritev2		382
 
-#define NR_syscalls 383
+#define __NR_syscalls 383
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index 6f809a5..9e6e8cb 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -416,6 +416,6 @@
 #define __NR_preadv2		392
 #define __NR_pwritev2		393
 
-#define NR_syscalls 394
+#define __NR_syscalls 394
 
 #endif /* __ASM_SH_UNISTD_64_H */
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index 0c8d037..d2ff022 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -1192,7 +1192,7 @@ system_call:
 	STI()
 
 	pta	syscall_allowed, tr0
-	movi	NR_syscalls - 1, r4	/* Last valid */
+	movi	__NR_syscalls - 1, r4	/* Last valid */
 	bgeu/l	r4, r5, tr0
 
 syscall_bad:
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 28cc612..80ea3c4 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -396,7 +396,7 @@ syscall_exit:
 #if !defined(CONFIG_CPU_SH2)
 1:	.long	TRA
 #endif
-2:	.long	NR_syscalls
+2:	.long	__NR_syscalls
 3:	.long	sys_call_table
 7:	.long	do_syscall_trace_enter
 8:	.long	do_syscall_trace_leave
-- 
1.9.1

