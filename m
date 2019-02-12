Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E39EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B0222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hME3mkaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfBLUCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:02:25 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43802 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfBLUB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:01:59 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F340E5C0E10;
        Tue, 12 Feb 2019 21:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1550001718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bun+cvAdHIasxPqS/vNFHAp3EC4NvD/DWIC9oBLQ0+E=;
        b=hME3mkazxA/uN2rYhG6PjJfFHgpovUyK2UqrrxrEZ+CKhap4wiXYyE2SrMD5kp7qtSHpW5
        VRuXPcsUg4FrnolQWFcpWT06Pikhi/BeppsKBjPfPHFC9F4jBbJ3YT63dxzuxmuXhexd4z
        4xik/Z/5bZW3igCUOeJUEXju9IQiZY4=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH v3 4/5] ARM: use unified assembler in c files
Date:   Tue, 12 Feb 2019 21:02:00 +0100
Message-Id: <a0aa512943024821fae210854b89ac0f430f388a.1550001435.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550001435.git.stefan@agner.ch>
References: <cover.1550001435.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unified assembler syntax (UAL) in inline assembler. Divided
syntax is considered deprecated. This will also allow to build
the kernel using LLVM's integrated assembler.

When compiling non-Thumb2 GCC always emits a ".syntax divided"
at the beginning of the inline assembly which makes the
assembler fail. Since GCC 5 there is the -masm-syntax-unified
GCC option which make GCC assume unified syntax asm and hence
emits ".syntax unified" even in ARM mode. However, the option
is broken since GCC version 6 (see GCC PR88648 [1]). Work
around by adding ".syntax unified" as part of the inline
assembly.

[0] https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#index-masm-syntax-unified
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
Changes in v2:
- Force unified syntax for inline assembler using .syntax unified
Changes in v3:
- Describe reason for adding ".syntax unified"

 arch/arm/mm/copypage-v4mc.c | 3 ++-
 arch/arm/mm/copypage-v4wb.c | 3 ++-
 arch/arm/mm/copypage-v4wt.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index b03202cddddb..f74cdce6d4da 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -45,6 +45,7 @@ static void mc_copy_user_page(void *from, void *to)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
@@ -56,7 +57,7 @@ static void mc_copy_user_page(void *from, void *to)
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ "
 	: "+&r" (from), "+&r" (to), "=&r" (tmp)
 	: "2" (PAGE_SIZE / 64)
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index cd3e165afeed..6d336740aae4 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,6 +27,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
@@ -38,7 +39,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index 8614572e1296..3851bb396442 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,6 +25,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	int tmp;
 
 	asm volatile ("\
+	.syntax unified\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -34,7 +35,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
 	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	subs	%2, %2, #1			@ 1\n\
 	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
 	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
-- 
2.20.1

