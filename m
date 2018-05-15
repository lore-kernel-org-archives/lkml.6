Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeEONGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:06:34 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:51173 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbeEONGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:06:31 -0400
Date: Tue, 15 May 2018 15:06:26 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot <syzbot+c8e66da874feb11aaca6@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: KASAN: out-of-bounds Read in ip6_xmit
Message-ID: <20180515130626.GA1389@alphalink.fr>
References: <001a11433bee67ed4c0563db12f9@google.com>
 <20180509044525.GD711@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509044525.GD711@sol.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:45:25PM -0700, Eric Biggers wrote:
> On Sun, Jan 28, 2018 at 11:24:01AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot hit the following crash on net-next commit
> > 6bb46bc57c8e9ce947cc605e555b7204b44d2b10 (Fri Jan 26 16:00:23 2018 +0000)
> > Merge branch 'cxgb4-fix-dump-collection-when-firmware-crashed'
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > Raw console output is attached.
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c8e66da874feb11aaca6@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> > 
> > ==================================================================
> > BUG: KASAN: out-of-bounds in ip6_dst_idev include/net/ip6_fib.h:192 [inline]
> > BUG: KASAN: out-of-bounds in ip6_xmit+0x1f76/0x2260
> > net/ipv6/ip6_output.c:264
> > Read of size 8 at addr ffff8801bcc8cc18 by task syz-executor2/11459
> > 
> > CPU: 0 PID: 11459 Comm: syz-executor2 Not tainted 4.15.0-rc9+ #212
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:17 [inline]
> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >  print_address_description+0x73/0x250 mm/kasan/report.c:252
> >  kasan_report_error mm/kasan/report.c:351 [inline]
> >  kasan_report+0x25b/0x340 mm/kasan/report.c:409
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
> >  ip6_dst_idev include/net/ip6_fib.h:192 [inline]
> >  ip6_xmit+0x1f76/0x2260 net/ipv6/ip6_output.c:264
> >  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
> >  l2tp_xmit_core net/l2tp/l2tp_core.c:1096 [inline]
> >  l2tp_xmit_skb+0x105f/0x1410 net/l2tp/l2tp_core.c:1191
> >  pppol2tp_sendmsg+0x470/0x670 net/l2tp/l2tp_ppp.c:341
> >  sock_sendmsg_nosec net/socket.c:630 [inline]
> >  sock_sendmsg+0xca/0x110 net/socket.c:640
> >  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
> >  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
> >  SYSC_sendmsg net/socket.c:2091 [inline]
> >  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
> >  entry_SYSCALL_64_fastpath+0x29/0xa0
> 
> No reproducer and last occurred 58 days ago (on commit f44b1886a5f876c8).
> Probably was fixed by commit b954f94023dcc61:
> 
Indeed, this commit certainly applies to this report too. Thanks a lot
for looking into this.
