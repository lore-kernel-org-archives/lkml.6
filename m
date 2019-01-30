Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353FC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA02821848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfA3F6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:58:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfA3F6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:58:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 707CB88E54;
        Wed, 30 Jan 2019 05:58:11 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 511643787;
        Wed, 30 Jan 2019 05:58:09 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, Jason Wang <jasowang@redhat.com>,
        peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Date:   Wed, 30 Jan 2019 13:57:58 +0800
Message-Id: <20190130055758.3994-3-peterx@redhat.com>
In-Reply-To: <20190130055758.3994-1-peterx@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 30 Jan 2019 05:58:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IOMMU driver is using the clear_flush_young() to do cache flushing
but that's actually already covered by invalidate_range().  Remove the
extra notifier and the chunks.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/amd_iommu_v2.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 23dae9348ace..5d7ef750e4a0 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -370,29 +370,6 @@ static struct pasid_state *mn_to_state(struct mmu_notifier *mn)
 	return container_of(mn, struct pasid_state, mn);
 }
 
-static void __mn_flush_page(struct mmu_notifier *mn,
-			    unsigned long address)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-
-	pasid_state = mn_to_state(mn);
-	dev_state   = pasid_state->device_state;
-
-	amd_iommu_flush_page(dev_state->domain, pasid_state->pasid, address);
-}
-
-static int mn_clear_flush_young(struct mmu_notifier *mn,
-				struct mm_struct *mm,
-				unsigned long start,
-				unsigned long end)
-{
-	for (; start < end; start += PAGE_SIZE)
-		__mn_flush_page(mn, start);
-
-	return 0;
-}
-
 static void mn_invalidate_range(struct mmu_notifier *mn,
 				struct mm_struct *mm,
 				unsigned long start, unsigned long end)
@@ -430,7 +407,6 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static const struct mmu_notifier_ops iommu_mn = {
 	.release		= mn_release,
-	.clear_flush_young      = mn_clear_flush_young,
 	.invalidate_range       = mn_invalidate_range,
 };
 
-- 
2.17.1

