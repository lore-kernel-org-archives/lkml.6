Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeCOMYE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:24:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeCOMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:24:02 -0400
MIME-Version: 1.0
Message-ID: <be0d17cf-12d5-440c-adee-e943ccb199c9@default>
Date: Thu, 15 Mar 2018 05:23:41 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <daniel@iogearbox.net>
Cc: <netdev@vger.kernel.org>, <shmulik.ladkani@gmail.com>,
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
 engine=8.0.1-1711220000 definitions=main-1803150139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FCOBPS000904


----- daniel@iogearbox.net wrote:

> On 03/15/2018 10:21 AM, Shmulik Ladkani wrote:
> > Regarding the premise of this commit, this "reduces" the
> > ipvs/orphan/mark scrubbing in the following *non* xnet situations:
> > 
> >  1. mac2vlan port xmit to other macvlan ports in Bridge Mode
> >  2. similarly for ipvlan
> >  3. veth xmit
> >  4. l2tp_eth_dev_recv
> >  5. bpf redirect/clone_redirect ingress actions
> > 
> > Regarding l2tp recv, this commit seems to align the srubbing
> behavior
> > with ip tunnels (full scrub only if crossing netns, see
> ip_tunnel_rcv).
> > 
> > Regarding veth xmit, it does makes sense to preserve the fields if
> not
> > crossing netns. This is also the case when one uses tc mirred.
> > 
> > Regarding bpf redirect, well, it depends on the expectations of each
> bpf
> > program.
> > I'd argue that preserving the fields (at least the mark field) in
> the
> > *non* xnet makes sense and provides more information and therefore
> more
> > capabilities; Alas this might change behavior already being relied
> on.
> > 
> > Maybe Daniel can comment on the matter.
> 
> Overall I think it might be nice to not need scrubbing skb in such
> cases,
> although my concern would be that this has potential to break
> existing
> setups when they would expect mark being zero on other veth peer in
> any
> case since it's the behavior for a long time already. The safer
> option
> would be to have some sort of explicit opt-in e.g. on link creation to
> let
> the skb->mark pass through unscrubbed. This would definitely be a
> useful
> option e.g. when mark is set in the netns facing veth via
> clsact/egress
> on xmit and when the container is unprivileged anyway.
> 
> Thanks,
> Daniel

I see your point in regards to backwards comparability.
However, not scrubbing skb when it cross netns via some kernel functions compared to
others is basically a bug which could easily break with a little bit of more refactoring.
Therefore, it seems a bit weird to me to from now on, we will force
every user on link creation to consider that once there was a bug leading
to this weird behavior on specific netdevs.
Thus, I suggest to maybe control this via a global /proc/sys/net file instead.

-Liran
