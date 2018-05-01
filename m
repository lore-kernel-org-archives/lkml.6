Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeEAIEz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:04:55 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.175]:18882 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751472AbeEAIEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:04:50 -0400
X-Authority-Reason: nr=8
From: Matheus Castello <matheus@castello.eng.br>
To: linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 2/2] pinctrl: generic: improve apply_setting error verbosity
Date: Tue,  1 May 2018 03:40:37 -0400
Message-Id: <1525160437-5222-3-git-send-email-matheus@castello.eng.br>
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
X-Exim-ID: 1fDPuj-001g0X-3z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:27442
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 9
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For generic pinconf: print the dev_error with the pinctrl vendor
driver name, error code, the sub-node property name used and the
pin that was tried to set.

Improves the undestading of the error if use a generic sub-node
property that generic-pinconf can do parse but the vendor pinctrl
driver does not support.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/pinctrl/pinconf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index d3fe143..fd5962a 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include "core.h"
 #include "pinconf.h"
 
@@ -169,9 +170,21 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
 				setting->data.configs.configs,
 				setting->data.configs.num_configs);
 		if (ret < 0) {
+#ifdef CONFIG_GENERIC_PINCONF
 			dev_err(pctldev->dev,
-				"pin_config_set op failed for pin %d\n",
+				"%s error %d seting %s for pin %d\n",
+				pctldev->desc->name, ret,
+				pinconf_generic_get_param_property_name(
+					pctldev, setting->data.configs.num_configs,
+					setting->data.configs.configs),
 				setting->data.configs.group_or_pin);
+#endif
+
+			dev_err(pctldev->dev,
+				"pin_config_set op failed for %s pin %d\n",
+				pctldev->desc->name,
+				setting->data.configs.group_or_pin);
+
 			return ret;
 		}
 		break;
-- 
2.7.4
