Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F506ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386672075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Nn5cwuMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386672075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeGRKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:17:25 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:34024 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbeGRKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:17:23 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 7CE6DB00760
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:40:20 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1531906820; x=1532770821; bh=ap
        mx8e7MR2fCjcAfxzL5A/sPOyuZCnRy2mAUmok9Rnw=; b=Nn5cwuMyX7Ge+skj1a
        bGzFSYs7vODdjMdYNpg5JS6bNuCBiBWl5mtmDkkvQIW9tkf3QIklx07Odc2jNITa
        tqyCoIOmaybet09e6CFtm6h/ybwxAiKml+vuV2PCMfLurLGYnLDyvrRtCG3pLT5C
        kAJ7kocLLNx3jdkECmq70qjAo=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y2SG4kXauK6K for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 11:40:20 +0200 (CEST)
Received: from localhost.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 8E574B00758;
        Wed, 18 Jul 2018 11:40:18 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs attribute to check tick on m41txx
Date:   Wed, 18 Jul 2018 11:40:05 +0200
Message-Id: <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
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
 drivers/rtc/rtc-ds1307.c | 96 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index c6d871456f25..3bccb742c983 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1050,6 +1050,96 @@ static int m41txx_rtc_set_offset(struct device *dev, long offset)
 				  ctrl_reg);
 }
 
+static ssize_t frequency_test_enable_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	bool freq_test_en = 0;
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
+	if (ctrl_reg & M41TXX_BIT_FT)
+		return scnprintf(buf, PAGE_SIZE, "on\n");
+	else
+		return scnprintf(buf, PAGE_SIZE, "off\n");
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
+			sysfs_remove_group(&(ds1307->dev)->kobj,
+					   &rtc_freq_test_attr_group);
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
@@ -1792,6 +1882,12 @@ static int ds1307_probe(struct i2c_client *client,
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

