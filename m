Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37086C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EAA21A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUFjJheP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfBOOqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:46:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbfBOOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EHWMeKcx9wnViTN9ihf7C7jkTSiQjOUf9Ygq4DjgD68=; b=MUFjJhePSTNbviuLt/tzzQlegp
        6C9Yny9pX5Am+pFoqCjYBamJtvFxF6VSGg+uAHsh/OJSQ6jCVcELcnUrK0xLdXNmyR55fEhmNLfNr
        nBgr9WyvK54spzUaipd9NFC68oneY9FOpYTXwpiE55/Kf4Y8gj+xtP4qBte35QMr/M8Ho5iELjX48
        e+CyhgSxIGwifBPgn7Cw885m8yz9s1g0q4sBWaqQG1+m8Ss0Ku3D7olkf1Xl9mocUXCzheBDn4t7P
        BJ2HJkbtFg8jn0vfC1k2dBaYNX4aiML7B/tIyhRdDyq45PYYCnwYAf2p4/FvqYqKcSm8PF2RQjLvE
        8JHgpukg==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gueke-0005PN-22; Fri, 15 Feb 2019 14:46:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ccio: allow large DMA masks
Date:   Fri, 15 Feb 2019 15:45:55 +0100
Message-Id: <20190215144559.8777-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
References: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no harm in setting a 64-bit mask even if we don't need it,
and the current ccio code is one of the few place in the kernel
still rejecting larger than required DMA masks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/ccio-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 8d2fc84119c6..24a68fb7b2f9 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -710,8 +710,8 @@ ccio_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
-	/* only support 32-bit devices (ie PCI/GSC) */
-	return (int)(mask == 0xffffffffUL);
+	/* only support 32-bit or better devices (ie PCI/GSC) */
+	return (int)(mask >= 0xffffffffUL);
 }
 
 /**
-- 
2.20.1

