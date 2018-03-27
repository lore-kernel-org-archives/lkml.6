Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC0H2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:28:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:55241 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeC0H2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:28:52 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [RESEND PATCH v2] ata: ahci-platform: add reset control support
Date: Tue, 27 Mar 2018 16:28:21 +0900
Message-Id: <1522135701-9964-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get and control a list of resets for the device
as optional and shared. These resets must be kept de-asserted until
the device is enabled.

This is specified as shared because some SoCs like UniPhier series
have common reset controls with all ahci controller instances.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v1:
- add 'Reviewed-by:' lines

 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb..f4006d3 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -30,6 +30,7 @@ compatible:
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
+- resets            : a list of phandle + reset specifier pairs
 - target-supply     : regulator for SATA target power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 749fd94..47ec77a2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -347,6 +347,7 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 341d0ef..3130db9 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -25,6 +25,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_platform.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -195,7 +196,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
  * following order:
  * 1) Regulator
  * 2) Clocks (through ahci_platform_enable_clks)
- * 3) Phys
+ * 3) Resets
+ * 4) Phys
  *
  * If resource enabling fails at any point the previous enabled resources
  * are disabled in reverse order.
@@ -215,12 +217,19 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = ahci_platform_enable_phys(hpriv);
+	rc = reset_control_deassert(hpriv->rsts);
 	if (rc)
 		goto disable_clks;
 
+	rc = ahci_platform_enable_phys(hpriv);
+	if (rc)
+		goto disable_resets;
+
 	return 0;
 
+disable_resets:
+	reset_control_assert(hpriv->rsts);
+
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
 
@@ -239,12 +248,15 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
  * following order:
  * 1) Phys
  * 2) Clocks (through ahci_platform_disable_clks)
- * 3) Regulator
+ * 3) Resets
+ * 4) Regulator
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
+	reset_control_assert(hpriv->rsts);
+
 	ahci_platform_disable_clks(hpriv);
 
 	ahci_platform_disable_regulators(hpriv);
@@ -393,6 +405,12 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
+	if (IS_ERR(hpriv->rsts)) {
+		rc = PTR_ERR(hpriv->rsts);
+		goto err_out;
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
-- 
2.7.4
