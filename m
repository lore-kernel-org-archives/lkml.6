Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBAOe7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAOe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:34:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C13F217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x227jByTPmHkkIE+pUpFCK8xbzH690aogFpWVmjkomT/P8qqO6gE69yzi7D1g/ovlWhtWnFJ4gLjyob+BYl0tYsY=
MIME-Version: 1.0
In-Reply-To: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Feb 2018 08:34:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+z7Z7nbXUS-6MxAzAq353OK02Uc6i3AH7WS2KmOrLnmA@mail.gmail.com>
Message-ID: <CAL_Jsq+z7Z7nbXUS-6MxAzAq353OK02Uc6i3AH7WS2KmOrLnmA@mail.gmail.com>
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

On Wed, Jan 31, 2018 at 2:05 PM,  <frowand.list@gmail.com> wrote:
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
> The cache is freed via a late_initcall_sync().
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> Some of_find_by_phandle() calls may occur before the cache is
> initialized or after it is freed.  For example, for the qualcomm
> qcom-apq8074-dragonboard, 11 calls occur before the initialization
> and 80 occur after the cache is freed (out of 516 total calls.)

We should be able to do this earlier. We already walk the tree twice
in unflattening. We can get the max phandle (or number of phandles
IMO) on the first pass, allocate with the early allocator and then
populate the cache in the 2nd pass. AIUI, you can alloc with memblock
and then free with kfree as the memblock allocations get transferred
to the slab.

Rob
