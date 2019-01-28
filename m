Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5085C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF70C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QNSUVJ62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfA1LLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:11:22 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32089 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfA1LLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:11:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43p6Pp5YL3z9v1qC;
        Mon, 28 Jan 2019 12:11:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QNSUVJ62; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BJ7zfPWyLM80; Mon, 28 Jan 2019 12:11:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Pp4MXKz9v1q3;
        Mon, 28 Jan 2019 12:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548673870; bh=QbZgLz+KBI+o6ZgRCiv2+UEBD8YC+qJe6rkAkJpJNVk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=QNSUVJ62Gg29Gu0y8Z81cRMRVFfE+2VCVMrHAwOSKEy4owG4u4uahl4OAZPhdybSY
         JgzIp5fO2SdlKlbJ9Cp6749ar+odTMdmWV3aCjoa4xCqRx7R3r0/nnv7pgwdL2O7ej
         CZaeUNrwdepdisw79bryq0ZoVw2XCDmqg1auBOo4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A7178B79D;
        Mon, 28 Jan 2019 12:11:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PTQI0kKahZtl; Mon, 28 Jan 2019 12:11:17 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 041088B796;
        Mon, 28 Jan 2019 12:11:17 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 06BAC72DE6; Mon, 28 Jan 2019 11:11:17 +0000 (UTC)
Message-Id: <e58c3c430c40da2ca0bbf735d33ecdd6cca67561.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/11] powerpc/32: Add a macro for setting MSR_RI in
 EXCEPTION_PROLOG_2
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jan 2019 11:11:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting MSR_RI applies to head_32 and head_8xx, but not to
head_40x. So in order to refactor EXCEPTION_PROLOG for 40x too,
this patch adds a macro for setting MSR_RI.

In the meantime, this gives the opportunity to make it
simpler on the 8xx as writing in SPRN_EID sets MSR_RI.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  | 2 ++
 arch/powerpc/kernel/head_32.h  | 7 +++++--
 arch/powerpc/kernel/head_8xx.S | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index a5efcdc78e8e..edc5e78faf08 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -37,6 +37,8 @@
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
 
+#define SET_AND_STORE_MSR_RI(reg)	li reg,MSR_KERNEL & ~(MSR_IR|MSR_DR); MTMSRD(reg)
+
 #include "head_32.h"
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 7356c27d2136..9e6fb9d468f0 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -4,6 +4,10 @@
 
 #include <asm/ptrace.h>	/* for STACK_FRAME_REGS_MARKER */
 
+#ifndef SET_AND_STORE_MSR_RI
+#define SET_AND_STORE_MSR_RI(reg)
+#endif
+
 /*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
@@ -44,8 +48,7 @@
 	stw	r1,GPR1(r11);	\
 	stw	r1,0(r11);	\
 	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
+	SET_AND_STORE_MSR_RI(r10);	/* can take exceptions */ \
 	stw	r0,GPR0(r11);	\
 	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d9c5bc48bef0..00dacec2b0d1 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -36,6 +36,8 @@
 .macro DO_KVM intno
 .endm
 
+#define SET_AND_STORE_MSR_RI(reg)	mtspr	SPRN_EID, reg
+
 #include "head_32.h"
 
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
-- 
2.13.3

