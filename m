Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1138DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C916B25517
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C916B25517
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeGARA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:00:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031845AbeGAQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CA33ACD;
        Sun,  1 Jul 2018 16:43:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Terry Zhou <bjzhou@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.17 118/220] pinctrl: armada-37xx: Fix spurious irq management
Date:   Sun,  1 Jul 2018 18:22:22 +0200
Message-Id: <20180701160913.284584352@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Zhou <bjzhou@marvell.com>

commit 702d1e81feae70aa16ca364b4d2d95ccad801022 upstream.

Until now, if we found spurious irq in irq_handler, we only updated the
status in register but not the status in the code. Due to this the system
will got stuck dues to the infinite loop

[gregory.clement@bootlin.com: update comment and add fix and stable tags]
Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Terry Zhou <bjzhou@marvell.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -679,12 +679,13 @@ static void armada_37xx_irq_handler(stru
 					writel(1 << hwirq,
 					       info->base +
 					       IRQ_STATUS + 4 * i);
-					continue;
+					goto update_status;
 				}
 			}
 
 			generic_handle_irq(virq);
 
+update_status:
 			/* Update status in case a new IRQ appears */
 			spin_lock_irqsave(&info->irq_lock, flags);
 			status = readl_relaxed(info->base +


