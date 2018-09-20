Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA65C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D03021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFXnTFun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D03021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeIUBD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38249 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbeIUBD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so4799553plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1I05pDEl9YDQOPdvRPriVg9w4n3vH5AzvtyzOmauupU=;
        b=AFXnTFunALZucfagVHzD8O6hubQF08TjXfiUNUNeDvJ1F6KOosTEBz4ucMLAc5G0Oe
         7yFl5oEDsiDQipnMjDIu3CiqEpT0jzgGywiE4cfDyM792fcfRykgBYgrcMQU1vOgKiJJ
         6S9vUVQD4XUKIAst+Gg5yyPlbZJKgXIPj+vUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1I05pDEl9YDQOPdvRPriVg9w4n3vH5AzvtyzOmauupU=;
        b=Y2pjoOs17qiabP+GbvX8W9cngQ7wDTmv4Fnu+4lb8t1Yp/8OtGIAef8TM0IBnooP0v
         /Pf271rlEDMcndTXvwW5zizTUKQ6VPqSST2/6n4221Q4kkIyO93pBL4RM8ODb4inAKxz
         32bFPsfpUFQ0sY0xUFqdL/p26V9EfN18pCL/7JYF8Dptmk2yNPBYDBH0VPzPJo6Q8IrJ
         Zkwuc3dkvRXbnpIgfHreoreRAHRlcoyuo9qJK2E0v+ld2Bov+lkNlnzc/Y8SVS7cWNBO
         /yjASJ3Xiqpsv12BbA38xB6VnKs7/Lvth3m8wevFbf+QhbkJfTyQpy8a7gtY8qEBYT53
         tfHg==
X-Gm-Message-State: APzg51C/8Auz0yMSz+gbwbZr3YN5T0QkY9UbAkGn0uIc9OcvuxxF+jeQ
        fvCKpF90t54dkFX1qveTVOyntw==
X-Google-Smtp-Source: ANB0Vda4em8SkSIl5mN6XZJbw9IXXS28Fi+t9X6RZf76AvDceKS70Hh8wmT6tv+50oku37GTMcco5A==
X-Received: by 2002:a17:902:d881:: with SMTP id b1-v6mr41058327plz.191.1537471108949;
        Thu, 20 Sep 2018 12:18:28 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/44] coresight: Fix remote endpoint parsing
Date:   Thu, 20 Sep 2018 13:17:40 -0600
Message-Id: <1537471099-19781-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 4b279f8fea0c..2ecdd1432b5c 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -134,7 +134,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	int ret = 0;
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
-	struct device_node *rport = NULL;
+	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
 
 	do {
@@ -142,16 +142,16 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		if (of_graph_parse_endpoint(ep, &endpoint))
 			break;
 		/*
-		 * Get a handle on the remote port and parent
-		 * attached to it.
+		 * Get a handle on the remote endpoint and the device it is
+		 * attached to.
 		 */
-		rparent = of_graph_get_remote_port_parent(ep);
-		if (!rparent)
+		rep = of_graph_get_remote_endpoint(ep);
+		if (!rep)
 			break;
-		rport = of_graph_get_remote_port(ep);
-		if (!rport)
+		rparent = of_graph_get_port_parent(rep);
+		if (!rparent)
 			break;
-		if (of_graph_parse_endpoint(rport, &rendpoint))
+		if (of_graph_parse_endpoint(rep, &rendpoint))
 			break;
 
 		/* If the remote device is not available, defer probing */
@@ -165,15 +165,15 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		pdata->child_names[i] = devm_kstrdup(dev,
 						     dev_name(rdev),
 						     GFP_KERNEL);
-		pdata->child_ports[i] = rendpoint.id;
+		pdata->child_ports[i] = rendpoint.port;
 		/* Connection record updated */
 		ret = 1;
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

