Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720247-2-15795197718519460657
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
    t=1518720247; b=lC7zzXmkzo9TuW/sfhSKzTv4AlNMBd6kn+Qt4QAgql3fFP+
    v3DLCT7hK73gt5txNMYPtgNUzSwjJR64+oN4oTBAqWYsvuYJGsD3FfQ5di9nwTH9
    JcIh9GTxlzecbaOEP+pHbKqmpjZtlkC3GN3BFqN+GCnQl1cyXpDJk8tmNmZvi4Ym
    z4P9igLg0jFZBehPiPsgTFkxjzKmtcgV9wEZWKxVAI8hQIjxLekDmAMNUUTPgCna
    +kqk3bljP2YV6qZImaVwS9r+uScqMa81GPPOBdFiTML41SPUppGns0YUJsuVF91H
    nUQfxkO9Kqz2372Kz42x3ELDArEHpM5yOhq6rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720247; bh=fa/gcb5jsb4LvJlWOwU2tJLpNw
    vmws8gZFseG6E5xaw=; b=psFuXSH1ISfMW76+u8fjnVgNFAKU+VbgJVOdjCS/uy
    nrk1irp52AjNSKsyltXYAsdfFGRWqrYsdljIbLnLi5B1zmgPnEa4kYImE6mYE6Gv
    +dR3nQBopYpXEMXAB01r1sS+ouHfT+PXmXXRUqFS4xZRQmSf4z4w5cscO8YR46TD
    e5sq0Wd1xEB/0pjXzDYlOsEMrUVPGEo8n5kO6QlGzSH5S+abeMON9bQgDTHsHKzs
    /jhZQ00oYrG4DAHYpyL5pKxwqcgVYQtqSvwpXza5jjsp0fOz+aybLp2qx3WlB04l
    wQveKSx5inENWkK0uwItkAifoE8SEl9E7+V4tErvDCBA==
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
        id S1162622AbeBOSnx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:43:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162408AbeBOPXO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 009/108] powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL
Date: Thu, 15 Feb 2018 16:16:06 +0100
Message-Id: <20180215151223.697415821@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -230,13 +230,23 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECK
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	HMT_MEDIUM_LOW_HAS_PPR
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
