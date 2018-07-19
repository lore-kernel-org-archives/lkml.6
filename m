Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED0C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44820684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MiJjYcgx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dw96qUUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A44820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbeGSSiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:38:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeGSSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:38:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9136B60BE2; Thu, 19 Jul 2018 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022876;
        bh=wler9wIaqgW6zsf4CatUPTGGqUnIkI9EJZNyUfJ+OF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiJjYcgxDifTBK+J1bOB4isM0KlN9QMvwNKFqzOharVRuk0rukXSLVKu2kwF3oiSB
         Q081hZPFidDZrTjdX1eDgTlraqbLt3rKMV9gYdcI3uG63zDNzALtlU8PXhfcJerT/F
         kL/+iKvjc+r4r+TcfqDWm0gZCQDHrQA2OSMWP+Vo=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F8A960B22;
        Thu, 19 Jul 2018 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532022874;
        bh=wler9wIaqgW6zsf4CatUPTGGqUnIkI9EJZNyUfJ+OF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dw96qUUMInEPCLwcTzzb2X0ftF7akMSWUZcGfPQ3f7pxiOZ/FTMn1meZjhmo+11ZE
         8Ofb3y6tNoXKk21K1ewWCbpJLbCh0Sqf7/R9wASY4E58EPF4d8ev27HG3NLJPrl8D7
         SuHYCj8oc7O7yRMruFZ8CUsutietE2R6XjboMZio=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F8A960B22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, andy.gross@linaro.org
Cc:     mark.rutland@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, david.brown@linaro.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context interrupts
Date:   Thu, 19 Jul 2018 23:23:56 +0530
Message-Id: <20180719175356.14753-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we check if the number of context banks is not equal to
num_context_interrupts. However, there are booloaders such as, one
on sdm845 that reserves few context banks and thus kernel views
less than the total available context banks.
So, although the hardware definition in device tree would mention
the correct number of context interrupts, this number can be
greater than the number of context banks visible to smmu in kernel.
We should therefore error out only when the number of context banks
is greater than the available number of context interrupts.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c69736a30f8..4cb53bf4f423 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	if (smmu->version == ARM_SMMU_V2 &&
-	    smmu->num_context_banks != smmu->num_context_irqs) {
-		dev_err(dev,
-			"found only %d context interrupt(s) but %d required\n",
-			smmu->num_context_irqs, smmu->num_context_banks);
-		return -ENODEV;
+	if (smmu->version == ARM_SMMU_V2) {
+		if (smmu->num_context_banks > smmu->num_context_irqs) {
+			dev_err(dev,
+			      "found only %d context irq(s) but %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			return -ENODEV;
+		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
+			/* loose extra context interrupts */
+			dev_notice(dev,
+			      "found %d context irq(s) but only %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			smmu->num_context_irqs = smmu->num_context_banks;
+		}
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

