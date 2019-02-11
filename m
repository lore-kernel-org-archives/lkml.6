Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A39C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B297B21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898684;
	bh=Bma2hH5b0ZekD5zjx7xWYr582MnnfKoi3hYhSA4Yfx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xKcbgoB+6fkmFD0w2TVbDFiDnEqjkracNMz/FLb0Bfg7WEuMmLvnA3gIYrTHN+xLG
	 SgwMkd6Qt/wUhOJRpxuzAgYO/yHWsUSd36ANO5MDsepMY9UJQV4e1la8evsBuh8+S2
	 xgnYVaeg+YTvB3xXsINvllB9SMY2ih6OISdMczpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfBKPCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390344AbfBKPCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92391222AB;
        Mon, 11 Feb 2019 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897328;
        bh=Bma2hH5b0ZekD5zjx7xWYr582MnnfKoi3hYhSA4Yfx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxVV9vUZxvYV3RwoQ0hjyPtf/hCuPEJycAEYKLLiueWTChTA+72y3TzHyObNg6dpq
         YSA6StZaplUzv5I3eR7XdS3P4Mkkddozb3QIZ827dJqOD6NaTx40a+oZreFHEY5rQI
         Ei1peGjckWc0VrZkq7zl+lJACGwHt15caud2jVnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 166/205] dccp: fool proof ccid_hc_[rt]x_parse_options()
Date:   Mon, 11 Feb 2019 15:19:24 +0100
Message-Id: <20190211141839.206034636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit 9b1f19d810e92d6cdc68455fbc22d9f961a58ce1 ]

Similarly to commit 276bdb82dedb ("dccp: check ccid before dereferencing")
it is wise to test for a NULL ccid.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ccid_hc_tx_parse_options net/dccp/ccid.h:205 [inline]
RIP: 0010:dccp_parse_options+0x8d9/0x12b0 net/dccp/options.c:233
Code: c5 0f b6 75 b3 80 38 00 0f 85 d6 08 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45 b8 4c 8b b8 f8 07 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 95 08 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
kobject: 'loop5' (0000000080f78fc1): kobject_uevent_env
RSP: 0018:ffff8880a94df0b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880858ac723 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: 0000000000000007 RDI: 0000000000000001
RBP: ffff8880a94df140 R08: 0000000000000001 R09: ffff888061b83a80
R10: ffffed100c370752 R11: ffff888061b83a97 R12: 0000000000000026
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0defa33518 CR3: 000000008db5e000 CR4: 00000000001406e0
kobject: 'loop5' (0000000080f78fc1): fill_kobj_path: path = '/devices/virtual/block/loop5'
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dccp_rcv_state_process+0x2b6/0x1af6 net/dccp/input.c:654
 dccp_v4_do_rcv+0x100/0x190 net/dccp/ipv4.c:688
 sk_backlog_rcv include/net/sock.h:936 [inline]
 __sk_receive_skb+0x3a9/0xea0 net/core/sock.c:473
 dccp_v4_rcv+0x10cb/0x1f80 net/dccp/ipv4.c:880
 ip_protocol_deliver_rcu+0xb6/0xa20 net/ipv4/ip_input.c:208
 ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
 NF_HOOK include/linux/netfilter.h:289 [inline]
 NF_HOOK include/linux/netfilter.h:283 [inline]
 ip_local_deliver+0x1f0/0x740 net/ipv4/ip_input.c:255
 dst_input include/net/dst.h:450 [inline]
 ip_rcv_finish+0x1f4/0x2f0 net/ipv4/ip_input.c:414
 NF_HOOK include/linux/netfilter.h:289 [inline]
 NF_HOOK include/linux/netfilter.h:283 [inline]
 ip_rcv+0xed/0x620 net/ipv4/ip_input.c:524
 __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
 __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
 process_backlog+0x206/0x750 net/core/dev.c:5923
 napi_poll net/core/dev.c:6346 [inline]
 net_rx_action+0x76d/0x1930 net/core/dev.c:6412
 __do_softirq+0x30b/0xb11 kernel/softirq.c:292
 run_ksoftirqd kernel/softirq.c:654 [inline]
 run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
 smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
 kthread+0x357/0x430 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 58a0ba03bea2c376 ]---
RIP: 0010:ccid_hc_tx_parse_options net/dccp/ccid.h:205 [inline]
RIP: 0010:dccp_parse_options+0x8d9/0x12b0 net/dccp/options.c:233
Code: c5 0f b6 75 b3 80 38 00 0f 85 d6 08 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45 b8 4c 8b b8 f8 07 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 95 08 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8880a94df0b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880858ac723 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: 0000000000000007 RDI: 0000000000000001
RBP: ffff8880a94df140 R08: 0000000000000001 R09: ffff888061b83a80
R10: ffffed100c370752 R11: ffff888061b83a97 R12: 0000000000000026
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0defa33518 CR3: 0000000009871000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccid.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/dccp/ccid.h
+++ b/net/dccp/ccid.h
@@ -202,7 +202,7 @@ static inline void ccid_hc_tx_packet_rec
 static inline int ccid_hc_tx_parse_options(struct ccid *ccid, struct sock *sk,
 					   u8 pkt, u8 opt, u8 *val, u8 len)
 {
-	if (ccid->ccid_ops->ccid_hc_tx_parse_options == NULL)
+	if (!ccid || !ccid->ccid_ops->ccid_hc_tx_parse_options)
 		return 0;
 	return ccid->ccid_ops->ccid_hc_tx_parse_options(sk, pkt, opt, val, len);
 }
@@ -214,7 +214,7 @@ static inline int ccid_hc_tx_parse_optio
 static inline int ccid_hc_rx_parse_options(struct ccid *ccid, struct sock *sk,
 					   u8 pkt, u8 opt, u8 *val, u8 len)
 {
-	if (ccid->ccid_ops->ccid_hc_rx_parse_options == NULL)
+	if (!ccid || !ccid->ccid_ops->ccid_hc_rx_parse_options)
 		return 0;
 	return ccid->ccid_ops->ccid_hc_rx_parse_options(sk, pkt, opt, val, len);
 }


