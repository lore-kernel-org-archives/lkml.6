Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655120870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D655120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbeGJSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:44:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbeGJSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26D88E6B;
        Tue, 10 Jul 2018 18:33:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.14 08/53] vfio: Use get_user_pages_longterm correctly
Date:   Tue, 10 Jul 2018 20:24:44 +0200
Message-Id: <20180710182459.373379025@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

commit bb94b55af3461e26b32f0e23d455abeae0cfca5d upstream.

The patch noted in the fixes below converted get_user_pages_fast() to
get_user_pages_longterm(), however the two calls differ in a few ways.

First _fast() is documented to not require the mmap_sem, while _longterm()
is documented to need it. Hold the mmap sem as required.

Second, _fast accepts an 'int write' while _longterm uses 'unsigned int
gup_flags', so the expression '!!(prot & IOMMU_WRITE)' is only working by
luck as FOLL_WRITE is currently == 0x1. Use the expected FOLL_WRITE
constant instead.

Fixes: 94db151dc892 ("vfio: disable filesystem-dax page pinning")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/vfio_iommu_type1.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -339,18 +339,16 @@ static int vaddr_get_pfn(struct mm_struc
 	struct page *page[1];
 	struct vm_area_struct *vma;
 	struct vm_area_struct *vmas[1];
+	unsigned int flags = 0;
 	int ret;
 
+	if (prot & IOMMU_WRITE)
+		flags |= FOLL_WRITE;
+
+	down_read(&mm->mmap_sem);
 	if (mm == current->mm) {
-		ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
-					      page, vmas);
+		ret = get_user_pages_longterm(vaddr, 1, flags, page, vmas);
 	} else {
-		unsigned int flags = 0;
-
-		if (prot & IOMMU_WRITE)
-			flags |= FOLL_WRITE;
-
-		down_read(&mm->mmap_sem);
 		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
 					    vmas, NULL);
 		/*
@@ -364,8 +362,8 @@ static int vaddr_get_pfn(struct mm_struc
 			ret = -EOPNOTSUPP;
 			put_page(page[0]);
 		}
-		up_read(&mm->mmap_sem);
 	}
+	up_read(&mm->mmap_sem);
 
 	if (ret == 1) {
 		*pfn = page_to_pfn(page[0]);


