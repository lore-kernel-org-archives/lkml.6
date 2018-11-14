Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EC621780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PjzF40cG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EC621780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeKNS0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNS0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/j3bQXpd/gVTqLpGersu6eVAWT1I+PIQi+24w5zL65w=; b=PjzF40cGj9fpFDaBgEFmomV4Xu
        W7i50ILLZCiy79xRnCNJkggV4KMgN574dqWZGq6KGQJDvaJh5WGsZ6Jj35QWgA21cPpWfeacwD3tO
        WMIi0YV96jtexDyizT9oC+Jv2tlA4JGMVZh9Zkd1O2lNgLCFixwyu7sc4NkVej9KnbHQqKE0WnYnJ
        7MvANHPcRGcQG+HFMAXaNv/ypeuT16Yg94kzhNTEjh6y1ETy7qGf+0NyoZ0iqZ9yXuAQAWf6yXSiX
        n1kJlpobcPJUTqlt/eXrTepODHGpdOPLxryJ5xf4s7C869URkZs5qNijL3l0pCPTH0pE+GvCb9Z1x
        oe6NyBZA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSo-0004t9-VK; Wed, 14 Nov 2018 08:23:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/34] powerpc/dart: remove dead cleanup code in iommu_init_early_dart
Date:   Wed, 14 Nov 2018 09:22:54 +0100
Message-Id: <20181114082314.8965-15-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dart_init failed we didn't have a chance to setup dma or controller
ops yet, so there is no point in resetting them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a5b40d1460f1..283ce04c5844 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -428,7 +428,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Initialize the DART HW */
 	if (dart_init(dn) != 0)
-		goto bail;
+		return;
 
 	/* Setup bypass if supported */
 	if (dart_is_u4)
@@ -439,15 +439,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
-	return;
-
- bail:
-	/* If init failed, use direct iommu and null setup functions */
-	controller_ops->dma_dev_setup = NULL;
-	controller_ops->dma_bus_setup = NULL;
-
-	/* Setup pci_dma ops */
-	set_pci_dma_ops(&dma_nommu_ops);
 }
 
 #ifdef CONFIG_PM
-- 
2.19.1

