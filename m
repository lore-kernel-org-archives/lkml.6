Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE4920844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="PQURTsbj";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="PQURTsbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE4920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGYVAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:00:23 -0400
Received: from node.akkea.ca ([192.155.83.177]:60968 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbeGYVAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:00:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5CB7F542066;
        Wed, 25 Jul 2018 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548020; bh=gEeceCDmWj2efu1V4GhaHymYOQ/ljVE4Lxgir9ZeSX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PQURTsbjFH7EwCCFCu6tVzWJLfTmo9DMLAmDgGAg8tXu3ytzxGiGHkeujOzKR0cU4
         0WWSKhBCHKTIh7OEDVQXKFCX/ysFScCktZX+an+0nQDl0GC281aYWnua2owioJJtoy
         aYDNfyK5IxiHJFWmlhsJNaRPVCcunMY9GWAYxhvs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rNiHegpRsiKI; Wed, 25 Jul 2018 19:47:00 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id AFB4954204A;
        Wed, 25 Jul 2018 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548020; bh=gEeceCDmWj2efu1V4GhaHymYOQ/ljVE4Lxgir9ZeSX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PQURTsbjFH7EwCCFCu6tVzWJLfTmo9DMLAmDgGAg8tXu3ytzxGiGHkeujOzKR0cU4
         0WWSKhBCHKTIh7OEDVQXKFCX/ysFScCktZX+an+0nQDl0GC281aYWnua2owioJJtoy
         aYDNfyK5IxiHJFWmlhsJNaRPVCcunMY9GWAYxhvs=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 4/4] power: bq25890_charger.c: Read back the current battery voltage
Date:   Wed, 25 Jul 2018 13:46:30 -0600
Message-Id: <20180725194630.10414-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725194630.10414-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part has the capability of reading the current battery voltage

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f4cf2987996b..60ccd6c2b7ad 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -464,6 +464,20 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!state.online) {
+			val->intval = 0;
+			break;
+		}
+
+		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
+		if (ret < 0)
+			return ret;
+
+		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
+		val->intval = 2304000 + ret * 20000;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -672,6 +686,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
 static char *bq25890_charger_supplied_to[] = {
-- 
2.17.1

