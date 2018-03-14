Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNPTa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:19:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCNPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:19:28 -0400
Date: Wed, 14 Mar 2018 14:03:43 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Liran Alon <liran.alon@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idan.brown@oracle.com,
        sharon.s.liu@oracle.com
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
Message-ID: <20180314120342.GA15750@yuvallap>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
 <20180313161345.GC4023@yuvallap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313161345.GC4023@yuvallap>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140173
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:13:45PM +0200, Yuval Shaia wrote:
> On Tue, Mar 13, 2018 at 05:07:22PM +0200, Liran Alon wrote:
> > Before this commit, dev_forward_skb() always cleared packet's
> > per-network-namespace info. Even if the packet doesn't cross
> > network namespaces.
> > 
> > The comment above dev_forward_skb() describes that this is done
> > because the receiving device may be in another network namespace.
> > However, this case can easily be tested for and therefore we can
> > scrub packet's per-network-namespace info only when receiving device
> > is indeed in another network namespace.
> > 
> > Therefore, this commit changes ____dev_forward_skb() to tell
> > skb_scrub_packet() that skb has crossed network-namespace only in case
> > transmitting device (skb->dev) network namespace is different then
> > receiving device (dev) network namespace.
> > 
> > An example of a netdev that use skb_forward_skb() is veth.
> > Thus, before this commit a packet transmitted from one veth peer to
> > another when both veth peers are on same network namespace will lose
> > it's skb->mark. The bug could easily be demonstrated by the following:
> > 
> > ip netns add test
> > ip netns exec test bash
> > ip link add veth-a type veth peer name veth-b
> > ip link set veth-a up
> > ip link set veth-b up
> > ip addr add dev veth-a 12.0.0.1/24
> > tc qdisc add dev veth-a root handle 1 prio
> > tc qdisc add dev veth-b ingress
> > tc filter add dev veth-a parent 1: u32 match u32 0 0 action skbedit mark 1337
> > tc filter add dev veth-b parent ffff: basic match 'meta(nf_mark eq 1337)' action simple "skb->mark 1337!"
> > dmesg -C
> > ping 12.0.0.2
> > dmesg
> > 
> > Before this change, the above will print nothing to dmesg.
> > After this change, "skb->mark 1337!" will be printed as necessary.
> 
> Hi Liran,
> 
> > 
> > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> 
> I did not earned the credits for SOB, only r-b.

Had an offlist conversation with Liran,
Turns out that this SOB is ok.

Yuval

> 
> Yuval
> 
> > ---
> >  include/linux/netdevice.h | 2 +-
> >  net/core/dev.c            | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5eef6c8e2741..5908f1e31ee2 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3371,7 +3371,7 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
> >  		return NET_RX_DROP;
> >  	}
> >  
> > -	skb_scrub_packet(skb, true);
> > +	skb_scrub_packet(skb, !net_eq(dev_net(dev), dev_net(skb->dev)));
> >  	skb->priority = 0;
> >  	return 0;
> >  }
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 2cedf520cb28..087787dd0a50 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1877,9 +1877,9 @@ int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
> >   * start_xmit function of one device into the receive queue
> >   * of another device.
> >   *
> > - * The receiving device may be in another namespace, so
> > - * we have to clear all information in the skb that could
> > - * impact namespace isolation.
> > + * The receiving device may be in another namespace.
> > + * In that case, we have to clear all information in the
> > + * skb that could impact namespace isolation.
> >   */
> >  int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -- 
> > 1.9.1
> > 
