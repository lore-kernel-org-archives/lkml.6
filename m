Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C42208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C42208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934885AbeF1IW2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:22:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934056AbeF1IW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:22:26 -0400
Received: from 1.general.shrirang--bagul.uk.vpn ([10.172.198.4] helo=snb-ubuntu.taipei.internal)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fYSC5-0000ab-Ku; Thu, 28 Jun 2018 08:22:22 +0000
From:   Shrirang Bagul <shrirang.bagul@canonical.com>
To:     jic23@kernel.org, lorenzo.bianconi@redhat.com
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hts221: Fix sensor reads after resume
Date:   Thu, 28 Jun 2018 16:22:15 +0800
Message-Id: <20180628082215.12023-1-shrirang.bagul@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AV_CONF register (RH & TEMP. oversampling ratio's) and CTRL1 register
(ODR & BDU settings) values are lost after suspend.

While the change in AV_CONF updates the sensor resolution modes
(overriding the user configuration before the device went to suspend);
loss of the contents of the CTRL1 register leads to failure in reading
sensor output.

This patch restores the AV_CONF & CTRL1 registers after resume.

Changes from v1:
- Don't drop enabling the sensor during resume
- Restore AV_CONF register along with CTRL1
  (As demonstrated with i2c register dumps of hts221 captured on Dell
  IoT Gateways 300x before suspend & after resume [1])

Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>

[v1] https://marc.info/?l=linux-iio&m=152506543000442&w=2
[1] https://marc.info/?l=linux-iio&m=152534455701742&w=2

This patch is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git -b testing
---
 drivers/iio/humidity/hts221_core.c | 31 +++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 166946d4978d..fc5599497f55 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -656,14 +656,43 @@ static int __maybe_unused hts221_resume(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct hts221_hw *hw = iio_priv(iio_dev);
+	const struct hts221_avg *avg;
+	u8 data, idx;
 	int err = 0;
 
+	/* Restore contents of AV_CONF (RH & TEMP. oversampling ratio's) */
+	avg = &hts221_avg_list[HTS221_SENSOR_H];
+	idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
+	data = avg->avg_avl[idx];
+	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
+	if (err < 0)
+		goto fail_err;
+
+	avg = &hts221_avg_list[HTS221_SENSOR_T];
+	idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
+	data = avg->avg_avl[idx];
+	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
+	if (err < 0)
+		goto fail_err;
+
+	/* Restore contents of CTRL1 (BDU & ODR) */
+	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
+				 HTS221_BDU_MASK,
+				 FIELD_PREP(HTS221_BDU_MASK, 1));
+	if (err < 0)
+		goto fail_err;
+
+	err = hts221_update_odr(hw, hw->odr);
+	if (err < 0)
+		goto fail_err;
+
 	if (hw->enabled)
 		err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
 					 HTS221_ENABLE_MASK,
 					 FIELD_PREP(HTS221_ENABLE_MASK,
 						    true));
-	return err;
+fail_err:
+	return err < 0 ? err : 0;
 }
 
 const struct dev_pm_ops hts221_pm_ops = {
-- 
2.17.1

