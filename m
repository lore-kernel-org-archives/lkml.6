Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474ED20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474ED20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJZWQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:16:59 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:39919 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:16:59 -0400
Received: from localhost.localdomain (p200300E9D70FDC4FA9666416553D800C.dip0.t-ipconnect.de [IPv6:2003:e9:d70f:dc4f:a966:6416:553d:800c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id E8498C8992;
        Fri, 26 Oct 2018 15:39:47 +0200 (CEST)
Subject: Re: [PATCH 4.9 50/71] inet: frags: use rhashtables for reassembly
 units
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181016170539.315587743@linuxfoundation.org>
 <20181016170541.874459615@linuxfoundation.org>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <62bd748b-20a8-d021-7b3b-32146df8beb8@datenfreihafen.org>
Date:   Fri, 26 Oct 2018 15:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016170541.874459615@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg.

[Hope I am not to late for this]

On 16/10/2018 19:09, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> Some applications still rely on IP fragmentation, and to be fair linux
> reassembly unit is not working under any serious load.
> 
> It uses static hash tables of 1024 buckets, and up to 128 items per bucket (!!!)
> 
> A work queue is supposed to garbage collect items when host is under memory
> pressure, and doing a hash rebuild, changing seed used in hash computations.
> 
> This work queue blocks softirqs for up to 25 ms when doing a hash rebuild,
> occurring every 5 seconds if host is under fire.
> 
> Then there is the problem of sharing this hash table for all netns.
> 
> It is time to switch to rhashtables, and allocate one of them per netns
> to speedup netns dismantle, since this is a critical metric these days.
> 
> Lookup is now using RCU. A followup patch will even remove
> the refcount hold/release left from prior implementation and save
> a couple of atomic operations.
> 
> Before this patch, 16 cpus (16 RX queue NIC) could not handle more
> than 1 Mpps frags DDOS.
> 
> After the patch, I reach 9 Mpps without any tuning, and can use up to 2GB
> of storage for the fragments (exact number depends on frags being evicted
> after timeout)
> 
> $ grep FRAG /proc/net/sockstat
> FRAG: inuse 1966916 memory 2140004608
> 
> A followup patch will change the limits for 64bit arches.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 648700f76b03b7e8149d13cc2bdb3355035258a9)
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/networking/ip-sysctl.txt  |    7 
>  include/net/inet_frag.h                 |   81 +++----
>  include/net/ipv6.h                      |   16 -
>  net/ieee802154/6lowpan/6lowpan_i.h      |   26 --
>  net/ieee802154/6lowpan/reassembly.c     |   91 +++-----
>  net/ipv4/inet_fragment.c                |  349 ++++++--------------------------
>  net/ipv4/ip_fragment.c                  |  112 ++++------
>  net/ipv6/netfilter/nf_conntrack_reasm.c |   51 +---
>  net/ipv6/reassembly.c                   |  110 ++++------
>  9 files changed, 267 insertions(+), 576 deletions(-)
> 

When this patch hit master a while back we had to address a regression
in the ieee802514 6lowpan layer. It seems this fix is missing in the
backport series (only looking at your patchset here, no the full tree).

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=f18fa5de5ba7f1d6650951502bb96a6e4715a948

I would appreciate if you could pull this into this series as well.

regards
Stefan Schmidt
