Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD52C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966486AbeFRI1k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:27:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965883AbeFRI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3176CCA8;
        Mon, 18 Jun 2018 08:27:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 261/279] ARM: davinci: dm646x: fix timer interrupt generation
Date:   Mon, 18 Jun 2018 10:14:06 +0200
Message-Id: <20180618080619.516461584@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 73d4337ed9ceddef4b2f0e226634d5f985aa2d1c ]

commit b38434145b34 ("ARM: davinci: irqs: Correct McASP1 TX interrupt
definition for DM646x") inadvertently removed priority setting for
timer0_12 (bottom half of timer0). This timer is used as clockevent.

When INTPRIn register setting for an interrupt is left at 0, it is
mapped to FIQ by the AINTC causing the timer interrupt to not get
generated.

Fix it by including an entry for timer0_12 in interrupt priority map
array. While at it, move the clockevent comment to the right place.

Fixes: b38434145b34 ("ARM: davinci: irqs: Correct McASP1 TX interrupt definition for DM646x")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/dm646x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -495,7 +495,8 @@ static u8 dm646x_default_priorities[DAVI
 	[IRQ_DM646X_MCASP0TXINT]        = 7,
 	[IRQ_DM646X_MCASP0RXINT]        = 7,
 	[IRQ_DM646X_RESERVED_3]         = 7,
-	[IRQ_DM646X_MCASP1TXINT]        = 7,    /* clockevent */
+	[IRQ_DM646X_MCASP1TXINT]        = 7,
+	[IRQ_TINT0_TINT12]              = 7,    /* clockevent */
 	[IRQ_TINT0_TINT34]              = 7,    /* clocksource */
 	[IRQ_TINT1_TINT12]              = 7,    /* DSP timer */
 	[IRQ_TINT1_TINT34]              = 7,    /* system tick */


