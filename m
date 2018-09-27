Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304AE215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304AE215F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeI1B07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:26:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1B07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:26:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RJ6vC0134335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 12:06:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RJ6uvf134332;
        Thu, 27 Sep 2018 12:06:56 -0700
Date:   Thu, 27 Sep 2018 12:06:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-bdec8d7fa55e6f5314ed72e5a0b435d90ff90548@git.kernel.org>
Cc:     kasong@redhat.com, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, bp@suse.de, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
          thomas.lendacky@amd.com, kasong@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180927123845.32052-1-kasong@redhat.com>
References: <20180927123845.32052-1-kasong@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Fix kexec booting failure in the SEV bit
 detection code
Git-Commit-ID: bdec8d7fa55e6f5314ed72e5a0b435d90ff90548
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bdec8d7fa55e6f5314ed72e5a0b435d90ff90548
Gitweb:     https://git.kernel.org/tip/bdec8d7fa55e6f5314ed72e5a0b435d90ff90548
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Thu, 27 Sep 2018 20:38:45 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 19:35:03 +0200

x86/boot: Fix kexec booting failure in the SEV bit detection code

Commit

  1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")

can occasionally cause system resets when kexec-ing a second kernel even
if SEV is not active.

That's because get_sev_encryption_bit() uses 32-bit rIP-relative
addressing to read the value of enc_bit - a variable which caches a
previously detected encryption bit position - but kexec may allocate
the early boot code to a higher location, beyond the 32-bit addressing
limit.

In this case, garbage will be read and get_sev_encryption_bit() will
return the wrong value, leading to accessing memory with the wrong
encryption setting.

Therefore, remove enc_bit, and thus get rid of the need to do 32-bit
rIP-relative addressing in the first place.

 [ bp: massage commit message heavily. ]

Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: brijesh.singh@amd.com
Cc: kexec@lists.infradead.org
Cc: dyoung@redhat.com
Cc: bhe@redhat.com
Cc: ghook@redhat.com
Link: https://lkml.kernel.org/r/20180927123845.32052-1-kasong@redhat.com
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
