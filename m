Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD27C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF4F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393913AbeKVUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:50:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbeKVUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:50:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C44752753E0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-pm@vger.kernel.org, sre@kernel.org
Cc:     Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 1/2] power: supply: add input voltage limit property.
Date:   Thu, 22 Nov 2018 11:11:18 +0100
Message-Id: <20181122101119.29194-1-enric.balletbo@collabora.com>
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
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v2:
- Document the new property in ABI/testing/sysfs-class-power.
- Add the Reviewed-by Guenter Roeck tag.

 Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
 Documentation/power/power_supply_class.txt  |  2 ++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dce1b..4fb24b0a28df 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -335,6 +335,17 @@ Description:
 		Access: Read, Write
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
+Date:		Nov 2018
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Details the incoming VBUS voltage limit currently set in the
+		supply. Normally this is configured based on the type of
+		connection made.
+
+		Access: Read, Write
+		Valid values: Represented in microvolts
+
 What:		/sys/class/power_supply/<supply_name>/online,
 Date:		May 2007
 Contact:	linux-pm@vger.kernel.org
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

