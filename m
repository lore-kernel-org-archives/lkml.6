Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A35C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2EB218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863791;
	bh=F9eTjEcRZEUYipucY4hvRfl+XxfBvPdr0vy1VzZKW/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBLI0kbEoW74WOnii+L1IWYJYbdZ7iXlTvVz6JTQwS/B6T4wSH644aAqaacR2+D+V
	 R49b/GhB5SUE9qt0LvxkRuSQ3MqdFbBH1jYKTPwQbfI45/vuoYSLUAt3rlBdui1bSt
	 /r/KvVgevD+qfmnhv40t75I3kbLhPpPLMG8+VJi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeLZWga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeLZWg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D96B218E2;
        Wed, 26 Dec 2018 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863787;
        bh=F9eTjEcRZEUYipucY4hvRfl+XxfBvPdr0vy1VzZKW/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6FQCwDjLPuYH2nPXm4VQ4BPt0O/621zWyHHoKoksQ7202pp+f0iXxJZMMMQtB3yA
         d3wqG8cT4y8q7Nbo142i/l6Xftygxfn8oTKQEhK8H3F4tF0ydlbjttw6aLiT3TWcUF
         gqVS5uyHLZU13Q1saMzYboQySj7UAaRwWMqFnShs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/97] xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force clears the dst_entry.
Date:   Wed, 26 Dec 2018 17:34:38 -0500
Message-Id: <20181226223557.149329-18-sashal@kernel.org>
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

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 0152eee6fc3b84298bb6a79961961734e8afa5b8 ]

Since commit 222d7dbd258d ("net: prevent dst uses after free")
skb_dst_force() might clear the dst_entry attached to the skb.
The xfrm code doesn't expect this to happen, so we crash with
a NULL pointer dereference in this case.

Fix it by checking skb_dst(skb) for NULL after skb_dst_force()
and drop the packet in case the dst_entry was cleared. We also
move the skb_dst_force() to a codepath that is not used when
the transformation was offloaded, because in this case we
don't have a dst_entry attached to the skb.

The output and forwarding path was already fixed by
commit 9e1437937807 ("xfrm: Fix NULL pointer dereference when
skb_dst_force clears the dst_entry.")

Fixes: 222d7dbd258d ("net: prevent dst uses after free")
Reported-by: Jean-Philippe Menil <jpmenil@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index be3520e429c9..790b514f86b6 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -346,6 +346,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		skb->sp->xvec[skb->sp->len++] = x;
 
+		skb_dst_force(skb);
+		if (!skb_dst(skb)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINERROR);
+			goto drop;
+		}
+
 lock:
 		spin_lock(&x->lock);
 
@@ -385,7 +391,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		skb_dst_force(skb);
 		dev_hold(skb->dev);
 
 		if (crypto_done)
-- 
2.19.1

