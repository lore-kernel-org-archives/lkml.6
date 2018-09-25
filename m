Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A120843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8A120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeIYRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeIYRTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:19:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D474462EAB;
        Tue, 25 Sep 2018 11:12:39 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2811081316;
        Tue, 25 Sep 2018 11:12:33 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        bp@suse.de, kasong@redhat.com, kexec@lists.infradead.org,
        dyoung@redhat.com
Subject: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot support
Date:   Tue, 25 Sep 2018 19:10:20 +0800
Message-Id: <20180925111020.23834-1-kasong@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 25 Sep 2018 11:12:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1958b5fc4010 ("x86/boot: Add early boot support when running
with SEV active") is causing kexec becomes sometimes unstable, kexec
reboot won't start a second kernel bypassing BIOS boot process, instead,
the system got reset.

That's because, in get_sev_encryption_bit function, we are using
32-bit RIP-relative addressing to read the value of enc_bit, but
kexec may alloc the early boot up code to a higher location, which
is beyond 32-bit addressing limit. Some garbage will be read and
get_sev_encryption_bit will return the wrong value, which lead to
wrong memory page flag.

This patch adds a get_sev_encryption_bit_64 function to avoid this
problem. 64-bit early boot code will use this function instead, it
uses native RIP addressing to read the enc_bit which have no problem
with any location.

Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/boot/compressed/mem_encrypt.S | 64 ++++++++++++++++++--------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index eaa843a52907..41933550449a 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -18,27 +18,13 @@
 
 	.text
 	.code32
-ENTRY(get_sev_encryption_bit)
+do_get_sev_encryption_bit:
 	xor	%eax, %eax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
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
@@ -69,25 +55,65 @@ ENTRY(get_sev_encryption_bit)
 
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
 
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
+
+	ret
+
+ENTRY(get_sev_encryption_bit)
+	xor	%eax, %eax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	push	%edi
+
+	/*
+	 * RIP-relative addressing is needed to access the encryption bit
+	 * variable. Since we are running in 32-bit mode we need this call/pop
+	 * sequence to get the proper relative addressing.
+	 */
+	call	1f
+1:	popl	%edi
+	subl	$1b, %edi
+
+	movl	enc_bit(%edi), %eax
+	cmpl	$0, %eax
+	jge 2f
+
+	call    do_get_sev_encryption_bit
+	movl	%eax, enc_bit(%edi)
+2:
+	pop	%edi
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 	ret
 ENDPROC(get_sev_encryption_bit)
 
 	.code64
+ENTRY(get_sev_encryption_bit_64)
+	xor	%rax, %rax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	movl	enc_bit(%rip), %eax
+	cmpl	$0, %eax
+	jge 1f
+
+	call    do_get_sev_encryption_bit
+	movl	%eax, enc_bit(%rip)
+1:
+#endif	/* CONFIG_AMD_MEM_ENCRYPT */
+
+	ret
+ENDPROC(get_sev_encryption_bit_64)
+
 ENTRY(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
@@ -95,7 +121,7 @@ ENTRY(set_sev_encryption_mask)
 
 	movq	%rsp, %rbp		/* Save current stack pointer */
 
-	call	get_sev_encryption_bit	/* Get the encryption bit position */
+	call	get_sev_encryption_bit_64	/* Get the encryption bit position */
 	testl	%eax, %eax
 	jz	.Lno_sev_mask
 
-- 
2.17.1

