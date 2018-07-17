Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065ADECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGQNbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:31:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731423AbeGQNbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:31:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92956B3D15723;
        Tue, 17 Jul 2018 20:59:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.382.0; Tue, 17 Jul 2018
 20:58:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sched: Using NULL instead of plain integer
Date:   Tue, 17 Jul 2018 20:58:14 +0800
Message-ID: <20180717125814.13792-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

net/sched/cls_api.c:1101:43: warning: Using plain integer as NULL pointer
net/sched/cls_api.c:1492:75: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/sched/cls_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index c51b1b1..623fe2c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1098,7 +1098,7 @@ static void tfilter_notify_chain(struct net *net, struct sk_buff *oskb,
 	for (tp = rtnl_dereference(chain->filter_chain);
 	     tp; tp = rtnl_dereference(tp->next))
 		tfilter_notify(net, oskb, n, tp, block,
-			       q, parent, 0, event, false);
+			       q, parent, NULL, event, false);
 }
 
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
@@ -1489,7 +1489,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 			memset(&cb->args[1], 0,
 			       sizeof(cb->args) - sizeof(cb->args[0]));
 		if (cb->args[1] == 0) {
-			if (tcf_fill_node(net, skb, tp, block, q, parent, 0,
+			if (tcf_fill_node(net, skb, tp, block, q, parent, NULL,
 					  NETLINK_CB(cb->skb).portid,
 					  cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					  RTM_NEWTFILTER) <= 0)
-- 
2.7.0


