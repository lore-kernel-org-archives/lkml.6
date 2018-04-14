Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbeDNJEZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 05:04:25 -0400
Received: from smtprz14.163.net ([106.3.154.247]:38000 "HELO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1750849AbeDNJEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 05:04:23 -0400
From: Liu Xiang <liu.xiang6@zte.com.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v3] net: davicom: dm9000: Avoid spinlock recursion during  dm9000_timeout routine
Date: Sat, 14 Apr 2018 16:50:34 +0800
Message-Id: <1523695834-6261-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the DM9000B, dm9000_phy_write() is called after the main spinlock
is held, during the dm9000_timeout() routine. Spinlock recursion
occurs because the main spinlock is requested again in
dm9000_phy_write(). So spinlock should be avoided in phy operation
during the dm9000_timeout() routine.

---
v3:
   When a task enters dm9000_timeout() and gets the main spinlock,
   another task that wants to do asynchronous phy operation must be
   running on another cpu.Because of different cpus, this
   asynchronous task will be blocked in dm9000_phy_write() until
   dm9000_timeout() routine is completed.
---

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/net/ethernet/davicom/dm9000.c | 39 +++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 50222b7..56df77d 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -112,7 +112,7 @@ struct board_info {
 	u8		imr_all;
 
 	unsigned int	flags;
-	unsigned int	in_timeout:1;
+	int		timeout_cpu;
 	unsigned int	in_suspend:1;
 	unsigned int	wake_supported:1;
 
@@ -158,6 +158,17 @@ static inline struct board_info *to_dm9000_board(struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static bool dm9000_current_in_timeout(struct board_info *db)
+{
+	bool ret = false;
+
+	preempt_disable();
+	ret = (db->timeout_cpu == smp_processor_id());
+	preempt_enable();
+
+	return ret;
+}
+
 /* DM9000 network board routine ---------------------------- */
 
 /*
@@ -276,7 +287,7 @@ static void dm9000_dumpblk_32bit(void __iomem *reg, int count)
  */
 static void dm9000_msleep(struct board_info *db, unsigned int ms)
 {
-	if (db->in_suspend || db->in_timeout)
+	if (db->in_suspend || dm9000_current_in_timeout(db))
 		mdelay(ms);
 	else
 		msleep(ms);
@@ -335,12 +346,13 @@ static void dm9000_msleep(struct board_info *db, unsigned int ms)
 	struct board_info *db = netdev_priv(dev);
 	unsigned long flags;
 	unsigned long reg_save;
+	bool in_timeout = dm9000_current_in_timeout(db);
 
 	dm9000_dbg(db, 5, "phy_write[%02x] = %04x\n", reg, value);
-	if (!db->in_timeout)
+	if (!in_timeout) {
 		mutex_lock(&db->addr_lock);
-
-	spin_lock_irqsave(&db->lock, flags);
+		spin_lock_irqsave(&db->lock, flags);
+	}
 
 	/* Save previous register address */
 	reg_save = readb(db->io_addr);
@@ -356,11 +368,13 @@ static void dm9000_msleep(struct board_info *db, unsigned int ms)
 	iow(db, DM9000_EPCR, EPCR_EPOS | EPCR_ERPRW);
 
 	writeb(reg_save, db->io_addr);
-	spin_unlock_irqrestore(&db->lock, flags);
+	if (!in_timeout)
+		spin_unlock_irqrestore(&db->lock, flags);
 
 	dm9000_msleep(db, 1);		/* Wait write complete */
 
-	spin_lock_irqsave(&db->lock, flags);
+	if (!in_timeout)
+		spin_lock_irqsave(&db->lock, flags);
 	reg_save = readb(db->io_addr);
 
 	iow(db, DM9000_EPCR, 0x0);	/* Clear phyxcer write command */
@@ -368,9 +382,10 @@ static void dm9000_msleep(struct board_info *db, unsigned int ms)
 	/* restore the previous address */
 	writeb(reg_save, db->io_addr);
 
-	spin_unlock_irqrestore(&db->lock, flags);
-	if (!db->in_timeout)
+	if (!in_timeout) {
+		spin_unlock_irqrestore(&db->lock, flags);
 		mutex_unlock(&db->addr_lock);
+	}
 }
 
 /* dm9000_set_io
@@ -980,7 +995,7 @@ static void dm9000_timeout(struct net_device *dev)
 
 	/* Save previous register address */
 	spin_lock_irqsave(&db->lock, flags);
-	db->in_timeout = 1;
+	db->timeout_cpu = smp_processor_id();
 	reg_save = readb(db->io_addr);
 
 	netif_stop_queue(dev);
@@ -992,7 +1007,7 @@ static void dm9000_timeout(struct net_device *dev)
 
 	/* Restore previous register address */
 	writeb(reg_save, db->io_addr);
-	db->in_timeout = 0;
+	db->timeout_cpu = -1;
 	spin_unlock_irqrestore(&db->lock, flags);
 }
 
@@ -1670,6 +1685,8 @@ static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
 	db->mii.mdio_read    = dm9000_phy_read;
 	db->mii.mdio_write   = dm9000_phy_write;
 
+	db->timeout_cpu = -1;
+
 	mac_src = "eeprom";
 
 	/* try reading the node address from the attached EEPROM */
-- 
1.9.1
