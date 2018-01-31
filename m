Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeAaULB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:11:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33356 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeAaUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:10:59 -0500
X-Google-Smtp-Source: AH8x227SZPYpYXfY0ISziqHqtKqVR8USSBOcu+kRWzUvMud+5TM1zTxWfjXasqIqopJnon4Mzlck8A==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
Message-ID: <2c1eca16-42bb-5a00-8f2b-a4536712ab79@gmail.com>
Date: Wed, 31 Jan 2018 12:10:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Chintan,

This patch resolves one of the issues that Rob had raised.  The space for
the phandle cache is freed after boot, instead of existing until shutdown.

Chintan, can you please apply this patch and see how it impacts your
boot time?  The portion of the patch that removes code from resolver.c
will fail on 4.9 because that code does not exist yet -- you can just
remove that portion of the patch.

-Frank


On 01/31/18 12:05, frowand.list@gmail.com wrote:
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
> The cache is freed via a late_initcall_sync().
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Some of_find_by_phandle() calls may occur before the cache is
> initialized or after it is freed.  For example, for the qualcomm
> qcom-apq8074-dragonboard, 11 calls occur before the initialization
> and 80 occur after the cache is freed (out of 516 total calls.)
> 
> 
>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/of/of_private.h |  5 +++
>  drivers/of/resolver.c   | 21 ------------
>  3 files changed, 86 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 26618ba8f92a..c3091d0e391f 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -95,10 +95,14 @@ int __weak of_node_to_nid(struct device_node *np)
>  }
>  #endif
>  
> +static void of_populate_phandle_cache(void);
> +
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
>  
> +	of_populate_phandle_cache();
> +
>  	/* Create the kset, and register existing nodes */
>  	mutex_lock(&of_mutex);
>  	of_kset = kset_create_and_add("devicetree", NULL, firmware_kobj);
> @@ -990,6 +994,72 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
>  }
>  EXPORT_SYMBOL_GPL(of_modalias_node);
>  
> +phandle live_tree_max_phandle(void)
> +{
> +	struct device_node *node;
> +	phandle max_phandle;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	max_phandle = 0;
> +	for_each_of_allnodes(node) {
> +		if (node->phandle != OF_PHANDLE_ILLEGAL &&
> +		    node->phandle > max_phandle)
> +			max_phandle = node->phandle;
> +	}
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	return max_phandle;
> +}
> +
> +static struct device_node **phandle_cache;
> +static u32 max_phandle_cache;
> +
> +static int __init of_free_phandle_cache(void)
> +{
> +	max_phandle_cache = 0;
> +	kfree(phandle_cache);
> +	phandle_cache = NULL;
> +
> +	return 0;
> +}
> +late_initcall_sync(of_free_phandle_cache);
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
> +		nodes++;
> +
> +	/* sanity cap for malformed tree */
> +	if (max_phandle > nodes)
> +		max_phandle = nodes;
> +
> +	phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
> +				GFP_KERNEL);
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
>  /**
>   * of_find_node_by_phandle - Find a node given a phandle
>   * @handle:	phandle of the node to find
> @@ -999,16 +1069,23 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
>   */
>  struct device_node *of_find_node_by_phandle(phandle handle)
>  {
> -	struct device_node *np;
> +	struct device_node *np = NULL;
>  	unsigned long flags;
>  
>  	if (!handle)
>  		return NULL;
>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
> -	for_each_of_allnodes(np)
> -		if (np->phandle == handle)
> -			break;
> +
> +	if (handle <= max_phandle_cache)
> +		np = phandle_cache[handle];
> +
> +	if (!np || np->phandle != handle) {
> +		for_each_of_allnodes(np)
> +			if (np->phandle == handle)
> +				break;
> +	}
> +
>  	of_node_get(np);
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  	return np;
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 92a9a3687446..77005978d60a 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -135,6 +135,11 @@ extern void __of_update_property_sysfs(struct device_node *np,
>  extern void __of_sysfs_remove_bin_file(struct device_node *np,
>  				       struct property *prop);
>  
> +/* illegal phandle value (set when unresolved) */
> +#define OF_PHANDLE_ILLEGAL	0xdeadbeef
> +
> +extern phandle live_tree_max_phandle(void);
> +
>  /* iterators for transactions, used for overlays */
>  /* forward iterator */
>  #define for_each_transaction_entry(_oft, _te) \
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index cfaeef5f6cb1..0384ce8fdc3b 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -22,27 +22,6 @@
>  
>  #include "of_private.h"
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
>  static void adjust_overlay_phandles(struct device_node *overlay,
>  		int phandle_delta)
>  {
> 
