Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeBLUdM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:33:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35757 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeBLUdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:33:10 -0500
X-Google-Smtp-Source: AH8x224CjsUuvEKV9BWqg/G4YCnKAsSZzsQc+/e2g7edq1BP0Dpg8++BP9XWekvT0tqvWEIDCuQFFQ==
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
 <6f83f4ef-0e90-d3c1-722b-f5342b9366b6@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <45b0ebfd-3588-082d-fc16-0ae2e2460162@gmail.com>
Date: Mon, 12 Feb 2018 12:33:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6f83f4ef-0e90-d3c1-722b-f5342b9366b6@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/18 02:51, Chintan Pandya wrote:
> 
> 
> On 2/12/2018 11:57 AM, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Create a cache of the nodes that contain a phandle property.  Use this
>> cache to find the node for a given phandle value instead of scanning
>> the devicetree to find the node.  If the phandle value is not found
>> in the cache, of_find_node_by_phandle() will fall back to the tree
>> scan algorithm.
>>
>> The cache is initialized in of_core_init().
>>
>> The cache is freed via a late_initcall_sync() if modules are not
>> enabled.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Changes since v1:
>>    - change short description from
>>      of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
>>    - rebase on v4.16-rc1
>>    - reorder new functions in base.c to avoid forward declaration
>>    - add locking around kfree(phandle_cache) for memory ordering
>>    - add explicit check for non-null of phandle_cache in
>>      of_find_node_by_phandle().  There is already a check for !handle,
>>      which prevents accessing a null phandle_cache, but that dependency
>>      is not obvious, so this check makes it more apparent.
>>    - do not free phandle_cache if modules are enabled, so that
>>      cached phandles will be available when modules are loaded
> 
> Most of the gain from this cache will already be achieved for kernel
> init calls. As the discussion started with boot_time_gain vs
> mem_overhead, we seem to be loosing here as mem_overhead will be for
> eternal for small savings. We can live without this, IMO.

Please line wrap your emails so I don't have to.

I was addressing the other maintainer's concern.  This was an attempt
to free the memory if modules are not a factor, otherwise provide the
reduced overhead for drivers that are loaded as modules.

I won't bike shed over this.

The memory cost is quite small relative to the boot time reduction gain
For systems with little boot time speedup, the memory used is especially
small. For systems with larger boot time speedup, the memory used is still
not large, though it is "forever" if modules are configured on.  If modules
are configured on, then the system designer has already decided that they
are willing to use more memory to gain the module functionality.

If modules are not configured on, then the cache is freed as late as
possible using the init functions.  There are some calls to
of_find_node_by_phandle() after this point (on the system that I tested
on), but those are in asynchronous threads that are not preventing
the boot from completing (and thus not an issue for those who are
tuning for minimal boot time).

So the question for when modules are configured on comes down to:  which
is more important, the reduced phandle lookup overhead provided by the
cache or the additional memory used by the cache?  My preference is to
just free the memory instead of providing the phandle access overhead
reduction for a theoretical case of lots of modular drivers (though the
patch implements the opposite).  If a system with lots of modular drivers
demonstrates a phandle lookup overhead issue then the implementation can
be revisited.

Whichever way Rob wants to answer this question is fine with me, I
consider it a theoretical non-issue at the moment.


>>
>>   drivers/of/base.c       | 93 ++++++++++++++++++++++++++++++++++++++++++++++---
>>   drivers/of/of_private.h |  5 +++
>>   drivers/of/resolver.c   | 21 -----------
>>   3 files changed, 94 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index ad28de96e13f..b3597c250837 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -91,10 +91,88 @@ int __weak of_node_to_nid(struct device_node *np)
>>   }
>>   #endif
>>   +static struct device_node **phandle_cache;
>> +static u32 max_phandle_cache;
>> +
>> +phandle live_tree_max_phandle(void)
>> +{
>> +    struct device_node *node;
>> +    phandle max_phandle;
>> +    unsigned long flags;
>> +
>> +    raw_spin_lock_irqsave(&devtree_lock, flags);
>> +
>> +    max_phandle = 0;
>> +    for_each_of_allnodes(node) {
>> +        if (node->phandle != OF_PHANDLE_ILLEGAL &&
>> +            node->phandle > max_phandle)
>> +            max_phandle = node->phandle;
>> +        }
> 
> This closing curly bracket needs proper indentation.

Thanks, will fix.


>> +
>> +    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +
>> +    return max_phandle;
>> +}
>> +
>> +static void of_populate_phandle_cache(void)
>> +{
>> +    unsigned long flags;
>> +    phandle max_phandle;
>> +    u32 nodes = 0;
>> +    struct device_node *np;
>> +
>> +    if (phandle_cache)
>> +        return;
>> +
>> +    max_phandle = live_tree_max_phandle();
>> +
>> +    raw_spin_lock_irqsave(&devtree_lock, flags);
>> +
>> +    for_each_of_allnodes(np)
> 
> This is 1ms call.
> 
>> +        nodes++;
> 
> We can calculate total nodes in live_tree_max_phandle to save 1ms.> 
>> +
>> +    /* sanity cap for malformed tree */
>> +    if (max_phandle > nodes)
>> +        max_phandle = nodes;
> 
> Or rather, we can take this entire thing to live_tree_max_phandle().

See my answer to Rasmus' review comments to see why I'll consider this
in the future, but not for this patch series.


>> +
>> +    phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
>> +                GFP_ATOMIC);
>> +
>> +    for_each_of_allnodes(np)
>> +        if (np->phandle != OF_PHANDLE_ILLEGAL  &&
>> +            np->phandle <= max_phandle &&
>> +            np->phandle)
>> +            phandle_cache[np->phandle] = np;
>> +
>> +    max_phandle_cache = max_phandle;
>> +
>> +    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +}
>> +
>> +#ifndef CONFIG_MODULES
>> +static int __init of_free_phandle_cache(void)
>> +{
>> +    unsigned long flags;
>> +
>> +    raw_spin_lock_irqsave(&devtree_lock, flags);
>> +
>> +    max_phandle_cache = 0;
>> +    kfree(phandle_cache);
>> +    phandle_cache = NULL;
>> +
>> +    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +
>> +    return 0;
>> +}
>> +late_initcall_sync(of_free_phandle_cache);
>> +#endif
>> +
>>   void __init of_core_init(void)
>>   {
>>       struct device_node *np;
>>   +    of_populate_phandle_cache();
>> +
>>       /* Create the kset, and register existing nodes */
>>       mutex_lock(&of_mutex);
>>       of_kset = kset_create_and_add("devicetree", NULL, firmware_kobj);
>> @@ -1021,16 +1099,23 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
>>    */
>>   struct device_node *of_find_node_by_phandle(phandle handle)
>>   {
>> -    struct device_node *np;
>> +    struct device_node *np = NULL;
>>       unsigned long flags;
>>         if (!handle)
>>           return NULL;
>>         raw_spin_lock_irqsave(&devtree_lock, flags);
>> -    for_each_of_allnodes(np)
>> -        if (np->phandle == handle)
>> -            break;
>> +
>> +    if (phandle_cache && handle <= max_phandle_cache)
>> +        np = phandle_cache[handle];
>> +
>> +    if (!np || np->phandle != handle) {
>> +        for_each_of_allnodes(np)
>> +            if (np->phandle == handle)
>> +                break;
>> +    }
>> +
>>       of_node_get(np);
>>       raw_spin_unlock_irqrestore(&devtree_lock, flags);
>>       return np;
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 0c609e7d0334..18e03c9d4b55 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -131,6 +131,11 @@ extern void __of_update_property_sysfs(struct device_node *np,
>>   extern void __of_sysfs_remove_bin_file(struct device_node *np,
>>                          struct property *prop);
>>   +/* illegal phandle value (set when unresolved) */
>> +#define OF_PHANDLE_ILLEGAL    0xdeadbeef
>> +
>> +extern phandle live_tree_max_phandle(void);
> 
> Why do we need this to be public API ? It was not previously and no
> good use-case for this now.

It is not public.  It is private ("of_private.h") to the devicetree
code.  It is used by the overlay code (look at top of tree, not
an old kernel).


>> +
>>   /* iterators for transactions, used for overlays */
>>   /* forward iterator */
>>   #define for_each_transaction_entry(_oft, _te) \
>> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
>> index 740d19bde601..a7580c24737a 100644
>> --- a/drivers/of/resolver.c
>> +++ b/drivers/of/resolver.c
>> @@ -19,27 +19,6 @@
>>     #include "of_private.h"
>>   -/* illegal phandle value (set when unresolved) */
>> -#define OF_PHANDLE_ILLEGAL    0xdeadbeef
>> -
>> -static phandle live_tree_max_phandle(void)
>> -{
>> -    struct device_node *node;
>> -    phandle phandle;
>> -    unsigned long flags;
>> -
>> -    raw_spin_lock_irqsave(&devtree_lock, flags);
>> -    phandle = 0;
>> -    for_each_of_allnodes(node) {
>> -        if (node->phandle != OF_PHANDLE_ILLEGAL &&
>> -                node->phandle > phandle)
>> -            phandle = node->phandle;
>> -    }
>> -    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> -
>> -    return phandle;
>> -}
>> -
>>   static void adjust_overlay_phandles(struct device_node *overlay,
>>           int phandle_delta)
>>   {
>>
> 
> Chintan
