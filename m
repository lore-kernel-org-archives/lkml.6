Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BF3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C458D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358821;
	bh=TnCEkuBPHKpBs20IyB5NNIpTQgWYqD2hqpSZG/03z28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gbctHjQvrttvBqUD43ysi9CRRU6DLoahhXw6QxEwESZFj4TB00tC8AXe8g+veyDzK
	 JVciM8rfqyADo0egxlXaa5E1+K6DrN5//W7sMRoKMIJXWN4z6pEOHhgrqVjHetK090
	 KZkaDBeRZgyUu/WS9xSqWVelLCIX9tq13o7cCVDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfAXTkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733218AbfAXTkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A6E218D3;
        Thu, 24 Jan 2019 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358816;
        bh=TnCEkuBPHKpBs20IyB5NNIpTQgWYqD2hqpSZG/03z28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wRJz3bATUD9c0zm2JHr3TK7pqEFyMX87TZGWOwTyrIGwU+M/679w+Yv+qbv1q2dAZ
         IrkJZogcpntoyPPKk22bsJ55yF9G6S8u8rooI+zVLEGND56PiKBT3OVNy3uG5mb/A/
         aSr0GMWKvoiSHSTSdZoxkHGEwZ3tIgbn2+u1qc2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 005/127] net, skbuff: do not prefer skb allocation fails early
Date:   Thu, 24 Jan 2019 20:19:11 +0100
Message-Id: <20190124190212.286918659@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

From: David Rientjes <rientjes@google.com>

[ Upstream commit f8c468e8537925e0c4607263f498a1b7c0c8982e ]

Commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
__GFP_RETRY_MAYFAIL with more useful semantic") replaced __GFP_REPEAT in
alloc_skb_with_frags() with __GFP_RETRY_MAYFAIL when the allocation may
directly reclaim.

The previous behavior would require reclaim up to 1 << order pages for
skb aligned header_len of order > PAGE_ALLOC_COSTLY_ORDER before failing,
otherwise the allocations in alloc_skb() would loop in the page allocator
looking for memory.  __GFP_RETRY_MAYFAIL makes both allocations failable
under memory pressure, including for the HEAD allocation.

This can cause, among many other things, write() to fail with ENOTCONN
during RPC when under memory pressure.

These allocations should succeed as they did previous to dcda9b04713c
even if it requires calling the oom killer and additional looping in the
page allocator to find memory.  There is no way to specify the previous
behavior of __GFP_REPEAT, but it's unlikely to be necessary since the
previous behavior only guaranteed that 1 << order pages would be reclaimed
before failing for order > PAGE_ALLOC_COSTLY_ORDER.  That reclaim is not
guaranteed to be contiguous memory, so repeating for such large orders is
usually not beneficial.

Removing the setting of __GFP_RETRY_MAYFAIL to restore the previous
behavior, specifically not allowing alloc_skb() to fail for small orders
and oom kill if necessary rather than allowing RPCs to fail.

Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by __GFP_RETRY_MAYFAIL with more useful semantic")
Signed-off-by: David Rientjes <rientjes@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5202,7 +5202,6 @@ struct sk_buff *alloc_skb_with_frags(uns
 	unsigned long chunk;
 	struct sk_buff *skb;
 	struct page *page;
-	gfp_t gfp_head;
 	int i;
 
 	*errcode = -EMSGSIZE;
@@ -5212,12 +5211,8 @@ struct sk_buff *alloc_skb_with_frags(uns
 	if (npages > MAX_SKB_FRAGS)
 		return NULL;
 
-	gfp_head = gfp_mask;
-	if (gfp_head & __GFP_DIRECT_RECLAIM)
-		gfp_head |= __GFP_RETRY_MAYFAIL;
-
 	*errcode = -ENOBUFS;
-	skb = alloc_skb(header_len, gfp_head);
+	skb = alloc_skb(header_len, gfp_mask);
 	if (!skb)
 		return NULL;
 


