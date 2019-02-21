Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A22C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3819420700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760518;
	bh=prcqGuMb0dNoQv2tkDPAC3bMFaWwaaz3868NkCLNCa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHGAwM3bsZvxMPDqFkmd4h4dm2O0qY6Eyo/4/BB5AiqZ4Yz0O1ZBzsSoaayhObO3K
	 ggQq57qkpQhxPceYAVJAycLruefWAnxkGTF71T+ynKMGVwK+VpH/QE22dvWhxZ5xwR
	 JHB0RRK0Sc/mGxY6Fn/cA/CP45HmGHetgpS6doAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfBUOsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfBUOkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6988A20838;
        Thu, 21 Feb 2019 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760016;
        bh=prcqGuMb0dNoQv2tkDPAC3bMFaWwaaz3868NkCLNCa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETJctNhoUNQFP6d+DTB2rJSXtZInmlksRZKVmZpW7GZbDTj48gZSV7YurPlGHOPee
         wvGdfIqMmlHGasFZAknvGZRiyodJNNMnOSJ0DE9zMA78ik06NtZ0RvE06D0Dg+2raY
         jq2QdIPnG0DYDJ/V4IfFMvww8sS5Po+uMV5d2S30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 23/23] ax25: fix possible use-after-free
Date:   Thu, 21 Feb 2019 15:36:05 +0100
Message-Id: <20190221125248.017150579@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 63530aba7826a0f8e129874df9c4d264f9db3f9e upstream.

syzbot found that ax25 routes where not properly protected
against concurrent use [1].

In this particular report the bug happened while
copying ax25->digipeat.

Fix this problem by making sure we call ax25_get_route()
while ax25_route_lock is held, so that no modification
could happen while using the route.

The current two ax25_get_route() callers do not sleep,
so this change should be fine.

Once we do that, ax25_get_route() no longer needs to
grab a reference on the found route.

[1]
ax25_connect(): syz-executor0 uses autobind, please contact jreuter@yaina.de
BUG: KASAN: use-after-free in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: use-after-free in kmemdup+0x42/0x60 mm/util.c:113
Read of size 66 at addr ffff888066641a80 by task syz-executor2/531

ax25_connect(): syz-executor0 uses autobind, please contact jreuter@yaina.de
CPU: 1 PID: 531 Comm: syz-executor2 Not tainted 5.0.0-rc2+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
 print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
 kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x123/0x190 mm/kasan/generic.c:191
 memcpy+0x24/0x50 mm/kasan/common.c:130
 memcpy include/linux/string.h:352 [inline]
 kmemdup+0x42/0x60 mm/util.c:113
 kmemdup include/linux/string.h:425 [inline]
 ax25_rt_autobind+0x25d/0x750 net/ax25/ax25_route.c:424
 ax25_connect.cold+0x30/0xa4 net/ax25/af_ax25.c:1224
 __sys_connect+0x357/0x490 net/socket.c:1664
 __do_sys_connect net/socket.c:1675 [inline]
 __se_sys_connect net/socket.c:1672 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:1672
 do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f870ee22c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
RDX: 0000000000000048 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
ax25_connect(): syz-executor4 uses autobind, please contact jreuter@yaina.de
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f870ee236d4
R13: 00000000004be48e R14: 00000000004ce9a8 R15: 00000000ffffffff

Allocated by task 526:
 save_stack+0x45/0xd0 mm/kasan/common.c:73
 set_track mm/kasan/common.c:85 [inline]
 __kasan_kmalloc mm/kasan/common.c:496 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
ax25_connect(): syz-executor5 uses autobind, please contact jreuter@yaina.de
 kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
 kmalloc include/linux/slab.h:545 [inline]
 ax25_rt_add net/ax25/ax25_route.c:95 [inline]
 ax25_rt_ioctl+0x3b9/0x1270 net/ax25/ax25_route.c:233
 ax25_ioctl+0x322/0x10b0 net/ax25/af_ax25.c:1763
 sock_do_ioctl+0xe2/0x400 net/socket.c:950
 sock_ioctl+0x32f/0x6c0 net/socket.c:1074
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:509 [inline]
 do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
 do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

ax25_connect(): syz-executor5 uses autobind, please contact jreuter@yaina.de
Freed by task 550:
 save_stack+0x45/0xd0 mm/kasan/common.c:73
 set_track mm/kasan/common.c:85 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
 __cache_free mm/slab.c:3487 [inline]
 kfree+0xcf/0x230 mm/slab.c:3806
 ax25_rt_add net/ax25/ax25_route.c:92 [inline]
 ax25_rt_ioctl+0x304/0x1270 net/ax25/ax25_route.c:233
 ax25_ioctl+0x322/0x10b0 net/ax25/af_ax25.c:1763
 sock_do_ioctl+0xe2/0x400 net/socket.c:950
 sock_ioctl+0x32f/0x6c0 net/socket.c:1074
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:509 [inline]
 do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
 ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
 do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888066641a80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 96-byte region [ffff888066641a80, ffff888066641ae0)
The buggy address belongs to the page:
page:ffffea0001999040 count:1 mapcount:0 mapping:ffff88812c3f04c0 index:0x0
flags: 0x1fffc0000000200(slab)
ax25_connect(): syz-executor4 uses autobind, please contact jreuter@yaina.de
raw: 01fffc0000000200 ffffea0001817948 ffffea0002341dc8 ffff88812c3f04c0
raw: 0000000000000000 ffff888066641000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888066641980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888066641a00: 00 00 00 00 00 00 00 00 02 fc fc fc fc fc fc fc
>ffff888066641a80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff888066641b00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888066641b80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/ax25.h    |   12 ++++++++++++
 net/ax25/ax25_ip.c    |    4 ++--
 net/ax25/ax25_route.c |   19 ++++++++-----------
 3 files changed, 22 insertions(+), 13 deletions(-)

--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -200,6 +200,18 @@ static inline void ax25_hold_route(ax25_
 
 void __ax25_put_route(ax25_route *ax25_rt);
 
+extern rwlock_t ax25_route_lock;
+
+static inline void ax25_route_lock_use(void)
+{
+	read_lock(&ax25_route_lock);
+}
+
+static inline void ax25_route_lock_unuse(void)
+{
+	read_unlock(&ax25_route_lock);
+}
+
 static inline void ax25_put_route(ax25_route *ax25_rt)
 {
 	if (refcount_dec_and_test(&ax25_rt->refcount))
--- a/net/ax25/ax25_ip.c
+++ b/net/ax25/ax25_ip.c
@@ -114,6 +114,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff
 	dst = (ax25_address *)(bp + 1);
 	src = (ax25_address *)(bp + 8);
 
+	ax25_route_lock_use();
 	route = ax25_get_route(dst, NULL);
 	if (route) {
 		digipeat = route->digipeat;
@@ -206,9 +207,8 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff
 	ax25_queue_xmit(skb, dev);
 
 put:
-	if (route)
-		ax25_put_route(route);
 
+	ax25_route_lock_unuse();
 	return NETDEV_TX_OK;
 }
 
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -40,7 +40,7 @@
 #include <linux/export.h>
 
 static ax25_route *ax25_route_list;
-static DEFINE_RWLOCK(ax25_route_lock);
+DEFINE_RWLOCK(ax25_route_lock);
 
 void ax25_rt_device_down(struct net_device *dev)
 {
@@ -349,6 +349,7 @@ const struct file_operations ax25_route_
  *	Find AX.25 route
  *
  *	Only routes with a reference count of zero can be destroyed.
+ *	Must be called with ax25_route_lock read locked.
  */
 ax25_route *ax25_get_route(ax25_address *addr, struct net_device *dev)
 {
@@ -356,7 +357,6 @@ ax25_route *ax25_get_route(ax25_address
 	ax25_route *ax25_def_rt = NULL;
 	ax25_route *ax25_rt;
 
-	read_lock(&ax25_route_lock);
 	/*
 	 *	Bind to the physical interface we heard them on, or the default
 	 *	route if none is found;
@@ -379,11 +379,6 @@ ax25_route *ax25_get_route(ax25_address
 	if (ax25_spe_rt != NULL)
 		ax25_rt = ax25_spe_rt;
 
-	if (ax25_rt != NULL)
-		ax25_hold_route(ax25_rt);
-
-	read_unlock(&ax25_route_lock);
-
 	return ax25_rt;
 }
 
@@ -414,9 +409,12 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25
 	ax25_route *ax25_rt;
 	int err = 0;
 
-	if ((ax25_rt = ax25_get_route(addr, NULL)) == NULL)
+	ax25_route_lock_use();
+	ax25_rt = ax25_get_route(addr, NULL);
+	if (!ax25_rt) {
+		ax25_route_lock_unuse();
 		return -EHOSTUNREACH;
-
+	}
 	if ((ax25->ax25_dev = ax25_dev_ax25dev(ax25_rt->dev)) == NULL) {
 		err = -EHOSTUNREACH;
 		goto put;
@@ -451,8 +449,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25
 	}
 
 put:
-	ax25_put_route(ax25_rt);
-
+	ax25_route_lock_unuse();
 	return err;
 }
 


