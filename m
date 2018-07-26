Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023FD20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023FD20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeGZMku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:40:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53250 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbeGZMku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:40:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A5580D;
        Thu, 26 Jul 2018 04:24:27 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73FB13F575;
        Thu, 26 Jul 2018 04:24:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] drivers/perf: arm-ccn: Use devm_ioremap_resource() to map memory
Date:   Thu, 26 Jul 2018 12:23:31 +0100
Message-Id: <1532604211-28609-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking the return value of platform_get_resource(), we can
use devm_ioremap_resource() which has the NULL pointer check and the
memory region requesting. devm_ioremap_resource is designed to replace
calls to devm_request_mem_region followed by devm_ioremap, so let's use
the same.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/perf/arm-ccn.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Hi Will,

Just came across this when I was trying to use devm_ioremap_resource
for vexpress-syscfg instead of adding a patch that adds more unnecessary
NULL ptr checks based on coccinelle warnings. All other perf drivers
seem to do the same except this one. I changed this too along
with vexpress-syscfg, but forgot to send.

Regards,
Sudeep


diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index b416ee18e6bb..4b15c36f4631 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1485,17 +1485,9 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ccn);

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(ccn->dev, res->start,
-			resource_size(res), pdev->name))
-		return -EBUSY;
-
-	ccn->base = devm_ioremap(ccn->dev, res->start,
-				resource_size(res));
-	if (!ccn->base)
-		return -EFAULT;
+	ccn->base = devm_ioremap_resource(ccn->dev, res);
+	if (IS_ERR(ccn->base))
+		return PTR_ERR(ccn->base);

 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res)
--
2.7.4

