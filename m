Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2032080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759975;
	bh=guo/oIDXR2494WDX2j8ha7m/Od/rT4IAYBGT+Jc4AaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ipy0eYoEV+TshfoYCdLCo7wCL7mYgScxtYG8DbpYEKTzmDIH/9GB7fgV3xe7c9XeD
	 IsyxVh5oTPPN3Vr2R4tHrewZsDvtG1+frbB4zvaDu/RkRk8TkfPlXZKxuoK/hfzavL
	 ZNLjvhwTwJfHD7GhygvOC/TB8iJ20l+1DvEjCx0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfBUOjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfBUOjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFF12080D;
        Thu, 21 Feb 2019 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759970;
        bh=guo/oIDXR2494WDX2j8ha7m/Od/rT4IAYBGT+Jc4AaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pI+A2nFSSzjTHigYXvbt/rcWYmXD7q9TKxks9QjmmKRAC5x/2MJ7bU5xpVX1t6j6N
         gK5GdBzVPnFvB+X5tL6sC20hPftNQakmzVvZTqXXQHIU/HQ4LvVqAhAyrb7HoiN4AV
         TFPY25eZrBnbvhnj3S+z76LZDQQhJ4c4XLK38L2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/23] dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to exit
Date:   Thu, 21 Feb 2019 15:35:43 +0100
Message-Id: <20190221125246.273251399@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c0db24cc431e2196d98a5d5ddaa9088e2fcbfe5 ]

The GPIO interrupt controller on the espressobin board only supports edge interrupts.
If one enables the use of hardware interrupts in the device tree for the 88E6341, it is
possible to miss an edge.  When this happens, the INTn pin on the Marvell switch is
stuck low and no further interrupts occur.

I found after adding debug statements to mv88e6xxx_g1_irq_thread_work() that there is
a race in handling device interrupts (e.g. PHY link interrupts).  Some interrupts are
directly cleared by reading the Global 1 status register.  However, the device interrupt
flag, for example, is not cleared until all the unmasked SERDES and PHY ports are serviced.
This is done by reading the relevant SERDES and PHY status register.

The code only services interrupts whose status bit is set at the time of reading its status
register.  If an interrupt event occurs after its status is read and before all interrupts
are serviced, then this event will not be serviced and the INTn output pin will remain low.

This is not a problem with polling or level interrupts since the handler will be called
again to process the event.  However, it's a big problem when using level interrupts.

The fix presented here is to add a loop around the code servicing switch interrupts.  If
any pending interrupts remain after the current set has been handled, we loop and process
the new set.  If there are no pending interrupts after servicing, we are sure that INTn has
gone high and we will get an edge when a new event occurs.

Tested on espressobin board.

Fixes: dc30c35be720 ("net: dsa: mv88e6xxx: Implement interrupt support.")
Signed-off-by:  John David Anglin <dave.anglin@bell.net>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 34998ecd9cc93..a3543d637736c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -258,6 +258,7 @@ static irqreturn_t mv88e6xxx_g1_irq_thread_fn(int irq, void *dev_id)
 	unsigned int sub_irq;
 	unsigned int n;
 	u16 reg;
+	u16 ctl1;
 	int err;
 
 	mutex_lock(&chip->reg_lock);
@@ -267,13 +268,28 @@ static irqreturn_t mv88e6xxx_g1_irq_thread_fn(int irq, void *dev_id)
 	if (err)
 		goto out;
 
-	for (n = 0; n < chip->g1_irq.nirqs; ++n) {
-		if (reg & (1 << n)) {
-			sub_irq = irq_find_mapping(chip->g1_irq.domain, n);
-			handle_nested_irq(sub_irq);
-			++nhandled;
+	do {
+		for (n = 0; n < chip->g1_irq.nirqs; ++n) {
+			if (reg & (1 << n)) {
+				sub_irq = irq_find_mapping(chip->g1_irq.domain,
+							   n);
+				handle_nested_irq(sub_irq);
+				++nhandled;
+			}
 		}
-	}
+
+		mutex_lock(&chip->reg_lock);
+		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &ctl1);
+		if (err)
+			goto unlock;
+		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &reg);
+unlock:
+		mutex_unlock(&chip->reg_lock);
+		if (err)
+			goto out;
+		ctl1 &= GENMASK(chip->g1_irq.nirqs, 0);
+	} while (reg & ctl1);
+
 out:
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
-- 
2.19.1



