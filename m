Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A089C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AA9214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLQXSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:18:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeLQXSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:18:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06CFE89AD3;
        Mon, 17 Dec 2018 23:18:37 +0000 (UTC)
Received: from localhost (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C5A619741;
        Mon, 17 Dec 2018 23:18:33 +0000 (UTC)
Date:   Tue, 18 Dec 2018 00:18:28 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Subject: Re: WARNING in __rcu_read_unlock
Message-ID: <20181218001828.49cea463@redhat.com>
In-Reply-To: <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
References: <0000000000005e47a2057d0edc49@google.com>
        <20181216190412.GE4170@linux.ibm.com>
        <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
        <20181217112916.GG4170@linux.ibm.com>
        <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
        <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
        <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
        <20181217162421.6d636ee5@redhat.com>
        <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 17 Dec 2018 23:18:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 16:53:36 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Mon, 17 Dec 2018 06:57:35 -0800
> > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >  
> > > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > > fou, fou6: ICMP error handlers for FoU and GUE  
> >
> > This:
> >
> > diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> > index 0d0ad19ecb87..20a6de26d146 100644
> > --- a/net/ipv4/fou.c
> > +++ b/net/ipv4/fou.c
> > @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
> >  {
> >         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
> >
> > +       if (ipprot == IPPROTO_UDP)
> > +               return -EINVAL;
> > +
> >         if (ipprot && ipprot->err_handler) {
> >                 if (!ipprot->err_handler(skb, info))
> >                         return 0;
> >
> > should fix the issue, but I still have to run tests and make sure we
> > don't hit similar cases.  
> 
> Please don't forget to add a regression test for it too ;)

Where would you suggest to add this? The only selftest that goes
through this path currently is net/pmtu.sh, but as configuration of an
actual UDP-in-GUE tunnel is currently not supported, I would really
need to forge that specific packet, so that doesn't seem to be a good
fit.

Won't syzbot add this to some list of reproducers that are checked in
the future?

-- 
Stefano
