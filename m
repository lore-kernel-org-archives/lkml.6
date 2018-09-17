Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F4EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACD12146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACD12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbeIREnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C343C49;
        Mon, 17 Sep 2018 23:14:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sameer Goel <sgoel@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 138/158] iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel
Date:   Tue, 18 Sep 2018 00:42:48 +0200
Message-Id: <20180917211717.520280511@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit b63b3439b85609338e4faabd5d2588dbda137e5c ]

If we find that the SMMU is enabled during probe, we reset it by
re-initialising its registers and either enabling translation or placing
it into bypass based on the disable_bypass commandline option.

In the case of a kdump kernel, the SMMU won't have been shutdown cleanly
by the previous kernel and there may be concurrent DMA through the SMMU.
Rather than reset the SMMU to bypass, which would likely lead to rampant
data corruption, we can instead configure the SMMU to abort all incoming
transactions when we find that it is enabled from within a kdump kernel.

Reported-by: Sameer Goel <sgoel@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm-smmu-v3.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -24,6 +24,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -2211,8 +2212,12 @@ static int arm_smmu_update_gbpa(struct a
 	reg &= ~clr;
 	reg |= set;
 	writel_relaxed(reg | GBPA_UPDATE, gbpa);
-	return readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+
+	if (ret)
+		dev_err(smmu->dev, "GBPA not responding to update\n");
+	return ret;
 }
 
 static void arm_smmu_free_msis(void *data)
@@ -2392,8 +2397,15 @@ static int arm_smmu_device_reset(struct
 
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
-	if (reg & CR0_SMMUEN)
+	if (reg & CR0_SMMUEN) {
+		if (is_kdump_kernel()) {
+			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+			arm_smmu_device_disable(smmu);
+			return -EBUSY;
+		}
+
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+	}
 
 	ret = arm_smmu_device_disable(smmu);
 	if (ret)
@@ -2491,10 +2503,8 @@ static int arm_smmu_device_reset(struct
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-		if (ret) {
-			dev_err(smmu->dev, "GBPA not responding to update\n");
+		if (ret)
 			return ret;
-		}
 	}
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);


