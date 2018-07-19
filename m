Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A910C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbeGSLi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:26 -0400
Received: from foss.arm.com ([217.140.101.70]:47390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbeGSLiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 970301684;
        Thu, 19 Jul 2018 03:55:49 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 145753F246;
        Thu, 19 Jul 2018 03:55:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH v2 04/10] coresight: platform: Fix leaking device reference
Date:   Thu, 19 Jul 2018 11:55:08 +0100
Message-Id: <1531997715-6767-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't drop the reference on the remote device while parsing the
connection, held by bus_find_device(). Fix this by duplicating the
device name and dropping the reference.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 - New in v2
---
 drivers/hwtracing/coresight/of_coresight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6c2f95a..c5f664c 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -161,7 +161,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		pdata->outports[*i] = endpoint.port;
-		pdata->child_names[*i] = dev_name(rdev);
+		pdata->child_names[*i] = devm_kstrdup(dev,
+						      dev_name(rdev),
+						      GFP_KERNEL);
 		pdata->child_ports[*i] = rendpoint.id;
 		/* Move the index */
 		(*i)++;
@@ -171,6 +173,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		of_node_put(rparent);
 	if (rport)
 		of_node_put(rport);
+	if (rdev)
+		put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4

