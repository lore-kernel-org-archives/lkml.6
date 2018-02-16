Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeBPWdg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:33:36 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46810 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeBPWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:33:34 -0500
X-Google-Smtp-Source: AH8x224uBNC4r1Xer3kC07IhbG6OhNu2OPllBNiFWHiZdiHSfRybowKKfDHN7xRfImGZfKbdeFq20Q==
Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518655979-10910-1-git-send-email-frowand.list@gmail.com>
 <207e055e-1074-9010-e719-2a4c13ede9f9@codeaurora.org>
 <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>
Message-ID: <40e5df43-4422-9209-01c8-3aea487da722@gmail.com>
Date: Fri, 16 Feb 2018 14:33:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/18 14:20, Frank Rowand wrote:
> On 02/16/18 01:04, Chintan Pandya wrote:
>>
>>
>> On 2/15/2018 6:22 AM, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Create a cache of the nodes that contain a phandle property.  Use this
>>> cache to find the node for a given phandle value instead of scanning
>>> the devicetree to find the node.  If the phandle value is not found
>>> in the cache, of_find_node_by_phandle() will fall back to the tree
>>> scan algorithm.
>>>
> 
> < snip >
> 
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index ad28de96e13f..ab545dfa9173 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -91,10 +91,69 @@ int __weak of_node_to_nid(struct device_node *np)
>>>   }
>>>   #endif
>>>   +static struct device_node **phandle_cache;
>>> +static u32 phandle_cache_mask;
>>> +
>>> +/*
>>> + * Assumptions behind phandle_cache implementation:
>>> + *   - phandle property values are in a contiguous range of 1..n
>>> + *
>>> + * If the assumptions do not hold, then
>>> + *   - the phandle lookup overhead reduction provided by the cache
>>> + *     will likely be less
>>> + */
>>> +static void of_populate_phandle_cache(void)
>>> +{
>>> +    unsigned long flags;
>>> +    u32 cache_entries;
>>> +    struct device_node *np;
>>> +    u32 phandles = 0;
>>> +
>>> +    raw_spin_lock_irqsave(&devtree_lock, flags);
>>> +
>>> +    kfree(phandle_cache);
>>
>> I couldn't understood this. Everything else looks good to me.
> 
> I will be adding a call to of_populate_phandle_cache() from the
> devicetree overlay code.  I put the kfree here so that the previous
> cache memory is freed when a new cache is created.
> 
> Adding the call from the overlay code is not done in this
> series because I have a patch series modifying overlays and
> I do not want to create a conflict or ordering between that
> series and that patch.  The lack of the call from overlay
             ^^^^ this

> code means that overlay code will gain some of the overhead
> reduction from this patch, but possibly not the entire reduction.
> 
> 
>>
>>> +    phandle_cache = NULL;
>>> +
>>> +    for_each_of_allnodes(np)
> 
> < snip >
> 
