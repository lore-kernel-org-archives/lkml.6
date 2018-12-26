Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6E218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864938;
	bh=Qfe/xgpIxdBaTq62qSX8XRLrH6ALo92fleV1JwWycFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prP43thQLaVvkgxWU9uPCnv4K1r2oRNV2PsnhSRblQ6zUC1cEZ3nTalHUnEjxEi0R
	 YDC0OUif21z37/o0Y/y+CLT/aYptFBoU6Byjr7MixiOuouGkCx7c9oHotMuRHEpoD0
	 KCBAMhqR2i2NpICYujYrQ6L+F1ZKffliXQZXtilw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbeLZWzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbeLZWyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F74218E2;
        Wed, 26 Dec 2018 22:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864894;
        bh=Qfe/xgpIxdBaTq62qSX8XRLrH6ALo92fleV1JwWycFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXsXKqN+UeUVTy1O1Fn6F+DzrvhsR9ESXkR6WlwAOtM9lmPPhiaAULmQ/bDf9GmRt
         BgjiL4jKXv0pbOpfZwC7eC6qf+dDQjR76mtgYGuUBBU8Wpdti6oZqZDgquckrx+A4+
         9RSB9sqBZExJ/p1fcQi03ILyYZMLiQ091iNMBP+A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 32/35] xen/netfront: tolerate frags with no data
Date:   Wed, 26 Dec 2018 17:41:39 -0500
Message-Id: <20181226224142.150866-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d81c5054a5d1d4999c7cdead7636b6cd4af83d36 ]

At least old Xen net backends seem to send frags with no real data
sometimes. In case such a fragment happens to occur with the frag limit
already reached the frontend will BUG currently even if this situation
is easily recoverable.

Modify the BUG_ON() condition accordingly.

Tested-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index aceae791baf3..14ceeaaa7fe5 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -903,7 +903,7 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
-			BUG_ON(pull_to <= skb_headlen(skb));
+			BUG_ON(pull_to < skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
 		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
-- 
2.19.1

