Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01992C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC83720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c/GIolUk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="otvSQucU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfAQJ1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:27:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfAQJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:27:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4BB4F608FD; Thu, 17 Jan 2019 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547717258;
        bh=1FOuaIwqoqh+sAAt199GtzaQ16QwThY29t1r7ojLmQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/GIolUkQ5uk5aM6g7ktmM8nHhrKT0v8OPrfgsvrbz+tlG/ULPIqBbfuQCRI/sHsi
         bA5/xA/8/Ptyv6HVShLWj/q/i4HohwESJiPPoBVfd/wlw9qjm2Pb28owH5sBO4YvhG
         S0//5aN1KS+YvOEHXqd4umwKs1aibJ9NM8qyhSjw=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8587608BA;
        Thu, 17 Jan 2019 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547717256;
        bh=1FOuaIwqoqh+sAAt199GtzaQ16QwThY29t1r7ojLmQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otvSQucUmuvrM8TuHoI7I6qfkjj5smG15AC8ybFKkCvJPyaCkL128EgrUfwfag2rv
         2Hg9MYvjLEDAg6m7ck8cPRRRdQ7McJpuaGhe4Fcws3RDMKe899rrCW5jahvXmnVW9t
         AuRL+GwYrgo23GIYbLfBZqKfQ+EnepgGmBbDyV18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8587608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page table mappings
Date:   Thu, 17 Jan 2019 14:57:18 +0530
Message-Id: <20190117092718.1396-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a device tree option for arm smmu to enable non-cacheable
memory for page tables.
We already enable a smmu feature for coherent walk based on
whether the smmu device is dma-coherent or not. Have an option
to enable non-cacheable page table memory to force set it for
particular smmu devices.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index af18a7e7f917..7ebbcf1b2eb3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -188,6 +188,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_PGTBL_NON_COHERENT (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
@@ -273,6 +274,7 @@ static bool using_legacy_binding, using_generic_binding;
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_PGTBL_NON_COHERENT, "arm,smmu-pgtable-non-coherent" },
 	{ 0, NULL},
 };
 
@@ -902,6 +904,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
+	/* Non coherent page table mappings only for Stage-1 */
+	if (smmu->options & ARM_SMMU_OPT_PGTBL_NON_COHERENT &&
+	    smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_COHERENT;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

