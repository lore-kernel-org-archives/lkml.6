Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988AFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD1923E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1923E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeGENlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:41:14 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41286 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbeGENdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:20 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 0FEDECD4E;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 06/34] media: camss: Fix OF node usage
Date:   Thu,  5 Jul 2018 16:32:37 +0300
Message-Id: <1530797585-8555-7-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_next_endpoint increases the refcount of the returned
node and decreases the refcount of the passed node. Take this into
account and use of_node_put properly.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 45285eb..abf6184 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -296,6 +296,7 @@ static int camss_of_parse_ports(struct device *dev,
 		if (of_device_is_available(node))
 			notifier->num_subdevs++;
 
+	of_node_put(node);
 	size = sizeof(*notifier->subdevs) * notifier->num_subdevs;
 	notifier->subdevs = devm_kzalloc(dev, size, GFP_KERNEL);
 	if (!notifier->subdevs) {
@@ -326,16 +327,16 @@ static int camss_of_parse_ports(struct device *dev,
 		}
 
 		remote = of_graph_get_remote_port_parent(node);
-		of_node_put(node);
-
 		if (!remote) {
 			dev_err(dev, "Cannot get remote parent\n");
+			of_node_put(node);
 			return -EINVAL;
 		}
 
 		csd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
 		csd->asd.match.fwnode = of_fwnode_handle(remote);
 	}
+	of_node_put(node);
 
 	return notifier->num_subdevs;
 }
-- 
2.7.4

