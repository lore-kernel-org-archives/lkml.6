Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9D206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC9D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeJAEjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:39:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48714 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJAEjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:39:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 82ACB27E031
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Milo Kim <milo.kim@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Breck <kernel@networkimprov.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 10/14] power: supply: pcf50633: fix race-condition in sysfs registration
Date:   Mon,  1 Oct 2018 00:03:45 +0200
Message-Id: <20180930220349.10515-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This registers custom sysfs properties using the native functionality
of the power-supply framework, which cleans up the code a bit and
fixes a race-condition. Before this patch the sysfs attributes were
not properly registered to udev.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/pcf50633-charger.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index 1aba14046a83..28ed463c866d 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -245,17 +245,14 @@ static ssize_t set_chglim(struct device *dev,
  */
 static DEVICE_ATTR(chg_curlim, S_IRUGO | S_IWUSR, show_chglim, set_chglim);
 
-static struct attribute *pcf50633_mbc_sysfs_entries[] = {
+static struct attribute *pcf50633_mbc_sysfs_attrs[] = {
 	&dev_attr_chgmode.attr,
 	&dev_attr_usb_curlim.attr,
 	&dev_attr_chg_curlim.attr,
 	NULL,
 };
 
-static const struct attribute_group mbc_attr_group = {
-	.name	= NULL,			/* put in device directory */
-	.attrs	= pcf50633_mbc_sysfs_entries,
-};
+ATTRIBUTE_GROUPS(pcf50633_mbc_sysfs);
 
 static void
 pcf50633_mbc_irq_handler(int irq, void *data)
@@ -390,6 +387,7 @@ static const struct power_supply_desc pcf50633_mbc_ac_desc = {
 static int pcf50633_mbc_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
+	struct power_supply_config usb_psy_cfg;
 	struct pcf50633_mbc *mbc;
 	int i;
 	u8 mbcs1;
@@ -419,8 +417,11 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 		return PTR_ERR(mbc->adapter);
 	}
 
+	usb_psy_cfg = psy_cfg;
+	usb_psy_cfg.attr_grp = pcf50633_mbc_sysfs_groups;
+
 	mbc->usb = power_supply_register(&pdev->dev, &pcf50633_mbc_usb_desc,
-					 &psy_cfg);
+					 &usb_psy_cfg);
 	if (IS_ERR(mbc->usb)) {
 		dev_err(mbc->pcf->dev, "failed to register usb\n");
 		power_supply_unregister(mbc->adapter);
@@ -436,9 +437,6 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 		return PTR_ERR(mbc->ac);
 	}
 
-	if (sysfs_create_group(&pdev->dev.kobj, &mbc_attr_group))
-		dev_err(mbc->pcf->dev, "failed to create sysfs entries\n");
-
 	mbcs1 = pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCS1);
 	if (mbcs1 & PCF50633_MBCS1_USBPRES)
 		pcf50633_mbc_irq_handler(PCF50633_IRQ_USBINS, mbc);
@@ -457,7 +455,6 @@ static int pcf50633_mbc_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(mbc_irq_handlers); i++)
 		pcf50633_free_irq(mbc->pcf, mbc_irq_handlers[i]);
 
-	sysfs_remove_group(&pdev->dev.kobj, &mbc_attr_group);
 	power_supply_unregister(mbc->usb);
 	power_supply_unregister(mbc->adapter);
 	power_supply_unregister(mbc->ac);
-- 
2.19.0

