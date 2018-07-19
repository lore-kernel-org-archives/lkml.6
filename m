Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECFEC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E099C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E099C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeGSLiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47356 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbeGSLiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6BB15A2;
        Thu, 19 Jul 2018 03:55:44 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CACF03F246;
        Thu, 19 Jul 2018 03:55:41 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 02/10] coresight: platform: Refactor graph endpoint parsing
Date:   Thu, 19 Jul 2018 11:55:06 +0100
Message-Id: <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the of graph endpoint parsing code, to make the error
handling easier.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Splitted from the of_node refcounting fix, part1
---
 drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
 1 file changed, 75 insertions(+), 54 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6880bee..68faaf8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
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
+static int of_coresight_parse_endpoint(struct device *dev,
+				       struct device_node *ep,
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
@@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
-	if (pdata->nr_outport) {
-		ret = of_coresight_alloc_memory(dev, pdata);
+	/* If there are no output connections, we are done */
+	if (!pdata->nr_outport)
+		return pdata;
+
+	ret = of_coresight_alloc_memory(dev, pdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Iterate through each port to discover topology */
+	while ((ep = of_graph_get_next_endpoint(node, ep))) {
+		/*
+		 * No need to deal with input ports, processing for as
+		 * processing for output ports will deal with them.
+		 */
+		if (of_find_property(ep, "slave-mode", NULL))
+			continue;
+
+		ret = of_coresight_parse_endpoint(dev, ep, pdata, &i);
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
 	}
 
-	pdata->cpu = of_coresight_get_cpu(node);
-
 	return pdata;
 }
 EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
-- 
2.7.4

