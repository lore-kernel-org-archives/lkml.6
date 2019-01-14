Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2965C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960DD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZlPJoyxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfANJ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfANJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1w9jZZTi3DvzoUA7QUurE84hYRAcJKNs5P1tn9D6S9o=; b=ZlPJoyxuVASkVw7JGj+0RxA7PZ
        C6spsELtfM+69XVM45tT3E767DfiUnoOuqRUnfWTu6M4JXfFotcNMNaMrpOnO8E0oHHDqC3WA7RwI
        o6nTuQ7s8RpGTEwgR2JJ5+Bl9/lo6m8Achv9IggGcIowotrXWvrCNVjQqeyqnKXDvjVtXG96mLYr9
        6DggEdbbLwQf0QjfqR6sUZJs0eX8RZhYy4darvTzBTJIyQ2M5+0PuOh1g5GIUmFOSJQwT34EMGW5l
        dnVVIq974WqmeOBnyAAlFllQ5W1wtRGFSIpUTyXEaYeiyRHaI6zsgxfKTIR8J2ihmpQrAqzsL7e3d
        JTzfiZ8Q==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0Z-0001uJ-UF; Mon, 14 Jan 2019 09:58:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] mmc: omap: handle highmem pages
Date:   Mon, 14 Jan 2019 10:57:56 +0100
Message-Id: <20190114095804.27978-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
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
index c60a7625b1fa..0377ac6194a0 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
@@ -148,7 +149,7 @@ struct mmc_omap_host {
 
 	unsigned int		sg_len;
 	int			sg_idx;
-	u16 *			buffer;
+	u32			buffer_offset;
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
 
@@ -649,7 +650,7 @@ mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 
 	sg = host->data->sg + host->sg_idx;
 	host->buffer_bytes_left = sg->length;
-	host->buffer = sg_virt(sg);
+	host->buffer_offset = sg->offset;
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -666,7 +667,9 @@ mmc_omap_clk_timer(struct timer_list *t)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
+	struct scatterlist *sg = host->data->sg + host->sg_idx;
 	int n, nwords;
+	void *p;
 
 	if (host->buffer_bytes_left == 0) {
 		host->sg_idx++;
@@ -684,15 +687,17 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	host->total_bytes_left -= n;
 	host->data->bytes_xfered += n;
 
+	p = kmap_atomic(sg_page(sg));
 	if (write) {
 		__raw_writesw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			      host->buffer, nwords);
+			      p + host->buffer_offset, nwords);
 	} else {
 		__raw_readsw(host->virt_base + OMAP_MMC_REG(host, DATA),
-			     host->buffer, nwords);
+			     p + host->buffer_offset, nwords);
 	}
+	kunmap_atomic(p);
 
-	host->buffer += nwords;
+	host->buffer_offset += nwords;
 }
 
 #ifdef CONFIG_MMC_DEBUG
-- 
2.20.1

