Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeFEVoz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:44:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34450 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:44:53 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 03/20] coresight: Fix remote endpoint parsing
Date: Tue,  5 Jun 2018 22:43:14 +0100
Message-Id: <1528235011-30691-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
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
 drivers/hwtracing/coresight/of_coresight.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 8a23c63..ada4f07 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -129,7 +129,7 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
+	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 
 	do {
@@ -144,16 +144,16 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 		if (of_graph_parse_endpoint(ep, &endpoint))
 			break;
 		/*
-		 * Get a handle on the remote port and parent
-		 * attached to it.
+		 * Get a handle on the remote endpoint and the device it is
+		 * attached to.
 		 */
-		rparent = of_graph_get_remote_port_parent(ep);
+		rep = of_graph_get_remote_endpoint(ep);
+		if (!rep)
+			break;
+		rparent = of_graph_get_port_parent(rep);
 		if (!rparent)
 			break;
-		rport = of_graph_get_remote_port(ep);
-		if (!rport)
-			break;
-		if (of_graph_parse_endpoint(rport, &rendpoint))
+		if (of_graph_parse_endpoint(rep, &rendpoint))
 			break;
 
 		/* If the remote device is not available, defer probing */
@@ -165,15 +165,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
 
 		pdata->outports[*i] = endpoint.port;
 		pdata->child_names[*i] = dev_name(rdev);
-		pdata->child_ports[*i] = rendpoint.id;
+		pdata->child_ports[*i] = rendpoint.port;
 		/* Move the index */
 		(*i)++;
 	} while (0);
 
 	if (rparent)
 		of_node_put(rparent);
-	if (rport)
-		of_node_put(rport);
+	if (rep)
+		of_node_put(rep);
 
 	return ret;
 }
-- 
2.7.4
