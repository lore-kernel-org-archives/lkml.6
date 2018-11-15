Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB4BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C04223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C04223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeKOTnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:43:13 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:46466 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388015AbeKOTnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id C4C095FD40; Thu, 15 Nov 2018 17:36:04 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] Bluetooth: hci_bcm: Simplify clk_get error handling
Date:   Thu, 15 Nov 2018 17:35:54 +0800
Message-Id: <20181115093603.26729-7-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently checks the clk pointer for an error condition, as
returned by clk_get, before every invocation of the clk consumer API.
This is redundant if the goal is simply to ignore the errors, thereby
making the clk optional. The clk consumer API already checks if the
pointer is NULL or not.

Simplify the code a bit by assigning NULL to the clk pointer if the
error condition is one we want to ignore, which is every error except
deferred probing.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 800132369134..ff73ecb8215f 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -214,7 +214,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	int err;
 
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {
+	if (powered && !dev->clk_enabled) {
 		err = clk_prepare_enable(dev->clk);
 		if (err)
 			return err;
@@ -228,7 +228,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
+	if (!powered && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 
 	dev->clk_enabled = powered;
@@ -238,7 +238,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 	return err;
 }
@@ -911,6 +911,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
 		return PTR_ERR(dev->clk);
 
+	/* Ignore all other errors as before */
+	if (IS_ERR(dev->clk))
+		dev->clk = NULL;
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1

