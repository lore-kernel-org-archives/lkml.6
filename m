Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E3C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F632186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j0IKJPsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBLHZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:25:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PbFY06L85QwqIqZmMhvtYp32gN0YEkn+6lQLGyA+51Q=; b=j0IKJPsBmNLGNK6Mp0W59c8TZb
        pz0+BmX/GQtSXZYtHbGPgm03L1Fw03F+nSCFJFiEN5gHi+FAW94SJUSwX2ZHw7rweQXUNHfxsErKT
        eYau7OcJkMKLF2+5XlRhL8DHr0Xr4lP89ighqxrlgx6Inl0S+CD1SO57z1+tb1uMsptlodjSyfdRm
        4RrJL1opr1hrp90hDCWxN7ERNTa3RlQHF8C0y3UCiaTzThQ3iqbdIIcJkdK7MGHaptS5j7EI4CJSo
        B9AzOI7S2AvKAlK5DUiemxN7hdQGdsYIAROk/4GQnS9oc7uS+gu6CkQz4PhPm92L33ez26wmhAOb2
        5N/iEUeA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRp-0002RZ-8Y; Tue, 12 Feb 2019 07:25:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] mmc: davinci: handle highmem pages
Date:   Tue, 12 Feb 2019 08:25:18 +0100
Message-Id: <20190212072528.13167-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/davinci_mmc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..6a16d7a1d5bc 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -194,11 +194,12 @@ struct mmc_davinci_host {
 #define DAVINCI_MMC_DATADIR_WRITE	2
 	unsigned char data_dir;
 
-	/* buffer is used during PIO of one scatterlist segment, and
-	 * is updated along with buffer_bytes_left.  bytes_left applies
-	 * to all N blocks of the PIO transfer.
+	/*
+	 * buffer_offset is used during PIO of one scatterlist segment, and is
+	 * updated along with buffer_bytes_left.  bytes_left applies to all N
+	 * blocks of the PIO transfer.
 	 */
-	u8 *buffer;
+	u32 buffer_offset;
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
@@ -229,8 +230,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +239,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	u8 *p, *base;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +247,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	base = sg_kmap_atomic(host->sg);
+	p = base + host->buffer_offset;
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -275,7 +277,8 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 			p = p + (n & 3);
 		}
 	}
-	host->buffer = p;
+	host->buffer_offset = p - base;
+	sg_kunmap_atomic(host->sg, base);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +575,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
@@ -1291,6 +1294,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	mmc->ops = &mmc_davinci_ops;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->need_kmap = 1;
 
 	/* With no iommu coalescing pages, each phys_seg is a hw_seg.
 	 * Each hw_seg uses one EDMA parameter RAM slot, always one
-- 
2.20.1

