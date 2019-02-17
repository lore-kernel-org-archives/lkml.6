Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD3222F3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBQO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:28:20 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41309 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfBQO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:28:17 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BABFA1BF208;
        Sun, 17 Feb 2019 14:28:13 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/7] power: supply: core: Add a field to support battery max voltage
Date:   Sun, 17 Feb 2019 15:29:11 +0100
Message-Id: <20190217142914.17433-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a field for "voltage_max_design_uv" to present fully charged
battery voltage.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 569790ea6917..702a2b17ff78 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -575,6 +575,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh         = -EINVAL;
 	info->charge_full_design_uah         = -EINVAL;
 	info->voltage_min_design_uv          = -EINVAL;
+	info->voltage_max_design_uv          = -EINVAL;
 	info->precharge_current_ua           = -EINVAL;
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
@@ -615,6 +616,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
+			     &info->voltage_max_design_uv);
 	of_property_read_u32(battery_np, "precharge-current-microamp",
 			     &info->precharge_current_ua);
 	of_property_read_u32(battery_np, "charge-term-current-microamp",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 57b2ab82b951..2f9c201a54d1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -332,6 +332,7 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	    /* microWatt-hours */
 	int charge_full_design_uah;	    /* microAmp-hours */
 	int voltage_min_design_uv;	    /* microVolts */
+	int voltage_max_design_uv;	    /* microVolts */
 	int precharge_current_ua;	    /* microAmps */
 	int charge_term_current_ua;	    /* microAmps */
 	int constant_charge_current_max_ua; /* microAmps */
-- 
2.20.1

