Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BAD20675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895573;
	bh=dPemYv0rjZQuY5DXmr2RSjreztvPnxszXmtgiXSCzlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xN+Rq4Z/yrc5ci6LP27s4y+XVyCGDXalHbieMuJ2T7Ipwm8jRgFYk3l6zeoXspoiJ
	 FTfiFeAMLWcGAPIyu1C39WE/KNWRsvTgd/N+GyrtsrHqvaJ3hc6s3DbmeU/03pfUKf
	 d3qo4GiCLck92FKI76TXNF7s0OwjacHk2Z0YGbZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfBKOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbfBKOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCEB20844;
        Mon, 11 Feb 2019 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895568;
        bh=dPemYv0rjZQuY5DXmr2RSjreztvPnxszXmtgiXSCzlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNebl4Uy6G7/qGmuaNgvqily/hepp1ETe/W9eYdiqc5caGqatzSG1iFNd+VoijzSE
         ZGcDyMG1f7MlCvsTRfVaP6v551EoC2rp+11lQpHkBmElJJD0jKpVz5GDtHfav6NtGP
         8UMu+I6t/INWbbLQ/D6aK4FaELJXRz+5Bh6E14HE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 219/352] net: hns3: fix the descriptor index when get rss type
Date:   Mon, 11 Feb 2019 15:17:26 +0100
Message-Id: <20190211141901.154302125@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 31a16f99e02c2e0b40a5fb05d66f5e56721027e2 ]

Driver gets rss information from the last descriptor of the packet.
When driver handle the rss type, ring->next_to_clean indicates the
first descriptor of next packet.

This patch fix the descriptor index with "ring->next_to_clean - 1".

Fixes: 232fc64b6e62 ("net: hns3: Add HW RSS hash information to RX skb")
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index beb5dbd5e98d..d424d5bc0507 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2332,9 +2332,16 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
 				     struct sk_buff *skb)
 {
-	struct hns3_desc *desc = &ring->desc[ring->next_to_clean];
 	struct hnae3_handle *handle = ring->tqp->handle;
 	enum pkt_hash_types rss_type;
+	struct hns3_desc *desc;
+	int last_bd;
+
+	/* When driver handle the rss type, ring->next_to_clean indicates the
+	 * first descriptor of next packet, need -1 here.
+	 */
+	last_bd = (ring->next_to_clean - 1 + ring->desc_num) % ring->desc_num;
+	desc = &ring->desc[last_bd];
 
 	if (le32_to_cpu(desc->rx.rss_hash))
 		rss_type = handle->kinfo.rss_type;
-- 
2.19.1



