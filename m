Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185877-2-16675860149621154182
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
    t=1518185877; b=Vo/seEAh9135Nzvo6NBl+JpoNXyqnNCqm6SgdBd3WFZmdQT
    lI+uQvpGYo047quDZdsAtxQPFSokDy18q2ZtuFupPGsVwBFfzGbSUoJpY8RLlpe1
    aJ/taYeH786OfauVJMJGK4gAesA0ApKulfBhdUcuKd5e1j/seFLdYvjRm3E3OEJH
    rqbe/VQbMPUBHi1WcEMEET00ua/yEAUHepTManL5S8fTikyP81H5Lyt7ZalrhsZn
    BhZh3ueTaQjySms+cGDIwjXV/u/bIQIfWmGq24RTPdot+sdDcqHZo7KhuIWpYUZD
    IlOBo3zUiOKTT40FukJ/Hw1xXLw5ntAIXPGxS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185877; bh=o2pekvyzS7CfKxZKeONDPqQqPG
    PVSx0ZWOO8EU2JcjE=; b=qiFinqtcBNsPoaI8uhWNCiSyF9GinzekaE4lkRcm0g
    6b+ybPi0uLxqHDePc0OwnlRq4fq7p+IAus/XdTZ9xWzBtxeHig70CTqtexMXDjyu
    19P9g5prk0gbeAx2B0dHKttTdGTn+4AQ/pX6pSZmreNzuzSOCKZZ8Zx9AxYGE7CG
    TVd7Y/MRjxY0AC4WEk7OCC84HWS9FdjDAj6NIg6/uqLgJSH5+zyNBFchsxtxvu/0
    9+z1NkgAICfMOWnUGlARMsIRCj+WxQV1QmrhW3ofsBSR8hukoGov9IH3OcVpy19V
    En02wfR1uDtzJqe/tpSiIpXvvJ+6r31HssnBz7uJerpw==
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
        id S1752408AbeBIORl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:17:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeBINkk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 03/92] powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL
Date: Fri,  9 Feb 2018 14:38:32 +0100
Message-Id: <20180209133931.435462954@linuxfoundation.org>
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
@@ -859,7 +859,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
-1:
+
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -872,8 +872,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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
