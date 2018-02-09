Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185830-5-8880318489212751440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185829; b=JNGBUETYCbOIjYeRooilm06si5711ohIXpgEinLqy4V6+Zx
    c1si+B0BttQxcVY45bvUnbB0nU5JOox8niZxMRITGBy2QoJi6o7jZIcRjL2Mr48m
    1aVXe3gVMn//Z96jGQ+lE7XBjgDzcJzYATLwhAuLaap0aSptD8TVjx4H5dGUxVEh
    RoloeM9almcaldWjd5cY5qZzgd/XOsUhp51L2ijPNZCbtIa+I6KRSnzPbJkXbQF1
    Uns2xV0AeLFHajPeMPtI/MwRz/Br5O5iE5MhxB8apiZdkZiVjY4kZRY2pxR1WzCS
    XkV/AaDQ2ejX47JN5HcabHQRKG/Nro0hOpIVn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185829; bh=tUf098qNjlY/u8w9/O4D+a0pME
    8C9bIEMUjbbRzyCZU=; b=YKsQCpFysmd/m1k0aOsAJKFV69u40Gm/bRlHcqjf59
    YPz0e+yatQJzJk9ZaBzmiHijHGodfk/nVKTHzVY0tpC96zCs8wVHWfUSIxcGhjL7
    yVFiUhGSNJJTOYqxgMO5Q1nCSITAmMBBPz7bEJobVCSBuRy+ZLb+CikKEmgeutc5
    Uk069op0Os/bjkBBpt4COJNFPJM75y3lNZAVFrrQj1KekQwga++iW3agqbGcwe26
    Gm5z9C96jFwovEIZs/Q70Gunp+raPOS4DBgwkBYszA7C46hfAL3Fpwq4amxJ4eiJ
    jQzM1T6RqPRSPrA2k98Nw8s0izihef0C+XXBxEiqqmSQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBINks (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:40:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBINkq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 05/92] powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL
Date: Fri,  9 Feb 2018 14:38:34 +0100
Message-Id: <20180209133931.683041548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c7305645eb0c1621351cfc104038831ae87c0053 upstream.

In the SLB miss handler we may be returning to user or kernel. We need
to add a check early on and save the result in the cr4 register, and
then we bifurcate the return path based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Backport to 4.4 based on patch from Balbir]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -655,6 +655,8 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_R
 
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
+	andi.	r10,r12,MSR_PR	/* check for user mode (PR != 0) */
+	bne	1f
 
 	/* All done -- return from exception. */
 
@@ -671,7 +673,23 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_R
 	ld	r11,PACA_EXSLB+EX_R11(r13)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
+	RFI_TO_KERNEL
+	b	.	/* prevent speculative execution */
+
+1:
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
+
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
 2:	mfspr	r11,SPRN_SRR0
@@ -679,7 +697,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_R
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 8:	mfspr	r11,SPRN_SRR0
