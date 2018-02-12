Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeBLUGH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:06:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42688 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeBLUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:06:04 -0500
X-Google-Smtp-Source: AH8x226vOcBAXkaGuwG76bHU4fsfYrvZjXfS4uT0axkdPQTu2U7UTUznCCf6/2kNChtI+tGpWGgixw==
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
 <5ca5194d-8b87-bcb6-73ca-a671075e4704@prevas.dk>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e1265e8e-348c-1672-c5e5-27a6820f330a@gmail.com>
Date: Mon, 12 Feb 2018 12:06:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5ca5194d-8b87-bcb6-73ca-a671075e4704@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/18 00:58, Rasmus Villemoes wrote:
> On 2018-02-12 07:27, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Create a cache of the nodes that contain a phandle property.  Use this
>> cache to find the node for a given phandle value instead of scanning
>> the devicetree to find the node.  If the phandle value is not found
>> in the cache, of_find_node_by_phandle() will fall back to the tree
>> scan algorithm.
>>
>> The cache is initialized in of_core_init().
>>
>> The cache is freed via a late_initcall_sync() if modules are not
>> enabled.
> 
> Maybe a few words about the memory consumption of this solution versus
> the other proposed ones.

The patch comment is about this patch, not the other proposals.

Please do not take that as a snippy response.  There were several
emails in the previous thread that discussed memory.  In that
thread I responded as to how I would address the concerns.  If
anyone wants to raise concerns about memory usage as a result of
this version of the patch they should do so in this current thread.


> Other nits below.
> 
>> +static void of_populate_phandle_cache(void)
>> +{
>> +	unsigned long flags;
>> +	phandle max_phandle;
>> +	u32 nodes = 0;
>> +	struct device_node *np;
>> +
>> +	if (phandle_cache)
>> +		return;
> 
> What's the point of that check? 

Sanity check to make sure a memory leak of a previous cache
does not occur.  I'll change it to free the cache if it
exists.

There is only one instance of of_populate_cache() being called,
so this is a theoretical issue.  I intend to add another caller
in the devicetree overlay code in the future, but do not want
to do that now, to avoid a conflict with the overlay patch
series that has been in parallel development, and for which
I submitted v2 shortly after this set of patches.


> And shouldn't it be done inside the
> spinlock if at all?

Not an issue yet, but I'll keep my eye on the possibility of races
when I add a call to of_populate_cache() from the overlay code.


>> +	max_phandle = live_tree_max_phandle();
>> +
>> +	raw_spin_lock_irqsave(&devtree_lock, flags);
>> +
>> +	for_each_of_allnodes(np)
>> +		nodes++;
> 
> Why not save a walk over all nodes and a spin_lock/unlock pair by
> combining the node count with the max_phandle computation? But you've
> just moved the existing live_tree_max_phandle, so probably better as a
> followup patch.

I'll consider adding the node counting into live_tree_max_phandle() later.
The other user of live_tree_max_phandle() is being modified in my overlay
patch series (see mention above).  I don't want to create a conflict between
the two series.


>> +	/* sanity cap for malformed tree */
>> +	if (max_phandle > nodes)
>> +		max_phandle = nodes;
>> +
>> +	phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
>> +				GFP_ATOMIC);
> 
> Maybe kcalloc. Sure, you've capped max_phandle so there's no real risk
> of overflow.

OK, will do.


>> +	for_each_of_allnodes(np)
>> +		if (np->phandle != OF_PHANDLE_ILLEGAL  &&
>> +		    np->phandle <= max_phandle &&
>> +		    np->phandle)
> 
> I'd reverse the order of these conditions so that for all the nodes with
> no phandle we only do the np->phandle check. Also, extra whitespace
> before &&.

Will do.


>> +			phandle_cache[np->phandle] = np;
>> +
>> +	max_phandle_cache = max_phandle;
>> +
>> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +}
>> +
> 
> Rasmus
> 
