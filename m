Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966319AbeBNBAt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:00:49 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37225 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966220AbeBNBAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:00:47 -0500
X-Google-Smtp-Source: AH8x2268/T6pTxLn2iuU+tpi2ASD7E6N6jcvvkqaCjCNJ6OPRxbqR4yllLIhCzG2VPr1LA0SjDNEzw==
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
 <6e967dd4-0fae-a912-88cd-b60f40ec0727@gmail.com>
Message-ID: <75515998-10e0-5025-7828-649112231067@gmail.com>
Date: Tue, 13 Feb 2018 17:00:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6e967dd4-0fae-a912-88cd-b60f40ec0727@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 02/11/18 22:56, Frank Rowand wrote:
> Hi Rob,
> 
> On 02/11/18 22:27, frowand.list@gmail.com wrote:
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
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Changes since v1:
>>   - change short description from
>>     of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
>>   - rebase on v4.16-rc1
>>   - reorder new functions in base.c to avoid forward declaration
>>   - add locking around kfree(phandle_cache) for memory ordering
>>   - add explicit check for non-null of phandle_cache in
>>     of_find_node_by_phandle().  There is already a check for !handle,
>>     which prevents accessing a null phandle_cache, but that dependency
>>     is not obvious, so this check makes it more apparent.
>>   - do not free phandle_cache if modules are enabled, so that
>>     cached phandles will be available when modules are loaded
> 
> < snip >
> 
> 
> 
> In a previous thread, you said:
> 
>> We should be able to do this earlier. We already walk the tree twice
>> in unflattening. We can get the max phandle (or number of phandles
>> IMO) on the first pass, allocate with the early allocator and then
>> populate the cache in the 2nd pass. AIUI, you can alloc with memblock
>> and then free with kfree as the memblock allocations get transferred
>> to the slab.
> 
> And I replied:
> 
>    Thanks for pointing out that kfree() can be used for memory alloced
>    with memblock.  I'll change to populate the cache earlier.
> 
> 
> I started to make this change when I moved forward to v4.16-rc1.  There
> are two obvious ways to do this.

< snip >

And I did not finish the explanation, sorry.  I meant to finish with saying
that given the drawbacks that I ended up not making the change for v2.

While modifying the patch to respond to the v2 comments, I decided to go
ahead and try using memblock to alloc memory earlier.  The result I got
was that when I tried to kfree() the memory at late_initcall_sync I got
a panic.  The alloc function I used is memblock_virt_alloc().  You mention
"slab" specifically.  Maybe the problem is that my system is using "slub"
instead.  Dunno...

-Frank
