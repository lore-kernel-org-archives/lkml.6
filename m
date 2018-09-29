Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911E520652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911E520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeI3AzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:55:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3AzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:55:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g6Jw4-0006mB-CV; Sat, 29 Sep 2018 20:25:48 +0200
Subject: [GIT pull] x86 fix for 4.19
Message-ID: <153824547597.23234.3630779580341862623.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <153824547597.23234.11668873233247402922.tglx@nanos.tec.linutronix.de>
Date:   Sat, 29 Sep 2018 20:25:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A single fix for the AMD memory encryption boot code so it does not read
random garbage instead of the cached encryption bit when a kexec kernel is
allocated above the 32bit address limit.

Thanks,

	tglx

------------------>
Kairui Song (1):
      x86/boot: Fix kexec booting failure in the SEV bit detection code


 arch/x86/boot/compressed/mem_encrypt.S | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index eaa843a52907..a480356e0ed8 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -25,20 +25,6 @@ ENTRY(get_sev_encryption_bit)
 	push	%ebx
 	push	%ecx
 	push	%edx
-	push	%edi
-
-	/*
-	 * RIP-relative addressing is needed to access the encryption bit
-	 * variable. Since we are running in 32-bit mode we need this call/pop
-	 * sequence to get the proper relative addressing.
-	 */
-	call	1f
-1:	popl	%edi
-	subl	$1b, %edi
-
-	movl	enc_bit(%edi), %eax
-	cmpl	$0, %eax
-	jge	.Lsev_exit
 
 	/* Check if running under a hypervisor */
 	movl	$1, %eax
@@ -69,15 +55,12 @@ ENTRY(get_sev_encryption_bit)
 
 	movl	%ebx, %eax
 	andl	$0x3f, %eax		/* Return the encryption bit location */
-	movl	%eax, enc_bit(%edi)
 	jmp	.Lsev_exit
 
 .Lno_sev:
 	xor	%eax, %eax
-	movl	%eax, enc_bit(%edi)
 
 .Lsev_exit:
-	pop	%edi
 	pop	%edx
 	pop	%ecx
 	pop	%ebx
@@ -113,8 +96,6 @@ ENTRY(set_sev_encryption_mask)
 ENDPROC(set_sev_encryption_mask)
 
 	.data
-enc_bit:
-	.int	0xffffffff
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8

