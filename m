Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E391C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F042070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAHQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:40:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfAHQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:40:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61BE83E2D3;
        Tue,  8 Jan 2019 16:40:18 +0000 (UTC)
Received: from gimli.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 908D15D75D;
        Tue,  8 Jan 2019 16:40:06 +0000 (UTC)
Subject: [PATCH] vfio/type1: Fix unmap overflow off-by-one
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, peterx@redhat.com, cohuck@redhat.com
Date:   Tue, 08 Jan 2019 09:40:06 -0700
Message-ID: <154696559827.32763.11706407320970225120.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 16:40:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below referenced commit adds a test for integer overflow, but in
doing so prevents the unmap ioctl from ever including the last page of
the address space.  Subtract one to compare to the last address of the
unmap to avoid the overflow and wrap-around.

Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Pei Zhang <pezhang@redhat.com>
Debugged-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7651cfb14836..73652e21efec 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -878,7 +878,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		return -EINVAL;
 	if (!unmap->size || unmap->size & mask)
 		return -EINVAL;
-	if (unmap->iova + unmap->size < unmap->iova ||
+	if (unmap->iova + unmap->size - 1 < unmap->iova ||
 	    unmap->size > SIZE_MAX)
 		return -EINVAL;
 

