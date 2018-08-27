Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C0B208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C0B208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH0TXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:57569 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0TXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 08:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="257606909"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2018 08:35:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9AF161F6; Mon, 27 Aug 2018 18:35:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] extcon: cht-wc: Correct USBID bit field handling
Date:   Mon, 27 Aug 2018 18:35:55 +0300
Message-Id: <20180827153557.58363-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
References: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USBID is 2-bit bit field according to specification. Make it clear.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 32 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 71b1126dbb0b..ad1fd70e4023 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -62,8 +62,11 @@
 #define CHT_WC_PWRSRC_VBUS		BIT(0)
 #define CHT_WC_PWRSRC_DC		BIT(1)
 #define CHT_WC_PWRSRC_BATT		BIT(2)
-#define CHT_WC_PWRSRC_ID_GND		BIT(3)
-#define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)
+#define CHT_WC_PWRSRC_USBID_MASK	GENMASK(4, 3)
+#define CHT_WC_PWRSRC_USBID_SHIFT	3
+#define CHT_WC_PWRSRC_RID_ACA		0
+#define CHT_WC_PWRSRC_RID_GND		1
+#define CHT_WC_PWRSRC_RID_FLOAT		2
 
 #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
 #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
@@ -104,16 +107,20 @@ struct cht_wc_extcon_data {
 
 static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
 {
-	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_GND)
+	switch ((pwrsrc_sts & CHT_WC_PWRSRC_USBID_MASK) >> CHT_WC_PWRSRC_USBID_SHIFT) {
+	case CHT_WC_PWRSRC_RID_GND:
 		return USB_ID_GND;
-	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_FLOAT)
+	case CHT_WC_PWRSRC_RID_FLOAT:
 		return USB_ID_FLOAT;
-
-	/*
-	 * Once we have iio support for the gpadc we should read the USBID
-	 * gpadc channel here and determine ACA role based on that.
-	 */
-	return USB_ID_FLOAT;
+	case CHT_WC_PWRSRC_RID_ACA:
+	default:
+		/*
+		 * Once we have IIO support for the GPADC we should read
+		 * the USBID GPADC channel here and determine ACA role
+		 * based on that.
+		 */
+		return USB_ID_FLOAT;
+	}
 }
 
 static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
@@ -292,6 +299,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct cht_wc_extcon_data *ext;
+	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -352,9 +360,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	}
 
 	/* Unmask irqs */
-	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ_MASK,
-			   (int)~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_ID_GND |
-				  CHT_WC_PWRSRC_ID_FLOAT));
+	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ_MASK, mask);
 	if (ret) {
 		dev_err(ext->dev, "Error writing irq-mask: %d\n", ret);
 		goto disable_sw_control;
-- 
2.18.0

