Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D28F8183B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED843217B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED843217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeIMWeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:34:16 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:49559 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:34:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 5C9CE2B52068;
        Thu, 13 Sep 2018 19:23:47 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id H0tzQJ6NF_dC; Thu, 13 Sep 2018 19:23:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 4BE362B52072;
        Thu, 13 Sep 2018 19:23:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xLPafC65zXRn; Thu, 13 Sep 2018 19:23:45 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 16D812B52068;
        Thu, 13 Sep 2018 19:23:45 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id DF8926014D; Thu, 13 Sep 2018 19:23:44 +0200 (CEST)
Date:   Thu, 13 Sep 2018 19:23:44 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Alexander Potapenko <glider@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in pppoe_rcv
Message-ID: <20180913172344.GB1507@alphalink.fr>
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
 <CAG_fn=WXPsQBWR1GDsprY3aL4oW0v6EGhNB5wrvPJCOMh_U7wQ@mail.gmail.com>
 <20180913161929.GA1507@alphalink.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913161929.GA1507@alphalink.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 06:19:29PM +0200, Guillaume Nault wrote:
> On Thu, Sep 13, 2018 at 04:12:38PM +0200, Alexander Potapenko wrote:
> > On Thu, Sep 13, 2018 at 3:57 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > >
> > >
> > >
> > > On 09/12/2018 03:38 AM, Alexander Potapenko wrote:
> > > > On Wed, Sep 12, 2018 at 12:24 PM syzbot
> > > > <syzbot+f5f6080811c849739212@syzkaller.appspotmail.com> wrote:
> > > >>
> > > >> Hello,
> > > >>
> > > >> syzbot found the following crash on:
> > > >>
> > > >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
> > > >> git tree:       https://github.com/google/kmsan.git/master
> > > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1465fc37800000
> > > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
> > > >> dashboard link: https://syzkaller.appspot.com/bug?extid=f5f6080811c849739212
> > > >> compiler:       clang version 7.0.0 (trunk 329391)
> > > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d6e607800000
> > > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a15b5b800000
> > > >>
> > > >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > >> Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
> > > >>
> > > >> IPVS: ftp: loaded support on port[0] = 21
> > > >> ==================================================================
> > > >> BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inline]
> > > >> BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
> > > >> BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0
> > > >> drivers/net/ppp/pppoe.c:450
> > > >> CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
> > > >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > >> Google 01/01/2011
> > > >> Call Trace:
> > > >>   __dump_stack lib/dump_stack.c:17 [inline]
> > > >>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
> > > >>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
> > > >>   __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
> > > >>   __get_item drivers/net/ppp/pppoe.c:172 [inline]
> > > >>   get_item drivers/net/ppp/pppoe.c:236 [inline]
> > > >>   pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
> > > >>   __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
> > > >>   __netif_receive_skb net/core/dev.c:4627 [inline]
> > > >>   netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
> > > >>   netif_receive_skb+0x230/0x240 net/core/dev.c:4725
> > > >>   tun_rx_batched drivers/net/tun.c:1555 [inline]
> > > >>   tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
> > > >>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
> > > >>   call_write_iter include/linux/fs.h:1782 [inline]
> > > >>   new_sync_write fs/read_write.c:469 [inline]
> > > >>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
> > > >>   vfs_write+0x463/0x8d0 fs/read_write.c:544
> > > >>   SYSC_write+0x172/0x360 fs/read_write.c:589
> > > >>   SyS_write+0x55/0x80 fs/read_write.c:581
> > > >>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
> > > >>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > >> RIP: 0033:0x4447c9
> > > >> RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
> > > >> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
> > > >> RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
> > > >> RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
> > > >> R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
> > > >> R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
> > > >>
> > > >> Uninit was created at:
> > > >>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
> > > >>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
> > > >>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
> > > >>   kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
> > > >>   slab_post_alloc_hook mm/slab.h:445 [inline]
> > > >>   slab_alloc_node mm/slub.c:2737 [inline]
> > > >>   __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
> > > >>   __kmalloc_reserve net/core/skbuff.c:138 [inline]
> > > >>   __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
> > > >>   alloc_skb include/linux/skbuff.h:984 [inline]
> > > >>   alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
> > > >>   sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
> > > >>   tun_alloc_skb drivers/net/tun.c:1532 [inline]
> > > >>   tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
> > > >>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
> > > >>   call_write_iter include/linux/fs.h:1782 [inline]
> > > >>   new_sync_write fs/read_write.c:469 [inline]
> > > >>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
> > > >>   vfs_write+0x463/0x8d0 fs/read_write.c:544
> > > >>   SYSC_write+0x172/0x360 fs/read_write.c:589
> > > >>   SyS_write+0x55/0x80 fs/read_write.c:581
> > > >>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
> > > >>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> > > >> ==================================================================
> > > > I did a little digging before sending the bug upstream.
> > > > If I add memset(obj, 0xfe, size) to __kmalloc_reserve(), these 0xfe
> > > > bytes are visible in __get_item() at the place where KMSAN reports an
> > > > error.
> > > >
> > > > The problem is somehow related to tun_get_user() creating a fragmented
> > > > sk_buff - when I change the call to tun_alloc_skb() so that it
> > > > allocates a single buffer the bug goes away.
> > > >
> > >
> > > I guess the following patch would fix the issue
> > >
> > > (I will submit it more formally)
> > No, as far as I can see it doesn't.
> > Saving sid before __skb_pull() is still a good idea, but in this
> > particular case |ph| doesn't change.
> 
> Yes, we probably need to save sid.
> 
> But I think the problem found by syzbot is related to
> eth_hdr(skb)->h_source. PPPoE expects that Ethernet header has already
> been parsed and is accessible at skb_mac_header(skb).
> But here skb_mac_header(skb) == skb->data, and we may pull only 6 bytes
> (sizeof(truct pppoe_hdr)). Therefore eth_hdr(skb)->h_source points past
> skb's head length.
> 
> Not sure if something needs to be changed in tun.c for properly setting
> skb_mac_header. But PPPoE has no reason to consider packets from
> non-Ethernet devices anyway.

Nothing to change in tun.c. Just some more tests in pppoe.
Can you try this patch? It only addresses this particular report, not
the problems spotted by Eric.

-------- 8< --------
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 5aa59f41bf8c..77241b584dff 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -429,6 +429,9 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto out;
 
+	if (skb_mac_header_len(skb) < ETH_HLEN)
+		goto drop;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto drop;
 
