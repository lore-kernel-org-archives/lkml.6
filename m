Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCED2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU2hU5Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCED2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJQBCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD1C20866;
        Tue, 16 Oct 2018 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709883;
        bh=JCZ8ZJ5sWsteDLrnor2NvQgeISVjfAsHKUcwnLwGP1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RU2hU5Ky8ISq+6rlNTgwlELdpvRxtsF+OC+GP/auf1YjYxqJBjGsdZkZgqpwtPlYt
         qj4n8xuJ5WVRXQJ7KroB3btbgh02VjoA6Hxn8t0Pr+RNPfln74lVBBp9cdlACDPEmd
         HQT1adwOO+RP9KV3o4s1i2ReSYEU9rOeXIFXEDUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 029/135] net: qualcomm: rmnet: Fix incorrect allocation flag in receive path
Date:   Tue, 16 Oct 2018 19:04:19 +0200
Message-Id: <20181016170517.116720853@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -113,7 +113,7 @@ rmnet_map_ingress_handler(struct sk_buff
 	struct sk_buff *skbn;
 
 	if (skb->dev->type == ARPHRD_ETHER) {
-		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_KERNEL)) {
+		if (pskb_expand_head(skb, ETH_HLEN, 0, GFP_ATOMIC)) {
 			kfree_skb(skb);
 			return;
 		}


