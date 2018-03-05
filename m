Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCETEm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:04:42 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35309 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCETEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:04:40 -0500
X-Google-Smtp-Source: AG47ELuj3Ibf70+EaqVaoPO6WSdt8TaRbY7/YvCwBv/zEpxdXeyZbYOqZf90mnyfCGB8FQ++LOCdjQ==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: devicetree@vger.kernel.org
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>, ilina@codeaurora.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Tue,  6 Mar 2018 00:06:45 +0530
Message-Id: <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520274879.git.amit.kucheria@linaro.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Chandrasekar <rkumbako@codeaurora.org>

There is currently no way for the governor to be selected for each thermal
zone in devicetree. This results in the default governor being used for all
thermal zones even though no such restriction exists in the core code.

Add support for specifying the thermal governor to be used for a thermal
zone in the devicetree. The devicetree config should specify the governor
name as a string that matches any available governors. If not specified, we
maintain the current behaviour of using the default governor.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
 drivers/thermal/of-thermal.c                          | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 1719d47..fced9d3 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -168,6 +168,14 @@ Optional property:
 			by means of sensor ID. Additional coefficients are
 			interpreted as constant offset.
 
+- thermal-governor:     Thermal governor to be used for this thermal zone.
+			Expected values are:
+			"step_wise": Use step wise governor.
+			"fair_share": Use fair share governor.
+			"user_space": Use user space governor.
+			"power_allocator": Use power allocator governor.
+  Type: string
+
 - sustainable-power:	An estimate of the sustainable power (in mW) that the
   Type: unsigned	thermal zone can dissipate at the desired
   Size: one cell	control temperature.  For reference, the
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index e09f035..a884b01 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -974,6 +974,7 @@ int __init of_parse_thermal_zones(void)
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
+		const char *governor_name;
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
@@ -996,6 +997,11 @@ int __init of_parse_thermal_zones(void)
 		/* No hwmon because there might be hwmon drivers registering */
 		tzp->no_hwmon = true;
 
+		if (!of_property_read_string(child, "thermal-governor",
+						&governor_name))
+			strlcpy(tzp->governor_name, governor_name,
+					THERMAL_NAME_LENGTH);
+
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
 
-- 
2.7.4
