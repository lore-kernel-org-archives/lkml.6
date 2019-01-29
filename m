Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62720869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRQ/zppk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA2HeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:34:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfA2HeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vmRuW3rV1BpLTjexkKN3MxaZhDeBnEhtxWvlUu/tw9I=; b=pRQ/zppkoZx4GipDSUv1MH7Up
        xo1FLdtki1rNSCqt2Lo3sJ2L5OErNK1Nei1IxXnS6l4RiDCwUHQJkzsmjiWSkGRLZZnENfWDjmBR+
        fkt+ZnrPfJ2PiAUL9LfNHgay7XpxxoIREw9NQCY+nyCHKdAX/ccZ5Y0U8om5nuu+gSE169NjmCWR8
        CNr5LEcxih5V+G7hgIwov5J5IOmlTVYkvITnhXADU4t2azOMZamb2EEjiJoZ48qgcOdpk7uIejIGP
        9YvE8Nfs+zR4mcuXtHq01wuOlka74gCgwnahcYY0zvfz5tajJtEHvS9hcb0W+eTDLEEsvD791CpPu
        sgm8ISkFA==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goNuO-0006KJ-7e; Tue, 29 Jan 2019 07:34:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     stuart.w.hayes@gmail.com, dvhart@infradead.org
Cc:     andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dell_rbu: stop abusing the DMA API
Date:   Tue, 29 Jan 2019 08:34:09 +0100
Message-Id: <20190129073409.7247-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some odd reason dell_rbu actually seems to want the physical and
not a bus address for the allocated buffer.  Lets assume that actually
is correct given that it is BIOS-related and that is a good source
of insanity.  In that case we should not use dma_alloc_coherent with
a NULL device to allocate memory, but use GFP_DMA32 to stay under
the 32-bit BIOS limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/platform/x86/dell_rbu.c | 52 ++++++++++-----------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
index ccefa84f7305..fba7d96c1714 100644
--- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -59,7 +59,6 @@ static struct _rbu_data {
 	unsigned long image_update_buffer_size;
 	unsigned long bios_image_size;
 	int image_update_ordernum;
-	int dma_alloc;
 	spinlock_t lock;
 	unsigned long packet_read_count;
 	unsigned long num_packets;
@@ -89,7 +88,6 @@ static struct packet_data packet_data_head;
 
 static struct platform_device *rbu_device;
 static int context;
-static dma_addr_t dell_rbu_dmaaddr;
 
 static void init_packet_head(void)
 {
@@ -380,12 +378,8 @@ static void img_update_free(void)
 	 */
 	memset(rbu_data.image_update_buffer, 0,
 		rbu_data.image_update_buffer_size);
-	if (rbu_data.dma_alloc == 1)
-		dma_free_coherent(NULL, rbu_data.bios_image_size,
-			rbu_data.image_update_buffer, dell_rbu_dmaaddr);
-	else
-		free_pages((unsigned long) rbu_data.image_update_buffer,
-			rbu_data.image_update_ordernum);
+	free_pages((unsigned long) rbu_data.image_update_buffer,
+		rbu_data.image_update_ordernum);
 
 	/*
 	 * Re-initialize the rbu_data variables after a free
@@ -394,7 +388,6 @@ static void img_update_free(void)
 	rbu_data.image_update_buffer = NULL;
 	rbu_data.image_update_buffer_size = 0;
 	rbu_data.bios_image_size = 0;
-	rbu_data.dma_alloc = 0;
 }
 
 /*
@@ -410,10 +403,8 @@ static void img_update_free(void)
 static int img_update_realloc(unsigned long size)
 {
 	unsigned char *image_update_buffer = NULL;
-	unsigned long rc;
 	unsigned long img_buf_phys_addr;
 	int ordernum;
-	int dma_alloc = 0;
 
 	/*
 	 * check if the buffer of sufficient size has been
@@ -444,36 +435,23 @@ static int img_update_realloc(unsigned long size)
 
 	ordernum = get_order(size);
 	image_update_buffer =
-		(unsigned char *) __get_free_pages(GFP_KERNEL, ordernum);
-
-	img_buf_phys_addr =
-		(unsigned long) virt_to_phys(image_update_buffer);
-
-	if (img_buf_phys_addr > BIOS_SCAN_LIMIT) {
-		free_pages((unsigned long) image_update_buffer, ordernum);
-		ordernum = -1;
-		image_update_buffer = dma_alloc_coherent(NULL, size,
-			&dell_rbu_dmaaddr, GFP_KERNEL);
-		dma_alloc = 1;
-	}
-
-	spin_lock(&rbu_data.lock);
-
-	if (image_update_buffer != NULL) {
-		rbu_data.image_update_buffer = image_update_buffer;
-		rbu_data.image_update_buffer_size = size;
-		rbu_data.bios_image_size =
-			rbu_data.image_update_buffer_size;
-		rbu_data.image_update_ordernum = ordernum;
-		rbu_data.dma_alloc = dma_alloc;
-		rc = 0;
-	} else {
+		(unsigned char *)__get_free_pages(GFP_DMA32, ordernum);
+	if (!image_update_buffer) {
 		pr_debug("Not enough memory for image update:"
 			"size = %ld\n", size);
-		rc = -ENOMEM;
+		return -ENOMEM;
 	}
 
-	return rc;
+	img_buf_phys_addr = (unsigned long)virt_to_phys(image_update_buffer);
+	if (WARN_ON_ONCE(img_buf_phys_addr > BIOS_SCAN_LIMIT))
+		return -EINVAL; /* can't happen per defintion */
+
+	spin_lock(&rbu_data.lock);
+	rbu_data.image_update_buffer = image_update_buffer;
+	rbu_data.image_update_buffer_size = size;
+	rbu_data.bios_image_size = rbu_data.image_update_buffer_size;
+	rbu_data.image_update_ordernum = ordernum;
+	return 0;
 }
 
 static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
-- 
2.20.1

