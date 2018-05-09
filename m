Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965514AbeEITeJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:34:09 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33634 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965475AbeEITeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:34:04 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3 4/4] rtc: ds1307: add freq_test sysfs attribute to check tick on m41txx
Date: Wed,  9 May 2018 21:33:55 +0200
Message-Id: <20180509193355.49466-4-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
References: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On m41txx you can enable open-drain OUT pin to check if offset is ok.
Enabling OUT pin with freq_test attribute, OUT pin will tick 512 times
faster than 1s tick base.

Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
V2 => V3: export freq_test on sysfs only if supported(m41txx series)

 drivers/rtc/rtc-ds1307.c | 107 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 33895668b363..79206bf21018 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1042,6 +1042,109 @@ static int m41txx_rtc_set_offset(struct device *dev, long offset)
 	return regmap_write(ds1307->regmap, M41TXX_REG_CONTROL,	ctrl_reg);
 }
 
+static ssize_t freq_test_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned long freq_test = 0;
+	unsigned int ctrl_reg;
+	int retval;
+
+	retval = kstrtoul(buf, 10, &freq_test);
+	if ((retval < 0) || (retval > 1)) {
+		dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
+		return -EINVAL;
+	}
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	if (freq_test)
+		ctrl_reg |= M41TXX_BIT_FT;
+	else
+		ctrl_reg &= ~M41TXX_BIT_FT;
+
+	retval = regmap_write(ds1307->regmap, M41TXX_REG_CONTROL, ctrl_reg);
+
+	return retval ? retval : count;
+}
+
+static ssize_t freq_test_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	int freq_test = 0;
+	unsigned int ctrl_reg;
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	if (ctrl_reg & M41TXX_BIT_FT)
+		freq_test = true;
+	else
+		freq_test = false;
+
+	if ((freq_test < 0) || (freq_test > 1)) {
+		dev_err(dev, "Failed to read RTC Frequency Test\n");
+		sprintf(buf, "0\n");
+		return freq_test;
+	}
+
+	return sprintf(buf, "%d\n", freq_test);
+}
+
+static DEVICE_ATTR_RW(freq_test);
+
+static struct attribute *rtc_freq_test_attrs[] = {
+	&dev_attr_freq_test.attr,
+	NULL,
+};
+
+static const struct attribute_group rtc_freq_test_attr_group = {
+	.attrs		= rtc_freq_test_attrs,
+};
+
+static void rtc_calib_remove_sysfs_group(void *_dev)
+{
+	struct device *dev = _dev;
+
+	sysfs_remove_group(&dev->kobj, &rtc_freq_test_attr_group);
+}
+
+static int ds1307_add_frequency_test(struct ds1307 *ds1307)
+{
+	int err = 0;
+
+	switch (ds1307->type) {
+	case m41t0:
+	case m41t00:
+	case m41t11:
+		/* Export sysfs entries */
+		err = sysfs_create_group(&(ds1307->dev)->kobj,
+					 &rtc_freq_test_attr_group);
+		if (err) {
+			dev_err(ds1307->dev,
+				"Failed to create sysfs group: %d\n",
+				err);
+			return err;
+		}
+
+		err = devm_add_action_or_reset(ds1307->dev,
+					       rtc_calib_remove_sysfs_group,
+					       ds1307->dev);
+		if (err) {
+			dev_err(ds1307->dev,
+				"Failed to add sysfs cleanup action: %d\n",
+				err);
+			return err;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
 /*----------------------------------------------------------------------*/
 
 static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
@@ -1783,6 +1886,10 @@ static int ds1307_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
+	err = ds1307_add_frequency_test(ds1307);
+	if (err)
+		return err;
+
 	if (chip->nvram_size) {
 		struct nvmem_config nvmem_cfg = {
 			.name = "ds1307_nvram",
-- 
2.17.0
