Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1379DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1AB2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1AB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbeGTNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbeGTNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:01 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26291BC8;
        Fri, 20 Jul 2018 12:26:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 24/29] net_sched: blackhole: tell upper qdisc about dropped packets
Date:   Fri, 20 Jul 2018 14:11:19 +0200
Message-Id: <20180720115159.846940481@linuxfoundation.org>
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

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 7e85dc8cb35abf16455f1511f0670b57c1a84608 ]

When blackhole is used on top of classful qdisc like hfsc it breaks
qlen and backlog counters because packets are disappear without notice.

In HFSC non-zero qlen while all classes are inactive triggers warning:
WARNING: ... at net/sched/sch_hfsc.c:1393 hfsc_dequeue+0xba4/0xe90 [sch_hfsc]
and schedules watchdog work endlessly.

This patch return __NET_XMIT_BYPASS in addition to NET_XMIT_SUCCESS,
this flag tells upper layer: this packet is gone and isn't queued.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_blackhole.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_blackhole.c
+++ b/net/sched/sch_blackhole.c
@@ -20,7 +20,7 @@
 static int blackhole_enqueue(struct sk_buff *skb, struct Qdisc *sch)
 {
 	qdisc_drop(skb, sch);
-	return NET_XMIT_SUCCESS;
+	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 }
 
 static struct sk_buff *blackhole_dequeue(struct Qdisc *sch)


