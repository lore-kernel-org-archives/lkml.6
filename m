Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6382A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLRMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:40:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeLRMke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:40:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5B24C0AF7B0;
        Tue, 18 Dec 2018 12:40:33 +0000 (UTC)
Received: from localhost (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 773A65C689;
        Tue, 18 Dec 2018 12:40:29 +0000 (UTC)
Date:   Tue, 18 Dec 2018 13:40:24 +0100
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
        netdev <netdev@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
Message-ID: <20181218134024.45d2d5e3@redhat.com>
In-Reply-To: <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
References: <0000000000005e47a2057d0edc49@google.com>
        <20181216190412.GE4170@linux.ibm.com>
        <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
        <20181217112916.GG4170@linux.ibm.com>
        <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
        <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
        <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
        <20181217162421.6d636ee5@redhat.com>
        <CACT4Y+YXFrnQh9h1KQf8=NcHugmxTj+d7AQdGCvRX_xsHwr1qA@mail.gmail.com>
        <20181218001828.49cea463@redhat.com>
        <CACT4Y+ZFpO26Tgqpi+Jies9XOiiCgAdp2DV0z_54hCNTqkJsiw@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Dec 2018 12:40:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 09:49:17 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> On Tue, Dec 18, 2018 at 12:18 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> >
> > On Mon, 17 Dec 2018 16:53:36 +0100
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> >  
> > > On Mon, Dec 17, 2018 at 4:24 PM Stefano Brivio <sbrivio@redhat.com> wrote:  
> > > >
> > > > On Mon, 17 Dec 2018 06:57:35 -0800
> > > > Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > >  
> > > > > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > > > > fou, fou6: ICMP error handlers for FoU and GUE  
> > > >
> > > > This:
> > > >
> > > > diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
> > > > index 0d0ad19ecb87..20a6de26d146 100644
> > > > --- a/net/ipv4/fou.c
> > > > +++ b/net/ipv4/fou.c
> > > > @@ -1008,6 +1008,9 @@ static int gue_err_proto_handler(int proto, struct sk_buff *skb, u32 info)
> > > >  {
> > > >         const struct net_protocol *ipprot = rcu_dereference(inet_protos[proto]);
> > > >
> > > > +       if (ipprot == IPPROTO_UDP)
> > > > +               return -EINVAL;
> > > > +
> > > >         if (ipprot && ipprot->err_handler) {
> > > >                 if (!ipprot->err_handler(skb, info))
> > > >                         return 0;
> > > >
> > > > should fix the issue, but I still have to run tests and make sure we
> > > > don't hit similar cases.  
> > >
> > > Please don't forget to add a regression test for it too ;)  
> >
> > Where would you suggest to add this? The only selftest that goes  
> 
> I dunno. But there must be some place for such tests, right?

Not as far as I know. The selftests checking this path, by design, only
use supported configurations, they don't forge packets.

Maybe it would be nice to have a semi-automated way to isolate and
describe/name specific conditions found by syzbot via fuzzing and turn
those into tests that are then repeated periodically. I'm not sure how
that would look like, but I think it's still more maintainable than a
pile of C reproducers with forged packets in selftests/net.

Eric, Cong, Xin, as you also recently fixed a nice deal of similar cases
reported by syzbot, what do you think? Did you ever feel the need to
turn a syzbot reproducer into a regression test case?

> > through this path currently is net/pmtu.sh, but as configuration of an
> > actual UDP-in-GUE tunnel is currently not supported, I would really
> > need to forge that specific packet, so that doesn't seem to be a good
> > fit.
> >
> > Won't syzbot add this to some list of reproducers that are checked in
> > the future?  
> 
> It won't. Also fuzzing is complementary to testing, not a replacement:

Indeed, but that doesn't mean we need to limit the potential of fuzzing
because "it's not testing". It can be used to check for regressions,
too, especially in these cases.

> https://twitter.com/dvyukov/status/1074719682962358272

Now, I'm extremely thankful for the work you're doing and especially
for finding this subtle condition with syzbot, but this is quite
inaccurate. To be exposed to this issue, the user would need to
have the fou module loaded (it won't autoload), which is used quite
rarely, and, on top of that, have a UDP tunnel configured. It wouldn't
have been the kind of "evil packet crashes the internet" scenario you
were dreaming of ;)

-- 
Stefano
