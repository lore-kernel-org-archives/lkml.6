Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9E5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F321525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiGmagt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195F321525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeIUBDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42107 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388617AbeIUBDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so4786269plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+l6miTx0bPUP17QuEfmjwVvk2Jma2rGvsaL51T/exTk=;
        b=UiGmagt+EdiUAqc2d1bwT8IVVejh37CF01kfLf9o3oruiYz12MIfmT89pGPN/mXOqY
         xyiFaN2O7/9x8qHsZ9i38H0ketYiXaP4fKACYPpW2RMRSWtcz1z78vL/ECntVDg8Eyle
         oWNCkt8Ultc6bXfKdFagrOkZ9O9hkQme1NKn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+l6miTx0bPUP17QuEfmjwVvk2Jma2rGvsaL51T/exTk=;
        b=HtF1Qp3eKBwrv5IW/NGx8QELRMBrvNGltjzXBmPU2fQO9VsevvkWPoNmIjcf9DZMv6
         T9DJQG+KAXk9poXtoVqSZ42IzWnhibs/FjSkpXqfRVkZhOlT7L/X/Gei9iz7ZFAprRtG
         AYZwQl5OEzNWlXvpZdnz/tAR0PN4fjIXicg/k/fAl17SRm4yuOJ3WpLOUSsNzy9gNnJL
         TAfp+vzGN6CJnjndCDo+eUWui8Je3pfOLyQGQaf+KiPzURHq4T30NB5mDJR2u4Gzab/A
         cgpp8XHREMn+qClCnfMEGb0ud6ZILNrdgU+vnwl+TnpDf27nI4sozjD7uaDumSvVnqvT
         9BNw==
X-Gm-Message-State: APzg51B/Z6eIYMCGH8V2gwayYFgpVsyfmMQ66asyFae5Tjb1VrGOnxTg
        bgUqyJl+PZNjJLCaw8dsxwGYo3H2lIs=
X-Google-Smtp-Source: ANB0Vdb0UPhsIid28MY3/wNidXK3ZVZrkjP2Urbam+K54Y7uT6wZfV8CMXz5a+47E7yUIX9jiHTKNQ==
X-Received: by 2002:a17:902:7291:: with SMTP id d17-v6mr5751917pll.260.1537471112260;
        Thu, 20 Sep 2018 12:18:32 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/44] coresight: platform: Cleanup coresight connection handling
Date:   Thu, 20 Sep 2018 13:17:42 -0600
Message-Id: <1537471099-19781-8-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c    | 21 +-----------
 drivers/hwtracing/coresight/of_coresight.c | 53 +++++++++++-------------------
 include/linux/coresight.h                  |  9 ++---
 3 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 9fd0c387e678..5e8880ca8078 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -995,13 +995,11 @@ postcore_initcall(coresight_init);
 
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
@@ -1030,22 +1028,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->nr_inport = desc->pdata->nr_inport;
 	csdev->nr_outport = desc->pdata->nr_outport;
 
-	/* Initialise connections if there is at least one outport */
-	if (csdev->nr_outport) {
-		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
-		if (!conns) {
-			ret = -ENOMEM;
-			goto err_free_refcnts;
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
@@ -1078,8 +1061,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_free_refcnts:
-	kfree(refcnts);
 err_free_csdev:
 	kfree(csdev);
 err_out:
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 44903d35009f..e8fb4e124744 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -75,29 +75,13 @@ static void of_coresight_get_ports(const struct device_node *node,
 static int of_coresight_alloc_memory(struct device *dev,
 			struct coresight_platform_data *pdata)
 {
-	/* List of output port on this component */
-	pdata->outports = devm_kcalloc(dev,
-				       pdata->nr_outport,
-				       sizeof(*pdata->outports),
-				       GFP_KERNEL);
-	if (!pdata->outports)
-		return -ENOMEM;
-
-	/* Children connected to this component via @outports */
-	pdata->child_names = devm_kcalloc(dev,
-					  pdata->nr_outport,
-					  sizeof(*pdata->child_names),
-					  GFP_KERNEL);
-	if (!pdata->child_names)
-		return -ENOMEM;
-
-	/* Port number on the child this component is connected to */
-	pdata->child_ports = devm_kcalloc(dev,
-					  pdata->nr_outport,
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
@@ -121,7 +105,7 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
- * and fill the connection information in @pdata[@i].
+ * and fill the connection information in @conn
  *
  * Parses the local port, remote device name and the remote port.
  *
@@ -133,8 +117,7 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
  */
 static int of_coresight_parse_endpoint(struct device *dev,
 				       struct device_node *ep,
-				       struct coresight_platform_data *pdata,
-				       int i)
+				       struct coresight_connection *conn)
 {
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
@@ -166,11 +149,11 @@ static int of_coresight_parse_endpoint(struct device *dev,
 			break;
 		}
 
-		pdata->outports[i] = endpoint.port;
-		pdata->child_names[i] = devm_kstrdup(dev,
-						     dev_name(rdev),
-						     GFP_KERNEL);
-		pdata->child_ports[i] = rendpoint.port;
+		conn->outport = endpoint.port;
+		conn->child_name = devm_kstrdup(dev,
+						dev_name(rdev),
+						GFP_KERNEL);
+		conn->child_port = rendpoint.port;
 		/* Connection record updated */
 		ret = 1;
 	} while (0);
@@ -189,8 +172,9 @@ struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
 			       const struct device_node *node)
 {
-	int i = 0, ret = 0;
+	int ret = 0;
 	struct coresight_platform_data *pdata;
+	struct coresight_connection *conn;
 	struct device_node *ep = NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -212,6 +196,7 @@ of_get_coresight_platform_data(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	conn = pdata->conns;
 	/* Iterate through each port to discover topology */
 	while ((ep = of_graph_get_next_endpoint(node, ep))) {
 		/*
@@ -221,10 +206,10 @@ of_get_coresight_platform_data(struct device *dev,
 		if (of_coresight_ep_is_input(ep))
 			continue;
 
-		ret = of_coresight_parse_endpoint(dev, ep, pdata, i);
+		ret = of_coresight_parse_endpoint(dev, ep, conn);
 		switch (ret) {
 		case 1:
-			i++;		/* Fall through */
+			conn++;		/* Fall through */
 		case 0:
 			break;
 		default:
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d828a6efe0b1..41e1f4333bf2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -94,20 +94,15 @@ union coresight_dev_subtype {
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

