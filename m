Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D56222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083391;
	bh=r0/je9PMCaBkAyZ1j0Y25BvQix6Z/PvImODgraSkXkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nojvvr9FuxVkkoEZaXrTi0HAjGRDYlJ4K2ZrIbnH8xF72fqAn6tltl+PtBLcGlfSu
	 Xn5UWiE2Nrp228tx56AsX2Cq6Y3hlWI+2Sd6IT92nTRPHZVuANeZAWf97riIt8SoFf
	 w6z0L2WHqnVIktm628YDRhPUvHxXFhkIZ/vArie0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405811AbfBMSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405778AbfBMSnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45E0222D9;
        Wed, 13 Feb 2019 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083383;
        bh=r0/je9PMCaBkAyZ1j0Y25BvQix6Z/PvImODgraSkXkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dBz1yKGNnyy9Pl7juzSi4G4T26PKPA4U9aYgpeg6+MVZ0m7nMooInolaMuR+3epH
         o0QM2B3q/mOSOtj24ayUhwvqjK3tKUDRVuAWfOeCeBHOY7RyrQCVKeVTKiJo461jgD
         UQFsUixcD9rrtn/pfIMC7HKpprZk1sp5ud+n38XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.19 02/44] mtd: spinand: Handle the case where PROGRAM LOAD does not reset the cache
Date:   Wed, 13 Feb 2019 19:38:03 +0100
Message-Id: <20190213183651.845108950@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


