Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F1ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477E72147D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yXmakMs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477E72147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeKIHhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbeKIHhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9EB2146D;
        Thu,  8 Nov 2018 21:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714387;
        bh=fi3W9tAmpwQK2NTdmJgR5IUdKzn3Hw3RD4WPVxbNFQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXmakMs+W9p7t/5MMNyrZDqgQUw3CylHXQBPOquYGBdtBz7qDID5OZ1VmCME9wtks
         LzWyl7XE3IT6//LFwLtsTi+BnuyNvCiIdzPfINsYiMTK5i4D2fdemTmglb/ydb0JuA
         ZYIzCIynwIBatrkRYK2drHgEbM4lY5UK4RVmK78s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 049/114] sch_red: update backlog as well
Date:   Thu,  8 Nov 2018 13:51:04 -0800
Message-Id: <20181108215105.588416436@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



