Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbeBLI6o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:58:44 -0500
Received: from mail02.prevas.se ([62.95.78.10]:54445 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932630AbeBLI6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:58:41 -0500
X-IronPort-AV: E=Sophos;i="5.46,501,1511823600";
   d="scan'208";a="3045692"
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        <cpandya@codeaurora.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <5ca5194d-8b87-bcb6-73ca-a671075e4704@prevas.dk>
Date: Mon, 12 Feb 2018 09:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-12 07:27, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Create a cache of the nodes that contain a phandle property.  Use this
> cache to find the node for a given phandle value instead of scanning
> the devicetree to find the node.  If the phandle value is not found
> in the cache, of_find_node_by_phandle() will fall back to the tree
> scan algorithm.
> 
> The cache is initialized in of_core_init().
> 
> The cache is freed via a late_initcall_sync() if modules are not
> enabled.

Maybe a few words about the memory consumption of this solution versus
the other proposed ones. Other nits below.

> +static void of_populate_phandle_cache(void)
> +{
> +	unsigned long flags;
> +	phandle max_phandle;
> +	u32 nodes = 0;
> +	struct device_node *np;
> +
> +	if (phandle_cache)
> +		return;

What's the point of that check? And shouldn't it be done inside the
spinlock if at all?

> +	max_phandle = live_tree_max_phandle();
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	for_each_of_allnodes(np)
> +		nodes++;

Why not save a walk over all nodes and a spin_lock/unlock pair by
combining the node count with the max_phandle computation? But you've
just moved the existing live_tree_max_phandle, so probably better as a
followup patch.

> +	/* sanity cap for malformed tree */
> +	if (max_phandle > nodes)
> +		max_phandle = nodes;
> +
> +	phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
> +				GFP_ATOMIC);

Maybe kcalloc. Sure, you've capped max_phandle so there's no real risk
of overflow.

> +	for_each_of_allnodes(np)
> +		if (np->phandle != OF_PHANDLE_ILLEGAL  &&
> +		    np->phandle <= max_phandle &&
> +		    np->phandle)

I'd reverse the order of these conditions so that for all the nodes with
no phandle we only do the np->phandle check. Also, extra whitespace
before &&.

> +			phandle_cache[np->phandle] = np;
> +
> +	max_phandle_cache = max_phandle;
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +}
> +

Rasmus
