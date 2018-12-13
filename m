Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00416C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13D020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3XDd+Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13D020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLMJIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45903 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeLMJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:08:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so751519plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rU0gk7hC5OI7CZ52UOe6mv3nED6+D6wIX2KCfJFy6io=;
        b=j3XDd+XxodEjM1gZV3hozEvfjM5kpnKur2kK4gWra0dyNx4p9Y9YvHDE7LnUYaNUZ8
         6fa09rwN0AGpv1qWmreFaZv8IZ3zNvaV9ZpMOj/KN7oXSraNhpWAf3pqax36XKDpMdSh
         8oPvxBKMyt8C4xhQHwZro+nyAG5y9bz33W2Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rU0gk7hC5OI7CZ52UOe6mv3nED6+D6wIX2KCfJFy6io=;
        b=eDk2gV+fQUYyqUa5NbBfeyNuz7lkjJO2kDVv9vgQ5qYqWyK481v/xo3rDyxFisWAat
         40urqVBh0OS0kziOIR+Tz0H9YVIT1t3XZlU9xb71Q5cObtn3EAg/B1zK+01dRwpzemqu
         /YJGqds7ww6tJcVRif/KWaZDyBOBjtNd+2HT4QLq/1aNaTV63QfinwwPURgboEW/RyJQ
         oblN0NBFVeMwL4PwbBhBYkyxrjArsTaDng8exZ+BmGaZqGLhpYfFPy3yc06qEBdEZByI
         in8SbxO5w0LI3ClwGnzvMzEOhmxdmBvVIFi8DamQBk0QWE0rMliNqVEATNMgYFmTUyLC
         EAZg==
X-Gm-Message-State: AA+aEWZucd831Yt4oqyxJF1wHWTPcyNQIFoyU1IbXTsSV4WbYJRDWqms
        oyedgrjDvt0KPouVp4WxgtM+nA==
X-Google-Smtp-Source: AFSGD/WM/1Nnxp8BrD2CFlPKyjK6EFSjQNkSptiN0Ipx67M/oIXS+H+4wc/4bhBgcAnKJXKhcoDzoQ==
X-Received: by 2002:a17:902:28c1:: with SMTP id f59mr22911296plb.37.1544692117973;
        Thu, 13 Dec 2018 01:08:37 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:37 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 4/7] mips: add +1 to __NR_syscalls in uapi header
Date:   Thu, 13 Dec 2018 14:37:36 +0530
Message-Id: <1544692059-9728-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other architectures are hold a value for __NR_syscalls will
be equal to the last system call number +1.

But in mips architecture, __NR_syscalls hold the value equal to
total number of system exits in the architecture. One of the
patch in this patch series will genarate uapi header files.

In order to make the implementation common across all architect-
ures, add +1 to __NR_syscalls, which will be equal to the last
system call number +1.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 12 ++++++------
 arch/mips/kernel/ftrace.c           |  6 +++---
 arch/mips/kernel/scall32-o32.S      |  4 ++--
 arch/mips/kernel/scall64-n32.S      |  4 ++--
 arch/mips/kernel/scall64-n64.S      |  2 +-
 arch/mips/kernel/scall64-o32.S      |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index baea6e4..e4a7b46 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -392,13 +392,13 @@
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			368
+#define __NR_syscalls			369
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls		369
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -737,13 +737,13 @@
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			328
+#define __NR_syscalls			329
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_N64_Linux			5000
-#define __NR_N64_Linux_syscalls		328
+#define __NR_N64_Linux_syscalls		329
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1086,12 +1086,12 @@
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			332
+#define __NR_syscalls			333
 #endif
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		333
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index d91a6e7..be8e69f 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -400,13 +400,13 @@ unsigned long __init arch_syscall_addr(int nr)
 unsigned long __init arch_syscall_addr(int nr)
 {
 #ifdef CONFIG_MIPS32_N32
-	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
+	if (nr >= __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Linux_syscalls)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_N64_Linux  && nr <= __NR_N64_Linux + __NR_N64_Linux_syscalls)
+	if (nr >= __NR_N64_Linux  && nr < __NR_N64_Linux + __NR_N64_Linux_syscalls)
 		return (unsigned long)sys_call_table[nr - __NR_N64_Linux];
 #ifdef CONFIG_MIPS32_O32
-	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
+	if (nr >= __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Linux_syscalls)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
 #endif
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fea6edb..10f6367 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -86,7 +86,7 @@ loads_done:
 	bnez	t0, syscall_trace_entry # -> yes
 syscall_common:
 	subu	v0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, v0, __NR_O32_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	sll	t0, v0, 2
@@ -182,7 +182,7 @@ illegal_syscall:
 
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	sll	t1, t0, 2
 	beqz	v0, einval
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c65eaac..6468546 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -33,7 +33,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 #endif
 
 	dsubu	t0, v0, __NR_N32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_N32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_N32_Linux_syscalls
 
 #ifndef CONFIG_MIPS32_O32
 	ld	t1, PT_EPC(sp)		# skip syscall on return
@@ -87,7 +87,7 @@ n32_syscall_trace_entry:
 	ld	a5, PT_R9(sp)
 
 	dsubu	t2, v0, __NR_N32_Linux	# check (new) syscall number
-	sltiu   t0, t2, __NR_N32_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_N32_Linux_syscalls
 	beqz	t0, not_n32_scall
 
 	j	syscall_common
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 497cd62..0bded19 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 syscall_common:
 	dsubu	t2, v0, __NR_N64_Linux
-	sltiu   t0, t2, __NR_N64_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_N64_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 73913f0..eb53d8ea 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -34,7 +34,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	ld	t1, PT_EPC(sp)		# skip syscall on return
 
 	dsubu	t0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	daddiu	t1, 4			# skip to next instruction
 	sd	t1, PT_EPC(sp)
 	beqz	t0, not_o32_scall
@@ -144,7 +144,7 @@ trace_a_syscall:
 	ld	a7, PT_R11(sp)		# For indirect syscalls
 
 	dsubu	t0, v0, __NR_O32_Linux	# check (new) syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, not_o32_scall
 
 	j	syscall_common
@@ -193,7 +193,7 @@ not_o32_scall:
 
 LEAF(sys32_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	dsll	t1, t0, 3
 	beqz	v0, einval
-- 
1.9.1

