Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeFEVpK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:45:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:45:06 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 08/20] coresight: dts: Cleanup device tree graph bindings
Date: Tue,  5 Jun 2018 22:43:19 +0100
Message-Id: <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
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
 .../devicetree/bindings/arm/coresight.txt          | 29 ++++++++++---
 drivers/hwtracing/coresight/of_coresight.c         | 49 +++++++++++++++++-----
 2 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index ed6b555..bf75ab3 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -108,8 +108,13 @@ following properties to uniquely identify the connection details.
 	"slave-mode"
 
  * Hardware Port number at the component:
-     -  The hardware port number is assumed to be the address of the "port"
-         component.
+     - Each "endpoint" must define the hardware port of the local end of the
+       connection using the following property :
+
+	"coresight,hwid" - 32bit integer, local hardware port.
+
+     - [ ** Obsolete ** ] The hardware port number is assumed to be the address
+       of the "port" component.
 
 
 
@@ -126,6 +131,7 @@ Example:
 			etb_in_port: endpoint@0 {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -140,6 +146,7 @@ Example:
 			tpiu_in_port: endpoint@0 {
 				slave-mode;
 				remote-endpoint = <&replicator_out_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -160,6 +167,7 @@ Example:
 				reg = <0>;
 				replicator_out_port0: endpoint {
 					remote-endpoint = <&etb_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
@@ -167,15 +175,17 @@ Example:
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
@@ -197,31 +207,35 @@ Example:
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
 
@@ -239,6 +253,7 @@ Example:
 		port {
 			ptm0_out_port: endpoint {
 				remote-endpoint = <&funnel_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -253,6 +268,7 @@ Example:
 		port {
 			ptm1_out_port: endpoint {
 				remote-endpoint = <&funnel_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -269,6 +285,7 @@ Example:
 		port {
 			stm_out_port: endpoint {
 				remote-endpoint = <&main_funnel_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index d01a9ce..d23d7dd 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -99,6 +99,31 @@ int of_coresight_get_cpu(const struct device_node *node)
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 /*
+ * of_coresight_endpoint_get_port_id : Get the hardware port number for the
+ * given endpoint device node. Prefer the explicit "coresight,hwid" property
+ * over the endpoint register id (obsolete bindings).
+ */
+static int of_coresight_endpoint_get_port_id(struct device *dev,
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
+		      "ep%d: Mandatory \"coresight,hwid\" property missing.\n",
+		      ep.port);
+	dev_warn_once(dev, "DT uses obsolete coresight bindings\n");
+	return ep.port;
+}
+
+/*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
  * and fill the connection information in *@pconn.
  *
@@ -109,11 +134,11 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
  *	 0	- If the parsing completed without any fatal errors.
  *	-Errno	- Fatal error, abort the scanning.
  */
-static int of_coresight_parse_endpoint(struct device_node *ep,
+static int of_coresight_parse_endpoint(struct device *dev,
+				       struct device_node *ep,
 				       struct coresight_connection **pconn)
 {
-	int ret = 0;
-	struct of_endpoint endpoint, rendpoint;
+	int ret = 0, local_port, child_port;
 	struct device_node *rparent = NULL;
 	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
@@ -128,7 +153,8 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 			break;
 
 		/* Parse the local port details */
-		if (of_graph_parse_endpoint(ep, &endpoint))
+		local_port = of_coresight_endpoint_get_port_id(dev, ep);
+		if (local_port < 0)
 			break;
 		/*
 		 * Get a handle on the remote endpoint and the device it is
@@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 		rparent = of_graph_get_port_parent(rep);
 		if (!rparent)
 			break;
-		if (of_graph_parse_endpoint(rep, &rendpoint))
-			break;
-
 		/* If the remote device is not available, defer probing */
 		rdev = of_coresight_get_endpoint_device(rparent);
 		if (!rdev) {
@@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 			break;
 		}
 
-		conn->outport = endpoint.port;
+		child_port = of_coresight_endpoint_get_port_id(rdev, rep);
+		if (child_port < 0) {
+			ret = 0;
+			break;
+		}
+
+		conn->outport = local_port;
 		conn->child_name = dev_name(rdev);
-		conn->child_port = rendpoint.port;
+		conn->child_port = child_port;
 		/* Move the connection record */
 		(*pconn)++;
 	} while (0);
@@ -200,7 +229,7 @@ of_get_coresight_platform_data(struct device *dev,
 		ep = of_graph_get_next_endpoint(node, ep);
 		if (!ep)
 			break;
-		ret = of_coresight_parse_endpoint(ep, &conn);
+		ret = of_coresight_parse_endpoint(dev, ep, &conn);
 		if (ret)
 			return ERR_PTR(ret);
 	} while (ep);
-- 
2.7.4
