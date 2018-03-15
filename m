Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCOMOo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:14:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:14:42 -0400
MIME-Version: 1.0
Message-ID: <cf2dee1b-6098-47aa-bb2b-f8a44db904e3@default>
Date: Thu, 15 Mar 2018 05:14:15 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <shmulik.ladkani@gmail.com>
Cc: <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <yuval.shaia@oracle.com>, <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FCEojc000870


----- shmulik.ladkani@gmail.com wrote:

> Hi,
> 
> On Tue, 13 Mar 2018 17:07:22 +0200 Liran Alon <liran.alon@oracle.com>
> wrote:
> > Before this commit, dev_forward_skb() always cleared packet's
> > per-network-namespace info. Even if the packet doesn't cross
> > network namespaces.
> > 
> > The comment above dev_forward_skb() describes that this is done
> > because the receiving device may be in another network namespace.
> > However, this case can easily be tested for and therefore we can
> > scrub packet's per-network-namespace info only when receiving
> device
> > is indeed in another network namespace.
> > 
> > Therefore, this commit changes ____dev_forward_skb() to tell
> > skb_scrub_packet() that skb has crossed network-namespace only in
> case
> > transmitting device (skb->dev) network namespace is different then
> > receiving device (dev) network namespace.
> 
> Assuming the premise of this commit is correct, note it may not act
> as
> intended for xnet situation in ipvlan_process_multicast, snip:
> 
> 		nskb->dev = ipvlan->dev;
> 		if (tx_pkt)
> 			ret = dev_forward_skb(ipvlan->dev, nskb);
> 		else
> 			ret = netif_rx(nskb);
> 
> as 'dev' gets already assigned to nskb prior dev_forward_skb (hence
> in
> ____dev_forward_skb both dev and skb->dev are the same).
> Fortunately every ipvlan_multicast_enqueue call is preceded by a
> forced
> scrub; It would be future-proof to not assign nskb->dev in the
> dev_forward_skb case (assign it only in the netif_rx case).

I agree. Nice catch.
skb->dev will later get assigned in eth_type_trans() called from __dev_forward_skb().
I will do this small change in a separate patch before this patch.
(In v2 of this series)

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
> with ip tunnels (full scrub only if crossing netns, see
> ip_tunnel_rcv).
> 
> Regarding veth xmit, it does makes sense to preserve the fields if
> not
> crossing netns. This is also the case when one uses tc mirred.
> 
> Regarding bpf redirect, well, it depends on the expectations of each
> bpf
> program.
> I'd argue that preserving the fields (at least the mark field) in the
> *non* xnet makes sense and provides more information and therefore
> more
> capabilities; Alas this might change behavior already being relied
> on.

I now noticed that a similar change was done in the past in
commit 8a83a00b0735 ("net: maintain namespace isolation
between vlan and real device"). Commit changed dev_forward_skb() from always
setting skb->mark=0 to do this only in case we cross netns.

However, a later commit: 59b9997baba5 ("Revert "net: maintain namespace
isolation between vlan and real device") seems to later reverted that change.
But I think that the regression issue mentioned in the revert isn't
related to the change proposed by this commit.
Please correct me if I'm missing something.

> 
> Maybe Daniel can comment on the matter.
> 
> Regards,
> Shmulik
