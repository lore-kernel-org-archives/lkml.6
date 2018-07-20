Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FCECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062D6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062D6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbeGTNNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:13:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeGTNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:13:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5DF2BBD;
        Fri, 20 Jul 2018 12:25:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/29] net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
Date:   Fri, 20 Jul 2018 14:11:12 +0200
Message-Id: <20180720115159.599065116@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 74174fe5634ffbf645a7ca5a261571f700b2f332 ]

On fast hosts or malicious bots, we trigger a DCCP_BUG() which
seems excessive.

syzbot reported :

BUG: delta (-6195) <= 0 at net/dccp/ccids/ccid3.c:628/ccid3_hc_rx_send_feedback()
CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.18.0-rc1+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
 ccid3_hc_rx_send_feedback net/dccp/ccids/ccid3.c:628 [inline]
 ccid3_hc_rx_packet_recv.cold.16+0x38/0x71 net/dccp/ccids/ccid3.c:793
 ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
 dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
 dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
 dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:654
 sk_backlog_rcv include/net/sock.h:914 [inline]
 __sk_receive_skb+0x3ba/0xd80 net/core/sock.c:517
 dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:875
 ip_local_deliver_finish+0x2eb/0xda0 net/ipv4/ip_input.c:215
 NF_HOOK include/linux/netfilter.h:287 [inline]
 ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
 dst_input include/net/dst.h:450 [inline]
 ip_rcv_finish+0x823/0x2220 net/ipv4/ip_input.c:396
 NF_HOOK include/linux/netfilter.h:287 [inline]
 ip_rcv+0xa18/0x1284 net/ipv4/ip_input.c:492
 __netif_receive_skb_core+0x2488/0x3680 net/core/dev.c:4628
 __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:4693
 process_backlog+0x219/0x760 net/core/dev.c:5373
 napi_poll net/core/dev.c:5771 [inline]
 net_rx_action+0x7da/0x1980 net/core/dev.c:5837
 __do_softirq+0x2e8/0xb17 kernel/softirq.c:284
 run_ksoftirqd+0x86/0x100 kernel/softirq.c:645
 smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
 kthread+0x345/0x410 kernel/kthread.c:240
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: dccp@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccids/ccid3.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/dccp/ccids/ccid3.c
+++ b/net/dccp/ccids/ccid3.c
@@ -624,9 +624,8 @@ static void ccid3_hc_rx_send_feedback(st
 	case CCID3_FBACK_PERIODIC:
 		delta = ktime_us_delta(now, hc->rx_tstamp_last_feedback);
 		if (delta <= 0)
-			DCCP_BUG("delta (%ld) <= 0", (long)delta);
-		else
-			hc->rx_x_recv = scaled_div32(hc->rx_bytes_recv, delta);
+			delta = 1;
+		hc->rx_x_recv = scaled_div32(hc->rx_bytes_recv, delta);
 		break;
 	default:
 		return;


