Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeBLWst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:49 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37576 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeBLWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:39 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 32/45] rtc: cmos: use generic nvmem
Date: Mon, 12 Feb 2018 23:47:46 +0100
Message-Id: <20180212224759.15999-33-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding a binary sysfs attribute from the driver, use the
core to register an nvmem device. This allows to use the in-kernel
interface to access the nvram.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-cmos.c | 73 +++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index e6393e784d0c..b8ec6009171a 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -541,11 +541,10 @@ static const struct rtc_class_ops cmos_rtc_ops = {
 
 #define NVRAM_OFFSET	(RTC_REG_D + 1)
 
-static ssize_t
-cmos_nvram_read(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int cmos_nvram_read(void *priv, unsigned int off, void *val,
+			   size_t count)
 {
+	unsigned char *buf = val;
 	int	retval;
 
 	off += NVRAM_OFFSET;
@@ -563,16 +562,13 @@ cmos_nvram_read(struct file *filp, struct kobject *kobj,
 	return retval;
 }
 
-static ssize_t
-cmos_nvram_write(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int cmos_nvram_write(void *priv, unsigned int off, void *val,
+			    size_t count)
 {
-	struct cmos_rtc	*cmos;
+	struct cmos_rtc	*cmos = priv;
+	unsigned char	*buf = val;
 	int		retval;
 
-	cmos = dev_get_drvdata(container_of(kobj, struct device, kobj));
-
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
 	 * here.  If userspace is smart enough to know what fields of
@@ -598,17 +594,6 @@ cmos_nvram_write(struct file *filp, struct kobject *kobj,
 	return retval;
 }
 
-static struct bin_attribute nvram = {
-	.attr = {
-		.name	= "nvram",
-		.mode	= S_IRUGO | S_IWUSR,
-	},
-
-	.read	= cmos_nvram_read,
-	.write	= cmos_nvram_write,
-	/* size gets set up later */
-};
-
 /*----------------------------------------------------------------*/
 
 static struct cmos_rtc	cmos_rtc;
@@ -675,6 +660,14 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	unsigned char			rtc_control;
 	unsigned			address_space;
 	u32				flags = 0;
+	struct nvmem_config nvmem_cfg = {
+		.name = "cmos_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.reg_read = cmos_nvram_read,
+		.reg_write = cmos_nvram_write,
+		.priv = &cmos_rtc,
+	};
 
 	/* there can be only one ... */
 	if (cmos_rtc.dev)
@@ -813,32 +806,28 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		}
 	}
 
-	/* export at least the first block of NVRAM */
-	nvram.size = address_space - NVRAM_OFFSET;
-	retval = sysfs_create_bin_file(&dev->kobj, &nvram);
-	if (retval < 0) {
-		dev_dbg(dev, "can't create nvram file? %d\n", retval);
-		goto cleanup2;
-	}
-
 	cmos_rtc.rtc->ops = &cmos_rtc_ops;
+	cmos_rtc.rtc->nvram_old_abi = true;
 	retval = rtc_register_device(cmos_rtc.rtc);
 	if (retval)
-		goto cleanup3;
+		goto cleanup2;
 
-	dev_info(dev, "%s%s, %zd bytes nvram%s\n",
-		!is_valid_irq(rtc_irq) ? "no alarms" :
-			cmos_rtc.mon_alrm ? "alarms up to one year" :
-			cmos_rtc.day_alrm ? "alarms up to one month" :
-			"alarms up to one day",
-		cmos_rtc.century ? ", y3k" : "",
-		nvram.size,
-		is_hpet_enabled() ? ", hpet irqs" : "");
+	/* export at least the first block of NVRAM */
+	nvmem_cfg.size = address_space - NVRAM_OFFSET;
+	if (rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg))
+		dev_err(dev, "nvmem registration failed\n");
+
+	dev_info(dev, "%s%s, %d bytes nvram%s\n",
+		 !is_valid_irq(rtc_irq) ? "no alarms" :
+		 cmos_rtc.mon_alrm ? "alarms up to one year" :
+		 cmos_rtc.day_alrm ? "alarms up to one month" :
+		 "alarms up to one day",
+		 cmos_rtc.century ? ", y3k" : "",
+		 nvmem_cfg.size,
+		 is_hpet_enabled() ? ", hpet irqs" : "");
 
 	return 0;
 
-cleanup3:
-	sysfs_remove_bin_file(&dev->kobj, &nvram);
 cleanup2:
 	if (is_valid_irq(rtc_irq))
 		free_irq(rtc_irq, cmos_rtc.rtc);
@@ -867,8 +856,6 @@ static void cmos_do_remove(struct device *dev)
 
 	cmos_do_shutdown(cmos->irq);
 
-	sysfs_remove_bin_file(&dev->kobj, &nvram);
-
 	if (is_valid_irq(cmos->irq)) {
 		free_irq(cmos->irq, cmos->rtc);
 		hpet_unregister_irq_handler(cmos_interrupt);
-- 
2.16.1
