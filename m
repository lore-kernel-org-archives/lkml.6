Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6A6218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxM3Gdeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfABVBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:01:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38724 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfABVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:01:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so15678183pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=7jOLZApund1vrMmXa18mGVqJGSoStuzJ8CBOA3gKuDw=;
        b=oxM3GdeoGbmHLLY+WvXY6v4dSjaMW5JgZz22eion/T6d/5+8CxP8NVtNibj2ewKDQh
         me8NHiFDewKIVBzR6F+xUYdUhNnX+J/pr7Qa1Y8jJYF/qK04r4v8Kp51del1ruVhcbQI
         LO9jD+N9rs8ceZQxdGt68ZeniViVfefXfAqVYjU6D3dXwwq+z/snVLqVw4289VkOof/Z
         0ok6zSmsU1kiqEyn1qX7Wr4auG0UVmIdqIaSEED08O/yyNWzGjpZmYAteixbxUcgLl3S
         06abecq9lbH8pj6grYV6Rmco8XUgrkg/Jnsx4ISn5Zszq5vSPFNcji2uqmYcvYxlOf4d
         S9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=7jOLZApund1vrMmXa18mGVqJGSoStuzJ8CBOA3gKuDw=;
        b=DP3SNOrCKTLsZVqo9BKBbYz4OLfd0VqkYDpsYcTzSX9Qk/hMcULqenAOSllLqzF9o0
         gL4noeD6jDkDlk1EjSSY3VZtn+U7Kh+WAjAbRu45i2zpyUPHL+9RxHq1lk+9rq9AacT3
         RvU91sRuMknslDzA1ifDboI0wOOP0dWfkZxSuJh+7Fcpi9KV5VeBtH2A2uPX0T5/Af/k
         J6IqW6VteJ7MGvmop2TrUzPv8AKN/ZCjSI86m9f/sBaiPvR/hkP84Fu0z/+tn2tA/BeE
         qysrChTMnDPRK4bcurd+wblkU1t407vlEPnL5tecphC4oixU+NphSLaAk39yYJ8iRNUS
         QD9w==
X-Gm-Message-State: AA+aEWbwYAdgOk+hLv2+wEOikOsUCID04Pn7erPntP6RN4kIK+I498co
        ycJ82glBHDrIV3YcIQ52iXk0Ig==
X-Google-Smtp-Source: AFSGD/UCTQzb7ytfTFZo9Pdga8W72uMWi1r3mIgACGcI1qGqeHZdD8LkHComvdasQ6gJ26VzUybCVg==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr46131674pfb.36.1546462905048;
        Wed, 02 Jan 2019 13:01:45 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k24sm79188227pfj.13.2019.01.02.13.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 13:01:44 -0800 (PST)
Date:   Wed, 2 Jan 2019 13:01:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Willem de Bruijn <willemb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [patch] net, skbuff: do not prefer skb allocation fails early
Message-ID: <alpine.DEB.2.21.1901021300420.62853@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
__GFP_RETRY_MAYFAIL with more useful semantic") 
Signed-off-by: David Rientjes <rientjes@google.com>
---
 net/core/skbuff.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5270,7 +5270,6 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 	unsigned long chunk;
 	struct sk_buff *skb;
 	struct page *page;
-	gfp_t gfp_head;
 	int i;
 
 	*errcode = -EMSGSIZE;
@@ -5280,12 +5279,8 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
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
 
