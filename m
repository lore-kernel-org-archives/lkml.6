Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBAOY0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbeBAOYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:24:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD7F21798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x225/ncqWcG9guVSQMtRhICTtCk5sb15HFz0JdjZ7YqPSVDDzn0ZfUIrwGhG0KiM/YT6E9QWJRikGX6XvRXtYfe8=
MIME-Version: 1.0
In-Reply-To: <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com> <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Feb 2018 08:24:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
Message-ID: <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of of_find_node_by_phandle()
To: Frank Rowand <frowand.list@gmail.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 3:43 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 01/31/18 12:05, frowand.list@gmail.com wrote:
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
>>
>>
>>  drivers/of/base.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
>>  drivers/of/of_private.h |  5 +++
>>  drivers/of/resolver.c   | 21 ------------
>>  3 files changed, 86 insertions(+), 25 deletions(-)
>
> Some observations....
>
> The size of the cache for a normal device tree would be a couple of
> words of overhead for the cache, plus one pointer per devicetree node
> that contains a phandle property.  This will be less space than
> would be used by adding a hash field to each device node.  It is
> also less space than was used by the older algorithm (long gone)
> that added a linked list through the nodes that contained a
> phandle property.
>
> This is assuming that the values of the phandle properties are
> the default ones created by the dtc compiler.  In the case
> where a very large phandle property value is hand-coded in
> a devicetree source, the size of the cache is capped at one
> entry per node.  In this case, a little bit of space will be
> wasted -- but this is just a sanity fallback, it should not
> be encountered, and can be fixed by fixing the devicetree
> source.

I don't think we should rely on how dtc allocates phandles. dtc is not
the only source of DeviceTrees. If we could do that, then lets make
them have some known flag in the upper byte so we have some hint for
phandle values. 2^24 phandles should be enough for anyone.TM

Your cache size is also going to balloon if the dtb was built with
'-@'. Since you walk the tree for every phandle, it is conceivable
that you could make things slower.

Freeing after boot is nice, but if someone has lots of modules or
large overlays, this doesn't help them at all.


There's still more tweaks we could do with a cache based (i.e. can
miss) approach. We could have an access count or some most recently
used list to avoid evicting frequently accessed phandles (your data
tends to indicate that would help). We could have cache sets. And so
far, no one has explained why a bigger cache got slower.

Or we could do something decentralized and make the frequent callers
cache their phandles.

Rob
