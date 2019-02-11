Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D8FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03830218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyJHQS2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfBKNgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfBKNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RtUMP0ioQKVTbDsGoLpOuoc2mofGUXunvDSMOETYOi0=; b=KyJHQS2aLUw3l/NeJZ1nbJrTY9
        ergNxxv6WxBuYrgQD6UFA2eUOQQarcR/YwySI+G1LdyhJmdf2Eok3SwkL3x1B2dLo0Uh3R8Z6z63w
        /99HR25oSLZ/3Uj5N0osMhccCJx9ucO5yzDp3fxC8WwhA3ZmBHbVwfqRMBX7HkzgUsprNkwCSAVJ7
        iVp/6jBqL37RuO+NlEyXSDCB6W+HcocBO/DDlgDWDNH0ZVlK8kLIpLWNhbaVTWL4CMUGK8xRWwH+6
        +C0qWqwMbxwY3Q7GxxzSUtdoNs3liZJkHNvdUkQx7DnQvxf7UCgNH4a8kH/gZy1pWdDEGJFkv3sWS
        l654rSOA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBki-0008NF-1C; Mon, 11 Feb 2019 13:36:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] device.h: dma_mem is only needed for HAVE_GENERIC_DMA_COHERENT
Date:   Mon, 11 Feb 2019 14:35:44 +0100
Message-Id: <20190211133554.30055-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to carry an unused field around.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..be544400acdd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1017,8 +1017,10 @@ struct device {
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+#endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
-- 
2.20.1

