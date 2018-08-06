Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448DBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ED321534
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07ED321534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeHFPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732529AbeHFPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D302115AD;
        Mon,  6 Aug 2018 06:43:33 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A23BD3F2EA;
        Mon,  6 Aug 2018 06:43:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 13/13] coreisght: tmc: Claim device before use
Date:   Mon,  6 Aug 2018 14:41:55 +0100
Message-Id: <1533562915-21558-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CLAIM tags to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 22 +++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index ceb4b30..59d862d6e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -36,6 +36,11 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etb_enable_hw(drvdata);
 	return 0;
 }
@@ -66,7 +71,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 	return;
 }
 
-static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -82,6 +87,12 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+{
+	coresight_disclaim_device(drvdata);
+	__tmc_etb_disable_hw(drvdata);
+}
+
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -100,6 +111,11 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etf_enable_hw(drvdata);
 	return 0;
 }
@@ -110,7 +126,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 	tmc_flush_and_stop(drvdata);
 	tmc_disable_hw(drvdata);
-
+	coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 }
 
@@ -556,7 +572,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if need be */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etb_disable_hw(drvdata);
+		__tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index daad521..f684283 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -991,6 +991,9 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	 * this on.
 	 */
 	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (rc)
+		return rc;
+	rc = coresight_claim_device(drvdata->base);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
 		__tmc_etr_enable_hw(drvdata);
@@ -1077,6 +1080,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
+	coresight_disclaim_device(drvdata->base);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
 }
-- 
2.7.4

