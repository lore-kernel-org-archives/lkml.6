Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215540-2-2134079488416962573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215539; b=oAvq/GvbTinXL0esAq/vLHO3rawWw1O9IQzzo6v/ePttHts
    V495/dUqwT2p8IVitORPCXhpUJCZ+9W5yYrOBLeiKciuezdC/D9y5y+XtG+WpfmZ
    E77jg0I9mcPkfb0yA0UpIk54uAMh5nA03hFOyUcel5moRCtO0KLjqzB/C0F20+cp
    2x5E2XMvCtpPJVfqzeVCySBe1uMc403NtJ9FrhIrkLIu41OudRSuv9667oP8I4qG
    j9DVSmMR0Z0Mj34uH6iWfr4vYBFpBkqF81A630m+dCptjzOLmSCl1HMUxHniQR3i
    2nBDChxx75R2Fosep+mbGSUAmYLWReQBjJMB7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215539; bh=q56fqQirj/EjTXBckbsDXNtO8w
    EZqL+uNYq5i0b2Amk=; b=OAOljrflI84wHENiGpdouBHqc/gBY0HP1xqzos8RSR
    32mbiQbCKzpd7PKFrVc5el4UGqAokACKgJDpEwgazroUlNa4PO+dohGlB5XneVM/
    olhDIMBbFaDUkNHz2TGNqt0ev+mzT5Tit+du7Vc8JwWHTd3mairMU/ARXoxnvWW3
    M2/tQbu2V88g2egQbqj+91wDKhlRE6+OaPv0wpMflC2t+jDXAnIQFcEAfy1l5Kw6
    di8xgutH9RMbvDfU4yxCcMqwo+BgOsg8HxPH5pZTgDdmJ2XdE8/cJzy7qI/8q4qA
    cG9vIzDTxhLSsbq4ShCTPCDeIhxgUCZJ2+BUczOtP8NA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965414AbeCPPoZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:44:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964834AbeCPPoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 113/128] powerpc/64: Dont trace irqs-off at interrupt return to soft-disabled context
Date: Fri, 16 Mar 2018 16:24:14 +0100
Message-Id: <20180316152342.149010619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>


[ Upstream commit acb1feab320e38588fccc568e3767761f494976f ]

When an interrupt is returning to a soft-disabled context (which can
happen for non-maskable interrupts or synchronous interrupts), it goes
through the motions of soft-disabling again, including calling
TRACE_DISABLE_INTS (i.e., trace_hardirqs_off()).

This is not necessary, because we must already be soft-disabled in the
interrupt context, it also may be causing crashes in the irq tracing
code to re-enter as an nmi. Replace it with a warning to ensure that
soft-interrupts are still disabled.

Fixes: 7c0482e3d055 ("powerpc/irq: Fix another case of lazy IRQ state getting out of sync")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_64.S |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -939,9 +939,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13);
-	TRACE_DISABLE_INTS
+1:
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+	/* The interrupt should not have soft enabled. */
+	lbz	r7,PACASOFTIRQEN(r13)
+1:	tdnei	r7,0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
+#endif
 	b	.Ldo_restore
 
 	/*
