Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A8BC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C8321A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C8321A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeHFPw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:28 -0400
Received: from foss.arm.com ([217.140.101.70]:38852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeHFPw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D697715AD;
        Mon,  6 Aug 2018 06:43:17 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A584F3F7A6;
        Mon,  6 Aug 2018 06:43:16 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 02/13] coresight: tmc-etr: Handle errors enabling CATU
Date:   Mon,  6 Aug 2018 14:41:44 +0100
Message-Id: <1533562915-21558-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we honor the errors in CATU device and abort the operation.
While at it, delay setting the etr_buf for the session until we are
sure that we are indeed enabling the ETR.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c426935..daad521 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -751,12 +751,14 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 	return NULL;
 }
 
-static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
+static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
+				      struct etr_buf *etr_buf)
 {
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
 
 	if (catu && helper_ops(catu)->enable)
-		helper_ops(catu)->enable(catu, drvdata->etr_buf);
+		return helper_ops(catu)->enable(catu, etr_buf);
+	return 0;
 }
 
 static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
@@ -971,6 +973,8 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 			     struct etr_buf *etr_buf)
 {
+	int rc;
+
 	/* Callers should provide an appropriate buffer for use */
 	if (WARN_ON(!etr_buf))
 		return -EINVAL;
@@ -982,16 +986,17 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	if (WARN_ON(drvdata->etr_buf))
 		return -EBUSY;
 
-	/* Set the buffer for the session */
-	drvdata->etr_buf = etr_buf;
 	/*
 	 * If this ETR is connected to a CATU, enable it before we turn
 	 * this on.
 	 */
-	tmc_etr_enable_catu(drvdata);
+	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (!rc) {
+		drvdata->etr_buf = etr_buf;
+		__tmc_etr_enable_hw(drvdata);
+	}
 
-	__tmc_etr_enable_hw(drvdata);
-	return 0;
+	return rc;
 }
 
 /*
-- 
2.7.4

