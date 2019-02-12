Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44975C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083592186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0c2VdRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfBLH0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfBLH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z2lTeBYlifNP2/9UvuiZxj60a5rzZPCVg1buSdgpIn4=; b=n0c2VdRv3X9nsqqigP7saoTuPQ
        cd54bgGBZk3FatXrHrTu0iZZBEF4CMlsHulArlfSub8wniVmU08nA5vdYjWdSGKUggRiM5tLXFzFi
        Pg6YTTePl87DiJmD6AaNt2AEyh4P/ToLncEVq9xbJm6MWw6lepm943kfFu1w4wqhRNqca8r7bzABa
        GtlBjwaDuBPJCbzgCExjXHp3WftzJFknflql2aDydnIFA0yCyJkbhABure5UY+thuecSO+T99hT7E
        KWb7ovbRzK10B3jByXhCMLSPK4LmOZOCygC/HvhJfe+WUIA0QSHfQrMO7GtK4iYngP2su6Bm1GiFR
        KGOaZHFw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSS8-0002oX-QN; Tue, 12 Feb 2019 07:26:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] mmc: sh_mmcif: handle highmem pages
Date:   Tue, 12 Feb 2019 08:25:25 +0100
Message-Id: <20190212072528.13167-12-hch@lst.de>
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
 drivers/mmc/host/sh_mmcif.c | 59 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 81bd9afb0980..24c3f13bafdb 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -228,7 +228,7 @@ struct sh_mmcif_host {
 	bool dying;
 	long timeout;
 	void __iomem *addr;
-	u32 *pio_ptr;
+	u32 pio_offset;
 	spinlock_t lock;		/* protect sh_mmcif_host::state */
 	enum sh_mmcif_state state;
 	enum sh_mmcif_wait_for wait_for;
@@ -595,7 +595,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	return ret;
 }
 
-static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
+static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 {
 	struct mmc_data *data = host->mrq->data;
 
@@ -606,10 +606,10 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len)
-			host->pio_ptr = sg_virt(++data->sg);
-	} else {
-		host->pio_ptr = p;
+		if (++host->sg_idx < data->sg_len) {
+			data->sg++;
+			host->pio_offset = data->sg->offset / 4;
+		}
 	}
 
 	return host->sg_idx != data->sg_len;
@@ -631,8 +631,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -640,8 +640,11 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = sg_kmap_atomic(data->sg);
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+		p[off++] = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	sg_kunmap_atomic(data->sg, p);
 
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
@@ -664,7 +667,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
@@ -673,7 +676,7 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -684,10 +687,14 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	p = sg_kmap_atomic(data->sg);
+	for (i = 0; i < host->blocksize / 4; i++) {
+		p[host->pio_offset++] =
+			sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+	}
+	sg_kunmap_atomic(data->sg, p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -711,8 +718,8 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = sg_virt(data->sg);
-	int i;
+	u32 *p;
+	int off, i;
 
 	if (host->sd_error) {
 		data->error = sh_mmcif_error_manage(host);
@@ -720,8 +727,11 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
+	p = sg_kmap_atomic(data->sg);
+	off = data->sg->offset / 4;
 	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, p[off++]);
+	sg_kunmap_atomic(data->sg, p);
 
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
@@ -744,7 +754,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
-	host->pio_ptr = sg_virt(data->sg);
+	host->pio_offset = data->sg->offset / 4;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
@@ -753,7 +763,7 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 {
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	struct mmc_data *data = host->mrq->data;
-	u32 *p = host->pio_ptr;
+	u32 *p;
 	int i;
 
 	if (host->sd_error) {
@@ -764,10 +774,14 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	BUG_ON(!data->sg->length);
 
-	for (i = 0; i < host->blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+	p = sg_kmap_atomic(data->sg);
+	for (i = 0; i < host->blocksize / 4; i++) {
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA,
+				p[host->pio_offset++]);
+	}
+	sg_kunmap_atomic(data->sg, p);
 
-	if (!sh_mmcif_next_block(host, p))
+	if (!sh_mmcif_next_block(host))
 		return false;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
@@ -1424,6 +1438,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
+	mmc->need_kmap = 1;
 	sh_mmcif_init_ocr(host);
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
-- 
2.20.1

