Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeDSONA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:13:00 -0400
Received: from sauhun.de ([88.99.104.3]:45416 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753378AbeDSOHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:09 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 44/61] rtc: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:14 +0200
Message-Id: <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/rtc/rtc-bq4802.c   |  6 ++----
 drivers/rtc/rtc-ds1216.c   |  6 ++----
 drivers/rtc/rtc-ds1511.c   |  9 +++------
 drivers/rtc/rtc-ds1553.c   | 15 +++++----------
 drivers/rtc/rtc-ds1685.c   | 21 +++++++--------------
 drivers/rtc/rtc-ds1742.c   |  6 ++----
 drivers/rtc/rtc-lpc32xx.c  | 16 ++++++----------
 drivers/rtc/rtc-m48t59.c   | 41 ++++++++++++++++-------------------------
 drivers/rtc/rtc-mv.c       |  3 +--
 drivers/rtc/rtc-mxc.c      | 21 +++++++--------------
 drivers/rtc/rtc-pcap.c     | 15 +++++----------
 drivers/rtc/rtc-sh.c       | 15 +++++----------
 drivers/rtc/rtc-stk17ta8.c | 15 +++++----------
 drivers/rtc/rtc-test.c     |  3 +--
 drivers/rtc/rtc-zynqmp.c   | 10 ++++------
 15 files changed, 71 insertions(+), 131 deletions(-)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bd170cb3361c..d768f6747961 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -48,8 +48,7 @@ static void bq4802_write_mem(struct bq4802 *p, int off, u8 val)
 
 static int bq4802_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bq4802 *p = platform_get_drvdata(pdev);
+	struct bq4802 *p = dev_get_drvdata(dev);
 	unsigned long flags;
 	unsigned int century;
 	u8 val;
@@ -91,8 +90,7 @@ static int bq4802_read_time(struct device *dev, struct rtc_time *tm)
 
 static int bq4802_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct bq4802 *p = platform_get_drvdata(pdev);
+	struct bq4802 *p = dev_get_drvdata(dev);
 	u8 sec, min, hrs, day, mon, yrs, century, val;
 	unsigned long flags;
 	unsigned int year;
diff --git a/drivers/rtc/rtc-ds1216.c b/drivers/rtc/rtc-ds1216.c
index 5f158715fb4c..50fabe1cd286 100644
--- a/drivers/rtc/rtc-ds1216.c
+++ b/drivers/rtc/rtc-ds1216.c
@@ -76,8 +76,7 @@ static void ds1216_switch_ds_to_clock(u8 __iomem *ioaddr)
 
 static int ds1216_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1216_priv *priv = platform_get_drvdata(pdev);
+	struct ds1216_priv *priv = dev_get_drvdata(dev);
 	struct ds1216_regs regs;
 
 	ds1216_switch_ds_to_clock(priv->ioaddr);
@@ -104,8 +103,7 @@ static int ds1216_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int ds1216_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1216_priv *priv = platform_get_drvdata(pdev);
+	struct ds1216_priv *priv = dev_get_drvdata(dev);
 	struct ds1216_regs regs;
 
 	ds1216_switch_ds_to_clock(priv->ioaddr);
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index a7d5ca428d68..b8b6e51c0461 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -314,8 +314,7 @@ ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
 static int
 ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -334,8 +333,7 @@ ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int
 ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -373,8 +371,7 @@ ds1511_interrupt(int irq, void *dev_id)
 
 static int ds1511_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 2441b9a2b366..34af7a802f43 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -73,8 +73,7 @@ struct rtc_plat_data {
 
 static int ds1553_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	u8 century;
 
@@ -98,8 +97,7 @@ static int ds1553_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int ds1553_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	unsigned int year, month, day, hour, minute, second, week;
 	unsigned int century;
@@ -155,8 +153,7 @@ static void ds1553_rtc_update_alarm(struct rtc_plat_data *pdata)
 
 static int ds1553_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -172,8 +169,7 @@ static int ds1553_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int ds1553_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -208,8 +204,7 @@ static irqreturn_t ds1553_rtc_interrupt(int irq, void *dev_id)
 
 static int ds1553_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 1a39829d2b40..f0f8011dce3d 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -267,8 +267,7 @@ ds1685_rtc_get_ssn(struct ds1685_priv *rtc, u8 *ssn)
 static int
 ds1685_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ctrlb, century;
 	u8 seconds, minutes, hours, wday, mday, month, years;
 
@@ -317,8 +316,7 @@ ds1685_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int
 ds1685_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ctrlb, seconds, minutes, hours, wday, mday, month, years, century;
 
 	/* Fetch the time info from rtc_time. */
@@ -394,8 +392,7 @@ ds1685_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int
 ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 seconds, minutes, hours, mday, ctrlb, ctrlc;
 	int ret;
 
@@ -453,8 +450,7 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int
 ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ctrlb, seconds, minutes, hours, mday;
 	int ret;
 
@@ -1119,8 +1115,7 @@ static ssize_t
 ds1685_rtc_sysfs_battery_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ctrld;
 
 	ctrld = rtc->read(rtc, RTC_CTRL_D);
@@ -1140,8 +1135,7 @@ static ssize_t
 ds1685_rtc_sysfs_auxbatt_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ctrl4a;
 
 	ds1685_rtc_switch_to_bank1(rtc);
@@ -1163,8 +1157,7 @@ static ssize_t
 ds1685_rtc_sysfs_serial_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct ds1685_priv *rtc = dev_get_drvdata(dev);
 	u8 ssn[8];
 
 	ds1685_rtc_switch_to_bank1(rtc);
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 2d781180e968..5b7f02e89941 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -58,8 +58,7 @@ struct rtc_plat_data {
 
 static int ds1742_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr_rtc;
 	u8 century;
 
@@ -83,8 +82,7 @@ static int ds1742_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int ds1742_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr_rtc;
 	unsigned int year, month, day, hour, minute, second, week;
 	unsigned int century;
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 3ba87239aacc..910e600275b9 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -294,11 +294,10 @@ static int lpc32xx_rtc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int lpc32xx_rtc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
+	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
 	if (rtc->irq >= 0) {
-		if (device_may_wakeup(&pdev->dev))
+		if (device_may_wakeup(dev))
 			enable_irq_wake(rtc->irq);
 		else
 			disable_irq_wake(rtc->irq);
@@ -309,10 +308,9 @@ static int lpc32xx_rtc_suspend(struct device *dev)
 
 static int lpc32xx_rtc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
+	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
-	if (rtc->irq >= 0 && device_may_wakeup(&pdev->dev))
+	if (rtc->irq >= 0 && device_may_wakeup(dev))
 		disable_irq_wake(rtc->irq);
 
 	return 0;
@@ -321,8 +319,7 @@ static int lpc32xx_rtc_resume(struct device *dev)
 /* Unconditionally disable the alarm */
 static int lpc32xx_rtc_freeze(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
+	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
 	spin_lock_irq(&rtc->lock);
 
@@ -337,8 +334,7 @@ static int lpc32xx_rtc_freeze(struct device *dev)
 
 static int lpc32xx_rtc_thaw(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
+	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
 	if (rtc->alarm_enabled) {
 		spin_lock_irq(&rtc->lock);
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 216fac62c888..1053a406b3aa 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -47,8 +47,7 @@ struct m48t59_private {
 static void
 m48t59_mem_writeb(struct device *dev, u32 ofs, u8 val)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 
 	writeb(val, m48t59->ioaddr+ofs);
 }
@@ -56,8 +55,7 @@ m48t59_mem_writeb(struct device *dev, u32 ofs, u8 val)
 static u8
 m48t59_mem_readb(struct device *dev, u32 ofs)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 
 	return readb(m48t59->ioaddr+ofs);
 }
@@ -67,9 +65,8 @@ m48t59_mem_readb(struct device *dev, u32 ofs)
  */
 static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	unsigned long flags;
 	u8 val;
 
@@ -110,9 +107,8 @@ static int m48t59_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int m48t59_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	unsigned long flags;
 	u8 val = 0;
 	int year = tm->tm_year;
@@ -157,9 +153,8 @@ static int m48t59_rtc_set_time(struct device *dev, struct rtc_time *tm)
  */
 static int m48t59_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 	unsigned long flags;
 	u8 val;
@@ -204,9 +199,8 @@ static int m48t59_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
  */
 static int m48t59_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 	u8 mday, hour, min, sec;
 	unsigned long flags;
@@ -265,9 +259,8 @@ static int m48t59_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
  */
 static int m48t59_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&m48t59->lock, flags);
@@ -282,9 +275,8 @@ static int m48t59_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int m48t59_rtc_proc(struct device *dev, struct seq_file *seq)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	unsigned long flags;
 	u8 val;
 
@@ -303,9 +295,8 @@ static int m48t59_rtc_proc(struct device *dev, struct seq_file *seq)
 static irqreturn_t m48t59_rtc_interrupt(int irq, void *dev_id)
 {
 	struct device *dev = (struct device *)dev_id;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = dev_get_platdata(dev);
+	struct m48t59_private *m48t59 = dev_get_drvdata(dev);
 	u8 event;
 
 	spin_lock(&m48t59->lock);
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index bc52dbb0c0e2..4b198b3778d3 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -176,8 +176,7 @@ static int mv_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static int mv_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 
 	if (pdata->irq < 0)
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index bce427d202ee..822ebe4be3c3 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -109,8 +109,7 @@ static inline int is_imx1_rtc(struct rtc_plat_data *data)
  */
 static time64_t get_alarm_or_time(struct device *dev, int time_alarm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	u32 day = 0, hr = 0, min = 0, sec = 0, hr_min = 0;
 
@@ -139,8 +138,7 @@ static time64_t get_alarm_or_time(struct device *dev, int time_alarm)
 static void set_alarm_or_time(struct device *dev, int time_alarm, time64_t time)
 {
 	u32 tod, day, hr, min, sec, temp;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 
 	day = div_s64_rem(time, 86400, &tod);
@@ -176,8 +174,7 @@ static void set_alarm_or_time(struct device *dev, int time_alarm, time64_t time)
 static void rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
 {
 	time64_t time;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 
 	time = rtc_tm_to_time64(alrm);
@@ -190,8 +187,7 @@ static void rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
 static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
 				unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	u32 reg;
 
@@ -266,8 +262,7 @@ static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
  */
 static int mxc_rtc_set_mmss(struct device *dev, time64_t time)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	/*
 	 * TTC_DAYR register is 9-bit in MX1 SoC, save time and day of year only
@@ -295,8 +290,7 @@ static int mxc_rtc_set_mmss(struct device *dev, time64_t time)
  */
 static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 
 	rtc_time64_to_tm(get_alarm_or_time(dev, MXC_RTC_ALARM), &alrm->time);
@@ -310,8 +304,7 @@ static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
  */
 static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	rtc_update_alarm(dev, &alrm->time);
 
diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index c05f524ba9af..f176cb9d0dbc 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -43,8 +43,7 @@ static irqreturn_t pcap_rtc_irq(int irq, void *_pcap_rtc)
 
 static int pcap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
+	struct pcap_rtc *pcap_rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 	unsigned long secs;
 	u32 tod;	/* time of day, seconds since midnight */
@@ -63,8 +62,7 @@ static int pcap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int pcap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
+	struct pcap_rtc *pcap_rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &alrm->time;
 	unsigned long secs;
 	u32 tod, days;
@@ -82,8 +80,7 @@ static int pcap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int pcap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
+	struct pcap_rtc *pcap_rtc = dev_get_drvdata(dev);
 	unsigned long secs;
 	u32 tod, days;
 
@@ -100,8 +97,7 @@ static int pcap_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pcap_rtc_set_mmss(struct device *dev, unsigned long secs)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
+	struct pcap_rtc *pcap_rtc = dev_get_drvdata(dev);
 	u32 tod, days;
 
 	tod = secs % SEC_PER_DAY;
@@ -115,8 +111,7 @@ static int pcap_rtc_set_mmss(struct device *dev, unsigned long secs)
 
 static int pcap_rtc_irq_enable(struct device *dev, int pirq, unsigned int en)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
+	struct pcap_rtc *pcap_rtc = dev_get_drvdata(dev);
 
 	if (en)
 		enable_irq(pcap_to_irq(pcap_rtc->pcap, pirq));
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 4e8ab370ce63..4f98543d1ea5 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -359,8 +359,7 @@ static int sh_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static int sh_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int sec128, sec2, yr, yr100, cf_bit;
 
 	do {
@@ -419,8 +418,7 @@ static int sh_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int sh_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int tmp;
 	int year;
 
@@ -475,8 +473,7 @@ static inline int sh_rtc_read_alarm_value(struct sh_rtc *rtc, int reg_off)
 
 static int sh_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
 	struct rtc_time *tm = &wkalrm->time;
 
 	spin_lock_irq(&rtc->lock);
@@ -509,8 +506,7 @@ static inline void sh_rtc_write_alarm_value(struct sh_rtc *rtc,
 
 static int sh_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int rcr1;
 	struct rtc_time *tm = &wkalrm->time;
 	int mon;
@@ -723,8 +719,7 @@ static int __exit sh_rtc_remove(struct platform_device *pdev)
 
 static void sh_rtc_set_irq_wake(struct device *dev, int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
 
 	irq_set_irq_wake(rtc->periodic_irq, enabled);
 
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index e70b78d17a98..fccbecbb2c98 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -74,8 +74,7 @@ struct rtc_plat_data {
 
 static int stk17ta8_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	u8 flags;
 
@@ -97,8 +96,7 @@ static int stk17ta8_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int stk17ta8_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	void __iomem *ioaddr = pdata->ioaddr;
 	unsigned int year, month, day, hour, minute, second, week;
 	unsigned int century;
@@ -163,8 +161,7 @@ static void stk17ta8_rtc_update_alarm(struct rtc_plat_data *pdata)
 
 static int stk17ta8_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -180,8 +177,7 @@ static int stk17ta8_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int stk17ta8_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -217,8 +213,7 @@ static irqreturn_t stk17ta8_rtc_interrupt(int irq, void *dev_id)
 static int stk17ta8_rtc_alarm_irq_enable(struct device *dev,
 	unsigned int enabled)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 3a2da4c892d6..390f928fd6fc 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -84,8 +84,7 @@ static ssize_t test_irq_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	int retval;
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
+	struct rtc_device *rtc = dev_get_drvdata(dev);
 
 	retval = count;
 	if (strncmp(buf, "tick", 4) == 0 && rtc->pie_enabled)
diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index fba994dc31eb..c532bd13fbe5 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -278,10 +278,9 @@ static int xlnx_rtc_remove(struct platform_device *pdev)
 
 static int __maybe_unused xlnx_rtc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct xlnx_rtc_dev *xrtcdev = platform_get_drvdata(pdev);
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		enable_irq_wake(xrtcdev->alarm_irq);
 	else
 		xlnx_rtc_alarm_irq_enable(dev, 0);
@@ -291,10 +290,9 @@ static int __maybe_unused xlnx_rtc_suspend(struct device *dev)
 
 static int __maybe_unused xlnx_rtc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct xlnx_rtc_dev *xrtcdev = platform_get_drvdata(pdev);
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		disable_irq_wake(xrtcdev->alarm_irq);
 	else
 		xlnx_rtc_alarm_irq_enable(dev, 1);
-- 
2.11.0
