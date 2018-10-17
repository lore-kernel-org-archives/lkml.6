Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A283EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600EA21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600EA21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQRAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:00:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeJQRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:00:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MavF5-1ffHbm01Ih-00cQ44; Wed, 17 Oct 2018 11:04:25 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MavF5-1ffHbm01Ih-00cQ44; Wed, 17 Oct 2018 11:04:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org, stefan@agner.ch,
        ulli.kroll@googlemail.com, joel@jms.id.au,
        linux-kernel@vger.kernel.org, roman@advem.lv,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [ALTERNATIVE] ARM: fix copypage functions for clang
Date:   Wed, 17 Oct 2018 11:04:17 +0200
Message-Id: <20181017090417.833924-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
References: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
X-Provags-ID: V03:K1:wE3FaQ+yc4pwSsDb2NlwO9LLQ1ELz82dI2Rvv5Xrw0zOIiAf2N9
 ifBJXOMrMV+hFejpLtA1kbJbqPWveuSLuqbsjkbUBZH3YftQgHkBUEvJJ+kGk2qU946S5vb
 JEuzl0wIIR8HxQUN+vAdTXYEf/+GD4bubSONu3ZjmZTKhhdujfWP1TpaLfAQnpKfsu2cMZf
 67xLlCgGeifxY0S7gS8tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AJfKk7AcN8s=:VgnMTMoeDfCNXdgBzvXitZ
 YeudGOFr7VhsHJ72GsAMSrwQQcpQDahYYpM+Q47CNeq+wtJFGjR6N8ZRQWNtEcIvsRgAHhkN4
 2bU9BNMAkLrWyWWhc782QNcjkl9Pqkz+FjfDQz9uGumsrBPiPsWqKxT5K4FKdPdLcBZbfSpHr
 K8bCztjKKYw8lUzhEAfUM5JV3024AXM5a5bZyChX+6iDnBudqmOcgfyvdSSolkkBvvosVNUVd
 IRcJuW+377z2lrNU9dy7k0IWQ9igvYp0KBRychn5BsocmgR9S9VH1+MRNRA/myvih9U+iVXKe
 zIy+kcFJHW2PbQH/vgGqzWPd1vs/O2pMFAKSa26QwoHGzvHYUbcYNFPe4JGOB0/VLkQsYCnJX
 nSFFpl74IJmikt2wXsQ8a4PKe7baRHRFMWzMozYMtpBbaf5ks6CDJX5edP3a64vdOJ6SL23sr
 ciUp8+bOzJPdm8B19mAIGJl4+ga8SjObDj1kvZ4T3MlExEfeeprt7x1g1R+emJCeeFNnYA664
 4XpWBSJNK/wRvL3KnbECOi8/vwmbIWdDbWx9jwSKhSWABk+xAunPd5ro1A4Vs+rmLyZ4L3Js1
 xqEaQfjT7WIFgFnxbMsDDO5rQtNYQgFANgkVaZC5cTzoxNsvIcNHMFj6m9T3z53JCk8zRnyIw
 mUwZgLLd4JSb5rEi+dh5FUQ1C3P0rJEsUuuC4AcxYMGWRbwJEZoVFRpk5I1jeSJKVLd8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that a naked function should not pass
the function arguments into the inline assembly:

arch/arm/mm/copypage-feroceon.c:67:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4mc.c:64:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-v4wt.c:43:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-xsc3.c:70:9: error: parameter references not allowed in naked functions
arch/arm/mm/copypage-xscale.c:84:9: error: parameter references not allowed in naked functions

The constraints were originally added in commit 9a40ac86152c ("ARM:
6164/1: Add kto and kfrom to input operands list.") as a gcc-4.5
workaround. Another workaround for the same problem was added in commit
9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone and noinline
on __naked functions") and should have obsoleted the first one. That
workaroud was subsequently reverted in commit d124b44f09ca ("Compiler
Attributes: naked was fixed in gcc 4.6") as we raised the minimum compiler
level to gcc-4.6.

Remove the extraneous references and use the register numbers
consistently as required by clang.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've used this on my randconfig build setup, and it makes all
configurations build without warnings, but I have not done
any runtime testing on it.
---
 arch/arm/mm/copypage-feroceon.c |  4 ++--
 arch/arm/mm/copypage-v4mc.c     | 26 +++++++++++++-------------
 arch/arm/mm/copypage-v4wb.c     |  4 ++--
 arch/arm/mm/copypage-v4wt.c     |  4 ++--
 arch/arm/mm/copypage-xsc3.c     |  6 +++---
 arch/arm/mm/copypage-xscale.c   |  4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 49ee0c1a7209..e69bf2f15f32 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -18,7 +18,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4-r9, lr}		\n\
-	mov	ip, %2				\n\
+	mov	ip, %0				\n\
 1:	mov	lr, r1				\n\
 	ldmia	r1!, {r2 - r9}			\n\
 	pld	[lr, #32]			\n\
@@ -64,7 +64,7 @@ feroceon_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
 	ldmfd	sp!, {r4-r9, pc}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
+	: "I" (PAGE_SIZE));
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 0224416cba3c..5c70e48ad833 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -45,23 +45,23 @@ mc_copy_user_page(void *from, void *to)
 {
 	asm volatile(
 	"stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r4, %2				@ 1\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4+1\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	mov	r4, %0				@ 1\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
+1:	mcr	p15, 0, r1, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4+1\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
+	mcr	p15, 0, r1, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmia	r0!, {r2, r3, ip, lr}		@ 4\n\
 	subs	r4, r4, #1			@ 1\n\
-	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
-	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
+	stmia	r1!, {r2, r3, ip, lr}		@ 4\n\
+	ldmneia	r0!, {r2, r3, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 067d0fdd630c..7ea9cf07bd5c 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -27,7 +27,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
+	mov	r2, %0				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
@@ -44,7 +44,7 @@ v4wb_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
 	ldmfd	 sp!, {r4, pc}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index b85c5da2e510..c742ab24efd6 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -25,7 +25,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
+	mov	r2, %0				@ 1\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
 1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
 	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
@@ -40,7 +40,7 @@ v4wt_copy_user_page(void *kto, const void *kfrom)
 	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
 	ldmfd	sp!, {r4, pc}			@ 3"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	: "I" (PAGE_SIZE / 64));
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 03a2042aced5..9944bdb4721d 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -34,8 +34,8 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
 	asm("\
 	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-						\n\
+	mov	lr, %0				\n\
+					\n\
 	pld	[r1, #0]			\n\
 	pld	[r1, #32]			\n\
 1:	pld	[r1, #64]			\n\
@@ -67,7 +67,7 @@ xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 						\n\
 	ldmfd	sp!, {r4, r5, pc}"
 	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	: "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 97972379f4d6..ef52a052d9bb 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -45,7 +45,7 @@ mc_copy_user_page(void *from, void *to)
 	 */
 	asm volatile(
 	"stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
+	mov	lr, %0				\n\
 	pld	[r0, #0]			\n\
 	pld	[r0, #32]			\n\
 	pld	[r1, #0]			\n\
@@ -81,7 +81,7 @@ mc_copy_user_page(void *from, void *to)
 	beq	2b				\n\
 	ldmfd	sp!, {r4, r5, pc}		"
 	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
+	: "I" (PAGE_SIZE / 64 - 1));
 }
 
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
-- 
2.18.0

