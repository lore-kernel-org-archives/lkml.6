Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CAC2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrbtHkRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBLH0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ovnWwJIGZbyfHvIMSi3gnaeG6dQuOk395gFp+nBctN0=; b=NrbtHkRT6Z+C3+uU+bxHlZOUll
        zWPT5RGApLR2o6c7fUaATBfsn6CtXcGBW1WBma7ZSH/ukFGUDGSRa4Oi8HllH5lxkm3N5x+GyQRBH
        /PELARLRldb6aoHikIOXLdXGqnzpWWAqzsdD+WHAz9g9iTaApNjuqX+07f4NxEsowrRKapJ6wqZWp
        yWJj+eJDx0V678li+sUuQab15AwJxd1AljfcHlN6kt2osOAhExT+rIL/R5cl3yqqk5tbOVepUP7zp
        dOD+CpYcJwKnizSIeeqZUjbl5Pd1/a5IUUK1ppxVAftIw6TJyhMHHvLMeRwfs8bAsljSGucCuyzqg
        GLmehhCQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRr-0002US-VE; Tue, 12 Feb 2019 07:25:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] mmc: moxart: handle highmem pages
Date:   Tue, 12 Feb 2019 08:25:19 +0100
Message-Id: <20190212072528.13167-6-hch@lst.de>
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
track the offset in the current page, and do a kmap for the page while
doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/moxart-mmc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..116964e6506d 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -311,7 +311,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	sgp = sg_virt(host->cur_sg);
+	sgp = kmap(sg_page(host->cur_sg)) + host->cur_sg->offset;
 	remain = host->data_remain;
 
 	if (data->flags & MMC_DATA_WRITE) {
@@ -319,8 +319,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_URUN, &status)
 			     == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				iowrite32(*sgp, host->base + REG_DATA_WINDOW);
@@ -335,8 +334,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_ORUN, &status)
 			    == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				/* SCR data must be read in big endian. */
@@ -356,10 +354,15 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	data->bytes_xfered += host->data_remain - remain;
 	host->data_remain = remain;
 
-	if (host->data_len != data->bytes_xfered)
+	if (host->data_len != data->bytes_xfered) {
+		kunmap(sg_page(host->cur_sg));
 		moxart_next_sg(host);
-	else
-		complete(&host->pio_complete);
+		return;
+	}
+
+done:
+	kunmap(sg_page(host->cur_sg));
+	complete(&host->pio_complete);
 }
 
 static void moxart_prepare_data(struct moxart_host *host)
@@ -614,6 +617,7 @@ static int moxart_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &moxart_ops;
+	mmc->need_kmap = 1;
 	mmc->f_max = DIV_ROUND_CLOSEST(host->sysclk, 2);
 	mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
 	mmc->ocr_avail = 0xffff00;	/* Support 2.0v - 3.6v power. */
-- 
2.20.1

