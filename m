Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeCGWu4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:50:56 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42680 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933743AbeCGWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:50:54 -0500
From: Brad Mouring <brad.mouring@ni.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Brad Mouring <brad.mouring@ni.com>
Subject: [PATCH] net: phy: Move interrupt check from phy_check to phy_interrupt
Date: Wed, 7 Mar 2018 16:50:42 -0600
Message-ID: <20180307225042.2205-1-brad.mouring@ni.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multiple phys share the same interrupt (e.g. a multi-phy chip),
the first device registered is the only one checked as phy_interrupt
will always return IRQ_HANDLED if the first phydev is not halted.
Move the interrupt check into phy_interrupt and, if it was not this
phydev, return IRQ_NONE to allow other devices on this irq a chance
to check if it was their interrupt.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 drivers/net/phy/phy.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e3e29c2b028b..ff1aa815568f 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -632,6 +632,12 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	if (PHY_HALTED == phydev->state)
 		return IRQ_NONE;		/* It can't be ours.  */
 
+	if (phy_interrupt_is_valid(phydev)) {
+		if (phydev->drv->did_interrupt &&
+			!phydev->drv->did_interrupt(phydev))
+			return IRQ_NONE;
+	}
+
 	phy_change(phydev);
 
 	return IRQ_HANDLED;
@@ -725,16 +731,6 @@ EXPORT_SYMBOL(phy_stop_interrupts);
  */
 void phy_change(struct phy_device *phydev)
 {
-	if (phy_interrupt_is_valid(phydev)) {
-		if (phydev->drv->did_interrupt &&
-		    !phydev->drv->did_interrupt(phydev))
-			return;
-
-		if (phydev->state == PHY_HALTED)
-			if (phy_disable_interrupts(phydev))
-				goto phy_err;
-	}
-
 	mutex_lock(&phydev->lock);
 	if ((PHY_RUNNING == phydev->state) || (PHY_NOLINK == phydev->state))
 		phydev->state = PHY_CHANGELINK;
-- 
2.16.2
