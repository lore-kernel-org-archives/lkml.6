Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C24C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329BD2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pEXyV/b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329BD2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeJNPcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:32:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/icEzEWJfTHlN0Oc7lY0KnPqMRT/U6+nnWEROoGc650=; b=pEXyV/b42HObEC3GDh4HevHr4
        cua1/mD2h14263JPj4u3knFdKyzleMx9IbV82c5bYFdvY6wgwdo81LE/039QwdmcF/ZP0t6VKxy4e
        cneZHI89YHxH8XJZ5BSZupbSpcNa4oUGIB+I3ntHe3JPsHwAgTgGHsxpdT+DJoodXtf5OpCM/PIWC
        Yj+1Myeq7214cMCzt7mJFSa0MP8Pdayfspa8i0v3oEyNm8bJWtcw3V58OyvdmPLI5K/PVnO6Q8Z8d
        RLQK43gKHxS2qzquJVHeFeLHtP03BzFVC0ZDmHQdx9ZsAfpKLqBH+C+MBNcwEa3E6L/1UZfjU31Zx
        44QwdWMzQ==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBbC7-0000Fy-Ue; Sun, 14 Oct 2018 07:52:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     tedheadster@gmail.com, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date:   Sun, 14 Oct 2018 09:52:08 +0200
Message-Id: <20181014075208.2715-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already build the swiotlb code for 32b-t kernels with PAE support,
but the code to actually use swiotlb has only been enabled for 64-bit
kernel for an unknown reason.

Before Linux 4.18 we papers over this fact because the networking code,
the scsi layer and some random block drivers implenented their own
bounce buffering scheme.

Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
Reported-by: tedheadster <tedheadster@gmail.com>
Tested-by: tedheadster <tedheadster@gmail.com>
---
 arch/x86/kernel/pci-swiotlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 661583662430..71c0b01d93b1 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce
-- 
2.19.1

