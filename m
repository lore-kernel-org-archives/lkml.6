Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeFANRD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:17:03 -0400
Received: from foss.arm.com ([217.140.101.70]:51862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeFANQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:16:56 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, sudeep.holla@arm.com, robh@kernel.org,
        mark.rutland@arm.com, frowand.list@gmail.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 2/8] coresight: Fix remote endpoint parsing
Date: Fri,  1 Jun 2018 14:16:01 +0100
Message-Id: <1527858967-16047-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing the remote endpoint of an output port, we do :
     rport = of_graph_get_remote_port(ep);
     rparent = of_graph_get_remote_port_parent(ep);

and then parse the "remote_port" as if it was the remote endpoint,
which is wrong. The code worked fine because we used endpoint number
as the port number. Let us fix it and optimise a bit as:

     remote_ep = of_graph_get_remote_endpoint(ep);
     if (remote_ep)
        remote_parent = of_graph_get_port_parent(remote_ep);

and then, parse the remote_ep for the port/endpoint details.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 7c37544..e0deab0 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -128,7 +128,7 @@ of_get_coresight_platform_data(struct device *dev,
 	struct device *rdev;
 	struct device_node *ep = NULL;
 	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
+	struct device_node *rep = NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -169,16 +169,17 @@ of_get_coresight_platform_data(struct device *dev,
 			pdata->outports[i] = endpoint.port;
 
 			/*
-			 * Get a handle on the remote port and parent
-			 * attached to it.
+			 * Get a handle on the remote endpoint and the device
+			 * it is attached to.
 			 */
-			rparent = of_graph_get_remote_port_parent(ep);
-			rport = of_graph_get_remote_port(ep);
-
-			if (!rparent || !rport)
+			rep = of_graph_get_remote_endpoint(ep);
+			if (!rep)
+				continue;
+			rparent = of_graph_get_port_parent(rep);
+			if (!rparent)
 				continue;
 
-			if (of_graph_parse_endpoint(rport, &rendpoint))
+			if (of_graph_parse_endpoint(rep, &rendpoint))
 				continue;
 
 			rdev = of_coresight_get_endpoint_device(rparent);
@@ -186,7 +187,7 @@ of_get_coresight_platform_data(struct device *dev,
 				return ERR_PTR(-EPROBE_DEFER);
 
 			pdata->child_names[i] = dev_name(rdev);
-			pdata->child_ports[i] = rendpoint.id;
+			pdata->child_ports[i] = rendpoint.port;
 
 			i++;
 		} while (ep);
-- 
2.7.4
