Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeDSEA4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:00:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750737AbeDSEAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:00:55 -0400
Date: Thu, 19 Apr 2018 07:00:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Joby Poriyath <joby.poriyath@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
Message-ID: <20180419065711-mutt-send-email-mst@kernel.org>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
 <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
 <20180418204229-mutt-send-email-mst@kernel.org>
 <f821bf46-94e9-c794-bc77-600dc19edb9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f821bf46-94e9-c794-bc77-600dc19edb9a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 01:38:43PM -0700, Eric Dumazet wrote:
> 
> 
> On 04/18/2018 10:55 AM, Michael S. Tsirkin wrote:
> 
> > Imagine you want to pass some data to card.
> > Natural thing is to just put it in a variable and start DMA.
> > However DMA API disallows stack access nowdays,
> > so it's natural to put this within struct device.
> > 
> > See e.g.
> > 
> > 	commit a725ee3e44e39dab1ec82cc745899a785d2a555e
> > 	Author: Andy Lutomirski <luto@kernel.org>
> > 	Date:   Mon Jul 18 15:34:49 2016 -0700
> > 
> > 	    virtio-net: Remove more stack DMA
> >
> 
> Andy just moved the problem to another one, since at that time we already
> had vmalloc() fallback for at least 2 years.
> 
> Note that my original patch had :
> 
> p = kzalloc(alloc_size, GFP_KERNEL | __GFP_NOWARN | __GFP_REPEAT);
> if (!p)
>       p = vzalloc(alloc_size);
> 
> So really, normal (less than PAGE_SIZE) allocations would have almost-zero-chance to end up to vmalloc(one_page)

Thanks Eric, I'll fix virtio.


-- 
MST
