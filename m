Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22608C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F112120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfA3F6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:58:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfA3F6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:58:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB38DC0BEAA4;
        Wed, 30 Jan 2019 05:58:08 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67C056266C;
        Wed, 30 Jan 2019 05:58:05 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, Jason Wang <jasowang@redhat.com>,
        peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 1/2] iommu/vt-d: Remove change_pte notifier
Date:   Wed, 30 Jan 2019 13:57:57 +0800
Message-Id: <20190130055758.3994-2-peterx@redhat.com>
In-Reply-To: <20190130055758.3994-1-peterx@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 30 Jan 2019 05:58:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change_pte() interface is tailored for PFN updates, while the
other notifier invalidate_range() should be enough for Intel IOMMU
cache flushing.  Actually we've done similar thing for AMD IOMMU
already in 8301da53fbc1 ("iommu/amd: Remove change_pte mmu_notifier
call-back", 2014-07-30) but the Intel IOMMU driver still have it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/intel-svm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a2a2aa4439aa..e9fd3ca057ac 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -180,14 +180,6 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 	rcu_read_unlock();
 }
 
-static void intel_change_pte(struct mmu_notifier *mn, struct mm_struct *mm,
-			     unsigned long address, pte_t pte)
-{
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-
-	intel_flush_svm_range(svm, address, 1, 1, 0);
-}
-
 /* Pages have been freed at this point */
 static void intel_invalidate_range(struct mmu_notifier *mn,
 				   struct mm_struct *mm,
@@ -227,7 +219,6 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static const struct mmu_notifier_ops intel_mmuops = {
 	.release = intel_mm_release,
-	.change_pte = intel_change_pte,
 	.invalidate_range = intel_invalidate_range,
 };
 
-- 
2.17.1

