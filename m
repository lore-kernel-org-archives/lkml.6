Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CEE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CEE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbeGSLi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbeGSLi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37633168F;
        Thu, 19 Jul 2018 03:55:52 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D49FC3F246;
        Thu, 19 Jul 2018 03:55:49 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 05/10] coresight: Fix remote endpoint parsing
Date:   Thu, 19 Jul 2018 11:55:09 +0100
Message-Id: <1531997715-6767-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index c5f664c..16a77a7 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -133,7 +133,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
+	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 
 	do {
@@ -141,16 +141,16 @@ static int of_coresight_parse_endpoint(struct device *dev,
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
@@ -164,15 +164,15 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		pdata->child_names[*i] = devm_kstrdup(dev,
 						      dev_name(rdev),
 						      GFP_KERNEL);
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
 	if (rdev)
 		put_device(rdev);
 
-- 
2.7.4

