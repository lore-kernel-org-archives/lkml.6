Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932693AbeB1SWo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:22:44 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32869 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeB1SWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:22:42 -0500
X-Google-Smtp-Source: AG47ELu9FFwTBem1VpOZBCuFkIuToNoTUO3HD/rZ/L0WO3L2viDtzhC7mW4bnPFhYg8OUETUE1Btcw==
Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518655979-10910-1-git-send-email-frowand.list@gmail.com>
 <ab87b605-6ec4-0b65-89ff-6232c89cb75f@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <22ed033d-fd35-7f06-39e3-075c500492b4@gmail.com>
Date: Wed, 28 Feb 2018 10:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ab87b605-6ec4-0b65-89ff-6232c89cb75f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/18 05:27, Chintan Pandya wrote:
> 
> 
> On 2/15/2018 6:22 AM, frowand.list@gmail.com wrote:
> 
>> +static void of_populate_phandle_cache(void)
>> +{
>> +    unsigned long flags;
>> +    u32 cache_entries;
>> +    struct device_node *np;
>> +    u32 phandles = 0;
>> +
>> +    raw_spin_lock_irqsave(&devtree_lock, flags);
>> +
>> +    kfree(phandle_cache);
>> +    phandle_cache = NULL;
>> +
>> +    for_each_of_allnodes(np)
>> +        if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
>> +            phandles++;
>> +
>> +    cache_entries = roundup_pow_of_two(phandles);
>> +    phandle_cache_mask = cache_entries - 1;
>> +
>> +    phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
>> +                GFP_ATOMIC);
>> +
> 
> NULL check of phandle_cache would be good to have.

Thanks for catching that.


>> +    for_each_of_allnodes(np)
>> +        if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
>> +            phandle_cache[np->phandle & phandle_cache_mask] = np;
>> +
>> +    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +}
> 
> 
> Chintan
