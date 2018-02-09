Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518183649-3-14601338706706226855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518183648; b=L3cC5ocVAMKfqy++Ms0kbVxGdewgdC1TA1QgLN7qoniBQC8
    7j8LpLD1SkhSj1kWudTvSQUVTaxz4ZhtulFdD4C3ae42C7jkcKxvkG9Rd6GOKyVW
    owi7DHHtXJ6l+1Ff/vb+0svpror0HWj/DCep8JCOCzQl8aqdO/wCRFI4y4IBhkb/
    ilFF/GyIs1kfsviRJ9P+O8HmjOcoUJgPYYE1EFe91vniKPXGZf3OcIyHsy4MWiVA
    20rkhuhcgt/7+abI993kqIxeA1nE7DDSbV48rTzIjyURTwuSt8Q6tmVLWJAWAIqM
    t2WsvJOcOMMohCR2Ms/w1zgHsKdlzCXMUBWW7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518183648; bh=gB7IYVRxzOJ+sGLaG2xZ6PwKKu
    lDoWq9sr8tFpjIuWo=; b=ihAyzwLKjdscVTbUE3/wqmAIIAzh15P6El8pRIVxs9
    IIOL15MfZnjTMZjY5QTaYaTlPps6EEFDzGMoQsmFzOtK6oLBgbFaNiUG6Ffa0dDl
    89XJgccgIa4p78KmdA0EfebJyT7tOquRqBae53Bmu0NjcxQueQG+5XNjSoV7u+ZC
    3EANnwocXS7nHr3etrJNj1aqJqWW59PPHhhLOjPmA3i8tbrcUK0w1COfUjlhwQ2D
    wIG3o2AAM0xvrQKQGBjpYKUkXu0f2Z6XiONHRP0fJjCkq5Iy/ml3ME0rjwCdHLm5
    so4YU+/EJp+0kZscoIJFPbiiY+Iar/0Gj676UEHQZ/nA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBINkp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:40:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBINkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 04/92] powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL
Date: Fri,  9 Feb 2018 14:38:33 +0100
Message-Id: <20180209133931.554992184@linuxfoundation.org>
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

commit b8e90cb7bc04a509e821e82ab6ed7a8ef11ba333 upstream.

In the syscall exit path we may be returning to user or kernel
context. We already have a test for that, because we conditionally
restore r13. So use that existing test and branch, and bifurcate the
return based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_64.S |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -251,13 +251,23 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
+	ld	r2,GPR2(r1)
+	ld	r1,GPR1(r1)
+	mtlr	r4
+	mtcr	r5
+	mtspr	SPRN_SRR0,r7
+	mtspr	SPRN_SRR1,r8
+	RFI_TO_USER
+	b	.	/* prevent speculative execution */
+
+	/* exit to kernel */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
-	RFI
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 syscall_error:	
