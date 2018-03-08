Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeCHUc0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:32:26 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36728 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751092AbeCHUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:32:23 -0500
From: Brad Mouring <brad.mouring@ni.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Brad Mouring <brad.mouring@ni.com>
Subject: [PATCH] net: phy: Tell caller result of phy_change()
Date: Thu, 8 Mar 2018 14:31:57 -0600
Message-ID: <20180308203157.10855-1-brad.mouring@ni.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307225042.2205-1-brad.mouring@ni.com>
References: <20180307225042.2205-1-brad.mouring@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 664fcf123a30e (net: phy: Threaded interrupts allow some simplification)
the phy_interrupt system was changed to use a traditional threaded
interrupt scheme instead of a workqueue approach.

With this change, the phy status check moved into phy_change, which
did not report back to the caller whether or not the interrupt was
handled. This means that, in the case of a shared phy interrupt,
only the first phydev's interrupt registers are checked (since
phy_interrupt() would always return IRQ_HANDLED). This leads to
interrupt storms when it is a secondary device that's actually the
interrupt source.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 drivers/net/phy/phy.c | 13 +++++++------
 include/linux/phy.h   |  1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e3e29c2b028b..ebce9f2b2742 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -617,6 +617,8 @@ static void phy_error(struct phy_device *phydev)
 	phy_trigger_machine(phydev, false);
 }
 
+static irqreturn_t phy_change(struct phy_device *phydev);
+
 /**
  * phy_interrupt - PHY interrupt handler
  * @irq: interrupt line
@@ -632,9 +634,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	if (PHY_HALTED == phydev->state)
 		return IRQ_NONE;		/* It can't be ours.  */
 
-	phy_change(phydev);
-
-	return IRQ_HANDLED;
+	return phy_change(phydev);
 }
 
 /**
@@ -723,12 +723,12 @@ EXPORT_SYMBOL(phy_stop_interrupts);
  * phy_change - Called by the phy_interrupt to handle PHY changes
  * @phydev: phy_device struct that interrupted
  */
-void phy_change(struct phy_device *phydev)
+static irqreturn_t phy_change(struct phy_device *phydev)
 {
 	if (phy_interrupt_is_valid(phydev)) {
 		if (phydev->drv->did_interrupt &&
 		    !phydev->drv->did_interrupt(phydev))
-			return;
+			return IRQ_NONE;
 
 		if (phydev->state == PHY_HALTED)
 			if (phy_disable_interrupts(phydev))
@@ -745,10 +745,11 @@ void phy_change(struct phy_device *phydev)
 
 	if (phy_interrupt_is_valid(phydev) && phy_clear_interrupt(phydev))
 		goto phy_err;
-	return;
+	return IRQ_HANDLED;
 
 phy_err:
 	phy_error(phydev);
+	return IRQ_NONE;
 }
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5a0c3e53e7c2..2e55838655b9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1011,7 +1011,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner);
 int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner);
 void phy_state_machine(struct work_struct *work);
-void phy_change(struct phy_device *phydev);
 void phy_change_work(struct work_struct *work);
 void phy_mac_interrupt(struct phy_device *phydev);
 void phy_start_machine(struct phy_device *phydev);
-- 
2.16.2
