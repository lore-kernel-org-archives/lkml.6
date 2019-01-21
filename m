Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA459C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FB020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080168;
	bh=ju+afPsOuxSnijuCMu33VV/RPBA1+HN3BAW2p80CuVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3N1X0AtAm7tVaBrmUjAgtPqFOg9oSHoc95fqFD5M0qH9cnZjDodfgHiB1rB1H3zl
	 J7NJh7dBY2bsW5v3wx3X1OffX/lioou84vTaIgJVUvG0YlwYiRTAtEMu7/Pg6B/WLi
	 uQan91PppZJSUQt61ffM0hLkJNO0eOPFNopBcTyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfAUNvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbfAUNvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9597120861;
        Mon, 21 Jan 2019 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078675;
        bh=ju+afPsOuxSnijuCMu33VV/RPBA1+HN3BAW2p80CuVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhvFkIXeEx0TmQ+AF+S6CllK1T9fD8btEnFiBq2cY5lYH7MIvyKRdLdwC94Ex97Oj
         Frd+m3K+7vCJdqW0hruBTFE38/ORcN7CKBqtcwl9p2UwA7jfthw2q8Z3s2OwQQDs+w
         p76FXD5tJt3ytsGtnudbe3no0Uw2vHKfUD5m/rU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+bca0dc46634781f08b38@syzkaller.appspotmail.com,
        syzbot+6bdb590321a7ae40c1a6@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 092/111] tipc: fix uninit-value in tipc_nl_compat_doit
Date:   Mon, 21 Jan 2019 14:43:26 +0100
Message-Id: <20190121122506.154509616@linuxfoundation.org>
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

commit 2753ca5d9009c180dbfd4c802c80983b4b6108d1 upstream.

BUG: KMSAN: uninit-value in tipc_nl_compat_doit+0x404/0xa10 net/tipc/netlink_compat.c:335
CPU: 0 PID: 4514 Comm: syz-executor485 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
 tipc_nl_compat_doit+0x404/0xa10 net/tipc/netlink_compat.c:335
 tipc_nl_compat_recv+0x164b/0x2700 net/tipc/netlink_compat.c:1153
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
RIP: 0033:0x43fda9
RSP: 002b:00007ffd0c184ba8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fda9
RDX: 0000000000000000 RSI: 0000000020023000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 00000000004016d0
R13: 0000000000401760 R14: 0000000000000000 R15: 0000000000000000

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

In tipc_nl_compat_recv(), when the len variable returned by
nlmsg_attrlen() is 0, the message is still treated as a valid one,
which is obviously unresonable. When len is zero, it means the
message not only doesn't contain any valid TLV payload, but also
TLV header is not included. Under this stituation, tlv_type field
in TLV header is still accessed in tipc_nl_compat_dumpit() or
tipc_nl_compat_doit(), but the field space is obviously illegal.
Of course, it is not initialized.

Reported-by: syzbot+bca0dc46634781f08b38@syzkaller.appspotmail.com
Reported-by: syzbot+6bdb590321a7ae40c1a6@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -1249,7 +1249,7 @@ static int tipc_nl_compat_recv(struct sk
 	}
 
 	len = nlmsg_attrlen(req_nlh, GENL_HDRLEN + TIPC_GENL_HDRLEN);
-	if (len && !TLV_OK(msg.req, len)) {
+	if (!len || !TLV_OK(msg.req, len)) {
 		msg.rep = tipc_get_err_tlv(TIPC_CFG_NOT_SUPPORTED);
 		err = -EOPNOTSUPP;
 		goto send;


