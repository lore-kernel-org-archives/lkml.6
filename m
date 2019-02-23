Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C96FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D97E20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957099;
	bh=24Iv1j3bf9LqF94srEW7PCn1HMw0DZWyae/+mGGyVr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/DUYe6Up7ZRQI4SYZnk+Ehy2ie6GZVGqeKvIQQlyMkGcvTZpcoMnuKuRv4x5rhVo
	 LWgMt62IgpE40bnuISgn3r0J/+9O31i8V/Kws+BD1z/pQTY04PbcifozYX6/ad/qYR
	 gtjBDv3HMyaF9Mhp9zk2Zc1RS8Gbxry1XQHwmjPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfBWVY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbfBWVHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3297B20861;
        Sat, 23 Feb 2019 21:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956069;
        bh=24Iv1j3bf9LqF94srEW7PCn1HMw0DZWyae/+mGGyVr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEjUu6dTavn43cbknDTdVe5DFlxuGhxIWXcG9FCLAm7hTKGs2TFseqJ8Pfcb1dlKX
         H1uEv60cahVZzruM4dxrPOU3IoBq+x6hv5wzA0L4qN7n9C3DqSaRgsJuP103Wba/hn
         qyF1gufnSS8VKEsA1g0z/5XKywBt/uyfh2b1A6lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 42/65] qed: Fix system crash in ll2 xmit
Date:   Sat, 23 Feb 2019 16:06:17 -0500
Message-Id: <20190223210640.200911-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 7c81626a3c37e4ac320b8ad785694ba498f24794 ]

Cache number of fragments in the skb locally as in case
of linear skb (with zero fragments), tx completion
(or freeing of skb) may happen before driver tries
to get number of frgaments from the skb which could
lead to stale access to an already freed skb.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 2fa1c050a14b4..b5beca97172a7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2426,19 +2426,24 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 {
 	struct qed_ll2_tx_pkt_info pkt;
 	const skb_frag_t *frag;
+	u8 flags = 0, nr_frags;
 	int rc = -EINVAL, i;
 	dma_addr_t mapping;
 	u16 vlan = 0;
-	u8 flags = 0;
 
 	if (unlikely(skb->ip_summed != CHECKSUM_NONE)) {
 		DP_INFO(cdev, "Cannot transmit a checksummed packet\n");
 		return -EINVAL;
 	}
 
-	if (1 + skb_shinfo(skb)->nr_frags > CORE_LL2_TX_MAX_BDS_PER_PACKET) {
+	/* Cache number of fragments from SKB since SKB may be freed by
+	 * the completion routine after calling qed_ll2_prepare_tx_packet()
+	 */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	if (1 + nr_frags > CORE_LL2_TX_MAX_BDS_PER_PACKET) {
 		DP_ERR(cdev, "Cannot transmit a packet with %d fragments\n",
-		       1 + skb_shinfo(skb)->nr_frags);
+		       1 + nr_frags);
 		return -EINVAL;
 	}
 
@@ -2460,7 +2465,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 	}
 
 	memset(&pkt, 0, sizeof(pkt));
-	pkt.num_of_bds = 1 + skb_shinfo(skb)->nr_frags;
+	pkt.num_of_bds = 1 + nr_frags;
 	pkt.vlan = vlan;
 	pkt.bd_flags = flags;
 	pkt.tx_dest = QED_LL2_TX_DEST_NW;
@@ -2471,12 +2476,17 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 	    test_bit(QED_LL2_XMIT_FLAGS_FIP_DISCOVERY, &xmit_flags))
 		pkt.remove_stag = true;
 
+	/* qed_ll2_prepare_tx_packet() may actually send the packet if
+	 * there are no fragments in the skb and subsequently the completion
+	 * routine may run and free the SKB, so no dereferencing the SKB
+	 * beyond this point unless skb has any fragments.
+	 */
 	rc = qed_ll2_prepare_tx_packet(&cdev->hwfns[0], cdev->ll2->handle,
 				       &pkt, 1);
 	if (rc)
 		goto err;
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+	for (i = 0; i < nr_frags; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
 
 		mapping = skb_frag_dma_map(&cdev->pdev->dev, frag, 0,
-- 
2.19.1

