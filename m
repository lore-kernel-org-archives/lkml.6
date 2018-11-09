Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1910CC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E051C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E051C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKIUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: from 8bytes.org ([81.169.241.247]:48954 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbeKIUr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9F2954E4; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 3/7] iommu/amd: Ignore page-mode 7 in free_sub_pt()
Date:   Fri,  9 Nov 2018 12:07:08 +0100
Message-Id: <20181109110712.12469-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The page-mode 7 is a special one as it marks a final PTE to
a page with an intermediary size.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c       | 4 ++++
 drivers/iommu/amd_iommu_types.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1186571f77e1..49b5d3115e56 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1372,6 +1372,7 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
+	case PAGE_MODE_7_LEVEL:
 		break;
 	case PAGE_MODE_1_LEVEL:
 		freelist = free_pt_page(root, freelist);
@@ -1403,6 +1404,9 @@ static void free_pagetable(struct protection_domain *domain)
 	unsigned long root = (unsigned long)domain->pt_root;
 	struct page *freelist = NULL;
 
+	BUG_ON(domain->mode < PAGE_MODE_NONE ||
+	       domain->mode > PAGE_MODE_6_LEVEL);
+
 	free_sub_pt(root, domain->mode, freelist);
 
 	free_page_list(freelist);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e2b342e65a7b..eae0741f72dc 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -269,6 +269,7 @@
 #define PAGE_MODE_4_LEVEL 0x04
 #define PAGE_MODE_5_LEVEL 0x05
 #define PAGE_MODE_6_LEVEL 0x06
+#define PAGE_MODE_7_LEVEL 0x07
 
 #define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
 #define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-- 
2.17.1

