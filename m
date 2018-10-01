Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE087C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B6421477
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Egg9WR/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B6421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeJAMG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:28 -0400
Received: from onstation.org ([52.200.56.107]:35948 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbeJAMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:28 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3520C972;
        Mon,  1 Oct 2018 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371828;
        bh=I2yy/b5ZELNTCdDLBtSa03Crd2LWDJA+Mk6VlqD4eWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Egg9WR/NlbPgB5a8AaqCMQ/eeux8NxYnWdjrXkeom+EeXDBOTe3cm8D3sqOLeNKSS
         HBw2106uF0Ny9+3GWaTvLp6CawN0MmlPEzNE7owGTdi1i5M9HmGD22mEn0+/r75nx8
         x7ylv7bnCQgOslRSB0evJSZ4OWtJ7+LzEeDdmv8s=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 2/5] power: supply: bq24190_charger: add support for bq24192 variant
Date:   Mon,  1 Oct 2018 01:30:02 -0400
Message-Id: <20181001053005.18906-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

This patch adds support for the bq24192 variant to bq24190_charger.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/power/supply/bq24190_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b58df04d03b3..e3836145286d 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1638,7 +1638,8 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		return ret;
 
 	if (v != BQ24190_REG_VPRS_PN_24190 &&
-	    v != BQ24190_REG_VPRS_PN_24192I) {
+		v != BQ24190_REG_VPRS_PN_24192 &&
+		v != BQ24190_REG_VPRS_PN_24192I) {
 		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		return -ENODEV;
 	}
@@ -1931,6 +1932,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
+	{ "bq24192" },
 	{ "bq24192i" },
 	{ },
 };
@@ -1939,6 +1941,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
+	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
 	{ },
 };
-- 
2.17.1

