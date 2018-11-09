Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216BDC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKIUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:28 -0500
Received: from 8bytes.org ([81.169.241.247]:48936 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbeKIUr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 74A4748C; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 2/7] iommu/amd: Introduce free_sub_pt() function
Date:   Fri,  9 Nov 2018 12:07:07 +0100
Message-Id: <20181109110712.12469-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is a more generic version of free_pagetable()
and will be used to free only specific sub-trees of a
page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2655bd91af93..1186571f77e1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1367,12 +1367,10 @@ DEFINE_FREE_PT_FN(l4, free_pt_l3)
 DEFINE_FREE_PT_FN(l5, free_pt_l4)
 DEFINE_FREE_PT_FN(l6, free_pt_l5)
 
-static void free_pagetable(struct protection_domain *domain)
+static struct page *free_sub_pt(unsigned long root, int mode,
+				struct page *freelist)
 {
-	unsigned long root = (unsigned long)domain->pt_root;
-	struct page *freelist = NULL;
-
-	switch (domain->mode) {
+	switch (mode) {
 	case PAGE_MODE_NONE:
 		break;
 	case PAGE_MODE_1_LEVEL:
@@ -1397,6 +1395,16 @@ static void free_pagetable(struct protection_domain *domain)
 		BUG();
 	}
 
+	return freelist;
+}
+
+static void free_pagetable(struct protection_domain *domain)
+{
+	unsigned long root = (unsigned long)domain->pt_root;
+	struct page *freelist = NULL;
+
+	free_sub_pt(root, domain->mode, freelist);
+
 	free_page_list(freelist);
 }
 
-- 
2.17.1

