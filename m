Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeFANSo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:18:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbeFANRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:17:01 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, sudeep.holla@arm.com, robh@kernel.org,
        mark.rutland@arm.com, frowand.list@gmail.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 4/8] coresight: platform: Cleanup coresight connection handling
Date: Fri,  1 Jun 2018 14:16:03 +0100
Message-Id: <1527858967-16047-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform code parses the component connections and populates
a platform-description of the output connections in arrays of fields
(which is never freed). This is later copied in the coresight_register
to a newly allocated area, represented by coresight_connection(s).

This patch cleans up the code dealing with connections by making
use of the "coresight_connection" structure right at the platform
code and lets the generic driver simply re-use information provided
by the platform.

Thus making it reader friendly as well as avoiding the wastage of
unused memory.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c    | 21 +---------------
 drivers/hwtracing/coresight/of_coresight.c | 40 +++++++++++-------------------
 include/linux/coresight.h                  |  9 ++-----
 3 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4ba..3b3756e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -961,13 +961,11 @@ postcore_initcall(coresight_init);
 
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
-	int i;
 	int ret;
 	int link_subtype;
 	int nr_refcnts = 1;
 	atomic_t *refcnts = NULL;
 	struct coresight_device *csdev;
-	struct coresight_connection *conns = NULL;
 
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
@@ -996,22 +994,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->nr_inport = desc->pdata->nr_inport;
 	csdev->nr_outport = desc->pdata->nr_outport;
 
-	/* Initialise connections if there is at least one outport */
-	if (csdev->nr_outport) {
-		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
-		if (!conns) {
-			ret = -ENOMEM;
-			goto err_kzalloc_conns;
-		}
-
-		for (i = 0; i < csdev->nr_outport; i++) {
-			conns[i].outport = desc->pdata->outports[i];
-			conns[i].child_name = desc->pdata->child_names[i];
-			conns[i].child_port = desc->pdata->child_ports[i];
-		}
-	}
-
-	csdev->conns = conns;
+	csdev->conns = desc->pdata->conns;
 
 	csdev->type = desc->type;
 	csdev->subtype = desc->subtype;
@@ -1039,8 +1022,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	return csdev;
 
 err_device_register:
-	kfree(conns);
-err_kzalloc_conns:
 	kfree(refcnts);
 err_kzalloc_refcnts:
 	kfree(csdev);
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index e0deab0..a3f3416 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -77,26 +77,13 @@ static void of_coresight_get_ports(const struct device_node *node,
 static int of_coresight_alloc_memory(struct device *dev,
 			struct coresight_platform_data *pdata)
 {
-	/* List of output port on this component */
-	pdata->outports = devm_kzalloc(dev, pdata->nr_outport *
-				       sizeof(*pdata->outports),
-				       GFP_KERNEL);
-	if (!pdata->outports)
-		return -ENOMEM;
-
-	/* Children connected to this component via @outports */
-	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
-					  sizeof(*pdata->child_names),
-					  GFP_KERNEL);
-	if (!pdata->child_names)
-		return -ENOMEM;
-
-	/* Port number on the child this component is connected to */
-	pdata->child_ports = devm_kzalloc(dev, pdata->nr_outport *
-					  sizeof(*pdata->child_ports),
-					  GFP_KERNEL);
-	if (!pdata->child_ports)
-		return -ENOMEM;
+	if (pdata->nr_outport) {
+		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
+					    sizeof(*pdata->conns),
+					    GFP_KERNEL);
+		if (!pdata->conns)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -122,8 +109,9 @@ struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
-	int i = 0, ret = 0;
+	int ret = 0;
 	struct coresight_platform_data *pdata;
+	struct coresight_connection *conn;
 	struct of_endpoint endpoint, rendpoint;
 	struct device *rdev;
 	struct device_node *ep = NULL;
@@ -145,6 +133,7 @@ of_get_coresight_platform_data(struct device *dev,
 		if (ret)
 			return ERR_PTR(ret);
 
+		conn = pdata->conns;
 		/* Iterate through each port to discover topology */
 		do {
 			/* Get a handle on a port */
@@ -166,7 +155,7 @@ of_get_coresight_platform_data(struct device *dev,
 				continue;
 
 			/* The local out port number */
-			pdata->outports[i] = endpoint.port;
+			conn->outport = endpoint.port;
 
 			/*
 			 * Get a handle on the remote endpoint and the device
@@ -186,10 +175,9 @@ of_get_coresight_platform_data(struct device *dev,
 			if (!rdev)
 				return ERR_PTR(-EPROBE_DEFER);
 
-			pdata->child_names[i] = dev_name(rdev);
-			pdata->child_ports[i] = rendpoint.port;
-
-			i++;
+			conn->child_name = dev_name(rdev);
+			conn->child_port = rendpoint.port;
+			conn++;
 		} while (ep);
 	}
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 32aaa1c..c2363bb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -89,20 +89,15 @@ struct coresight_dev_subtype {
  * @cpu:	the CPU a source belongs to. Only applicable for ETM/PTMs.
  * @name:	name of the component as shown under sysfs.
  * @nr_inport:	number of input ports for this component.
- * @outports:	list of remote endpoint port number.
- * @child_names:name of all child components connected to this device.
- * @child_ports:child component port number the current component is
-		connected  to.
  * @nr_outport:	number of output ports for this component.
+ * @conns:	Array of nr_outport connections from this component
  */
 struct coresight_platform_data {
 	int cpu;
 	const char *name;
 	int nr_inport;
-	int *outports;
-	const char **child_names;
-	int *child_ports;
 	int nr_outport;
+	struct coresight_connection *conns;
 };
 
 /**
-- 
2.7.4
