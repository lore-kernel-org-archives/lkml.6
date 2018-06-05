Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeFEVtZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:49:25 -0400
Received: from foss.arm.com ([217.140.101.70]:34436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752512AbeFEVou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:44:50 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 02/20] coresight: of: Fix refcounting for graph nodes
Date: Tue,  5 Jun 2018 22:43:13 +0100
Message-Id: <1528235011-30691-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coresight driver doesn't drop the references on the
remote endpoint/port nodes. Add the missing of_node_put()
calls. To make it easier to handle different corner cases
cleanly, move the parsing of an endpoint to separate
function.

Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 139 +++++++++++++++++------------
 1 file changed, 84 insertions(+), 55 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index a33a92e..8a23c63 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -111,17 +111,80 @@ int of_coresight_get_cpu(const struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
+/*
+ * of_coresight_parse_endpoint : Parse the given output endpoint @ep
+ * and fill the connection information in @pdata[*@i].
+ *
+ * Parses the local port, remote device name and the remote port. Also
+ * updates *@i to point to the next index, when an entry is added.
+ *
+ * Returns :
+ *	 0	- If the parsing completed without any fatal errors.
+ *	-Errno	- Fatal error, abort the scanning.
+ */
+static int of_coresight_parse_endpoint(struct device_node *ep,
+				       struct coresight_platform_data *pdata,
+				       int *i)
+{
+	int ret = 0;
+	struct of_endpoint endpoint, rendpoint;
+	struct device_node *rparent = NULL;
+	struct device_node *rport = NULL;
+	struct device *rdev = NULL;
+
+	do {
+		/*
+		 * No need to deal with input ports, processing for as
+		 * processing for output ports will deal with them.
+		 */
+		if (of_find_property(ep, "slave-mode", NULL))
+			break;
+
+		/* Parse the local port details */
+		if (of_graph_parse_endpoint(ep, &endpoint))
+			break;
+		/*
+		 * Get a handle on the remote port and parent
+		 * attached to it.
+		 */
+		rparent = of_graph_get_remote_port_parent(ep);
+		if (!rparent)
+			break;
+		rport = of_graph_get_remote_port(ep);
+		if (!rport)
+			break;
+		if (of_graph_parse_endpoint(rport, &rendpoint))
+			break;
+
+		/* If the remote device is not available, defer probing */
+		rdev = of_coresight_get_endpoint_device(rparent);
+		if (!rdev) {
+			ret = -EPROBE_DEFER;
+			break;
+		}
+
+		pdata->outports[*i] = endpoint.port;
+		pdata->child_names[*i] = dev_name(rdev);
+		pdata->child_ports[*i] = rendpoint.id;
+		/* Move the index */
+		(*i)++;
+	} while (0);
+
+	if (rparent)
+		of_node_put(rparent);
+	if (rport)
+		of_node_put(rport);
+
+	return ret;
+}
+
 struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
 	int i = 0, ret = 0;
 	struct coresight_platform_data *pdata;
-	struct of_endpoint endpoint, rendpoint;
-	struct device *rdev;
 	struct device_node *ep = NULL;
-	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -129,63 +192,29 @@ of_get_coresight_platform_data(struct device *dev,
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
-	if (pdata->nr_outport) {
-		ret = of_coresight_alloc_memory(dev, pdata);
+	/* If there are not output connections, we are done */
+	if (!pdata->nr_outport)
+		return pdata;
+
+	ret = of_coresight_alloc_memory(dev, pdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Iterate through each port to discover topology */
+	do {
+		/* Get a handle on a port */
+		ep = of_graph_get_next_endpoint(node, ep);
+		if (!ep)
+			break;
+		ret = of_coresight_parse_endpoint(ep, pdata, &i);
 		if (ret)
 			return ERR_PTR(ret);
-
-		/* Iterate through each port to discover topology */
-		do {
-			/* Get a handle on a port */
-			ep = of_graph_get_next_endpoint(node, ep);
-			if (!ep)
-				break;
-
-			/*
-			 * No need to deal with input ports, processing for as
-			 * processing for output ports will deal with them.
-			 */
-			if (of_find_property(ep, "slave-mode", NULL))
-				continue;
-
-			/* Get a handle on the local endpoint */
-			ret = of_graph_parse_endpoint(ep, &endpoint);
-
-			if (ret)
-				continue;
-
-			/* The local out port number */
-			pdata->outports[i] = endpoint.port;
-
-			/*
-			 * Get a handle on the remote port and parent
-			 * attached to it.
-			 */
-			rparent = of_graph_get_remote_port_parent(ep);
-			rport = of_graph_get_remote_port(ep);
-
-			if (!rparent || !rport)
-				continue;
-
-			if (of_graph_parse_endpoint(rport, &rendpoint))
-				continue;
-
-			rdev = of_coresight_get_endpoint_device(rparent);
-			if (!rdev)
-				return ERR_PTR(-EPROBE_DEFER);
-
-			pdata->child_names[i] = dev_name(rdev);
-			pdata->child_ports[i] = rendpoint.id;
-
-			i++;
-		} while (ep);
-	}
-
-	pdata->cpu = of_coresight_get_cpu(node);
+	} while (ep);
 
 	return pdata;
 }
-- 
2.7.4
