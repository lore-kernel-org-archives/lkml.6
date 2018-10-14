Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB4FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E74204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E74204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeJNXSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:18:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36274 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbeJNXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:03 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cY-CJ; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000VF-Vz; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.77057313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 253/366] net_sched: fq: take care of throttled flows
 before reuse
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 7df40c2673a1307c3260aab6f9d4b9bf97ca8fd7 upstream.

Normally, a socket can not be freed/reused unless all its TX packets
left qdisc and were TX-completed. However connect(AF_UNSPEC) allows
this to happen.

With commit fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for
reused flows") we cleared f->time_next_packet but took no special
action if the flow was still in the throttled rb-tree.

Since f->time_next_packet is the key used in the rb-tree searches,
blindly clearing it might break rb-tree integrity. We need to make
sure the flow is no longer in the rb-tree to avoid this problem.

Fixes: fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for reused flows")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sched/sch_fq.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -124,6 +124,28 @@ static bool fq_flow_is_detached(const st
 	return f->next == &detached;
 }
 
+static bool fq_flow_is_throttled(const struct fq_flow *f)
+{
+	return f->next == &throttled;
+}
+
+static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
+{
+	if (head->first)
+		head->last->next = flow;
+	else
+		head->first = flow;
+	head->last = flow;
+	flow->next = NULL;
+}
+
+static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flow *f)
+{
+	rb_erase(&f->rate_node, &q->delayed);
+	q->throttled_flows--;
+	fq_flow_add_tail(&q->old_flows, f);
+}
+
 static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 {
 	struct rb_node **p = &q->delayed.rb_node, *parent = NULL;
@@ -151,15 +173,6 @@ static void fq_flow_set_throttled(struct
 
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
-static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
-{
-	if (head->first)
-		head->last->next = flow;
-	else
-		head->first = flow;
-	head->last = flow;
-	flow->next = NULL;
-}
 
 /* limit number of collected flows per round */
 #define FQ_GC_MAX 8
@@ -251,6 +264,8 @@ static struct fq_flow *fq_classify(struc
 				     f->socket_hash != sk->sk_hash)) {
 				f->credit = q->initial_quantum;
 				f->socket_hash = sk->sk_hash;
+				if (fq_flow_is_throttled(f))
+					fq_flow_unset_throttled(q, f);
 				f->time_next_packet = 0ULL;
 			}
 			return f;
@@ -407,9 +422,7 @@ static void fq_check_throttled(struct fq
 			q->time_next_delayed_flow = f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
 

