Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeCXX0Q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:26:16 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:1668 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeCXX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:26:15 -0400
From: Alban Bedel <albeu@free.fr>
To: linux-kernel@vger.kernel.org
Cc: Alban Bedel <albeu@free.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for the cells list
Date: Sun, 25 Mar 2018 00:24:57 +0100
Message-Id: <1521933899-362-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521933899-362-1-git-send-email-albeu@free.fr>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the cells as subnodes of the provider device without any
compatible property might clash with other bindings. To avoid this
problem update the binding to have all the cells in a 'nvmem-cells'
subnode with a 'nvmem-cells' compatible string. This new binding
guarantee that we can turn any kind of device in a nvmem provider.

While discouraged for new uses the old scheme is still supported for
backward compatibility.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 Documentation/devicetree/bindings/nvmem/nvmem.txt | 55 ++++++++++++++++-------
 drivers/nvmem/core.c                              | 10 +++++
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
index fd06c09..6b723e7 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
@@ -11,14 +11,29 @@ these data from, and where they are stored on the storage device.
 This document is here to document this.
 
 = Data providers =
-Contains bindings specific to provider drivers and data cells as children
-of this node.
+A data provider should have a subnode named 'nvmem-cells' that contains
+a subnodes for each data cells.
+
+For backward compatibility the nvmem data cells can be direct children
+of the data provider. This use is discouraged as it can conflict with
+other bindings.
 
 Optional properties:
  read-only: Mark the provider as read only.
 
+= Data cells list =
+The data cells list node should be named 'nvmem-cells' and have a
+child node for each data cell.
+
+Required properties:
+ compatible: Must be "nvmem-cells"
+ #address-cells: <1> if the provider use 32 bit addressing,
+                 <2> for 64 bits addressing
+ #size-cells: <1> if the provider use 32 bit sizes,
+              <2> for 64 bits sizes
+
 = Data cells =
-These are the child nodes of the provider which contain data cell
+These are the child nodes of the nvmem-cells node which contain data cell
 information like offset and size in nvmem provider.
 
 Required properties:
@@ -37,24 +52,30 @@ For example:
 		...
 
 		/* Data cells */
-		tsens_calibration: calib@404 {
-			reg = <0x404 0x10>;
-		};
+		nvmem-cells {
+			compatible = "nvmem-cells";
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-		tsens_calibration_bckp: calib_bckp@504 {
-			reg = <0x504 0x11>;
-			bits = <6 128>
-		};
+			tsens_calibration: calib@404 {
+				reg = <0x404 0x10>;
+			};
 
-		pvs_version: pvs-version@6 {
-			reg = <0x6 0x2>
-			bits = <7 2>
-		};
+			tsens_calibration_bckp: calib_bckp@504 {
+				reg = <0x504 0x11>;
+				bits = <6 128>
+			};
 
-		speed_bin: speed-bin@c{
-			reg = <0xc 0x1>;
-			bits = <2 3>;
+			pvs_version: pvs-version@6 {
+				reg = <0x6 0x2>
+				bits = <7 2>
+			};
 
+			speed_bin: speed-bin@c{
+				reg = <0xc 0x1>;
+				bits = <2 3>;
+
+			};
 		};
 		...
 	};
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 78051f0..a59195c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -783,6 +783,16 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
+	/* Devices using the new binding have all the cells in
+	 * a subnode with compatible = "nvmem-cells". In this
+	 * case the device will be the parent of this node.
+	 */
+	if (of_device_is_compatible(nvmem_np, "nvmem-cells")) {
+		nvmem_np = of_get_next_parent(nvmem_np);
+		if (!nvmem_np)
+			return ERR_PTR(-EINVAL);
+	}
+
 	nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
-- 
2.7.4
