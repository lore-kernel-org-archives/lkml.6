Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeCOPGB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:06:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56130 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeCOPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:06:00 -0400
MIME-Version: 1.0
Message-ID: <eb240da0-9498-4367-8430-600a481f8159@default>
Date: Thu, 15 Mar 2018 08:05:33 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <daniel@iogearbox.net>
Cc: <netdev@vger.kernel.org>, <shmulik.ladkani@gmail.com>,
        <mrv@mojatatu.com>, <davem@davemloft.net>,
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
 engine=8.0.1-1711220000 definitions=main-1803150167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FF67eX014271


----- daniel@iogearbox.net wrote:

> On 03/15/2018 03:35 PM, Roman Mashak wrote:
> > Liran Alon <liran.alon@oracle.com> writes:
> > [...]
> >>> Overall I think it might be nice to not need scrubbing skb in
> such
> >>> cases,
> >>> although my concern would be that this has potential to break
> >>> existing
> >>> setups when they would expect mark being zero on other veth peer
> in
> >>> any
> >>> case since it's the behavior for a long time already. The safer
> >>> option
> >>> would be to have some sort of explicit opt-in e.g. on link
> creation to
> >>> let
> >>> the skb->mark pass through unscrubbed. This would definitely be a
> >>> useful
> >>> option e.g. when mark is set in the netns facing veth via
> >>> clsact/egress
> >>> on xmit and when the container is unprivileged anyway.
> >>>
> >>> Thanks,
> >>> Daniel
> >>
> >> I see your point in regards to backwards comparability.
> >> However, not scrubbing skb when it cross netns via some kernel
> functions compared to
> >> others is basically a bug which could easily break with a little
> bit of more refactoring.
> >> Therefore, it seems a bit weird to me to from now on, we will
> force
> >> every user on link creation to consider that once there was a bug
> leading
> >> to this weird behavior on specific netdevs.
> 
> Why bug specifically? It could well be that for some unpriv
> containers
> it would be fine to do e.g. in cases where orchestrator sets up
> clsact/
> egress on veth/ipvlan/etc in the container to set the mark and where
> app
> cannot mess with this while for others you need to act out of host
> facing
> veth; thus, explicit opt-in per dev could provide such more fine
> grained
> control.
> 
> > One valid use case could be preserving a source namespace nsid in
> > skb->mark when a packet crosses netns.
> 
> Right, was thinking about something similar.

I agree with all the above but this behavior was not supported both
before and after this commit. skb->mark is always zeroed when crossing netns.
This commit only changes behavior for skb crossing netdevs on *same* netns
via dev_forward_skb().

Therefore, I believe we should discuss here what we want default behavior to be
and how it should be controlled for backwards comparability.
Only after we should discuss about adding an extra feature of controlling skb scrub
per netdev or something similar.
