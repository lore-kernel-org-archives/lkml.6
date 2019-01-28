Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78256C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB332147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696997;
	bh=mq8NmfjqDpb5Dlu6rFELx06N7wGrH1MuDBYnCer/gVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hu2PBEHO9wyLGzs3oLtWideqOB3Lxwss7HA4EDA38KdyZ1+qtLfchWkTopW5J+E/s
	 s6bAeSOT0KMAKPmuTFnvqKCCiYso+0WFLMfEB2eRUVXjAiuDwk9V5fQlaEz421YopY
	 dXGElCnCrrQ/APtvVHvKNs5+3SugImx3fjYwqEAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfA1PzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfA1PzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4E620989;
        Mon, 28 Jan 2019 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690905;
        bh=mq8NmfjqDpb5Dlu6rFELx06N7wGrH1MuDBYnCer/gVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdvtvYt4It6a6JNKQtvtAa6Ji0k7d2zlLhGkTQTCSM4Hd98WZiUkZhuIggIC1tp7p
         NXaS0NJdu50e9tdlScQmujUhIlqkYN+23WT23H0O8uB/EmOTZ/Av1HW+QAZm6YrYI6
         939DCXDN0+DiglZDiQEQZ9GOaJ37Ap0f8wtuCULg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 231/304] net: hns3: fix the descriptor index when get rss type
Date:   Mon, 28 Jan 2019 10:42:28 -0500
Message-Id: <20190128154341.47195-231-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

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

