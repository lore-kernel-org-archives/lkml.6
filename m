Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F52ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9620848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahsLVXqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C9620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeJYWu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbeJYWuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDE120854;
        Thu, 25 Oct 2018 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477078;
        bh=WZnz6fy8xCGt62k6Wuslo3Gc+EzZFVmx45+Y6xZeyVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahsLVXqbRGHNVI5f8CuE3uP7ubIQXB40z933cUypKoMFqcPIcoQZGdMMRB8WI6HYY
         ZjkK3HTzfExHzPcKz32a4JV2M+/gfUDHaUrnm71sxdat/V2mWt7elTk/CyfetA6cs7
         LKwbFukKGBpztVCnSLES/lEJY4AvZwyRcSgA9Bds=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     WANG Cong <xiyou.wangcong@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 31/65] sch_red: update backlog as well
Date:   Thu, 25 Oct 2018 10:16:31 -0400
Message-Id: <20181025141705.213937-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Cong <xiyou.wangcong@gmail.com>

[ Upstream commit d7f4f332f082c4d4ba53582f902ed6b44fd6f45e ]

Fixes: 2ccccf5fb43f ("net_sched: update hierarchical backlog too")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_red.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 0505b8408c8b..4bf2b599ef98 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -97,6 +97,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch)
 
 	ret = qdisc_enqueue(skb, child);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
+		qdisc_qstats_backlog_inc(sch, skb);
 		sch->q.qlen++;
 	} else if (net_xmit_drop_count(ret)) {
 		q->stats.pdrop++;
@@ -118,6 +119,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	skb = child->dequeue(child);
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
+		qdisc_qstats_backlog_dec(sch, skb);
 		sch->q.qlen--;
 	} else {
 		if (!red_is_idling(&q->vars))
@@ -143,6 +145,7 @@ static unsigned int red_drop(struct Qdisc *sch)
 	if (child->ops->drop && (len = child->ops->drop(child)) > 0) {
 		q->stats.other++;
 		qdisc_qstats_drop(sch);
+		sch->qstats.backlog -= len;
 		sch->q.qlen--;
 		return len;
 	}
@@ -158,6 +161,7 @@ static void red_reset(struct Qdisc *sch)
 	struct red_sched_data *q = qdisc_priv(sch);
 
 	qdisc_reset(q->qdisc);
+	sch->qstats.backlog = 0;
 	sch->q.qlen = 0;
 	red_restart(&q->vars);
 }
-- 
2.17.1

