Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB03A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeKVCJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:09:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49038 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeKVCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:09:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D00DF271740
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-pm@vger.kernel.org, sre@kernel.org
Cc:     Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] power: supply: add input voltage limit property.
Date:   Wed, 21 Nov 2018 16:34:43 +0100
Message-Id: <20181121153444.24747-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a problem with USBPD chargers which under certain conditions
can result in system overheating if the voltage provided by the USBPD
port is too high. While the preferred means to control this would be
through devicetree or ACPI settings, this is not always possible, and
we need to have a means to set a voltage limit.

This patch exposes a new property, similar to input current limit, to
re-configure the maximum voltage from the external supply at runtime
based on system-level knowledge or user input.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 Documentation/power/power_supply_class.txt | 2 ++
 drivers/power/supply/power_supply_sysfs.c  | 1 +
 include/linux/power_supply.h               | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index 300d37896e51..7b4be615b4f8 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -137,6 +137,8 @@ power supply object.
 
 INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
 the current drawn from a charging source.
+INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
+the voltage limit from a charging source.
 
 CHARGE_CONTROL_LIMIT - current charge control limit setting
 CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5848742ebb59 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(charge_control_limit),
 	POWER_SUPPLY_ATTR(charge_control_limit_max),
 	POWER_SUPPLY_ATTR(input_current_limit),
+	POWER_SUPPLY_ATTR(input_voltage_limit),
 	POWER_SUPPLY_ATTR(energy_full_design),
 	POWER_SUPPLY_ATTR(energy_empty_design),
 	POWER_SUPPLY_ATTR(energy_full),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f80769175c56..608ba88e32ee 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -122,6 +122,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
-- 
2.19.1

