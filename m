Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967548AbeEYRxN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:53:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967385AbeEYRxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:53:11 -0400
Date: Fri, 25 May 2018 20:53:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 00/12] XDP batching for TUN/vhost_net
Message-ID: <20180525205219-mutt-send-email-mst@kernel.org>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:04:21PM +0800, Jason Wang wrote:
> Hi all:
> 
> We do not support XDP batching for TUN since it can only receive one
> packet a time from vhost_net. This series tries to remove this
> limitation by:
> 
> - introduce a TUN specific msg_control that can hold a pointer to an
>   array of XDP buffs
> - try copy and build XDP buff in vhost_net
> - store XDP buffs in an array and submit them once for every N packets
>   from vhost_net
> - since TUN can only do native XDP for datacopy packet, to simplify
>   the logic, split datacopy out logic and only do batching for
>   datacopy.

I like how this rework looks. Pls go ahead and repost as
non-RFC.

> With this series, TX PPS can improve about 34% from 2.9Mpps to
> 3.9Mpps when doing xdp_redirect_map between TAP and ixgbe.
> 
> Thanks
> 
> Jason Wang (12):
>   vhost_net: introduce helper to initialize tx iov iter
>   vhost_net: introduce vhost_exceeds_weight()
>   vhost_net: introduce vhost_has_more_pkts()
>   vhost_net: split out datacopy logic
>   vhost_net: batch update used ring for datacopy TX
>   tuntap: enable premmption early
>   tuntap: simplify error handling in tun_build_skb()
>   tuntap: tweak on the path of non-xdp case in tun_build_skb()
>   tuntap: split out XDP logic
>   vhost_net: build xdp buff
>   vhost_net: passing raw xdp buff to tun
>   vhost_net: batch submitting XDP buffers to underlayer sockets
> 
>  drivers/net/tun.c      | 226 +++++++++++++++++++++++++++----------
>  drivers/vhost/net.c    | 297 ++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/if_tun.h |   7 ++
>  3 files changed, 444 insertions(+), 86 deletions(-)
> 
> -- 
> 2.7.4
