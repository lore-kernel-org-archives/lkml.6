Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88052C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C70A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yPXUnKIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C70A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJPMCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJPMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7FE2148D;
        Tue, 16 Oct 2018 04:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663217;
        bh=3yssc3R0Y58/D9UaNEs46y32kUTRiAV4gAnURo/7vjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPXUnKIaGd+roD5eT5J7g4lu5e09HiASmhz7ZOqeETRp8LEZ56WOJV8isAzZif7/p
         ajQEVfpD7oBgjOaKdYjd1HlyW6yyfFTEl3vu9c9f9QLuIOpYj1xhOMGMlAURgm1Zz3
         2jwpSDh+3sQ04DdSw1KVig6VJ5eSfqSqVReWJnMo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 079/100] net: qualcomm: rmnet: Fix incorrect allocation flag in transmit
Date:   Tue, 16 Oct 2018 00:12:00 -0400
Message-Id: <20181016041221.135528-79-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 6392ff3c8e4c23d0a09b0ae9f94feb3effed490b ]

The incoming skb needs to be reallocated in case the headroom
is not sufficient to add the MAP header. This allocation needs to
be atomic otherwise it results in the following splat

[32805.801456] BUG: sleeping function called from invalid context
[32805.841141] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[32805.904773] task: ffffffd7c5f62280 task.stack: ffffff80464a8000
[32805.910851] pc : ___might_sleep+0x180/0x188
[32805.915143] lr : ___might_sleep+0x180/0x188
[32806.131520] Call trace:
[32806.134041]  ___might_sleep+0x180/0x188
[32806.137980]  __might_sleep+0x50/0x84
[32806.141653]  __kmalloc_track_caller+0x80/0x3bc
[32806.146215]  __kmalloc_reserve+0x3c/0x88
[32806.150241]  pskb_expand_head+0x74/0x288
[32806.154269]  rmnet_egress_handler+0xb0/0x1d8
[32806.162239]  rmnet_vnd_start_xmit+0xc8/0x13c
[32806.166627]  dev_hard_start_xmit+0x148/0x280
[32806.181181]  sch_direct_xmit+0xa4/0x198
[32806.185125]  __qdisc_run+0x1f8/0x310
[32806.188803]  net_tx_action+0x23c/0x26c
[32806.192655]  __do_softirq+0x220/0x408
[32806.196420]  do_softirq+0x4c/0x70

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 6908b26feb9e..1f98d65473cf 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -147,7 +147,7 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
 	}
 
 	if (skb_headroom(skb) < required_headroom) {
-		if (pskb_expand_head(skb, required_headroom, 0, GFP_KERNEL))
+		if (pskb_expand_head(skb, required_headroom, 0, GFP_ATOMIC))
 			return -ENOMEM;
 	}
 
-- 
2.17.1

