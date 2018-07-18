Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA305ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D71C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Hfa5HFDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D71C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeGROsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:48:13 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:43454 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeGROsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:48:01 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id DFB12B00709
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:09:54 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1531922994; x=1532786995; bh=5y
        FYt/I7y/ZHKsAzhWbFdraxuq84xE3JDm0/bna/jIc=; b=Hfa5HFDRAJNmgJNnpJ
        O64ES4M9XBfQJ+3T4QAzjFy2kTz16u76eKaPD2oZUiOO+nlhIIzM5SY5vu6eFcT0
        0B/tN/AiCxP1p956yWUy3jsYQ7cyzIwyChtbW/4tY8osVjqONRzxkhJdJcM05bqt
        8lyHVy3ff6gLcNTGtrgScjwE0=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LQHMKTJdUZVn for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 16:09:54 +0200 (CEST)
Received: from localhost.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id B9B60B0076D;
        Wed, 18 Jul 2018 16:09:52 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs attribute to check tick on m41txx
Date:   Wed, 18 Jul 2018 16:09:45 +0200
Message-Id: <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On m41txx you can enable open-drain OUT pin to check if offset is ok.
Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
512 times faster than 1s tick base.

Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index c6d871456f25..2efe55f43774 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1050,6 +1050,94 @@ static int m41txx_rtc_set_offset(struct device *dev, long offset)
 				  ctrl_reg);
 }
 
+static ssize_t frequency_test_enable_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	bool freq_test_en;
+	int ret;
+
+	ret = kstrtobool(buf, &freq_test_en);
+	if (ret == -EINVAL) {
+		dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
+		return ret;
+	}
+
+	regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
+			   freq_test_en ? M41TXX_BIT_FT : 0);
+
+	return count;
+}
+
+static ssize_t frequency_test_enable_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned int ctrl_reg;
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	return scnprintf(buf, PAGE_SIZE, (ctrl_reg & M41TXX_BIT_FT) ? "on\n" :
+			"off\n");
+}
+
+static DEVICE_ATTR_RW(frequency_test_enable);
+
+static struct attribute *rtc_freq_test_attrs[] = {
+	&dev_attr_frequency_test_enable.attr,
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
+	int err;
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
+			sysfs_remove_group(&(ds1307->dev)->kobj,
+					   &rtc_freq_test_attr_group);
+			return err;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 /*----------------------------------------------------------------------*/
 
 static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
@@ -1792,6 +1880,12 @@ static int ds1307_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
+	err = ds1307_add_frequency_test(ds1307);
+	if (err) {
+		rtc_device_unregister(ds1307->rtc);
+		return err;
+	}
+
 	if (chip->nvram_size) {
 		struct nvmem_config nvmem_cfg = {
 			.name = "ds1307_nvram",
-- 
2.17.1

