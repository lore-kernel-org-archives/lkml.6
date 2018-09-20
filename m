Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E958021531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJRmzXds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E958021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeIUBDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbeIUBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so4878133pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K210pcF1deFGvxqr7d7Nkhqm4/GdyjS5AJj692buw54=;
        b=WJRmzXdsShVNUf6r/SFr1Fdmk3D8UaKvgE/iD9CulnqBx6dPjhK8oy6yh8RmuPfT76
         0B4tmo5z97GCmIt8cJVcPeThw0hWJGR9j9ucR7Q1fRESHULsyLstVKU83cm4XYmmxJeL
         MeFPTs/hn4RMe0L3UYBgsRPqOa002vFbg71c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K210pcF1deFGvxqr7d7Nkhqm4/GdyjS5AJj692buw54=;
        b=k+4x6A1alGt4pfdFB/kH1lu2fWygBZPnQHQWqcTldHAwsF5XDCBfs7m0LKYsAemSJs
         agHRxcDm0tWKDCAnvrqZ4bwN+9BnRY0U8T454lamMkQW46R6s7JgoxbREq9M6Z8ebF6F
         kvWlZv7iMM6dMjrivwv++FV5q9hYQznBmAXOZooelijyTlJ9qhVnley5aGygqB6lIBVr
         4r3YHkvE8TT+F+n4sOVTh/apvI7w1bGcSDtKYdkyzDZVyqrPVuRPP9o6hO8sKuor9lBp
         HXGKrTT1PKLY8osL+ulMIUnKdJogSS3zBjRea9HLWOh3wnWOKfpjPsNzHfJeOisVF9L/
         icFw==
X-Gm-Message-State: APzg51AlP1uYFL7M6v1Bi1NYV7UMXsHcMUrBhOXtl2fQLCfXrnhmb7Tu
        eQDNAdO3QPxNSw+KaMY6Mv2WDA==
X-Google-Smtp-Source: ANB0VdaDO6EdN64om14jPtLVjbciPJ7AGzRvHRwMzwT/iTimKX9o+rCQx2EPSHkdZj8qX4/D9ZxIbw==
X-Received: by 2002:a62:fcd2:: with SMTP id e201-v6mr43149852pfh.101.1537471104263;
        Thu, 20 Sep 2018 12:18:24 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/44] coresight: platform: Refactor graph endpoint parsing
Date:   Thu, 20 Sep 2018 13:17:37 -0600
Message-Id: <1537471099-19781-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Refactor the of graph endpoint parsing code, to make the error
handling easier.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 138 +++++++++++++++++------------
 1 file changed, 83 insertions(+), 55 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6880bee195c8..70205f3eae8e 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -114,17 +114,70 @@ int of_coresight_get_cpu(const struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
+/*
+ * of_coresight_parse_endpoint : Parse the given output endpoint @ep
+ * and fill the connection information in @pdata[@i].
+ *
+ * Parses the local port, remote device name and the remote port.
+ *
+ * Returns :
+ *	 1	- If the parsing is successful and a connection record
+ *		  was created for an output connection.
+ *	 0	- If the parsing completed without any fatal errors.
+ *	-Errno	- Fatal error, abort the scanning.
+ */
+static int of_coresight_parse_endpoint(struct device *dev,
+				       struct device_node *ep,
+				       struct coresight_platform_data *pdata,
+				       int i)
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
+		pdata->outports[i] = endpoint.port;
+		pdata->child_names[i] = dev_name(rdev);
+		pdata->child_ports[i] = rendpoint.id;
+		/* Connection record updated */
+		ret = 1;
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
@@ -132,64 +185,39 @@ of_get_coresight_platform_data(struct device *dev,
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
-	if (pdata->nr_outport) {
-		ret = of_coresight_alloc_memory(dev, pdata);
-		if (ret)
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
+		 * No need to deal with input ports, as processing the
+		 * output ports connected to them will process the details.
+		 */
+		if (of_find_property(ep, "slave-mode", NULL))
+			continue;
+
+		ret = of_coresight_parse_endpoint(dev, ep, pdata, i);
+		switch (ret) {
+		case 1:
+			i++;		/* Fall through */
+		case 0:
+			break;
+		default:
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
+		}
 	}
 
-	pdata->cpu = of_coresight_get_cpu(node);
-
 	return pdata;
 }
 EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
-- 
2.7.4

