Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E692054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2TSSbb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E692054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJIUpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:45:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeJIUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FPvgBLtWHsWCoL0Sua1w8BYNtdVAHDwhlJY2AxROsgo=; b=L2TSSbb+lOD59zteiXYTwFQ7Ma
        Dw0zO+HHGGmLlMqchBHV+WbkXMLMJO/7Uy00wg+DENtwWf5uVx1VA2umOZNklgKsr997KxO4HmbAp
        vJS01fFgWXBkFFJWtjQuxMCPpTYV3kHMi71E5ZzLXUa4ewHl7g1nk3LTV4s0cdrzzgozaunGWeJr3
        TzEqp9+1gsNa5OLDunqPjsZCc6j0iAqKJn7BAtLUSX0wXX+0FQs/ALqt+q/pJaGpwRqWRjEmbyVkm
        y4p2LOdeUzMtLQJDiqlj+jTgGRWfvttHeBMeN1Tff4eX1rpU4tmstM20qKALPd9WrbnL+4Fkv+XmK
        E4rYwf/A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9s0z-0001B1-3S; Tue, 09 Oct 2018 13:25:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/33] powerpc/dart: remove dead cleanup code in iommu_init_early_dart
Date:   Tue,  9 Oct 2018 15:24:40 +0200
Message-Id: <20181009132500.17643-14-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
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
index 5ca3e22d0512..ce5dd2048f57 100644
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
2.19.0

