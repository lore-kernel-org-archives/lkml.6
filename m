Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCOL4W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:56:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:42992 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCOL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:56:20 -0400
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
To: Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Liran Alon <liran.alon@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idan.brown@oracle.com,
        Yuval Shaia <yuval.shaia@oracle.com>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
 <20180315112150.58586758@halley>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a673c689-ec30-61f6-9238-6b1773788201@iogearbox.net>
Date: Thu, 15 Mar 2018 12:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180315112150.58586758@halley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 10:21 AM, Shmulik Ladkani wrote:
> Hi,
> 
> On Tue, 13 Mar 2018 17:07:22 +0200 Liran Alon <liran.alon@oracle.com> wrote:
>> Before this commit, dev_forward_skb() always cleared packet's
>> per-network-namespace info. Even if the packet doesn't cross
>> network namespaces.
>>
>> The comment above dev_forward_skb() describes that this is done
>> because the receiving device may be in another network namespace.
>> However, this case can easily be tested for and therefore we can
>> scrub packet's per-network-namespace info only when receiving device
>> is indeed in another network namespace.
>>
>> Therefore, this commit changes ____dev_forward_skb() to tell
>> skb_scrub_packet() that skb has crossed network-namespace only in case
>> transmitting device (skb->dev) network namespace is different then
>> receiving device (dev) network namespace.
> 
> Assuming the premise of this commit is correct, note it may not act as
> intended for xnet situation in ipvlan_process_multicast, snip:
> 
> 		nskb->dev = ipvlan->dev;
> 		if (tx_pkt)
> 			ret = dev_forward_skb(ipvlan->dev, nskb);
> 		else
> 			ret = netif_rx(nskb);
> 
> as 'dev' gets already assigned to nskb prior dev_forward_skb (hence in
> ____dev_forward_skb both dev and skb->dev are the same).
> Fortunately every ipvlan_multicast_enqueue call is preceded by a forced
> scrub; It would be future-proof to not assign nskb->dev in the
> dev_forward_skb case (assign it only in the netif_rx case).
> 
> 
> Regarding the premise of this commit, this "reduces" the
> ipvs/orphan/mark scrubbing in the following *non* xnet situations:
> 
>  1. mac2vlan port xmit to other macvlan ports in Bridge Mode
>  2. similarly for ipvlan
>  3. veth xmit
>  4. l2tp_eth_dev_recv
>  5. bpf redirect/clone_redirect ingress actions
> 
> Regarding l2tp recv, this commit seems to align the srubbing behavior
> with ip tunnels (full scrub only if crossing netns, see ip_tunnel_rcv).
> 
> Regarding veth xmit, it does makes sense to preserve the fields if not
> crossing netns. This is also the case when one uses tc mirred.
> 
> Regarding bpf redirect, well, it depends on the expectations of each bpf
> program.
> I'd argue that preserving the fields (at least the mark field) in the
> *non* xnet makes sense and provides more information and therefore more
> capabilities; Alas this might change behavior already being relied on.
> 
> Maybe Daniel can comment on the matter.

Overall I think it might be nice to not need scrubbing skb in such cases,
although my concern would be that this has potential to break existing
setups when they would expect mark being zero on other veth peer in any
case since it's the behavior for a long time already. The safer option
would be to have some sort of explicit opt-in e.g. on link creation to let
the skb->mark pass through unscrubbed. This would definitely be a useful
option e.g. when mark is set in the netns facing veth via clsact/egress
on xmit and when the container is unprivileged anyway.

Thanks,
Daniel
