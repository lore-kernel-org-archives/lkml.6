Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074E120651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863879;
	bh=FAgK+32FtAdRBxicbLdk5A8x5F2575EBm9/bodMWuiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=trh1xd8rD9iPfUjyyu1IutAqfcgxINuiknowCTNN7RKCi4gFzjnl7jX8UwSMhMyTy
	 CxzaF2hxCdIejAYoJlRKd1+OcB1xqpmw7Gdkle8jAiRLl4mq4YDAPaSD/tpv7U5Yi8
	 NL6bC5weQDP18UramgR+cmXm9NTZcftZSKlUKSxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeLZWh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbeLZWhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046A421741;
        Wed, 26 Dec 2018 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863869;
        bh=FAgK+32FtAdRBxicbLdk5A8x5F2575EBm9/bodMWuiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=in8cpSJ8YA6eKzT2cEtxv+3HdYDtJreGNaMPSC1/cafPror/60S0kQYhPRKuWEAzL
         IS8+BDParTco6mYrwN1Eum6uSkkHQrBJ3PbBFnyDI/qK61TTh1va/CFb0l60S2+kg7
         kM9+F6Bffbh7KSv5QxU+2Rzv6LQhz4oKW0bTmrg4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcin Wojtas <mw@semihalf.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 64/97] net: mvneta: fix operation for 64K PAGE_SIZE
Date:   Wed, 26 Dec 2018 17:35:24 -0500
Message-Id: <20181226223557.149329-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index b4ed7d394d07..a78a39244b79 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -406,7 +406,6 @@ struct mvneta_port {
 	struct mvneta_pcpu_stats __percpu	*stats;
 
 	int pkt_size;
-	unsigned int frag_size;
 	void __iomem *base;
 	struct mvneta_rx_queue *rxqs;
 	struct mvneta_tx_queue *txqs;
@@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
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
@@ -3749,7 +3750,6 @@ static int mvneta_open(struct net_device *dev)
 	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
-	pp->frag_size = PAGE_SIZE;
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret)
-- 
2.19.1

