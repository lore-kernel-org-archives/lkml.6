Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9022082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYfvcmjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9022082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeKCDpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:45:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67D92081B;
        Fri,  2 Nov 2018 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183850;
        bh=0cPkCCReXTxYDEfZQGfr1asHPUL8+dBGtw/7yHy/WVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYfvcmjnpSwm/C79RMCv4/7mSBVFsAJMn/Zrau6M0MvzmMsR9asXJsye/QdFQEf+v
         PpU8lwadq9i8g5Nw7ZMUurHLJOoPS5jD77dwhME+Sq/LIhY0RI6fPX4AMFe2QNNq4N
         /aZ21T8e76HgtoEc6+mcO1Ik6piF7ed4tNf5IdeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 08/24] rtnetlink: Disallow FDB configuration for non-Ethernet device
Date:   Fri,  2 Nov 2018 19:34:41 +0100
Message-Id: <20181102182841.019250031@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit da71577545a52be3e0e9225a946e5fd79cfab015 ]

When an FDB entry is configured, the address is validated to have the
length of an Ethernet address, but the device for which the address is
configured can be of any type.

The above can result in the use of uninitialized memory when the address
is later compared against existing addresses since 'dev->addr_len' is
used and it may be greater than ETH_ALEN, as with ip6tnl devices.

Fix this by making sure that FDB entries are only configured for
Ethernet devices.

BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
CPU: 1 PID: 4318 Comm: syz-executor998 Not tainted 4.19.0-rc3+ #49
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  memcmp+0x11d/0x180 lib/string.c:863
  dev_uc_add_excl+0x165/0x7b0 net/core/dev_addr_lists.c:464
  ndo_dflt_fdb_add net/core/rtnetlink.c:3463 [inline]
  rtnl_fdb_add+0x1081/0x1270 net/core/rtnetlink.c:3558
  rtnetlink_rcv_msg+0xa0b/0x1530 net/core/rtnetlink.c:4715
  netlink_rcv_skb+0x36e/0x5f0 net/netlink/af_netlink.c:2454
  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4733
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x1638/0x1720 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0x1205/0x1290 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440ee9
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff6a93b518 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ee9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 000000000000b4b0
R13: 0000000000401ec0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2718 [inline]
  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
  netlink_sendmsg+0xb49/0x1290 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

v2:
* Make error message more specific (David)

Fixes: 090096bf3db1 ("net: generic fdb support for drivers without ndo_fdb_<op>")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-and-tested-by: syzbot+3a288d5f5530b901310e@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+d53ab4e92a1db04110ff@syzkaller.appspotmail.com
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3530,6 +3530,11 @@ static int rtnl_fdb_add(struct sk_buff *
 		return -EINVAL;
 	}
 
+	if (dev->type != ARPHRD_ETHER) {
+		NL_SET_ERR_MSG(extack, "FDB delete only supported for Ethernet devices");
+		return -EINVAL;
+	}
+
 	addr = nla_data(tb[NDA_LLADDR]);
 
 	err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
@@ -3634,6 +3639,11 @@ static int rtnl_fdb_del(struct sk_buff *
 		return -EINVAL;
 	}
 
+	if (dev->type != ARPHRD_ETHER) {
+		NL_SET_ERR_MSG(extack, "FDB add only supported for Ethernet devices");
+		return -EINVAL;
+	}
+
 	addr = nla_data(tb[NDA_LLADDR]);
 
 	err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);


