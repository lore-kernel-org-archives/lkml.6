Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC6ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B782420664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="NipsQLyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B782420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeKAJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:13:20 -0400
Received: from onstation.org ([52.200.56.107]:44736 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeKAJMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 802CAB0C;
        Thu,  1 Nov 2018 00:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031131;
        bh=iezGjImedq/LkxrzjpD62LOtq1MXGldLnWtale4QFC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NipsQLyXdupZtXv21zSjgnBJGQO2a8x7yt+mm9dFaDTPJwk4aJhZ0Anvm/Btd/mS+
         KjdgRR/hJEhgDKixHY7akj+/feQXhtwmREvvfy2R3ZF1g/2Ev5ejeAuwCx3PRmdB+U
         01DhWGdu5R/ieQcy5wBOl5b8N1TGNlvR3vL+RpQ0=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 2/7] power: supply: bq24190_charger: add support for bq24192 variant
Date:   Wed, 31 Oct 2018 20:11:44 -0400
Message-Id: <20181101001149.13453-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds support for the bq24192 variant to bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: Changed if statement to a switch based on
feedback from Sebastian Reichel.]
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b58df04d03b3..44d3aff32885 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1637,8 +1637,12 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
-	if (v != BQ24190_REG_VPRS_PN_24190 &&
-	    v != BQ24190_REG_VPRS_PN_24192I) {
+	switch (v) {
+	case BQ24190_REG_VPRS_PN_24190:
+	case BQ24190_REG_VPRS_PN_24192:
+	case BQ24190_REG_VPRS_PN_24192I:
+		break;
+	default:
 		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		return -ENODEV;
 	}
@@ -1931,6 +1935,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
+	{ "bq24192" },
 	{ "bq24192i" },
 	{ },
 };
@@ -1939,6 +1944,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
 	{ },
 };
-- 
2.17.2

