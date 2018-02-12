Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeBLG7B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 01:59:01 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33241 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbeBLG67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 01:58:59 -0500
X-Google-Smtp-Source: AH8x2243B7Fgk9x7Dwcd7U67A8+9Zp//6a1SXzD8XKA2cfm1AhCXHR8Hd0VSXi+xJHqCxRdCTKusoQ==
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: cpandya@codeaurora.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
Message-ID: <dc3c66d5-b848-d1cc-48f4-cabeccc2e383@gmail.com>
Date: Sun, 11 Feb 2018 22:58:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/18 22:27, frowand.list@gmail.com wrote:
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
>   - change short description from
>     of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
>   - rebase on v4.16-rc1
>   - reorder new functions in base.c to avoid forward declaration
>   - add locking around kfree(phandle_cache) for memory ordering
>   - add explicit check for non-null of phandle_cache in
>     of_find_node_by_phandle().  There is already a check for !handle,
>     which prevents accessing a null phandle_cache, but that dependency
>     is not obvious, so this check makes it more apparent.
>   - do not free phandle_cache if modules are enabled, so that
>     cached phandles will be available when modules are loaded
> 
>  drivers/of/base.c       | 93 ++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/of/of_private.h |  5 +++
>  drivers/of/resolver.c   | 21 -----------
>  3 files changed, 94 insertions(+), 25 deletions(-)
> 

< snip >

Hi Chintan,

Just as in the previous version, this part of the patch will not apply
on older kernel versions, and can just be deleted:

> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 740d19bde601..a7580c24737a 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -19,27 +19,6 @@
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
