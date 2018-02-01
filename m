Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBAVN5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:13:57 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45803 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeBAVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:13:51 -0500
X-Google-Smtp-Source: AH8x2250QGm1zhu8qkZeRIartnsWYeNXEsuar2C0HvE33gNC1+HhlKvKukIgrCEm3zAxrMOHbJEdfA==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Rob Herring <robh+dt@kernel.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <CAL_Jsq+z7Z7nbXUS-6MxAzAq353OK02Uc6i3AH7WS2KmOrLnmA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ff07efbc-a7d2-135f-a96e-5cd0d2149f6f@gmail.com>
Date: Thu, 1 Feb 2018 13:13:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+z7Z7nbXUS-6MxAzAq353OK02Uc6i3AH7WS2KmOrLnmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 06:34, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 2:05 PM,  <frowand.list@gmail.com> wrote:
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
>> The cache is freed via a late_initcall_sync().
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Some of_find_by_phandle() calls may occur before the cache is
>> initialized or after it is freed.  For example, for the qualcomm
>> qcom-apq8074-dragonboard, 11 calls occur before the initialization
>> and 80 occur after the cache is freed (out of 516 total calls.)
> 
> We should be able to do this earlier. We already walk the tree twice
> in unflattening. We can get the max phandle (or number of phandles
> IMO) on the first pass, allocate with the early allocator and then
> populate the cache in the 2nd pass. AIUI, you can alloc with memblock
> and then free with kfree as the memblock allocations get transferred
> to the slab.

Thanks for pointing out that kfree() can be used for memory alloced
with memblock.  I'll change to populate the cache earlier.
