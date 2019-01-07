Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF9FC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AA0206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865465;
	bh=DZEbFFkD5ny86jnlkb4QcLMzIu9kvM9Q9aZbZk9Ukpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tPQ+JvGmlnwzqjNc8WDlrqNP96+yY9XyDGRBUShUVOR9ZRcCejYgMTjN98KDUVDCJ
	 QFs/oMLNeystKKZ3QSM4hBbCoRnyp0EUIoAHwMCP98E66VJMb4bAr4HOwz1Y49ptHH
	 +EoK6VY76W7Xd6OA0KUwwBY7cxdKe+KsqcT9BL28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfAGMsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfAGMss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8A2206BB;
        Mon,  7 Jan 2019 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865327;
        bh=DZEbFFkD5ny86jnlkb4QcLMzIu9kvM9Q9aZbZk9Ukpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8iSJOXQiaotKL4aCLR2cttUdURrhg5dsvjYP9KwxHIL7ZBVFPAcwjzwSHEx/L3eL
         3GaFJlNPB9EfNOgrXtB9Fm++bunFJFqM4qsvlHnqvu7JNP9+MARqkUydCbHuDs28iy
         D5q1U+XDv0cC6ejShWQdPiA0pSFLvwZy6AO9I8ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 056/170] net: mvneta: fix operation for 64K PAGE_SIZE
Date:   Mon,  7 Jan 2019 13:31:23 +0100
Message-Id: <20190107104459.712652752@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Marcin Wojtas <mw@semihalf.com>

[ Upstream commit e735fd55b94bb48363737db3b1d57627c1a16b47 ]

Recent changes in the mvneta driver reworked allocation
and handling of the ingress buffers to use entire pages.
Apart from that in SW BM scenario the HW must be informed
via PRXDQS about the biggest possible incoming buffer
that can be propagated by RX descriptors.

The BufferSize field was filled according to the MTU-dependent
pkt_size value. Later change to PAGE_SIZE broke RX operation
when usin 64K pages, as the field is simply too small.

This patch conditionally limits the value passed to the BufferSize
of the PRXDQS register, depending on the PAGE_SIZE used.
On the occasion remove now unused frag_size field of the mvneta_port
structure.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -406,7 +406,6 @@ struct mvneta_port {
 	struct mvneta_pcpu_stats __percpu	*stats;
 
 	int pkt_size;
-	unsigned int frag_size;
 	void __iomem *base;
 	struct mvneta_rx_queue *rxqs;
 	struct mvneta_tx_queue *txqs;
@@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mv
 	if (!pp->bm_priv) {
 		/* Set Offset */
 		mvneta_rxq_offset_set(pp, rxq, 0);
-		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
+		mvneta_rxq_buf_size_set(pp, rxq, PAGE_SIZE < SZ_64K ?
+					PAGE_SIZE :
+					MVNETA_RX_BUF_SIZE(pp->pkt_size));
 		mvneta_rxq_bm_disable(pp, rxq);
 		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
@@ -3749,7 +3750,6 @@ static int mvneta_open(struct net_device
 	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
-	pp->frag_size = PAGE_SIZE;
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret)


