Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600522168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600522168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeI0S5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:57:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeI0S5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 047CF307D867;
        Thu, 27 Sep 2018 12:38:57 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3BB461168;
        Thu, 27 Sep 2018 12:38:50 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        bp@suse.de, kasong@redhat.com, kexec@lists.infradead.org,
        dyoung@redhat.com, bhe@redhat.com, ghook@redhat.com
Subject: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot support
Date:   Thu, 27 Sep 2018 20:38:45 +0800
Message-Id: <20180927123845.32052-1-kasong@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 27 Sep 2018 12:38:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1958b5fc4010 ("x86/boot: Add early boot support when running
with SEV active") is causing kexec becomes sometimes unstable even if
SEV is not active. kexec reboot won't start a second kernel bypassing
BIOS boot process, instead, the system got reset.

That's because, in get_sev_encryption_bit function, we are using
32-bit RIP-relative addressing to read the value of enc_bit, but
kexec may alloc the early boot up code to a higher location, which
is beyond 32-bit addressing limit. Some garbage will be read and
get_sev_encryption_bit will return the wrong value, which leads to
wrong memory page flag.

This patch removes the use of enc_bit, as currently, enc_bit's only
purpose is to avoid duplicated encryption bit reading, but the overhead
of reading encryption bit is so tiny, so no need to cache that.

Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
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
-- 
2.17.1

