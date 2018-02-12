Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeBLG4r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 01:56:47 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51612 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBLG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 01:56:45 -0500
X-Google-Smtp-Source: AH8x225IgkyEkXB4+hKNOD62WgdW4peDy1DKe6Uioj0gWf7V8e4w3y4ZxgKC5a1BGiDba513sfp25g==
Subject: Re: [PATCH v2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518416868-8804-1-git-send-email-frowand.list@gmail.com>
Message-ID: <6e967dd4-0fae-a912-88cd-b60f40ec0727@gmail.com>
Date: Sun, 11 Feb 2018 22:56:42 -0800
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

Hi Rob,

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

< snip >



In a previous thread, you said:

> We should be able to do this earlier. We already walk the tree twice
> in unflattening. We can get the max phandle (or number of phandles
> IMO) on the first pass, allocate with the early allocator and then
> populate the cache in the 2nd pass. AIUI, you can alloc with memblock
> and then free with kfree as the memblock allocations get transferred
> to the slab.

And I replied:

   Thanks for pointing out that kfree() can be used for memory alloced
   with memblock.  I'll change to populate the cache earlier.


I started to make this change when I moved forward to v4.16-rc1.  There
are two obvious ways to do this.

The first is to create and populate
the phandle cache during the two phases of unflattening.  To do this
would require counting the number of nodes to be unflattened and find
the largest phandle value during phase 1, then allocate the cache before
phase 2, then populate the cache during phase 2.  This is not difficult,
but it is intrusive.

The second obvious way is to modify of_populate_phandle_cache() to
use the early allocator if called early in the boot and call this
immediately after unflattening.  Then if of_populate_phandle_cache()
is called later (eg for applying overlays) it would have to change
to using kzalloc().  It did not seem like the larger overhead of the
very few calls of of_find_node_by_phandle() before the slightly later
phandle cache population justify adding the extra complexity in
of_populate_phandle_cache().

-Frank
