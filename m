Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C62EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235F320811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083778;
	bh=gGG85TO/KRs/OuiwPthGb4aVTHNgRmStwAEvT/3rkV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sc/gZhLj/ZLlZ9VR+/EwfCe5D4jizkmYKBpNcZTmXNhPyyl8D0KzP/f0WvKSipGKs
	 y7aB6judzXVGttcXxvU/309c6ni8fBANQJUOC0aKYj9Uu4rO5y8zhr5zKblAhTu3dT
	 8TfHWYeKg+QkhJ5WrlVs1aTzc/RxgKJVkwkjGXvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfBMStg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394031AbfBMSpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628B6222D2;
        Wed, 13 Feb 2019 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083499;
        bh=gGG85TO/KRs/OuiwPthGb4aVTHNgRmStwAEvT/3rkV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfs8DVeMrbHsPaVZwfED8VWWAlZe5KgHdEdBmcEdlfWpXXAU/aaBwsduoCEdLEw9v
         /TxweIEciLh0z7M+yjQpWwLSg0zDAGzPDuf6+VjNdrG7DA1v4SPkJSl2pgh6j5yY/h
         qVO7BdU6KUCKNNu7c2xjNtvVMNICOVVFn5muj5NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.20 02/50] mtd: spinand: Handle the case where PROGRAM LOAD does not reset the cache
Date:   Wed, 13 Feb 2019 19:38:07 +0100
Message-Id: <20190213183655.943424211@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <bbrezillon@kernel.org>

commit 13c15e07eedf26092054c8c71f2f47edb8388310 upstream.

Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
the cache content to 0xFF (depends on vendor implementation), so we
must fill the page cache entirely even if we only want to program the
data portion of the page, otherwise we might corrupt the BBM or user
data previously programmed in OOB area.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Reported-by: Stefan Roese <sr@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Tested-by: Stefan Roese <sr@denx.de>
Reviewed-by: Stefan Roese <sr@denx.de>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/core.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -304,24 +304,30 @@ static int spinand_write_to_cache_op(str
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
+	void *buf = spinand->databuf;
+	unsigned int nbytes;
 	u16 column = 0;
 	int ret;
 
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	/*
+	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
+	 * the cache content to 0xFF (depends on vendor implementation), so we
+	 * must fill the page cache entirely even if we only want to program
+	 * the data portion of the page, otherwise we might corrupt the BBM or
+	 * user data previously programmed in OOB area.
+	 */
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
+	adjreq.dataoffs = 0;
+	adjreq.datalen = nanddev_page_size(nand);
+	adjreq.databuf.out = spinand->databuf;
+	adjreq.ooblen = nanddev_per_page_oobsize(nand);
+	adjreq.ooboffs = 0;
+	adjreq.oobbuf.out = spinand->oobbuf;
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -332,14 +338,6 @@ static int spinand_write_to_cache_op(str
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
 	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
@@ -370,8 +368,8 @@ static int spinand_write_to_cache_op(str
 
 		/*
 		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
+		 * more than one iteration, because the LOAD operation might
+		 * reset the cache to 0xff.
 		 */
 		if (nbytes) {
 			column = op.addr.val;


