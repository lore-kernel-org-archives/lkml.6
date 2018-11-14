Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6DD2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TPdQTXCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6DD2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeKNS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbeKNS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4zqQQi9ctkbH3jopiquXd5fu3/8u2WITpCDxsIiflrA=; b=TPdQTXCPA7HV8duv45UM2kksn5
        K4lnpxClg9GDk3B/eiCJa4zo9A4n3XQYGW6UgMSXdvOT/Y+/0t1EnBZ4bgrEiJBEcq9LlY5Zi6JWz
        PxmcZdA48dAihR5Fq2ukodBfxVq5ZVP1oyejRLyEQJaODUkB1phAP/YhDDMMAweV7xbHuhPmFCc7m
        DI3GM1UhqzxFGgUw19bGkwtGof2E0+MZ4TUQ6E9z+1/3uwWINb+TQc04myiZKvtH9aeUHK+6nKs9l
        T9MKHtEgQXZEUHjNG7mYAO8/o61HSJy3CkQ5CqHfhJwUxPtrVBialr1tRcYv4lTPGWKABBQMYy02M
        YJJ2riwA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSd-0004pr-U3; Wed, 14 Nov 2018 08:23:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/34] powerpc/pseries: unwind dma_get_required_mask_pSeriesLP a bit
Date:   Wed, 14 Nov 2018 09:22:50 +0100
Message-Id: <20181114082314.8965-11-hch@lst.de>
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

Call dma_get_required_mask_pSeriesLP directly instead of dma_iommu_ops
to simply the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f02960b439..da5716de7f4c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1273,7 +1273,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 			return DMA_BIT_MASK(64);
 	}
 
-	return dma_iommu_ops.get_required_mask(dev);
+	return dma_iommu_get_required_mask(dev);
 }
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
-- 
2.19.1

