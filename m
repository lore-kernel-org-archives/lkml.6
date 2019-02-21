Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC617C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778342075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760350;
	bh=AiF6O1EPq8Liai8wVixAcF066aUVrQw9MtC+pRdgx80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVlBwk1sXZpjop4tqYpLrwvTk3DPj1I9IUZh3VMFf7DqFTwKQDoCXRaVOiWtSYIq3
	 p9WlDjomVyTEfgyoveY/R4BuBoAFh4c/uLr7iGSH7Cc6WmZho5JlCs/DiGo55uH201
	 UU8Cr2NtYd2CPFzXI3esFml8nU7ZsKFHEGZsWW04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfBUOma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbfBUOmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968EE2075A;
        Thu, 21 Feb 2019 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760142;
        bh=AiF6O1EPq8Liai8wVixAcF066aUVrQw9MtC+pRdgx80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiG0G6lYcQmp9UKITFrJwtw3wz7CPaf+Eyu3dKa4e5wJmGGeEfZ6bJZlJxvVfmFqj
         YgSFq6NXxJJo8xBZ1kcWG14nImRNr6V07p21eMpwo+dSn3+uXw4xiZ9iT15SRcrl8U
         GbYl1vOdjmQILE/cYbxK6ppFYYRuaxuQh/U1X/k4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 01/32] dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to exit
Date:   Thu, 21 Feb 2019 15:35:49 +0100
Message-Id: <20190221125250.938593000@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index b2a0e59b6252e..b0113f6fdbb46 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -261,6 +261,7 @@ static irqreturn_t mv88e6xxx_g1_irq_thread_work(struct mv88e6xxx_chip *chip)
 	unsigned int sub_irq;
 	unsigned int n;
 	u16 reg;
+	u16 ctl1;
 	int err;
 
 	mutex_lock(&chip->reg_lock);
@@ -270,13 +271,28 @@ static irqreturn_t mv88e6xxx_g1_irq_thread_work(struct mv88e6xxx_chip *chip)
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



