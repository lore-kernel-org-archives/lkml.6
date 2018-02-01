Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBAI7I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:59:08 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40979 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBAI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:59:04 -0500
X-Google-Smtp-Source: AH8x2264nI2Wv1uKbcUIOk0lqq315dR6fq9oav5ythbvKqMXlSEhBTbTFVbxfB2VTbpvKwnOYQFE8w==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <38cdcae5-ec0f-d1be-b024-1990d4387731@gmail.com>
Date: Thu, 1 Feb 2018 00:59:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/18 22:45, Chintan Pandya wrote:
> 
> 
> On 2/1/2018 1:35 AM, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
> 
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
>> +        nodes++;
>> +
>> +    /* sanity cap for malformed tree */
>> +    if (max_phandle > nodes)
>> +        max_phandle = nodes;
> Shouldn't we speak up about this in kernel log ? May be WARN_ON() ?

Probably not.  If we care enough about a hand coded phandle property
value we should add a check to checkpatch and/or dtc instead of adding
the warning here.


>> +
>> +    phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
>> +                GFP_KERNEL);
> kzalloc (might_sleep) in critical context will break.

Yes, thanks.

I also need to ensure memory ordering in of_free_phandle_cache()
to ensure that max_phandle_cache is zero before the cache memory
is freed.


> Anyways, will fix this locally and share test results.

Thanks, I look forward to the results.


> Thanks,
> Chintan
> 
