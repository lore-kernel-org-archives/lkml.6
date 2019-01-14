Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604EF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EnB6rFYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfANJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfANJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T4OCbupN7r9XzFe0NMLIX5QDout51/50IpzPj/iVSVU=; b=EnB6rFYvBStp+HzKG0KpV7/ZQF
        9LALqZfaJGKhkdrZ/sio/2G9AOMAYji1BJfIcwaiRDYO4pSTiDlw1pGsFLO0YeVxbBcOaOMxTCQGM
        PcrR6Rvn7aeg50pBWBDxVX3WjPhzoXSdIWU84LnUY8FnvqUKi+RgGYQr2gKeKU3gZLqKzxCvbyHH0
        kwjMd88/WxRUZbyRyp7xvUf02OL3TO4+6ocV84/gXdwz/lGfh4+xUfy/Rub+SX8UmdsHllM09lTvS
        h42FfN/Q5VaRacGxer8wIqMu6ntWEoWnwUpVs5RyoBooAOQGxaGWM3XqHcOSFnHd5sAqbUISdPcMh
        REPDbtTw==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0v-0002Is-AA; Mon, 14 Jan 2019 09:58:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] mmc: sh_mmcif: handle chained sglists
Date:   Mon, 14 Jan 2019 10:58:02 +0100
Message-Id: <20190114095804.27978-10-hch@lst.de>
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

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/sh_mmcif.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0d2bbb8943f5..a4116be5ebc7 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -234,7 +234,6 @@ struct sh_mmcif_host {
 	enum sh_mmcif_wait_for wait_for;
 	struct delayed_work timeout_work;
 	size_t blocksize;
-	int sg_idx;
 	int sg_blkidx;
 	bool power;
 	bool ccs_enable;		/* Command Completion Signal support */
@@ -606,13 +605,13 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host)
 
 	if (host->sg_blkidx == data->sg->length) {
 		host->sg_blkidx = 0;
-		if (++host->sg_idx < data->sg_len) {
-			data->sg++;
-			host->pio_offset = data->sg->offset / 4;
-		}
+		data->sg = sg_next(data->sg);
+		if (!data->sg)
+			return false;
+		host->pio_offset = data->sg->offset / 4;
 	}
 
-	return host->sg_idx != data->sg_len;
+	return true;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -665,7 +664,6 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
@@ -752,7 +750,6 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 		BLOCK_SIZE_MASK;
 
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
-	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_offset = data->sg->offset / 4;
 
-- 
2.20.1

