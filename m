Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1AC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4B820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDubjdg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4B820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJPMCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbeJPMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A089C21479;
        Tue, 16 Oct 2018 04:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663218;
        bh=ZQ1+SYus1DILyqiKa9s939j9qxoz/uR52fIheB1huKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDubjdg6+y1yk0RLTxnLRArT8ZIqtDMSZhUuvSumnzaPaP1Y499dxo37OmWxwYL2C
         SGmoumJwJfnbAZL8+zm8kMv4il87mkJnacdklyhx0AwtVtwE77zFreFgMyDF+nGyS3
         rrpMLUU+u2W6T0ePHIxaSABBx8OGMoJLFhVlFgN8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 080/100] net: qualcomm: rmnet: Fix incorrect allocation flag in receive path
Date:   Tue, 16 Oct 2018 00:12:01 -0400
Message-Id: <20181016041221.135528-80-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit ec405641e2b73160e26ef17580d0cf28565d146c ]

The incoming skb needs to be reallocated in case the headroom
is not sufficient to adjust the ethernet header. This allocation
needs to be atomic otherwise it results in this splat

 [<600601bb>] ___might_sleep+0x185/0x1a3
 [<603f6314>] ? _raw_spin_unlock_irqrestore+0x0/0x27
 [<60069bb0>] ? __wake_up_common_lock+0x95/0xd1
 [<600602b0>] __might_sleep+0xd7/0xe2
 [<60065598>] ? enqueue_task_fair+0x112/0x209
 [<600eea13>] __kmalloc_track_caller+0x5d/0x124
 [<600ee9b6>] ? __kmalloc_track_caller+0x0/0x124
 [<602696d5>] __kmalloc_reserve.isra.34+0x30/0x7e
 [<603f629b>] ? _raw_spin_lock_irqsave+0x0/0x3d
 [<6026b744>] pskb_expand_head+0xbf/0x310
 [<6025ca6a>] rmnet_rx_handler+0x7e/0x16b
 [<6025c9ec>] ? rmnet_rx_handler+0x0/0x16b
 [<6027ad0c>] __netif_receive_skb_core+0x301/0x96f
 [<60033c17>] ? set_signals+0x0/0x40
 [<6027bbcb>] __netif_receive_skb+0x24/0x8e

Fixes: 74692caf1b0b ("net: qualcomm: rmnet: Process packets over ethernet")
Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 1f98d65473cf..11167abe5934 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -113,7 +113,7 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 	struct sk_buff *skbn;
 
 	if (skb->dev->type == ARPHRD_ETHER) {
-		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_KERNEL)) {
+		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
 			kfree_skb(skb);
 			return;
 		}
-- 
2.17.1

