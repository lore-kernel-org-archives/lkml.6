Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeCOPBe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:01:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeCOPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:01:33 -0400
MIME-Version: 1.0
Message-ID: <58e67195-56f6-4d01-8747-f8322a382358@default>
Date: Thu, 15 Mar 2018 08:01:03 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <mrv@mojatatu.com>
Cc: <netdev@vger.kernel.org>, <shmulik.ladkani@gmail.com>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <yuval.shaia@oracle.com>,
        <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FF1erR013824


----- mrv@mojatatu.com wrote:

> Liran Alon <liran.alon@oracle.com> writes:
> 
> 
> [...]
> 
> >> Overall I think it might be nice to not need scrubbing skb in such
> >> cases,
> >> although my concern would be that this has potential to break
> >> existing
> >> setups when they would expect mark being zero on other veth peer
> in
> >> any
> >> case since it's the behavior for a long time already. The safer
> >> option
> >> would be to have some sort of explicit opt-in e.g. on link creation
> to
> >> let
> >> the skb->mark pass through unscrubbed. This would definitely be a
> >> useful
> >> option e.g. when mark is set in the netns facing veth via
> >> clsact/egress
> >> on xmit and when the container is unprivileged anyway.
> >> 
> >> Thanks,
> >> Daniel
> >
> > I see your point in regards to backwards comparability.
> > However, not scrubbing skb when it cross netns via some kernel
> functions compared to
> > others is basically a bug which could easily break with a little bit
> of more refactoring.
> > Therefore, it seems a bit weird to me to from now on, we will force
> > every user on link creation to consider that once there was a bug
> leading
> > to this weird behavior on specific netdevs.
> > Thus, I suggest to maybe control this via a global /proc/sys/net
> file instead.
> 
> One valid use case could be preserving a source namespace nsid in
> skb->mark when a packet crosses netns.

Before and after this commit, veth peers that crosses netns zero skb->mark.
Therefore, what you suggest is a new feature unrelated to the
issue fixed by this commit.

I still think that default behavior should be to zero skb->mark only when skb
cross netdevs in different netns. And for backwards comparability, we can
consider adding a /proc/sys/net/core file to let dev_forward_skb() to always
scrub packet regardless if it crosses netdevs or not.
