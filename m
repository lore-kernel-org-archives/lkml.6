Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09CBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F4620671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F4620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGSLic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbeGSLib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB86E16A3;
        Thu, 19 Jul 2018 03:55:54 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 751473F246;
        Thu, 19 Jul 2018 03:55:52 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 06/10] coresight: Add helper to check if the endpoint is input
Date:   Thu, 19 Jul 2018 11:55:10 +0100
Message-Id: <1531997715-6767-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check if the given endpoint is input.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 16a77a7..b6a170f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -45,6 +45,11 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
+static inline bool of_coresight_ep_is_input(struct device_node *ep)
+{
+	return of_property_read_bool(ep, "slave-mode");
+}
+
 static void of_coresight_get_ports(const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
@@ -56,7 +61,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_property_read_bool(ep, "slave-mode"))
+		if (of_coresight_ep_is_input(ep))
 			in++;
 		else
 			out++;
@@ -212,7 +217,7 @@ of_get_coresight_platform_data(struct device *dev,
 		 * No need to deal with input ports, processing for as
 		 * processing for output ports will deal with them.
 		 */
-		if (of_find_property(ep, "slave-mode", NULL))
+		if (of_coresight_ep_is_input(ep))
 			continue;
 
 		ret = of_coresight_parse_endpoint(dev, ep, pdata, &i);
-- 
2.7.4

