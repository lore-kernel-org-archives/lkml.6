Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B875C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079985;
	bh=vL6tQa3r+pD8H2syFZ4Z3E3u/c3MMxXPVEBe10hyPWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MfGGebYziANjroOYhq7D8rHjEG/k065oYtLpCFfLd8J7NrdA4IYQRg7e5gXwo+4XP
	 NnYkFEedHO3hUU7oWEEb/3o/VPGh7SNGzh6CpfUPEc6kSQzEbW3EO3XRn7PPyrLsZo
	 0so96k8aSAfBE+sGhxJT8RBVBXOWzDzywuVepfA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfAUOND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfAUNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21EA2084C;
        Mon, 21 Jan 2019 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078802;
        bh=vL6tQa3r+pD8H2syFZ4Z3E3u/c3MMxXPVEBe10hyPWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBBq9qIRk45w2JlYLT0yVPHN5xPrcvgUO5V4nEIFR9TjD2Gli8xV00raZbxZbCzwc
         gJnhEKFhzGhEcvzmAeBP3xvKTZ0GctT+ZsVKH0ExgPtWNOecSyIEDLwrpAU4iemKBY
         /nYE5kHzXyFphPgR5ZFoY+D+P4bo2katmGAlpCmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b33d5cae0efd35dbfe77@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 49/59] tipc: fix uninit-value in tipc_nl_compat_bearer_enable
Date:   Mon, 21 Jan 2019 14:44:14 +0100
Message-Id: <20190121122502.127468749@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

From: Ying Xue <ying.xue@windriver.com>

commit 0762216c0ad2a2fccd63890648eca491f2c83d9a upstream.

syzbot reported:

BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:484
CPU: 1 PID: 6371 Comm: syz-executor652 Not tainted 4.19.0-rc8+ #70
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x306/0x460 lib/dump_stack.c:113
 kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
 __msan_warning+0x7c/0xe0 mm/kmsan/kmsan_instr.c:500
 strlen+0x3b/0xa0 lib/string.c:484
 nla_put_string include/net/netlink.h:1011 [inline]
 tipc_nl_compat_bearer_enable+0x238/0x7b0 net/tipc/netlink_compat.c:389
 __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
 tipc_nl_compat_doit+0x39f/0xae0 net/tipc/netlink_compat.c:344
 tipc_nl_compat_recv+0x147c/0x2760 net/tipc/netlink_compat.c:1107
 genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
 genl_rcv_msg+0x185c/0x1a20 net/netlink/genetlink.c:626
 netlink_rcv_skb+0x394/0x640 net/netlink/af_netlink.c:2454
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x166d/0x1720 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x1391/0x1420 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
 __sys_sendmsg net/socket.c:2154 [inline]
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
 do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440179
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffef7beee8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440179
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401a00
R13: 0000000000401a90 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
 kmsan_internal_poison_shadow+0xc8/0x1d0 mm/kmsan/kmsan.c:180
 kmsan_kmalloc+0xa4/0x120 mm/kmsan/kmsan_hooks.c:104
 kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:113
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2727 [inline]
 __kmalloc_node_track_caller+0xb43/0x1400 mm/slub.c:4360
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x422/0xe90 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:996 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
 netlink_sendmsg+0xcaf/0x1420 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
 __sys_sendmsg net/socket.c:2154 [inline]
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
 do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

The root cause is that we don't validate whether bear name is a valid
string in tipc_nl_compat_bearer_enable().

Meanwhile, we also fix the same issue in the following functions:
tipc_nl_compat_bearer_disable()
tipc_nl_compat_link_stat_dump()
tipc_nl_compat_media_set()
tipc_nl_compat_bearer_set()

Reported-by: syzbot+b33d5cae0efd35dbfe77@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -380,6 +380,7 @@ static int tipc_nl_compat_bearer_enable(
 	struct nlattr *prop;
 	struct nlattr *bearer;
 	struct tipc_bearer_config *b;
+	int len;
 
 	b = (struct tipc_bearer_config *)TLV_DATA(msg->req);
 
@@ -387,6 +388,10 @@ static int tipc_nl_compat_bearer_enable(
 	if (!bearer)
 		return -EMSGSIZE;
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_BEARER_NAME);
+	if (!string_is_valid(b->name, len))
+		return -EINVAL;
+
 	if (nla_put_string(skb, TIPC_NLA_BEARER_NAME, b->name))
 		return -EMSGSIZE;
 
@@ -412,6 +417,7 @@ static int tipc_nl_compat_bearer_disable
 {
 	char *name;
 	struct nlattr *bearer;
+	int len;
 
 	name = (char *)TLV_DATA(msg->req);
 
@@ -419,6 +425,10 @@ static int tipc_nl_compat_bearer_disable
 	if (!bearer)
 		return -EMSGSIZE;
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_BEARER_NAME);
+	if (!string_is_valid(name, len))
+		return -EINVAL;
+
 	if (nla_put_string(skb, TIPC_NLA_BEARER_NAME, name))
 		return -EMSGSIZE;
 
@@ -479,6 +489,7 @@ static int tipc_nl_compat_link_stat_dump
 	struct nlattr *prop[TIPC_NLA_PROP_MAX + 1];
 	struct nlattr *stats[TIPC_NLA_STATS_MAX + 1];
 	int err;
+	int len;
 
 	if (!attrs[TIPC_NLA_LINK])
 		return -EINVAL;
@@ -505,6 +516,11 @@ static int tipc_nl_compat_link_stat_dump
 		return err;
 
 	name = (char *)TLV_DATA(msg->req);
+
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_LINK_NAME);
+	if (!string_is_valid(name, len))
+		return -EINVAL;
+
 	if (strcmp(name, nla_data(link[TIPC_NLA_LINK_NAME])) != 0)
 		return 0;
 
@@ -645,6 +661,7 @@ static int tipc_nl_compat_media_set(stru
 	struct nlattr *prop;
 	struct nlattr *media;
 	struct tipc_link_config *lc;
+	int len;
 
 	lc = (struct tipc_link_config *)TLV_DATA(msg->req);
 
@@ -652,6 +669,10 @@ static int tipc_nl_compat_media_set(stru
 	if (!media)
 		return -EMSGSIZE;
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_MEDIA_NAME);
+	if (!string_is_valid(lc->name, len))
+		return -EINVAL;
+
 	if (nla_put_string(skb, TIPC_NLA_MEDIA_NAME, lc->name))
 		return -EMSGSIZE;
 
@@ -672,6 +693,7 @@ static int tipc_nl_compat_bearer_set(str
 	struct nlattr *prop;
 	struct nlattr *bearer;
 	struct tipc_link_config *lc;
+	int len;
 
 	lc = (struct tipc_link_config *)TLV_DATA(msg->req);
 
@@ -679,6 +701,10 @@ static int tipc_nl_compat_bearer_set(str
 	if (!bearer)
 		return -EMSGSIZE;
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_MEDIA_NAME);
+	if (!string_is_valid(lc->name, len))
+		return -EINVAL;
+
 	if (nla_put_string(skb, TIPC_NLA_BEARER_NAME, lc->name))
 		return -EMSGSIZE;
 


