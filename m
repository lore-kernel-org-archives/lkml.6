Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58466C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5949208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5949208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeHAKAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:00:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387566AbeHAKAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:00:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CF11402243B;
        Wed,  1 Aug 2018 08:15:40 +0000 (UTC)
Received: from bistromath.localdomain (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 027232156711;
        Wed,  1 Aug 2018 08:15:25 +0000 (UTC)
Date:   Wed, 1 Aug 2018 10:15:37 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lucien xin <lucien.xin@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
Message-ID: <20180801081537.GA31982@bistromath.localdomain>
References: <0000000000004fe2be05724ac084@google.com>
 <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
 <20180731134014.GA32114@bistromath.localdomain>
 <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 08:15:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 08:15:40 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sd@queasysnail.net' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-31, 16:03:13 -0700, Cong Wang wrote:
> On Tue, Jul 31, 2018 at 6:41 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > 2018-07-31, 05:41:56 -0700, Eric Dumazet wrote:
> > >
> > >
> > > On 07/31/2018 05:31 AM, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> > > > git tree:       net
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a9de58400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=41f9c04b50ef70c66947
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > [...]
> >
> > > Probably also caused by :
> > >
> > >
> > > commit df18b50448fab1dff093731dfd0e25e77e1afcd1
> > > Author: Sabrina Dubroca <sd@queasysnail.net>
> > > Date:   Mon Jul 30 16:23:10 2018 +0200
> > >
> > >     net/ipv6: fix metrics leak
> >
> > Yeah, I'm looking into both those reports :/
> 
> Looks like this commit is completely unnecessary,
> fib6_drop_pcpu_from() calls fib6_info_release()
> which calls fib6_info_destroy_rcu(), so this metrics
> will be released twice...

kmemleak disagrees:

unreferenced object 0xffff88006b605080 (size 96):
  comm "ip", pid 433, jiffies 4294889793 (age 74.844s)
  hex dump (first 32 bytes):
    00 00 00 00 f4 01 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002650e4e2>] ip6_route_info_create+0x770/0x4050
    [<000000000a8d4c52>] ip6_route_add+0x18/0x90
    [<00000000474d669c>] inet6_rtm_newroute+0xeb/0x100
    [<0000000019fb732d>] rtnetlink_rcv_msg+0x3b5/0xb40
    [<000000006f891e19>] netlink_rcv_skb+0x137/0x380
    [<0000000070451985>] netlink_unicast+0x47f/0x6e0
    [<000000004487d656>] netlink_sendmsg+0x7a7/0x10c0
    [<0000000089fdf5ae>] sock_sendmsg+0xac/0x160
    [<00000000aae19c54>] ___sys_sendmsg+0x6e0/0xbb0
    [<00000000a3906352>] __sys_sendmsg+0xdc/0x230
    [<00000000c7c8548a>] do_syscall_64+0x15d/0x740
    [<000000007dfdad73>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000003adb705a>] 0xffffffffffffffff


ip netns add peerA
ip link add eth0 netns peerA type veth peer name ethA
ip -net peerA link set eth0 up
ip -net peerA link set lo up
ip -net peerA a a fec0:A::1/64 dev eth0
ip -net peerA route add fec0:B::/64 via fec0:A:: mtu 1300

ip netns exec peerA nc fec0:B::1 1234

ip -net peerA route del fec0:B::/64
ip netns del peerA

-- 
Sabrina
