Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A62C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6742083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6742083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeIFNnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbeIFNnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5D315BE;
        Thu,  6 Sep 2018 02:09:03 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9D803F575;
        Thu,  6 Sep 2018 02:09:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 12/14] coresight: catu: Claim device before use
Date:   Thu,  6 Sep 2018 10:08:33 +0100
Message-Id: <1536224915-31766-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CLAIM protocol to grab the ownership of the component when
in use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index ff94e58..170fbb6 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -406,6 +406,7 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 {
+	int rc;
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
 
@@ -418,6 +419,10 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 		return -EBUSY;
 	}
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		return rc;
+
 	control |= BIT(CATU_CONTROL_ENABLE);
 
 	if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
@@ -459,6 +464,7 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	int rc = 0;
 
 	catu_write_control(drvdata, 0);
+	coresight_disclaim_device_unlocked(drvdata->base);
 	if (catu_wait_for_ready(drvdata)) {
 		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
-- 
2.7.4

