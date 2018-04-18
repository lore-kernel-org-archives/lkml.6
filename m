Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeDRUis (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:38:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43453 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:38:46 -0400
X-Google-Smtp-Source: AIpwx4/dNptO4sEqn9VnZ7Y8lV5nbgHZsaSe/rXR4sujGqjI/uYcRhqF6G2icVS9eLGoIHEceJOX0Q==
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Joby Poriyath <joby.poriyath@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
 <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
 <20180418204229-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f821bf46-94e9-c794-bc77-600dc19edb9a@gmail.com>
Date: Wed, 18 Apr 2018 13:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418204229-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2018 10:55 AM, Michael S. Tsirkin wrote:

> Imagine you want to pass some data to card.
> Natural thing is to just put it in a variable and start DMA.
> However DMA API disallows stack access nowdays,
> so it's natural to put this within struct device.
> 
> See e.g.
> 
> 	commit a725ee3e44e39dab1ec82cc745899a785d2a555e
> 	Author: Andy Lutomirski <luto@kernel.org>
> 	Date:   Mon Jul 18 15:34:49 2016 -0700
> 
> 	    virtio-net: Remove more stack DMA
>

Andy just moved the problem to another one, since at that time we already
had vmalloc() fallback for at least 2 years.

Note that my original patch had :

p = kzalloc(alloc_size, GFP_KERNEL | __GFP_NOWARN | __GFP_REPEAT);
if (!p)
      p = vzalloc(alloc_size);

So really, normal (less than PAGE_SIZE) allocations would have almost-zero-chance to end up to vmalloc(one_page)
