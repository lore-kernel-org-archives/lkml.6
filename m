Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeEAIDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:03:31 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.46]:30708 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751833AbeEAID0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:03:26 -0400
X-Authority-Reason: nr=8
From: Matheus Castello <matheus@castello.eng.br>
To: linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 1/2] pinctrl: generic: add API to solve generic sub-node property name
Date: Tue,  1 May 2018 03:40:36 -0400
Message-Id: <1525160437-5222-2-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525160437-5222-1-git-send-email-matheus@castello.eng.br>
References: <1525160437-5222-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1fDPue-001g0X-Jl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:27442
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 5
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set dt_params with the definitions of the generic sub-node properties
global in pinconf-generic.h and add a function to pinconf-generic API
to decode a packed param returning the string name from sub-node
property.

This can be useful in debug from pinctrl-vendor driver or even for
debug in pinconf driver.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/pinctrl/pinconf-generic.c       | 61 +++++++++++++++++----------------
 include/linux/pinctrl/pinconf-generic.h | 32 +++++++++++++++++
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index b4f7f8a..78585bc 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -156,34 +156,6 @@ EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
 #endif
 
 #ifdef CONFIG_OF
-static const struct pinconf_generic_params dt_params[] = {
-	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
-	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
-	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
-	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
-	{ "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 1 },
-	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
-	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
-	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
-	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
-	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
-	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
-	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
-	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
-	{ "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
-	{ "input-schmitt-disable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 0 },
-	{ "input-schmitt-enable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 1 },
-	{ "low-power-disable", PIN_CONFIG_LOW_POWER_MODE, 0 },
-	{ "low-power-enable", PIN_CONFIG_LOW_POWER_MODE, 1 },
-	{ "output-disable", PIN_CONFIG_OUTPUT_ENABLE, 0 },
-	{ "output-enable", PIN_CONFIG_OUTPUT_ENABLE, 1 },
-	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
-	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
-	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
-	{ "sleep-hardware-state", PIN_CONFIG_SLEEP_HARDWARE_STATE, 0 },
-	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
-	{ "skew-delay", PIN_CONFIG_SKEW_DELAY, 0 },
-};
 
 /**
  * parse_dt_cfg() - Parse DT pinconf parameters
@@ -247,14 +219,14 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 		return -EINVAL;
 
 	/* allocate a temporary array big enough to hold one of each option */
-	max_cfg = ARRAY_SIZE(dt_params);
+	max_cfg = ARRAY_SIZE(pinconf_dt_params);
 	if (pctldev)
 		max_cfg += pctldev->desc->num_custom_params;
 	cfg = kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
 
-	parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
+	parse_dt_cfg(np, pinconf_dt_params, ARRAY_SIZE(pinconf_dt_params), cfg, &ncfg);
 	if (pctldev && pctldev->desc->num_custom_params &&
 		pctldev->desc->custom_params)
 		parse_dt_cfg(np, pctldev->desc->custom_params,
@@ -409,4 +381,33 @@ void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinconf_generic_dt_free_map);
 
+const char *pinconf_generic_get_param_property_name(struct pinctrl_dev *pctldev,
+	unsigned int num_configs, unsigned long *param)
+{
+	struct pinctrl_desc *desc = pctldev->desc;
+	unsigned int num_params = ARRAY_SIZE(pinconf_dt_params),
+		num_custom_params = desc->num_custom_params,
+		i, j;
+
+	for (i = 0; i < num_configs; i++) {
+		enum pin_config_param pin_param =
+		pinconf_to_config_param(param[i]);
+
+		/* first search on default properties */
+		for (j = 0; j < num_params; j++) {
+			if (pin_param == pinconf_dt_params[j].param)
+				return pinconf_dt_params[j].property;
+		}
+
+		/* search on custom properties */
+		for (j = 0; j < num_custom_params; j++) {
+			if (pin_param == desc->custom_params[j].param)
+				return desc->custom_params[j].property;
+		}
+	}
+
+	return "property undefined";
+}
+EXPORT_SYMBOL_GPL(pinconf_generic_get_param_property_name);
+
 #endif
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 6c06806..c51f4b3 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -184,6 +184,35 @@ struct pinconf_generic_params {
 	u32 default_value;
 };
 
+static const struct pinconf_generic_params pinconf_dt_params[] = {
+	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 1 },
+	{ "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 1 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
+	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
+	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
+	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
+	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
+	{ "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
+	{ "input-schmitt-disable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 0 },
+	{ "input-schmitt-enable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 1 },
+	{ "low-power-disable", PIN_CONFIG_LOW_POWER_MODE, 0 },
+	{ "low-power-enable", PIN_CONFIG_LOW_POWER_MODE, 1 },
+	{ "output-disable", PIN_CONFIG_OUTPUT_ENABLE, 0 },
+	{ "output-enable", PIN_CONFIG_OUTPUT_ENABLE, 1 },
+	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
+	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
+	{ "sleep-hardware-state", PIN_CONFIG_SLEEP_HARDWARE_STATE, 0 },
+	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
+	{ "skew-delay", PIN_CONFIG_SKEW_DELAY, 0 },
+};
+
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
 		unsigned *reserved_maps, unsigned *num_maps,
@@ -194,6 +223,9 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
 		struct pinctrl_map *map, unsigned num_maps);
 
+const char *pinconf_generic_get_param_property_name(struct pinctrl_dev *pctldev,
+		unsigned int num_configs, unsigned long *param);
+
 static inline int pinconf_generic_dt_node_to_map_group(
 		struct pinctrl_dev *pctldev, struct device_node *np_config,
 		struct pinctrl_map **map, unsigned *num_maps)
-- 
2.7.4
