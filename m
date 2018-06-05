Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeFEVrp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:47:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752800AbeFEVpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:09 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 09/20] coresight: dts: Define new bindings for direction of data flow
Date: Tue,  5 Jun 2018 22:43:20 +0100
Message-Id: <1528235011-30691-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have relied on an undocumented property "slave-mode",
to indicate if the given port is input or not. Since we are
redefining the coresight bindings, define new property for the
"direction" of data flow for a given connection endpoint in the
device.

Each endpoint must define the following property.

 - "direction" : 0 => Port is input
		 1 => Port is output

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 24 ++++++++++++++--------
 drivers/hwtracing/coresight/of_coresight.c         | 22 ++++++++++++++++----
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index bf75ab3..ff382bc 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -103,9 +103,11 @@ with a specific direction of data flow, each connection must define the
 following properties to uniquely identify the connection details.
 
  * Direction of the data flow w.r.t the component :
-   Each input port must have the following property defined at the "endpoint"
+   Each hardware port must have the following property defined at the "endpoint"
    for the port.
-	"slave-mode"
+	"direction" - 32bit integer, whose values are defined as follows :
+		0 => the endpoint is an Input port
+		1 => the endpoint is an Output port.
 
  * Hardware Port number at the component:
      - Each "endpoint" must define the hardware port of the local end of the
@@ -129,7 +131,7 @@ Example:
 		clock-names = "apb_pclk";
 		port {
 			etb_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port0>;
 				coresight,hwid = <0>;
 			};
@@ -144,7 +146,7 @@ Example:
 		clock-names = "apb_pclk";
 		port {
 			tpiu_in_port: endpoint@0 {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port1>;
 				coresight,hwid = <0>;
 			};
@@ -166,6 +168,7 @@ Example:
 			port@0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&etb_in_port>;
 					coresight,hwid = <0>;
 				};
@@ -174,6 +177,7 @@ Example:
 			port@1 {
 				reg = <1>;
 				replicator_out_port1: endpoint {
+					direction = <1>;
 					remote-endpoint = <&tpiu_in_port>;
 					coresight,hwid = <1>;
 				};
@@ -183,7 +187,7 @@ Example:
 			port@2 {
 				reg = <1>;
 				replicator_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&funnel_out_port0>;
 					coresight,hwid = <0>;
 				};
@@ -205,6 +209,7 @@ Example:
 			port@0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 							<&replicator_in_port0>;
 					coresight,hwid = <0>;
@@ -215,7 +220,7 @@ Example:
 			port@1 {
 				reg = <1>;
 				funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm0_out_port>;
 					coresight,hwid = <0>;
 				};
@@ -224,7 +229,7 @@ Example:
 			port@2 {
 				reg = <2>;
 				funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm1_out_port>;
 					coresight,hwid = <1>;
 				};
@@ -233,7 +238,7 @@ Example:
 			port@3 {
 				reg = <3>;
 				funnel_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm0_out_port>;
 					coresight,hwid = <2>;
 				};
@@ -252,6 +257,7 @@ Example:
 		clock-names = "apb_pclk";
 		port {
 			ptm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port0>;
 				coresight,hwid = <0>;
 			};
@@ -267,6 +273,7 @@ Example:
 		clock-names = "apb_pclk";
 		port {
 			ptm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port1>;
 				coresight,hwid = <0>;
 			};
@@ -284,6 +291,7 @@ Example:
 		clock-names = "apb_pclk";
 		port {
 			stm_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&main_funnel_in_port2>;
 				coresight,hwid = <0>;
 			};
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index d23d7dd..0d6e6a9 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -45,7 +45,20 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
-static void of_coresight_get_ports(const struct device_node *node,
+static bool of_coresight_endpoint_is_input(struct device *dev,
+					   struct device_node *ep_node)
+{
+	u32 dir;
+
+	if (!of_property_read_u32(ep_node, "direction", &dir))
+		return dir == 0;
+
+	dev_warn_once(dev, "Missing mandatory \"direction\" property!\n");
+	return of_property_read_bool(ep_node, "slave-mode");
+}
+
+static void of_coresight_get_ports(struct device *dev,
+				   const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
 	struct device_node *ep = NULL;
@@ -56,7 +69,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_property_read_bool(ep, "slave-mode"))
+		if (of_coresight_endpoint_is_input(dev, ep))
 			in++;
 		else
 			out++;
@@ -149,7 +162,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 * No need to deal with input ports, processing for as
 		 * processing for output ports will deal with them.
 		 */
-		if (of_find_property(ep, "slave-mode", NULL))
+		if (of_coresight_endpoint_is_input(dev, ep))
 			break;
 
 		/* Parse the local port details */
@@ -212,7 +225,8 @@ of_get_coresight_platform_data(struct device *dev,
 	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
-	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
+	of_coresight_get_ports(dev, node,
+			       &pdata->nr_inport, &pdata->nr_outport);
 
 	/* If there are not output connections, we are done */
 	if (!pdata->nr_outport)
-- 
2.7.4
