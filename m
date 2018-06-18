Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D82B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966331AbeFRJZ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:25:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965606AbeFRI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 88B02C94;
        Mon, 18 Jun 2018 08:26:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 212/279] tipc: eliminate KMSAN uninit-value in strcmp complaint
Date:   Mon, 18 Jun 2018 10:13:17 +0200
Message-Id: <20180618080617.644106981@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ying Xue <ying.xue@windriver.com>

[ Upstream commit 94f6a80c0c11828cb7b3d79294459dd8d761ca89 ]

When we get link properties through netlink interface with
tipc_nl_node_get_link(), we don't validate TIPC_NLA_LINK_NAME
attribute at all, instead we directly use it. As a consequence,
KMSAN detected the TIPC_NLA_LINK_NAME attribute was an uninitialized
value, and then posted the following complaint:

==================================================================
BUG: KMSAN: uninit-value in strcmp+0xf7/0x160 lib/string.c:329
CPU: 1 PID: 4527 Comm: syz-executor655 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  strcmp+0xf7/0x160 lib/string.c:329
  tipc_nl_node_get_link+0x220/0x6f0 net/tipc/node.c:1881
  genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]
  genl_rcv_msg+0x1686/0x1810 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x378/0x600 net/netlink/af_netlink.c:2447
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
  netlink_unicast+0x166b/0x1740 net/netlink/af_netlink.c:1337
  netlink_sendmsg+0x1048/0x1310 net/netlink/af_netlink.c:1900
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x445589
RSP: 002b:00007fb7ee66cdb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445589
RDX: 0000000000000000 RSI: 0000000020023000 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffa2bf3f3f R14: 00007fb7ee66d9c0 R15: 0000000000000001

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1183 [inline]
  netlink_sendmsg+0x9a6/0x1310 net/netlink/af_netlink.c:1875
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
==================================================================

To quiet the complaint, TIPC_NLA_LINK_NAME attribute has been
validated in tipc_nl_node_get_link() before it's used.

Reported-by: syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/node.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1863,6 +1863,7 @@ out:
 int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
+	struct nlattr *attrs[TIPC_NLA_LINK_MAX + 1];
 	struct tipc_nl_msg msg;
 	char *name;
 	int err;
@@ -1870,9 +1871,19 @@ int tipc_nl_node_get_link(struct sk_buff
 	msg.portid = info->snd_portid;
 	msg.seq = info->snd_seq;
 
-	if (!info->attrs[TIPC_NLA_LINK_NAME])
+	if (!info->attrs[TIPC_NLA_LINK])
 		return -EINVAL;
-	name = nla_data(info->attrs[TIPC_NLA_LINK_NAME]);
+
+	err = nla_parse_nested(attrs, TIPC_NLA_LINK_MAX,
+			       info->attrs[TIPC_NLA_LINK],
+			       tipc_nl_link_policy, info->extack);
+	if (err)
+		return err;
+
+	if (!attrs[TIPC_NLA_LINK_NAME])
+		return -EINVAL;
+
+	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
 
 	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg.skb)


