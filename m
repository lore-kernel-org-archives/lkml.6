Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3525AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A2820854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mE5ouElt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A2820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIJLGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:06:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbeIJLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dMSYRDJ2DKnp0sh1+FO5EiP7oVb0QT7X44eAVfEZQxk=; b=mE5ouEltnQP2jk7J/U5Szsm51
        wzmXUCBn/YAIaxipEJIVdPdowiVytZufqeeyKYcJqZ1gJllLi0bylEf4ywvJF84/ngQfT4XBwn7eT
        WtrytKRXWQQoF/TsuPntu/6mlLLZvlFCPKfDq+8sNmQMT1jjzKtjFh3CRgD7vFhuTGIMultjUYxki
        jc/edqG3yEF4v20t2pSQtkCahmjItpVWT7QBuk2rU5NXLyI4YiD9mqzKjN2kZcQKPn2NV6rfIKcHP
        9aXFFhyTBgq/991nYodTCLiYPOsY6sK5GxNcKV5xTGfQIiVzqUhy6cnaVOUX4YPlrP8k623scWGdb
        TFid/zasg==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFSB-00022Y-NW; Mon, 10 Sep 2018 06:13:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-mapping: use phys_to_dma in dma_direct_get_required
Date:   Mon, 10 Sep 2018 08:13:32 +0200
Message-Id: <20180910061332.28187-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to apply an DMA offset for the function to work as expected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7812b861b6da..6feac7294f8d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -15,7 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -1185,7 +1185,7 @@ int __init platform_bus_init(void)
  */
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 end = ((max_pfn - 1) << PAGE_SHIFT);
+	u64 end = phys_to_dma(dev, (max_pfn - 1) << PAGE_SHIFT);
 
 	return (1 << (fls64(end) - 1)) * 2 - 1;
 }
-- 
2.18.0

