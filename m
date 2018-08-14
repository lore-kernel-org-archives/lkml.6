Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A6FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEC521778
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lgazkwG4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cRp4UaBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC521778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeHNNmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:42:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeHNNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:42:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C5C660C8A; Tue, 14 Aug 2018 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244175;
        bh=imINSkoKG3HWjUH9No+Ke/14n2fh8HwmVPnF9Gezd+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgazkwG4V3x+qiers/QYsmXb/qxY2Z2OxKpDhegmJXBV3rULFapzUY+9yCajhmXtA
         L2smSNpSyHTHD5fSLT6XM9eRhHHhCsxp3VyCjfLm8wYcK0sWbQezqhskosuWsj/x71
         K3mHmh3VRZANe4r753Ga7Z4GaUjc7s0toCIiIKUM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A945B608C9;
        Tue, 14 Aug 2018 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244160;
        bh=imINSkoKG3HWjUH9No+Ke/14n2fh8HwmVPnF9Gezd+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRp4UaBsT3HkwMoHm+k/MM6qd33Aj9+GPOPm/WpM4yHGlx/QNImZKhwjsk2Gmqx66
         BnqI5oixW3yOpoO3H9P4Fkrrr8tU7vteQhsn+Yk7tgWEuwVmTeTbKpBI5nCo56GmMu
         9g0PW6D8yK+wiFXdSyFm2sEVGz5BUe9BkHEFAev8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A945B608C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500 errata handling
Date:   Tue, 14 Aug 2018 16:25:27 +0530
Message-Id: <20180814105528.20592-5-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup to re-use some of the stuff

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 32e86df80428..75c146751c87 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -391,21 +391,31 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }
 
-/* Wait for any pending TLB invalidations to complete */
-static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
-				void __iomem *sync, void __iomem *status)
+static int __arm_smmu_tlb_sync_wait(void __iomem *status)
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
-				return;
+				return 0;
 			cpu_relax();
 		}
 		udelay(delay);
 	}
+
+	return -EBUSY;
+}
+
+/* Wait for any pending TLB invalidations to complete */
+static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
+				void __iomem *sync, void __iomem *status)
+{
+	writel_relaxed(0, sync);
+
+	if (!__arm_smmu_tlb_sync_wait(status))
+		return;
+
 	dev_err_ratelimited(smmu->dev,
 			    "TLB sync timed out -- SMMU may be deadlocked\n");
 }
@@ -461,8 +471,9 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 	arm_smmu_tlb_sync_global(smmu);
 }
 
-static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-					  size_t granule, bool leaf, void *cookie)
+static void __arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					    size_t granule, bool leaf,
+					    void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
@@ -498,6 +509,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	}
 }
 
+static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					  size_t granule, bool leaf,
+					  void *cookie)
+{
+	__arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
+}
+
 /*
  * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
  * almost negligible, but the benefit of getting the first one in as far ahead
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

