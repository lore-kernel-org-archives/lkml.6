Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFANSI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:18:08 -0400
Received: from foss.arm.com ([217.140.101.70]:51916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751900AbeFANRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:17:07 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, sudeep.holla@arm.com, robh@kernel.org,
        mark.rutland@arm.com, frowand.list@gmail.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph bindings
Date: Fri,  1 Jun 2018 14:16:05 +0100
Message-Id: <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coresight drivers relied on default bindings for graph
in DT, while reusing the "reg" field of the "ports" to indicate
the actual hardware port number for the connections. However,
with the rules getting stricter w.r.t to the address mismatch
with the label, it is no longer possible to use the port address
field for the hardware port number. Hence, we add an explicit
property to denote the hardware port number, "coresight,hwid"
which must be specified for each "endpoint".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 26 +++++++++---
 drivers/hwtracing/coresight/of_coresight.c         | 46 ++++++++++++++++------
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index bd36e40..385581a 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -104,7 +104,11 @@ properties to uniquely identify the connection details.
 	"slave-mode"
 
  * Hardware Port number at the component:
-     -  The hardware port number is assumed to be the address of the "port" component.
+   - (Obsolete) The hardware port number is assumed to be the address of the "port" component.
+   - Each "endpoint" must define the hardware port of the local end of the
+     connection using the following property:
+	"coresight,hwid" - 32bit integer, hardware port number at the local end.
+
 
 
 Example:
@@ -120,6 +124,7 @@ Example:
 			etb_in_port: endpoint@0 {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -134,6 +139,7 @@ Example:
 			tpiu_in_port: endpoint@0 {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -154,6 +160,7 @@ Example:
 				reg = <0>;
 				replicator_out_port0: endpoint {
 					remote-endpoint = <&etb_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
@@ -161,15 +168,17 @@ Example:
 				reg = <1>;
 				replicator_out_port1: endpoint {
 					remote-endpoint = <&tpiu_in_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port@2 {
-				reg = <0>;
+				reg = <1>;
 				replicator_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&funnel_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -191,31 +200,35 @@ Example:
 				funnel_out_port0: endpoint {
 					remote-endpoint =
 							<&replicator_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port@1 {
-				reg = <0>;
+				reg = <1>;
 				funnel_in_port0: endpoint {
 					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port@2 {
-				reg = <1>;
+				reg = <2>;
 				funnel_in_port1: endpoint {
 					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port@3 {
-				reg = <2>;
+				reg = <3>;
 				funnel_in_port2: endpoint {
 					slave-mode;
 					remote-endpoint = <&etm0_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
@@ -233,6 +246,7 @@ Example:
 		port {
 			ptm0_out_port: endpoint {
 				remote-endpoint = <&funnel_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -247,6 +261,7 @@ Example:
 		port {
 			ptm1_out_port: endpoint {
 				remote-endpoint = <&funnel_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -263,6 +278,7 @@ Example:
 		port {
 			stm_out_port: endpoint {
 				remote-endpoint = <&main_funnel_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index a3f3416..99d7a9c 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -105,14 +105,37 @@ int of_coresight_get_cpu(const struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
+/*
+ * of_graph_ep_coresight_get_port_id : Get the hardware port number for the
+ * given endpoint device node. Prefer the explicit "coresight,hwid" property
+ * over the endpoint register id (obsolete bindings).
+ */
+static int of_graph_ep_coresight_get_port_id(struct device *dev,
+					     struct device_node *ep_node)
+{
+	struct of_endpoint ep;
+	int rc, port_id;
+
+
+	if (!of_property_read_u32(ep_node, "coresight,hwid", &port_id))
+		return port_id;
+
+	rc = of_graph_parse_endpoint(ep_node, &ep);
+	if (rc)
+		return rc;
+	dev_warn_once(dev,
+		      "ep%d: Mandatory \"coresight,hwid\" property missing."
+		      " DT uses obsolete coresight bindings\n", ep.port);
+	return ep.port;
+}
+
 struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
-	int ret = 0;
+	int ret = 0, outport, inport;
 	struct coresight_platform_data *pdata;
 	struct coresight_connection *conn;
-	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
 	struct device_node *ep = NULL;
 	struct device_node *rparent = NULL;
@@ -148,14 +171,10 @@ of_get_coresight_platform_data(struct device *dev,
 			if (of_find_property(ep, "slave-mode", NULL))
 				continue;
 
-			/* Get a handle on the local endpoint */
-			ret = of_graph_parse_endpoint(ep, &endpoint);
-
-			if (ret)
+			outport = of_graph_ep_coresight_get_port_id(dev, ep);
+			if (outport < 0)
 				continue;
-
-			/* The local out port number */
-			conn->outport = endpoint.port;
+			conn->outport = outport;
 
 			/*
 			 * Get a handle on the remote endpoint and the device
@@ -168,15 +187,16 @@ of_get_coresight_platform_data(struct device *dev,
 			if (!rparent)
 				continue;
 
-			if (of_graph_parse_endpoint(rep, &rendpoint))
-				continue;
-
 			rdev = of_coresight_get_endpoint_device(rparent);
 			if (!rdev)
 				return ERR_PTR(-EPROBE_DEFER);
 
+			inport = of_graph_ep_coresight_get_port_id(rdev, rep);
+			if (inport < 0)
+				continue;
+
 			conn->child_name = dev_name(rdev);
-			conn->child_port = rendpoint.port;
+			conn->child_port = inport;
 			conn++;
 		} while (ep);
 	}
-- 
2.7.4
