Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5815BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119322086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPd3uaDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119322086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIKWJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:09:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39258 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeIKWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:08:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BH8bYF082840;
        Tue, 11 Sep 2018 12:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536685717;
        bh=Pff6VZKUoQSAkQoyDdee2vuNXRPxf7o05IPGv0EMvY0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oPd3uaDmUr6SyyQ/ZsswOw+LVkfcKbDS+HT5stFGErXOEacE4xD4cecXjpYwsVOU7
         EhQlFnCny3v71EvH+0rQyUddZdkBqYs4JfGLjIgr0G7D9eqE8JWcRTjXSUk8edGlIB
         R/QsvImCZVy39mmRUDyOIOJRzHtoSxk/MSWTcREg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8bZh017631;
        Tue, 11 Sep 2018 12:08:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:08:37 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:08:37 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8bUf000986;
        Tue, 11 Sep 2018 12:08:37 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.156.248])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8BH8ax21209;
        Tue, 11 Sep 2018 12:08:37 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 6/6] leds: lm3697: Add ramp rate feature
Date:   Tue, 11 Sep 2018 12:08:25 -0500
Message-ID: <20180911170825.17789-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the runtime ramp up and down of the
LEDs in the specific control bank.

Each control bank can have separate ramp up
and ramp down values for the lighting zones
the control banks manage.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series to support feature in ti-lmu

 drivers/leds/leds-lm3697.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
index 7416c545ec59..997c270a46b5 100644
--- a/drivers/leds/leds-lm3697.c
+++ b/drivers/leds/leds-lm3697.c
@@ -59,6 +59,8 @@ struct lm3697_led {
 	struct led_classdev led_dev;
 	struct lm3697 *priv;
 	int control_bank;
+	int ramp_up_rate;
+	int ramp_down_rate;
 };
 
 /**
@@ -178,6 +180,62 @@ static int lm3697_set_control_bank(struct lm3697 *priv)
 	return ret;
 }
 
+static int lm3697_find_ramp_reg_val(int rate)
+{
+	const static int lookup[16] = { 2, 262, 524, 1049, 2090, 4194, 8389,
+					16780, 33550, 41940, 50330, 58720,
+					67110, 83880, 100660, 117440};
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(lookup); i++) {
+		if (rate == lookup[i])
+			return i;
+
+		if (rate > lookup[i - 1] && rate < lookup[i]) {
+			if (rate - lookup[i - 1] < lookup[i] - rate)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int lm3697_set_ramp_rates(struct lm3697 *priv)
+{
+	u8 ramp, ramp_up, ramp_down;
+	struct lm3697_led *led;
+	u8 ramp_reg;
+	int i, ret = 0;
+
+	for (i = 0; i < 2; i++) {
+		led = &priv->leds[i];
+		if (led->ramp_up_rate == 0 && led->ramp_down_rate == 0)
+			continue;
+
+		if (led->control_bank == LM3697_CONTROL_A)
+			ramp_reg = LM3697_CTRL_A_RAMP;
+		else
+			ramp_reg = LM3697_CTRL_B_RAMP;
+
+		ramp_up = lm3697_find_ramp_reg_val(led->ramp_up_rate);
+		ramp_down = lm3697_find_ramp_reg_val(led->ramp_down_rate);
+
+		if (ramp_up < 0 || ramp_down < 0) {
+			dev_err(&priv->client->dev, "Cannot find ramp rate\n");
+			continue;
+		}
+
+		ramp = (ramp_up << 4) | ramp_down;
+		ret = regmap_write(priv->regmap, ramp_reg, ramp);
+		if (ret)
+			dev_err(&priv->client->dev, "Cannot write ramp config\n");
+	}
+
+	return ret;
+}
+
 static int lm3697_init(struct lm3697 *priv)
 {
 	int ret;
@@ -202,6 +260,9 @@ static int lm3697_init(struct lm3697 *priv)
 	if (ret)
 		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
 
+	ret = lm3697_set_ramp_rates(priv);
+	if (ret)
+		dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
 out:
 	return ret;
 }
@@ -254,6 +315,17 @@ static int lm3697_probe_dt(struct lm3697 *priv)
 			goto child_out;
 		}
 
+		ret = fwnode_property_read_u32(child, "runtime-ramp-up-msec",
+					       &led->ramp_up_rate);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp-up-msec property missing\n");
+
+		ret = fwnode_property_read_u32(child, "runtime-ramp-down-msec",
+					       &led->ramp_down_rate);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp-down-msec property missing\n");
+
+
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led->led_dev.default_trigger);
 
-- 
2.17.0.1855.g63749b2dea

