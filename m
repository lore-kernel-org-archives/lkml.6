Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0C214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTV/ND/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED0C214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeJHWih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbeJHWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A682089D;
        Mon,  8 Oct 2018 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012381;
        bh=4oFR1r4Rg19huhhjFCNss0diV4LwGgMfLyqId/iWh+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTV/ND/AtWjqNq0p9xABZ3Ffxt5t1le2FiaCQE+GkoP6PAvrMySnIgECCVQ6SoZgK
         PeDVISz+VSLHvY2IxrkEVUjL64py2VaUzRyb9jHKjEVMnefmSc0n1+FZsVlqJrAodI
         AUuvRB+vJ/qUbyjDT8332IDOG2F+CN5VqSSj8HDg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kairui Song <kasong@redhat.com>, Borislav Petkov <bp@suse.de>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org,
        dyoung@redhat.com, bhe@redhat.com, ghook@redhat.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 58/58] x86/boot: Fix kexec booting failure in the SEV bit detection code
Date:   Mon,  8 Oct 2018 11:25:23 -0400
Message-Id: <20181008152523.70705-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@redhat.com>

[ Upstream commit bdec8d7fa55e6f5314ed72e5a0b435d90ff90548 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
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

