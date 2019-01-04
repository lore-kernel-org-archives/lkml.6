Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54021872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfADUyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:54:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:54:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 160EE14C5C7FE;
        Fri,  4 Jan 2019 12:54:15 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:54:14 -0800 (PST)
Message-Id: <20190104.125414.2212636411296708605.davem@davemloft.net>
To:     rientjes@google.com
Cc:     edumazet@google.com, akpm@linux-foundation.org, willemb@google.com,
        mhocko@suse.com, vbabka@suse.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] net, skbuff: do not prefer skb allocation fails early
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.1901021300420.62853@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1901021300420.62853@chino.kir.corp.google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 12:54:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>
Date: Wed, 2 Jan 2019 13:01:43 -0800 (PST)

> Commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by 
> __GFP_RETRY_MAYFAIL with more useful semantic") replaced __GFP_REPEAT in
> alloc_skb_with_frags() with __GFP_RETRY_MAYFAIL when the allocation may
> directly reclaim.
> 
> The previous behavior would require reclaim up to 1 << order pages for
> skb aligned header_len of order > PAGE_ALLOC_COSTLY_ORDER before failing,
> otherwise the allocations in alloc_skb() would loop in the page allocator
> looking for memory.  __GFP_RETRY_MAYFAIL makes both allocations failable
> under memory pressure, including for the HEAD allocation.
> 
> This can cause, among many other things, write() to fail with ENOTCONN
> during RPC when under memory pressure.  
> 
> These allocations should succeed as they did previous to dcda9b04713c
> even if it requires calling the oom killer and additional looping in the
> page allocator to find memory.  There is no way to specify the previous
> behavior of __GFP_REPEAT, but it's unlikely to be necessary since the
> previous behavior only guaranteed that 1 << order pages would be reclaimed
> before failing for order > PAGE_ALLOC_COSTLY_ORDER.  That reclaim is not
> guaranteed to be contiguous memory, so repeating for such large orders is
> usually not beneficial.
> 
> Removing the setting of __GFP_RETRY_MAYFAIL to restore the previous
> behavior, specifically not allowing alloc_skb() to fail for small orders
> and oom kill if necessary rather than allowing RPCs to fail.
> 
> Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") 
> Signed-off-by: David Rientjes <rientjes@google.com>

Applied and queued up for -stable.
