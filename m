Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720811-2-17782833437028173686
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
    t=1518720811; b=OXOQCDslVU5lJnurH0J++tckxKV1a16SDtQ2McD8uh505H6
    EjN2/vrkGQGJkwpD1g4yZr/Wa8z+NzUJQi9IcHkQV/9Je1pW7h6S3a2JLhsybaep
    YhNxy/LuJbMM4GzIGwVMuLlCVphclc/r0udR/xNs7WD+WrvGEY5GtRHOgiT0xw50
    5FSYZkOi5w6XIeH2KS6Mu/WLUSmWSS7SzAhvr5ZfxPLMYfY9JNE0DRbcb1EKMR4i
    leu8Ix0hrl67SSTbPyytD5EriFShQ6uGmlFESbckI2WJHDa9hwMrLrtAOchPkAHm
    KHQEsSv0UKfls5V/hcWrVVVAo6WpcS06opSY88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720811; bh=dSvUav4O4IfTdiKk7fxc/87cvs
    jOlNMBjONxUkvXSEk=; b=J32PiwW2Bpzc9C8oYN3LlGZ5fhe4t8ihMFtdN4y3eS
    stn7XWOxJPbx9vo5JDN2bSMxL9zeeWpKV0qDNPtoTvUNbACPCqVJKcBLyTHeNreF
    GmNiVpshhqXouT/RB82nLe8M5FXpmdzvhTF38eij6oJOOx8ULlJiLfmEFBSqJJ9J
    F790oSdwPJcZaC55xc8Vkppn54O+m9/TzsxnVtb0Klf4s4kvp1lBaNR/hCH1pDDt
    VahrlXBESrr58ItYzTS+pS6HeC/ih3Yl25HJf/Nm1rONHMq4h6EMl4MZAYgfzRH6
    ZFs5vAQcedmQTHmkrirVoV9c2szF806VjhyH7fcIlctw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161120AbeBOPVG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161956AbeBOPVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 008/108] powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL
Date: Thu, 15 Feb 2018 16:16:05 +0100
Message-Id: <20180215151223.508675841@linuxfoundation.org>
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

commit a08f828cf47e6c605af21d2cdec68f84e799c318 upstream.

Similar to the syscall return path, in fast_exception_return we may be
returning to user or kernel context. We already have a test for that,
because we conditionally restore r13. So use that existing test and
branch, and bifurcate the return based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_64.S |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -891,7 +891,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
 	REST_GPR(13, r1)
-1:
+
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -904,8 +904,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
 	ld	r1,GPR1(r1)
+	RFI_TO_USER
+	b	.	/* prevent speculative execution */
 
-	rfid
+1:	mtspr	SPRN_SRR1,r3
+
+	ld	r2,_CCR(r1)
+	mtcrf	0xFF,r2
+	ld	r2,_NIP(r1)
+	mtspr	SPRN_SRR0,r2
+
+	ld	r0,GPR0(r1)
+	ld	r2,GPR2(r1)
+	ld	r3,GPR3(r1)
+	ld	r4,GPR4(r1)
+	ld	r1,GPR1(r1)
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 #endif /* CONFIG_PPC_BOOK3E */
