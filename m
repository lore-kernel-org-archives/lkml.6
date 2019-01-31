Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6853C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959C9218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btJPnHFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfAaDIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:08:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33139 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:08:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so817853pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iec/iwyk+9yIyetIpSnDlz9q4nLWbzvs4Tb+BjkPjDE=;
        b=btJPnHFFmNfaReq5/e7TkaGbwn15giRl9XlitU46PRtF/0teXo0bWC1peOMGRPqPA8
         hxAb0yGT180I0FDMfC86c/tvU+9G6qZ1Rx1ilqWyX4vHBBETh7UPpSVVyUGUHQV1uQQo
         Nd3mIgmXCAbNkh8lBEMTntnGXxdqSwKzraFTYyTORHy0zOogKhLvdaw47rbsjlLPPuRs
         aeqhr8e4CwkRDvSeOrC7vIPstO0GVYeSubKCmIlkrToB20gf51xWHeogaA5+SVliS+ZB
         SoSvM7OtvGHYInHjKr77zMMAlEywrAABgpKu1dA0bjh0cumvwJ/m0hgNXUPCXOF1J3H7
         mDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iec/iwyk+9yIyetIpSnDlz9q4nLWbzvs4Tb+BjkPjDE=;
        b=mSxzQRbn2puyIMTCL/ALCJP3yKlUEgRWhSCyNFL7rtSYAYggr8c+scBfdBlyWfxxt+
         6hsLwGPKouG/M0rrsB5xLLkn17FOo5QHZBvSUVOaH0IW49aYWhtaKvxw/wUYHyqEQ9vO
         D3S6D7glmDU/8XLuCJXedpJOtr3hZ4JJFkJPS621QOuKF3k6d+pqeNZq8XnPuS2nndbi
         SWXuXDksFtSWjwrobJP1VJqApdzNRMwQDGc41US2PBQsMnOTLNVtzhQxb581If98WMtr
         KSupZgeZn4UzxH6uVrtuVvFDKLUcLBdiorE15IrcMk+VQMyFww0lj8TNXLefq/Bp0fyL
         o4bg==
X-Gm-Message-State: AJcUukfTPf8nGIsD91oqyzldPb0ZcBPy5/RGh0XhsUbeHTUP4yeOpLvp
        /s1hl0teicuTOR8O2e4ma/A=
X-Google-Smtp-Source: ALg8bN7nn3ngJBjBBd3F3bgclAbBF0cXBwm0q+GBXn5HYfScD2qZEcAMQ9j5PQSYrWPibjpeeIgmmw==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr28672360pgm.88.1548904089076;
        Wed, 30 Jan 2019 19:08:09 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id z13sm3977258pgf.84.2019.01.30.19.08.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:08:08 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:42:22 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCHv2 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20190131031222.GA2356@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/iommu/dma-iommu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..bdf14b87 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -620,17 +620,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
-
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

