Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +jPnNUtIGVtCRwAAmS7hNA
	; Thu, 07 Jun 2018 15:02:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8AAF9608C9; Thu,  7 Jun 2018 15:02:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 17283608BF;
	Thu,  7 Jun 2018 15:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17283608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964966AbeFGPCu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41457 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964940AbeFGPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:42 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbS-0005hJ-9Z; Thu, 07 Jun 2018 15:09:26 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003C1-Rq; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Neil Horman" <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.85784177@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 329/410] sch_netem: fix skb leak in netem_enqueue()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

commit 35d889d10b649fda66121891ec05eca88150059d upstream.

When we exceed current packets limit and we have more than one
segment in the list returned by skb_gso_segment(), netem drops
only the first one, skipping the rest, hence kmemleak reports:

unreferenced object 0xffff880b5d23b600 (size 1024):
  comm "softirq", pid 0, jiffies 4384527763 (age 2770.629s)
  hex dump (first 32 bytes):
    00 80 23 5d 0b 88 ff ff 00 00 00 00 00 00 00 00  ..#]............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d8a19b9d>] __alloc_skb+0xc9/0x520
    [<000000001709b32f>] skb_segment+0x8c8/0x3710
    [<00000000c7b9bb88>] tcp_gso_segment+0x331/0x1830
    [<00000000c921cba1>] inet_gso_segment+0x476/0x1370
    [<000000008b762dd4>] skb_mac_gso_segment+0x1f9/0x510
    [<000000002182660a>] __skb_gso_segment+0x1dd/0x620
    [<00000000412651b9>] netem_enqueue+0x1536/0x2590 [sch_netem]
    [<0000000005d3b2a9>] __dev_queue_xmit+0x1167/0x2120
    [<00000000fc5f7327>] ip_finish_output2+0x998/0xf00
    [<00000000d309e9d3>] ip_output+0x1aa/0x2c0
    [<000000007ecbd3a4>] tcp_transmit_skb+0x18db/0x3670
    [<0000000042d2a45f>] tcp_write_xmit+0x4d4/0x58c0
    [<0000000056a44199>] tcp_tasklet_func+0x3d9/0x540
    [<0000000013d06d02>] tasklet_action+0x1ca/0x250
    [<00000000fcde0b8b>] __do_softirq+0x1b4/0x5a3
    [<00000000e7ed027c>] irq_exit+0x1e2/0x210

Fix it by adding the rest of the segments, if any, to skb 'to_free'
list. Add new __qdisc_drop_all() and qdisc_drop_all() functions
because they can be useful in the future if we need to drop segmented
GSO packets in other places.

Fixes: 6071bd1aa13e ("netem: Segment GSO packets on enqueue")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - The reshape_fail operation still exists, so keep calling it here if the
   skb did not require segmentation
 - We don't have a to_free list, so free directly in qdisc_drop_all()
 - Open-code qdisc_qstats_drop()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -656,6 +656,14 @@ static inline int qdisc_drop(struct sk_b
 	return NET_XMIT_DROP;
 }
 
+static inline int qdisc_drop_all(struct sk_buff *skb, struct Qdisc *sch)
+{
+	kfree_skb_list(skb);
+	sch->qstats.drops++;
+
+	return NET_XMIT_DROP;
+}
+
 static inline int qdisc_reshape_fail(struct sk_buff *skb, struct Qdisc *sch)
 {
 	sch->qstats.drops++;
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -511,8 +511,12 @@ static int netem_enqueue(struct sk_buff
 			1<<(prandom_u32() % 8);
 	}
 
-	if (unlikely(skb_queue_len(&sch->q) >= sch->limit))
+	if (unlikely(skb_queue_len(&sch->q) >= sch->limit)) {
+		/* qdisc_reshape_fail() can't handle segmented skb */
+		if (segs)
+			return qdisc_drop_all(skb, sch);
 		return qdisc_reshape_fail(skb, sch);
+	}
 
 	sch->qstats.backlog += qdisc_pkt_len(skb);
 
