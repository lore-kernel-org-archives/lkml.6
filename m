Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20848C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C43215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9H9wEav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C43215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeI1FG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:06:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41559 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1FG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:06:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id n3-v6so2693438qkn.8;
        Thu, 27 Sep 2018 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=68dCE8AAJ7ks0wme6FIZwJzv+K1DwC/CeEghUvOZQm8=;
        b=b9H9wEavPlqBF88iN6gKF6vpE9NzMBkBVkMrRqBhAMJUfXnruqq8Q6/gw6N5EUidIk
         dn/EpxcMSoY52m6DnOn2WxCw374WC4D83AND322yCFFqdbuFqemF2/dYtAEiXr7+bESg
         D/x+KXaFqaA+6K8ljyu57DJR7cME0n2fdZ7kzy6wxe0JPzv0+q6sE4RDep+KGQdZb6kL
         T93l6nqv8F6XokwVtJDNV1qlFpsJCBSe2eZhCJFNQfNy7YZ+ATvzr0w/6BPqpbsm7VlG
         4gFXpufkhpnsL1nQ0JLE3nJQUlF6gBNt/6sEw5uXZE2dcHEWkoykY3V26KoqddLvtaQT
         z9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68dCE8AAJ7ks0wme6FIZwJzv+K1DwC/CeEghUvOZQm8=;
        b=IvP+uFr6aX4aQpyJvwRJNvi7Hmg2hGXTZ9LEHhBPE9cqX9J4s1Nfej+Z0txY/hnjRd
         IoRlAp2lrLpzvoEOxbymujnLcLty0FSxNG/vrgMMO/o0pcpL81JlvFHs6YCMAmcGVFWK
         m7WgBhkfREi7bJUymfZSqGe5is133ORz0HdvQ0OJzQ9QAQfnFSlVYWFX11RrOhZzJKKQ
         WdWyE/2hZjqkUccUA7rNZs5O3rvAJUWZEJsV5GKsgPIKdSFnd/+3WCLV7lXohIShbT7Q
         z4Xc1Df/16DxD0UhGhLD/MnN8jndoFCtAIwSXGL0Wvdq4QspiKDASZhzbkDjp2JaL7gH
         ih2g==
X-Gm-Message-State: ABuFfoiXR0SeH9Jh6lp9mNlyV5w92E2+5mnje43w1irXpKCPFlsqLAl1
        UgvDlAgnEJV9QiTuNy/c2yk=
X-Google-Smtp-Source: ACcGV60uKXiUiI+N+LKuITTXmlWXjpbfGwyrmtNNbScHDTZrVF1Vqp/cHy3qLLrKpNye0YV9/iKmBA==
X-Received: by 2002:a37:e20a:: with SMTP id g10-v6mr9910556qki.45.1538088381308;
        Thu, 27 Sep 2018 15:46:21 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:6268:7a0b:50be:cebc])
        by smtp.gmail.com with ESMTPSA id 23-v6sm1969465qkn.11.2018.09.27.15.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:46:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
Date:   Thu, 27 Sep 2018 18:46:07 -0400
Message-Id: <20180927224609.19515-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We seem to need to set either this or CFCFG (stall), otherwise gpu
faults trigger problems with other in-flight transactions from the
GPU causing CP errors, etc.

In the ARM SMMU spec, the 'Hit under previous context fault' bit is
described as:

 '0' - Stall or terminate subsequent transactions in the presence
       of an outstanding context fault
 '1' - Process all subsequent transactions independently of any
       outstanding context fault.

Since we don't enable CFCFG (stall) the behavior of terminating
other transactions makes sense.  And is probably not what we want
(and definately not what we want for GPU).

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
So I hit this issue a long time back on 820 (msm8996) and at the
time I solved it with a patch that enabled CFCFG.  And it resurfaced
more recently on sdm845.  But at the time CFCFG was rejected, iirc
because of concern that it would cause problems on other non-qcom
arm smmu implementations.  And I think I forgot to send this version
of the solution.

If enabling HUPCF is anticipated to cause problems on other ARM
SMMU implementations, I think I can come up with a variant of this
patch which conditionally enables it for snapdragon.

Either way, I'd really like to get some variant of this fix merged
(and probably it would be a good idea for stable kernel branches
too), since current behaviour with the GPU means faults turn into
a fantastic cascade of fail.

 drivers/iommu/arm-smmu-regs.h | 1 +
 drivers/iommu/arm-smmu.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..2291925eb800 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -178,6 +178,7 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_SMMU_CB_ATSR		0x8f0
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
+#define SCTLR_HUPCF			(1 << 8)
 #define SCTLR_CFCFG			(1 << 7)
 #define SCTLR_CFIE			(1 << 6)
 #define SCTLR_CFRE			(1 << 5)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..47ffc9aade72 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -713,9 +713,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
 	if (stage1)
 		reg |= SCTLR_S1_ASIDPNE;
+	reg |= SCTLR_HUPCF;
 	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		reg |= SCTLR_E;
-
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
 }
 
-- 
2.17.1

