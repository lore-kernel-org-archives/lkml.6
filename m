Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B53EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9F420661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="mquajh8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9F420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbeGTVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:10:03 -0400
Received: from vern.gendns.com ([206.190.152.46]:50535 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbeGTVJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ya4YohUra/+FG+gbxg1YVVK3xdOb9BPE96T2ce1VYvw=; b=mquajh8X7IJvpKfyTk08j0uwm
        SNfSIh3AjKKsTJtRbN3Fnw5wI9HcFmD/GQBe8WlO57qo/GqFVaWAKCeaZZAq+7mE8gZ1oJf0oImjm
        nwqZ1go6DDKwyNrzoPMnd3GDknek6UPrJ2EbA+Fmq8z81RM1GYx82ebmU4G25J/LzA38s+XX7C08t
        duvujtgqM4f80GvKrp3nry+Hj01OAnVwmIFEe8YK8fnqYhFgFy3tZd0b9WELK1ypnAQ+aVv22I4Wp
        w8BXhJJAldCHsn1AVcCAOdoMTM9ZNaSw1r0IKJy+zCjUcLv1rRGrp3HoXXYjsYpWcMOIfmP0KWUiS
        V3MV+lgUw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41598 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgbse-006e0i-9h; Fri, 20 Jul 2018 16:20:00 -0400
From:   David Lechner <david@lechnology.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: lego_ev3_battery: Don't ignore iio_read_channel_processed() return value
Date:   Fri, 20 Jul 2018 15:19:43 -0500
Message-Id: <20180720201944.20503-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720201944.20503-1-david@lechnology.com>
References: <20180720201944.20503-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the LEGO MINDSTORMS EV3 power supply driver to return an
error if iio_read_channel_processed() fails.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/lego_ev3_battery.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 7b993d669f7f..6e3b3e384172 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -39,7 +39,7 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 					 union power_supply_propval *val)
 {
 	struct lego_ev3_battery *batt = power_supply_get_drvdata(psy);
-	int val2;
+	int ret, val2;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
@@ -47,11 +47,18 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		/* battery voltage is iio channel * 2 + Vce of transistor */
-		iio_read_channel_processed(batt->iio_v, &val->intval);
+		ret = iio_read_channel_processed(batt->iio_v, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval *= 2000;
 		val->intval += 200000;
+
 		/* plus adjust for shunt resistor drop */
-		iio_read_channel_processed(batt->iio_i, &val2);
+		ret = iio_read_channel_processed(batt->iio_i, &val2);
+		if (ret)
+			return ret;
+
 		val2 *= 1000;
 		val2 /= 15;
 		val->intval += val2;
@@ -64,7 +71,10 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		/* battery current is iio channel / 15 / 0.05 ohms */
-		iio_read_channel_processed(batt->iio_i, &val->intval);
+		ret = iio_read_channel_processed(batt->iio_i, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval *= 20000;
 		val->intval /= 15;
 		break;
-- 
2.17.1

