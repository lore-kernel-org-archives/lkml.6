Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF499C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C72089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeG0Lhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:37:32 -0400
Received: from foss.arm.com ([217.140.101.70]:40962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbeG0Lhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:37:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330311684;
        Fri, 27 Jul 2018 03:16:18 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC1EF3F575;
        Fri, 27 Jul 2018 03:16:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 8/9] coresight: Cleanup coresight DT bindings
Date:   Fri, 27 Jul 2018 11:15:36 +0100
Message-Id: <1532686537-12380-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coresight drivers relied on default bindings for graph
in DT, while reusing the "reg" field of the "ports" to indicate
the actual hardware port number for the connections. This can
cause duplicate ports with same addresses, but different
direction. However, with the rules getting stricter for the
address mismatch with the label, it is no longer possible to use
the port address field for the hardware port number.

This patch introduces new DT binding rules for coresight
components, based on the same generic DT graph bindings, but
avoiding the address duplication.

- All output ports must be specified under a child node with
  name "out-ports".
- All input ports must be specified under a childe node with
  name "in-ports".
- Port address should match the hardware port number.

The support for legacy bindings is retained, with a warning.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 95 ++++++++++++---------
 drivers/hwtracing/coresight/of_coresight.c         | 98 +++++++++++++++++++---
 2 files changed, 143 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 5d1ad09..f39d2c6 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -54,9 +54,7 @@ its hardware characteristcs.
 	  clocks the core of that coresight component. The latter clock
 	  is optional.
 
-	* port or ports: The representation of the component's port
-	  layout using the generic DT graph presentation found in
-	  "bindings/graph.txt".
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Additional required properties for System Trace Macrocells (STM):
 	* reg: along with the physical base address and length of the register
@@ -73,7 +71,7 @@ its hardware characteristcs.
 	  AMBA markee):
 		- "arm,coresight-replicator"
 
-	* port or ports: same as above.
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Optional properties for ETM/PTMs:
 
@@ -96,6 +94,20 @@ its hardware characteristcs.
 	* interrupts : Exactly one SPI may be listed for reporting the address
 	  error
 
+Graph bindings for Coresight
+-------------------------------
+
+Coresight components are interconnected to create a data path for the flow of
+trace data generated from the "sources" to their collection points "sink".
+Each coresight component must describe the "input" and "output" connections.
+The connections must be described via generic DT graph bindings as described
+by the "bindings/graph.txt", where each "port" along with an "endpoint"
+component represents a hardware port and the connection.
+
+ * All output ports must be listed inside a child node named "out-ports"
+ * All input ports must be listed inside a child node named "in-ports".
+ * Port address must match the hardware port number.
+
 Example:
 
 1. Sinks
@@ -105,10 +117,11 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
+		in-ports {
+			port {
+				etb_in_port: endpoint@0 {
+					remote-endpoint = <&replicator_out_port0>;
+				};
 			};
 		};
 	};
@@ -119,10 +132,11 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			tpiu_in_port: endpoint@0 {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+		out-ports {
+			port {
+				tpiu_in_port: endpoint@0 {
+					remote-endpoint = <&replicator_out_port1>;
+				};
 			};
 		};
 	};
@@ -163,7 +177,7 @@ Example:
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -181,12 +195,11 @@ Example:
 					remote-endpoint = <&tpiu_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port@2 {
-				reg = <0>;
+		in-ports {
+			port {
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel_out_port0>;
 				};
 			};
@@ -199,40 +212,36 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* funnel output port */
-			port@0 {
-				reg = <0>;
+		out-ports {
+			port {
 				funnel_out_port0: endpoint {
 					remote-endpoint =
 							<&replicator_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port@1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
 				reg = <0>;
 				funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
 				};
 			};
 
-			port@2 {
+			port@1 {
 				reg = <1>;
 				funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
 				};
 			};
 
-			port@3 {
+			port@2 {
 				reg = <2>;
 				funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm0_out_port>;
 				};
 			};
@@ -248,9 +257,11 @@ Example:
 		cpu = <&cpu0>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port0>;
+		out-ports {
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -262,9 +273,11 @@ Example:
 		cpu = <&cpu1>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port1>;
+		out-ports {
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -278,9 +291,11 @@ Example:
 
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
-		port {
-			stm_out_port: endpoint {
-				remote-endpoint = <&main_funnel_in_port2>;
+		out-ports {
+			port {
+				stm_out_port: endpoint {
+					remote-endpoint = <&main_funnel_in_port2>;
+				};
 			};
 		};
 	};
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index e8fb4e1..da71c97 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -45,13 +45,13 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
-static inline bool of_coresight_ep_is_input(struct device_node *ep)
+static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
 {
 	return of_property_read_bool(ep, "slave-mode");
 }
 
-static void of_coresight_get_ports(const struct device_node *node,
-				   int *nr_inport, int *nr_outport)
+static void of_coresight_get_ports_legacy(const struct device_node *node,
+					  int *nr_inport, int *nr_outport)
 {
 	struct device_node *ep = NULL;
 	int in = 0, out = 0;
@@ -61,7 +61,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_coresight_ep_is_input(ep))
+		if (of_coresight_legacy_ep_is_input(ep))
 			in++;
 		else
 			out++;
@@ -72,6 +72,67 @@ static void of_coresight_get_ports(const struct device_node *node,
 	*nr_outport = out;
 }
 
+static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
+{
+	struct device_node *parent = of_graph_get_port_parent(ep);
+
+	/*
+	 * Skip one-level up to the real device node, if we
+	 * are using the new bindings.
+	 */
+	if (!of_node_cmp(parent->name, "in-ports") ||
+	    !of_node_cmp(parent->name, "out-ports"))
+		parent = of_get_next_parent(parent);
+
+	return parent;
+}
+
+static inline struct device_node *
+of_coresight_get_input_ports_node(const struct device_node *node)
+{
+	return of_get_child_by_name(node, "in-ports");
+}
+
+static inline struct device_node *
+of_coresight_get_output_ports_node(const struct device_node *node)
+{
+	return of_get_child_by_name(node, "out-ports");
+}
+
+static inline int
+of_coresight_count_ports(struct device_node *port_parent)
+{
+	int i = 0;
+	struct device_node *ep = NULL;
+
+	while ((ep = of_graph_get_next_endpoint(port_parent, ep)))
+		i++;
+	return i;
+}
+
+static void of_coresight_get_ports(const struct device_node *node,
+				   int *nr_inport, int *nr_outport)
+{
+	struct device_node *input_ports = NULL, *output_ports = NULL;
+
+	input_ports = of_coresight_get_input_ports_node(node);
+	output_ports = of_coresight_get_output_ports_node(node);
+
+	if (input_ports || output_ports) {
+		if (input_ports) {
+			*nr_inport = of_coresight_count_ports(input_ports);
+			of_node_put(input_ports);
+		}
+		if (output_ports) {
+			*nr_outport = of_coresight_count_ports(output_ports);
+			of_node_put(output_ports);
+		}
+	} else {
+		/* Fall back to legacy DT bindings parsing */
+		of_coresight_get_ports_legacy(node, nr_inport, nr_outport);
+	}
+}
+
 static int of_coresight_alloc_memory(struct device *dev,
 			struct coresight_platform_data *pdata)
 {
@@ -136,7 +197,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		rep = of_graph_get_remote_endpoint(ep);
 		if (!rep)
 			break;
-		rparent = of_graph_get_port_parent(rep);
+		rparent = of_coresight_get_port_parent(rep);
 		if (!rparent)
 			break;
 		if (of_graph_parse_endpoint(rep, &rendpoint))
@@ -176,6 +237,8 @@ of_get_coresight_platform_data(struct device *dev,
 	struct coresight_platform_data *pdata;
 	struct coresight_connection *conn;
 	struct device_node *ep = NULL;
+	const struct device_node *parent = NULL;
+	bool legacy_binding = false;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -196,14 +259,29 @@ of_get_coresight_platform_data(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	parent = of_coresight_get_output_ports_node(node);
+	/*
+	 * If the DT uses obsoleted bindings, the ports are listed
+	 * under the device and we need to filter out the input
+	 * ports.
+	 */
+	if (!parent) {
+		legacy_binding = true;
+		parent = node;
+		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
+	}
+
 	conn = pdata->conns;
-	/* Iterate through each port to discover topology */
-	while ((ep = of_graph_get_next_endpoint(node, ep))) {
+
+	/* Iterate through each output port to discover topology */
+	while ((ep = of_graph_get_next_endpoint(parent, ep))) {
 		/*
-		 * No need to deal with input ports, as processing the
-		 * output ports connected to them will process the details.
+		 * Legacy binding mixes input/output ports under the
+		 * same parent. So, skip the input ports if we are dealing
+		 * with legacy binding, as they processed with their
+		 * connected output ports.
 		 */
-		if (of_coresight_ep_is_input(ep))
+		if (legacy_binding && of_coresight_legacy_ep_is_input(ep))
 			continue;
 
 		ret = of_coresight_parse_endpoint(dev, ep, conn);
-- 
2.7.4

