Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09276C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE221773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfAJIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:55:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfAJIz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:55:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C2867FD5A;
        Thu, 10 Jan 2019 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2FB05C6C1;
        Thu, 10 Jan 2019 08:55:25 +0000 (UTC)
Message-ID: <351f5da149072c8c1165f8f205ac5c852a92dff8.camel@redhat.com>
Subject: Re: [BUG] moving fq back to clock monotonic breaks my setup
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Jan 2019 09:55:24 +0100
In-Reply-To: <CAA85sZvciuNTc1NM1XbbBCqV-hWwjMZM+0i3vigtzmJ8CpPjHg@mail.gmail.com>
References: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
         <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
         <CAA85sZvciuNTc1NM1XbbBCqV-hWwjMZM+0i3vigtzmJ8CpPjHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 10 Jan 2019 08:55:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 09:25 +0100, Ian Kumlien wrote:
> On Thu, Jan 10, 2019 at 6:53 AM Eric Dumazet <edumazet@google.com> wrote:
> > On Wed, Jan 9, 2019 at 4:48 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > Hi,
> > > 
> > > Just been trough ~5+ hours of bisecting and eventually actually found
> > > the culprit =)
> > > 
> > > commit fb420d5d91c1274d5966917725e71f27ed092a85 (refs/bisect/bad)
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Fri Sep 28 10:28:44 2018 -0700
> > > 
> > >     tcp/fq: move back to CLOCK_MONOTONIC
> > > 
> > > [--8<--]
> > > 
> > > So this might be because my setup might be "odd".
> > > 
> > > Basically I have a firewall with four nics that uses two of those nics
> > > to handle my normal
> > > internet connection (firewall/MASQ/NAT) and the other two are assigned
> > > to one bridge each.
> > > 
> > > The firewall is also my local caching DNS server and DHCP server,
> > > which is also used by the VM:s...
> > > But with 4.20 DHCP replies disappeared before entering the bridge - i
> > > couldn't even see them in
> > > tcpdump! (all nics are ixgbe on a atom soc)
> > > 
> > > I'm currently running a kernel with that patch reversed but I'm also
> > > wondering about possible ways
> > > forward since I'm reverting a fix from someone else...
> > 
> > I suggest you use netdev@ mailing list instead of lkml
> > 
> > Then, we probably need to clear skb->tstamp in more paths (you are
> > mentioning bridge ...)
> > 
> > See commit 8203e2d844d34af247a151d8ebd68553a6e91785 for reference.
> > 
> > Can you try :
> > 
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index 5372e2042adfe20d3cd039c29057535b2413be61..bd4fa141420c92a44716bd93fcd8aa3d3310203a
> > 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -53,6 +53,7 @@ int br_dev_queue_push_xmit(struct net *net, struct
> > sock *sk, struct sk_buff *skb
> >                 skb_set_network_header(skb, depth);
> >         }
> > 
> > +       skb->tstamp = 0;
> >         dev_queue_xmit(skb);
> > 
> >         return 0;
> 
> This works, and so does: https://marc.info/?l=linux-netdev&m=154696956604748&w=2
> 
> Pointed out by Paolo (tested both separately)

Note: I cleared the tstamp in br_forward_finish() instead of
br_dev_queue_push_xmit() because I think the latter could be called
also in the local xmit path, via br_nf_post_routing.

We must preserve the tstamp in output path, right?

Thanks,

Paolo




