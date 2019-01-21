Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB5C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576020879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078652;
	bh=w9CkSrRNAbfrrJx99lTKeJpvI6Bvfz4pVPEVTjN9oVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pteHyL3J3HUyTRZxBIPYmjlz8Lg3I8fQDUvtRrfrAilpnhw+N/hSdXysz6oHW86ex
	 6X+z0ePvy513LQPAeHVLnjmMjjbr7ku4NBnwmNCxF/UwrCIoSq9uCE1B3V7tSQ3CHX
	 6uf4rE4L4rLGQR8poW0jk3jjxAZYTB87ALNRyNos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfAUNuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbfAUNus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007F32063F;
        Mon, 21 Jan 2019 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078647;
        bh=w9CkSrRNAbfrrJx99lTKeJpvI6Bvfz4pVPEVTjN9oVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn12Cr/qaQB7zFwk9qXNiGsSInleTgRySpBejPRgNx90QfkkTAQXFKr9uwyXXP446
         nKY6Lj1b2oFSGzlX2vbJo3JxD2eNIp6GxE8yzYSs3RfLUMqLw5uU43OrKbpt4mkBsV
         gmYFwZo4A9paqbfOlxQg8E+d/EEP8y7QlgSPZ+WY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e01d94b5a4c266be6e4c@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 088/111] tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
Date:   Mon, 21 Jan 2019 14:43:22 +0100
Message-Id: <20190121122505.672369529@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ying Xue <ying.xue@windriver.com>

commit 8b66fee7f8ee18f9c51260e7a43ab37db5177a05 upstream.

syzbot reports following splat:

BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:486
CPU: 1 PID: 11057 Comm: syz-executor0 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
 __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:295
 strlen+0x3b/0xa0 lib/string.c:486
 nla_put_string include/net/netlink.h:1154 [inline]
 tipc_nl_compat_link_reset_stats+0x1f0/0x360 net/tipc/netlink_compat.c:760
 __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
 tipc_nl_compat_doit+0x3aa/0xaf0 net/tipc/netlink_compat.c:344
 tipc_nl_compat_handle net/tipc/netlink_compat.c:1107 [inline]
 tipc_nl_compat_recv+0x14d7/0x2760 net/tipc/netlink_compat.c:1210
 genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
 genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
 netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0xf40/0x1020 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2116
 __sys_sendmsg net/socket.c:2154 [inline]
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2557338c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25573396d4
R13: 00000000004cb478 R14: 00000000004d86c8 R15: 00000000ffffffff

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
 kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
 kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
 kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
 slab_post_alloc_hook mm/slab.h:446 [inline]
 slab_alloc_node mm/slub.c:2759 [inline]
 __kmalloc_node_track_caller+0xe18/0x1030 mm/slub.c:4383
 __kmalloc_reserve net/core/skbuff.c:137 [inline]
 __alloc_skb+0x309/0xa20 net/core/skbuff.c:205
 alloc_skb include/linux/skbuff.h:998 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
 netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg net/socket.c:631 [inline]
 ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2116
 __sys_sendmsg net/socket.c:2154 [inline]
 __do_sys_sendmsg net/socket.c:2163 [inline]
 __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7

The uninitialised access happened in tipc_nl_compat_link_reset_stats:
    nla_put_string(skb, TIPC_NLA_LINK_NAME, name)

This is because name string is not validated before it's used.

Reported-by: syzbot+e01d94b5a4c266be6e4c@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -87,6 +87,11 @@ static int tipc_skb_tailroom(struct sk_b
 	return limit;
 }
 
+static inline int TLV_GET_DATA_LEN(struct tlv_desc *tlv)
+{
+	return TLV_GET_LEN(tlv) - TLV_SPACE(0);
+}
+
 static int tipc_add_tlv(struct sk_buff *skb, u16 type, void *data, u16 len)
 {
 	struct tlv_desc *tlv = (struct tlv_desc *)skb_tail_pointer(skb);
@@ -166,6 +171,11 @@ static struct sk_buff *tipc_get_err_tlv(
 	return buf;
 }
 
+static inline bool string_is_valid(char *s, int len)
+{
+	return memchr(s, '\0', len) ? true : false;
+}
+
 static int __tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
 				   struct tipc_nl_compat_msg *msg,
 				   struct sk_buff *arg)
@@ -750,6 +760,7 @@ static int tipc_nl_compat_link_reset_sta
 {
 	char *name;
 	struct nlattr *link;
+	int len;
 
 	name = (char *)TLV_DATA(msg->req);
 
@@ -757,6 +768,10 @@ static int tipc_nl_compat_link_reset_sta
 	if (!link)
 		return -EMSGSIZE;
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_LINK_NAME);
+	if (!string_is_valid(name, len))
+		return -EINVAL;
+
 	if (nla_put_string(skb, TIPC_NLA_LINK_NAME, name))
 		return -EMSGSIZE;
 


