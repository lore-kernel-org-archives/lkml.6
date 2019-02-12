Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010C3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12EE2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFdTzQFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBLH0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfBLHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sg1qZTQ7f9C8PWpCTPEQSLyZ0uNPVzWT71WdI2nlxFk=; b=YFdTzQFwF+TYW3Ckxd01RI5yWB
        y7pAh5SBC3oI/fHE2Vo8lK3y5zXFkhXGOOKpPd3XtuGw0K8r8Pa0G68uvfD/7P9T/5BV4Ol0g34Zf
        Uttz6iyMzZemhFH+2hhl8P0XUdUt36xP0AkivZ52Ilguuul5nsnZxdLH358eQmDGvpq3qf8SijTRE
        1zwjvvOYXSWdA76FQ2HP9/+220hOuzA9Neeoe1NRXt1HT86yQFsi2NUqaAC4/aI1hVSqFWL19bur+
        ZJspyCFxuZorXHxeKxvUheYK2cGr0hR0KTDJpjKOroa6aYAu/f0uuYe3lG7OedfFTbMqhcxve3jJL
        Dq4n5NVw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRu-0002XO-Kx; Tue, 12 Feb 2019 07:25:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] mmc: omap: handle highmem pages
Date:   Tue, 12 Feb 2019 08:25:20 +0100
Message-Id: <20190212072528.13167-7-hch@lst.de>
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
 drivers/mmc/host/omap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c60a7625b1fa..6741c95f2281 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -148,7 +148,7 @@ struct mmc_omap_host {
 
 	unsigned int		sg_len;
 	int			sg_idx;
-	u16 *			buffer;
+	u32			buffer_offset;
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
 
@@ -649,7 +649,7 @@ mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 
 	sg = host->data->sg + host->sg_idx;
 	host->buffer_bytes_left = sg->length;
-	host->buffer = sg_virt(sg);
+	host->buffer_offset = sg->offset;
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -666,7 +666,9 @@ mmc_omap_clk_timer(struct timer_list *t)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
+	struct scatterlist *sg = host->data->sg + host->sg_idx;
 	int n, nwords;
+	void *p;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -684,15 +686,17 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	host->total_bytes_left -= n;
 	host->data->bytes_xfered += n;
 
+	p = sg_kmap_atomic(sg);
 	if (write) {
 		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			      host->buffer, nwords);
+			      p + host->buffer_offset, nwords);
 	} else {
 		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			     host->buffer, nwords);
+			     p + host->buffer_offset, nwords);
 	}
+	sg_kunmap_atomic(sg, p);
 
-	host->buffer += nwords;
+	host->buffer_offset += nwords;
 }
 
 #ifdef CONFIG_MMC_DEBUG
@@ -1250,6 +1254,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_ERASE;
 
 	mmc->ops = &mmc_omap_ops;
+	mmc->need_kmap = 1;
 	mmc->f_min = 400000;
 
 	if (mmc_omap2())
-- 
2.20.1

