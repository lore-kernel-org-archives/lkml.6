Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89782089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89782089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbeG0LhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:37:21 -0400
Received: from foss.arm.com ([217.140.101.70]:40904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbeG0LhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C041688;
        Fri, 27 Jul 2018 03:16:07 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FFF13F575;
        Fri, 27 Jul 2018 03:16:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH v3 4/9] coresight: platform: Fix leaking device reference
Date:   Fri, 27 Jul 2018 11:15:32 +0100
Message-Id: <1532686537-12380-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
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
index 28d3aef..4b279f8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -162,7 +162,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		pdata->outports[i] = endpoint.port;
-		pdata->child_names[i] = dev_name(rdev);
+		pdata->child_names[i] = devm_kstrdup(dev,
+						     dev_name(rdev),
+						     GFP_KERNEL);
 		pdata->child_ports[i] = rendpoint.id;
 		/* Connection record updated */
 		ret = 1;
@@ -172,6 +174,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		of_node_put(rparent);
 	if (rport)
 		of_node_put(rport);
+	if (rdev)
+		put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4

