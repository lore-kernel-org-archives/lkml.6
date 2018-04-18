Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDRRyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:54:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751830AbeDRRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:54:00 -0400
Date: Wed, 18 Apr 2018 13:53:59 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: David Miller <davem@davemloft.net>
cc: eric.dumazet@gmail.com, edumazet@google.com, bhutchings@solarflare.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
In-Reply-To: <20180418.134651.2225112489265654270.davem@davemloft.net>
Message-ID: <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com> <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com> <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
 <20180418.134651.2225112489265654270.davem@davemloft.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2018, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 18 Apr 2018 12:44:25 -0400 (EDT)
> 
> > The structure net_device is followed by arbitrary driver-specific data 
> > (accessible with the function netdev_priv). And for virtio-net, these 
> > driver-specific data must be in DMA memory.
> 
> And we are saying that this assumption is wrong and needs to be
> corrected.

So, try to find all the networking drivers that to DMA to the private 
area.

The problem here is that kvzalloc usually returns DMA-able area, but it 
may return non-DMA area rarely, if the memory is too fragmented. So, we 
are in a situation, where some networking drivers will randomly fail. Go 
and find them.

Mikulas
