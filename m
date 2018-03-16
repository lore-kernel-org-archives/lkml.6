Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214698-2-714456892555621601
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
    t=1521214697; b=SaxNu7PPhiKTVrszmb3EIx/PSk8g5M1Movl9hiyli0mOlcm
    7y8QfDWXaeYBvQcqVNfakU2YayIyiYsEINc0cpSgOQTVEGf66Ar8YRUUQ33mnw3K
    5WzZlYKgCmNdd9a4WFQWeKQ0L8ywAtMdQOgrM/m0T7Vdoals9Z7X5zWcScPcTG9z
    RvVaAaovsskOEAk0xVUcxAGlemD3srOHLqhdqDWRl9mbBsahTY5JjFGyL6kniL3g
    9AO3TWgf6WzPFICphGTnzPOaIxBn7Vy2QevYgw+xHX0LPPr9dQ1yalNgyLuRUHCa
    9+cTRAnM1NG236+I4T5Gm0JOHEM8NlNc7iKqBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214697; bh=KEgIYKDexd1wTh0pkBQzTSiBkh
    tHLTIO/B4/R0Ocpmw=; b=jRy2tZoIYoGQ1xZl9Qf+M5URtE6XkmXf2BHMaSAPBh
    rV5gGKnvSposWQ6n67YplzM1eofX81Mi+qO6scwFlLuPkDWkWjy9oSTLwJvv9KiH
    heq+8e1r3HByNJAK5sf+ijjgqDjwaIA1UtZPUFjZCbVdbwjMkeF3pN4kHVYaD7zp
    UpdW+F4tLxWL2Px9417F/Psd2SjUXOu8vLegADScvRSFJ7oz1Q3DaiD2R549qdHV
    x6z6jYoBAq5nPwHxdaanmC0SA5NsFe3R2cIV6+edieNCVKky79StSFxPRKhd9WS5
    nVjQ/wdQQZRI76zCYu5HQBptZBPBfx3vTRU29ySaDlUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1754469AbeCPPiN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:38:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPPiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:38:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 094/109] powerpc/64: Dont trace irqs-off at interrupt return to soft-disabled context
Date: Fri, 16 Mar 2018 16:24:03 +0100
Message-Id: <20180316152335.018699164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
