Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283AE20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="e3uqE2zp";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="tp6gMNmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283AE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeGaSY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:24:57 -0400
Received: from node.akkea.ca ([192.155.83.177]:53340 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGaSY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:24:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1772354204F;
        Tue, 31 Jul 2018 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055428; bh=dCfHocIygE2OVwn7APcYr3UlqLVlhR6vjcV4lVWShuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e3uqE2zpTJ6ijtL+rm3QN5uVJ5lnGsf+y2DczPs4eeZ8PWtG3Vzp0ugUVBHN0+1QY
         g1yVExdzrrm5Y9Hpkxz1sTrA4+0lNHcxV7M0VBrps7BgcCh1jRdvS/mRbOhyZMONGJ
         mITa818qKqj6pHCmNPUAVM7ame0KQbJfThRRIx6s=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PqJDkMT_kRZB; Tue, 31 Jul 2018 16:43:47 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 5F8E454204E;
        Tue, 31 Jul 2018 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055427; bh=dCfHocIygE2OVwn7APcYr3UlqLVlhR6vjcV4lVWShuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tp6gMNmcouP1+S5ZX70x1jEZiSrXgcJUXiZnbKqQ6G3FnB6wGpQic1qZFaPh7UkLu
         AGLL8fA6vAensODXhws+0u3aDaeIERIEcxKTNdvi2vIJ4mOoENwvOKImjIN4poo+KL
         /qCgof1MMli0hGHY86gn0pZKF0dGIkMpQIoxQbAE=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 4/4] power: bq25890_charger.c: Read back the current battery voltage
Date:   Tue, 31 Jul 2018 10:43:16 -0600
Message-Id: <20180731164316.32696-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731164316.32696-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part has the capability of reading the current battery voltage.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 23b39da07e56..1aa7872ddeb0 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -461,6 +461,15 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
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
@@ -669,6 +678,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
 static char *bq25890_charger_supplied_to[] = {
-- 
2.17.1

