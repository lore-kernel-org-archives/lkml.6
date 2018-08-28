Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55FAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B1C208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B1C208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH1LXO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:23:14 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:61846 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbeH1LXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:23:14 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 874579F11D97556FEC90;
        Tue, 28 Aug 2018 15:32:52 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7S7WeR9048815;
        Tue, 28 Aug 2018 15:32:40 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082815324467-6302102 ;
          Tue, 28 Aug 2018 15:32:44 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     edumazet@google.com, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wen.yang99@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, liu.bo9@zte.com.cn
Subject: [PATCH] tcp: another fix of uncloning packets before mangling them
Date:   Tue, 28 Aug 2018 15:31:05 +0800
Message-Id: <1535441465-65170-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-28 15:32:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-28 15:32:36
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn w7S7WeR9048815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning was caught：

[937151.638394] Call Trace:
[937151.638401]  [<ffffffff8163f2f6>] dump_stack+0x19/0x1b
[937151.638405]  [<ffffffff8107dd70>] warn_slowpath_common+0x70/0xb0
[937151.638407]  [<ffffffff8107deba>] warn_slowpath_null+0x1a/0x20
[937151.638410]  [<ffffffff8158bb7b>] tcp_set_skb_tso_segs+0xeb/0x100
[937151.638412]  [<ffffffff8158bbc7>] tcp_init_tso_segs+0x37/0x50
[937151.638414]  [<ffffffff8158d7b9>] tcp_write_xmit+0x1d9/0xce0
[937151.638417]  [<ffffffff8158e53e>] __tcp_push_pending_frames+0x2e/0xc0
[937151.638419]  [<ffffffff8157cf3c>] tcp_push+0xec/0x120
[937151.638421]  [<ffffffff81580728>] tcp_sendmsg+0xc8/0xc20
[937151.638424]  [<ffffffff815aae24>] inet_sendmsg+0x64/0xb0
[937151.638428]  [<ffffffff810b9565>] ? check_preempt_curr+0x75/0xa0
[937151.638434]  [<ffffffff81519917>] sock_aio_write+0x157/0x180
[937151.638437]  [<ffffffff811e267d>] do_sync_write+0x8d/0xd0
[937151.638440]  [<ffffffff811e2f95>] vfs_write+0x1b5/0x1e0
[937151.638442]  [<ffffffff811e393f>] SyS_write+0x7f/0xe0
[937151.638445]  [<ffffffff816513fd>] system_call_fastpath+0x16/0x1b

According commit c52e2421f736 ("tcp: must unclone packets before
mangling them"), TCP stack should make sure it owns skbs before
mangling them.
And there is another place where skb_unclone() is needed. This patch
fix that.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Tested-by: Liu Bo <liu.bo9@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 net/ipv4/tcp_output.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 597dbd7..fbe8140 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1793,6 +1793,9 @@ static int tcp_init_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 	int tso_segs = tcp_skb_pcount(skb);
 
 	if (!tso_segs || (tso_segs > 1 && tcp_skb_mss(skb) != mss_now)) {
+		if (skb_unclone(skb, GFP_ATOMIC))
+			return -ENOMEM;
+
 		tcp_set_skb_tso_segs(skb, mss_now);
 		tso_segs = tcp_skb_pcount(skb);
 	}
@@ -2045,6 +2048,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	int copy, len;
 	int mss_now;
 	int interval;
+	int err;
 
 	/* Not currently probing/verifying,
 	 * not in recovery,
@@ -2151,7 +2155,9 @@ static int tcp_mtu_probe(struct sock *sk)
 		if (len >= probe_size)
 			break;
 	}
-	tcp_init_tso_segs(nskb, nskb->len);
+	err = tcp_init_tso_segs(nskb, nskb->len);
+	if (unlikely(err < 0))
+		return err;
 
 	/* We're ready to send.  If this fails, the probe will
 	 * be resegmented into mss-sized pieces by tcp_write_xmit().
@@ -2309,6 +2315,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 
 		tso_segs = tcp_init_tso_segs(skb, mss_now);
 		BUG_ON(!tso_segs);
+		if (unlikely(tso_segs < 0))
+			break;
 
 		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
 			/* "skb_mstamp" is used as a start point for the retransmit timer */
-- 
1.8.3.1

