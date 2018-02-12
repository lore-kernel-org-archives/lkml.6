Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeBLKvn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:51:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbeBLKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:51:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B39376030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <6f83f4ef-0e90-d3c1-722b-f5342b9366b6@codeaurora.org>
Date: Mon, 12 Feb 2018 16:21:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2018 11:57 AM, frowand.list@gmail.com wrote:
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
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Changes since v1:
>    - change short description from
>      of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
>    - rebase on v4.16-rc1
>    - reorder new functions in base.c to avoid forward declaration
>    - add locking around kfree(phandle_cache) for memory ordering
>    - add explicit check for non-null of phandle_cache in
>      of_find_node_by_phandle().  There is already a check for !handle,
>      which prevents accessing a null phandle_cache, but that dependency
>      is not obvious, so this check makes it more apparent.
>    - do not free phandle_cache if modules are enabled, so that
>      cached phandles will be available when modules are loaded

Most of the gain from this cache will already be achieved for kernel 
init calls. As the discussion started with boot_time_gain vs 
mem_overhead, we seem to be loosing here as mem_overhead will be for 
eternal for small savings. We can live without this, IMO.

> 
>   drivers/of/base.c       | 93 ++++++++++++++++++++++++++++++++++++++++++++++---
>   drivers/of/of_private.h |  5 +++
>   drivers/of/resolver.c   | 21 -----------
>   3 files changed, 94 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ad28de96e13f..b3597c250837 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -91,10 +91,88 @@ int __weak of_node_to_nid(struct device_node *np)
>   }
>   #endif
>   
> +static struct device_node **phandle_cache;
> +static u32 max_phandle_cache;
> +
> +phandle live_tree_max_phandle(void)
> +{
> +	struct device_node *node;
> +	phandle max_phandle;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	max_phandle = 0;
> +	for_each_of_allnodes(node) {
> +		if (node->phandle != OF_PHANDLE_ILLEGAL &&
> +		    node->phandle > max_phandle)
> +			max_phandle = node->phandle;
> +		}

This closing curly bracket needs proper indentation.

> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	return max_phandle;
> +}
> +
> +static void of_populate_phandle_cache(void)
> +{
> +	unsigned long flags;
> +	phandle max_phandle;
> +	u32 nodes = 0;
> +	struct device_node *np;
> +
> +	if (phandle_cache)
> +		return;
> +
> +	max_phandle = live_tree_max_phandle();
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	for_each_of_allnodes(np)

This is 1ms call.

> +		nodes++;

We can calculate total nodes in live_tree_max_phandle to save 1ms.

> +
> +	/* sanity cap for malformed tree */
> +	if (max_phandle > nodes)
> +		max_phandle = nodes;

Or rather, we can take this entire thing to live_tree_max_phandle().

> +
> +	phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
> +				GFP_ATOMIC);
> +
> +	for_each_of_allnodes(np)
> +		if (np->phandle != OF_PHANDLE_ILLEGAL  &&
> +		    np->phandle <= max_phandle &&
> +		    np->phandle)
> +			phandle_cache[np->phandle] = np;
> +
> +	max_phandle_cache = max_phandle;
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +}
> +
> +#ifndef CONFIG_MODULES
> +static int __init of_free_phandle_cache(void)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	max_phandle_cache = 0;
> +	kfree(phandle_cache);
> +	phandle_cache = NULL;
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	return 0;
> +}
> +late_initcall_sync(of_free_phandle_cache);
> +#endif
> +
>   void __init of_core_init(void)
>   {
>   	struct device_node *np;
>   
> +	of_populate_phandle_cache();
> +
>   	/* Create the kset, and register existing nodes */
>   	mutex_lock(&of_mutex);
>   	of_kset = kset_create_and_add("devicetree", NULL, firmware_kobj);
> @@ -1021,16 +1099,23 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
>    */
>   struct device_node *of_find_node_by_phandle(phandle handle)
>   {
> -	struct device_node *np;
> +	struct device_node *np = NULL;
>   	unsigned long flags;
>   
>   	if (!handle)
>   		return NULL;
>   
>   	raw_spin_lock_irqsave(&devtree_lock, flags);
> -	for_each_of_allnodes(np)
> -		if (np->phandle == handle)
> -			break;
> +
> +	if (phandle_cache && handle <= max_phandle_cache)
> +		np = phandle_cache[handle];
> +
> +	if (!np || np->phandle != handle) {
> +		for_each_of_allnodes(np)
> +			if (np->phandle == handle)
> +				break;
> +	}
> +
>   	of_node_get(np);
>   	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>   	return np;
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 0c609e7d0334..18e03c9d4b55 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -131,6 +131,11 @@ extern void __of_update_property_sysfs(struct device_node *np,
>   extern void __of_sysfs_remove_bin_file(struct device_node *np,
>   				       struct property *prop);
>   
> +/* illegal phandle value (set when unresolved) */
> +#define OF_PHANDLE_ILLEGAL	0xdeadbeef
> +
> +extern phandle live_tree_max_phandle(void);

Why do we need this to be public API ? It was not previously and no good 
use-case for this now.

> +
>   /* iterators for transactions, used for overlays */
>   /* forward iterator */
>   #define for_each_transaction_entry(_oft, _te) \
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 740d19bde601..a7580c24737a 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -19,27 +19,6 @@
>   
>   #include "of_private.h"
>   
> -/* illegal phandle value (set when unresolved) */
> -#define OF_PHANDLE_ILLEGAL	0xdeadbeef
> -
> -static phandle live_tree_max_phandle(void)
> -{
> -	struct device_node *node;
> -	phandle phandle;
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&devtree_lock, flags);
> -	phandle = 0;
> -	for_each_of_allnodes(node) {
> -		if (node->phandle != OF_PHANDLE_ILLEGAL &&
> -				node->phandle > phandle)
> -			phandle = node->phandle;
> -	}
> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -
> -	return phandle;
> -}
> -
>   static void adjust_overlay_phandles(struct device_node *overlay,
>   		int phandle_delta)
>   {
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
