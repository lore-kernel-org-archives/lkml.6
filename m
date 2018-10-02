Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574082089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574082089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeJBObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:31:38 -0400
Received: from olimex.com ([184.105.72.32]:56423 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbeJBObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:31:38 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 10:31:37 EDT
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AES(128):Mac=SHA256) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 00:39:35 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] mfd: rk808: Prepare rk805 for poweroff
Date:   Tue,  2 Oct 2018 10:38:29 +0300
Message-Id: <1538465910-27233-1-git-send-email-stefan@olimex.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK805 has SLEEP signal, which can put the device into SLEEP or OFF
mode. The default is SLEEP mode.

However, when the kernel performs power-off (actually the ATF) the
device will not go fully off and this will result in higher power
consumption and inability to wake the device with RTC alarm.

The solution is to enable pm_power_off_prepare function, which will
configure SLEEP pin for OFF function.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/mfd/rk808.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 216fbf6..50f3f78 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -387,6 +387,25 @@ static void rk805_device_shutdown(void)
 		dev_err(&rk808_i2c_client->dev, "power off error!\n");
 }
 
+static void rk805_device_shutdown_prepare(void)
+{
+	int ret;
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+
+	if (!rk808) {
+		dev_warn(&rk808_i2c_client->dev,
+			 "have no rk805, so do nothing here\n");
+
+		return;
+	}
+
+	ret = regmap_update_bits(rk808->regmap,
+				 RK805_GPIO_IO_POL_REG,
+				 SLP_SD_MSK, SHUTDOWN_FUN);
+	if (ret)
+		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+}
+
 static void rk808_device_shutdown(void)
 {
 	int ret;
@@ -549,6 +568,10 @@ static int rk808_probe(struct i2c_client *client,
 	if (pm_off && !pm_power_off) {
 		rk808_i2c_client = client;
 		pm_power_off = pm_pwroff_fn;
+	} else if (pm_off && !pm_power_off_prepare &&
+		   rk808->variant == RK805_ID) {
+		rk808_i2c_client = client;
+		pm_power_off_prepare = rk805_device_shutdown_prepare;
 	}
 
 	return 0;
@@ -564,6 +587,7 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	pm_power_off = NULL;
+	pm_power_off_prepare = NULL;
 
 	return 0;
 }
-- 
2.7.4

