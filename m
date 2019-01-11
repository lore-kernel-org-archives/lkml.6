Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492DD2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219083;
	bh=kuBCjkYKjrFs3yOAG44KEPjLV9TLBTG+SjF87wvfl7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TBwx2/DYHiqqObMki13YDxSaw6DjKLtPprThm1rRKITS3nDymqIfNwpy/PyjTwZ4C
	 dP5pb7pg++t+82TfoWFZVmnb1WXfeUvuRBUD5AKBAmWz2vGIuolhz24WBFlQB5zSWr
	 tq6uGPKfx2HPHRHmw9qotgzJ/Nkq2wOD9/Io2oi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfAKOaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388917AbfAKOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526E621841;
        Fri, 11 Jan 2019 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217015;
        bh=kuBCjkYKjrFs3yOAG44KEPjLV9TLBTG+SjF87wvfl7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwhJ5GFp0teAeXCs7yuhAzIlV8tew3KF8aOQE3eFxaatd7lQtambvk7dk33M9h/0S
         2QPHb/GpNfbjmgdzUQPaZ18cKTwvQbev1WCJqCVh7PfLDV7vkh7YpcuzWEHnFTI7Xv
         t65Lk9i/Oy0ccco4i5uOhpK/1PSjCDHRp+SNyNOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Philippe Menil <jpmenil@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 011/105] xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force clears the dst_entry.
Date:   Fri, 11 Jan 2019 15:13:42 +0100
Message-Id: <20190111131104.058553643@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8e75319dd9c0..06dec32503bd 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -341,6 +341,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		skb->sp->xvec[skb->sp->len++] = x;
 
+		skb_dst_force(skb);
+		if (!skb_dst(skb)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINERROR);
+			goto drop;
+		}
+
 lock:
 		spin_lock(&x->lock);
 
@@ -380,7 +386,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		skb_dst_force(skb);
 		dev_hold(skb->dev);
 
 		if (crypto_done)
-- 
2.19.1



