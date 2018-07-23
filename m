Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106CE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106CE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbeGWN3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388073AbeGWN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:15 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3C3E4C19;
        Mon, 23 Jul 2018 12:28:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 26/63] vfio/spapr: Use IOMMU pageshift rather than pagesize
Date:   Mon, 23 Jul 2018 14:24:32 +0200
Message-Id: <20180723122447.364040087@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>

commit 1463edca6734d42ab4406fa2896e20b45478ea36 upstream.

The size is always equal to 1 page so let's use this. Later on this will
be used for other checks which use page shifts to check the granularity
of access.

This should cause no behavioral change.

Cc: stable@vger.kernel.org # v4.12+
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/vfio_iommu_spapr_tce.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -457,13 +457,13 @@ static void tce_iommu_unuse_page(struct
 }
 
 static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
-		unsigned long tce, unsigned long size,
+		unsigned long tce, unsigned long shift,
 		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
 {
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem;
 
-	mem = mm_iommu_lookup(container->mm, tce, size);
+	mem = mm_iommu_lookup(container->mm, tce, 1ULL << shift);
 	if (!mem)
 		return -EINVAL;
 
@@ -487,7 +487,7 @@ static void tce_iommu_unuse_page_v2(stru
 	if (!pua)
 		return;
 
-	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
+	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
 			&hpa, &mem);
 	if (ret)
 		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
@@ -611,7 +611,7 @@ static long tce_iommu_build_v2(struct tc
 				entry + i);
 
 		ret = tce_iommu_prereg_ua_to_hpa(container,
-				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
+				tce, tbl->it_page_shift, &hpa, &mem);
 		if (ret)
 			break;
 


