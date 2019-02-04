Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E084C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E5A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276812;
	bh=trmpcSe3OITfTjOziUZl9FKg1pDDftfXShC19q/KqVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMVumbZkR4lqKeRnbldj0MJTfW3k/yB6I+zvCwyYsqXQDIs34cNjRYcEIZUMEWCHz
	 W2h27kX9wq/lVRZnD8bbz2QGu16FUg5e3zoEsfHHQaZqzit+/q35nebRu1qQ+uZdjX
	 miGk9W+1Ml9h9YM8kDzb2W1R+4Ms6WdbTdPE3/+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfBDKkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfBDKkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D962070C;
        Mon,  4 Feb 2019 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276806;
        bh=trmpcSe3OITfTjOziUZl9FKg1pDDftfXShC19q/KqVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXKkTlFID/XBeNfx1L5TPenO6+U5VaLHl2v/blYw3KiOLOqwzAiFjQe8nVlJuSczS
         K6vrChoJbAmbNAe66ety2WLyFkl7okuzkux86z+rGoiiMPdZpVmysGF5VtuW3jkvsl
         BG6h12TESdy9wmve1aUwNdOoKQmNfqJVMKjK0jy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Olsson <martin.olsson+netdev@sentorsecurity.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/65] net_sched: refetch skb protocol for each filter
Date:   Mon,  4 Feb 2019 11:35:57 +0100
Message-Id: <20190204103611.317915261@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit cd0c4e70fc0ccfa705cdf55efb27519ce9337a26 ]

Martin reported a set of filters don't work after changing
from reclassify to continue. Looking into the code, it
looks like skb protocol is not always fetched for each
iteration of the filters. But, as demonstrated by Martin,
TC actions could modify skb->protocol, for example act_vlan,
this means we have to refetch skb protocol in each iteration,
rather than using the one we fetch in the beginning of the loop.

This bug is _not_ introduced by commit 3b3ae880266d
("net: sched: consolidate tc_classify{,_compat}"), technically,
if act_vlan is the only action that modifies skb protocol, then
it is commit c7e2b9689ef8 ("sched: introduce vlan action") which
introduced this bug.

Reported-by: Martin Olsson <martin.olsson+netdev@sentorsecurity.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_api.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1823,7 +1823,6 @@ done:
 int tc_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		struct tcf_result *res, bool compat_mode)
 {
-	__be16 protocol = tc_skb_protocol(skb);
 #ifdef CONFIG_NET_CLS_ACT
 	const struct tcf_proto *old_tp = tp;
 	int limit = 0;
@@ -1831,6 +1830,7 @@ int tc_classify(struct sk_buff *skb, con
 reclassify:
 #endif
 	for (; tp; tp = rcu_dereference_bh(tp->next)) {
+		__be16 protocol = tc_skb_protocol(skb);
 		int err;
 
 		if (tp->protocol != protocol &&
@@ -1857,7 +1857,6 @@ reset:
 	}
 
 	tp = old_tp;
-	protocol = tc_skb_protocol(skb);
 	goto reclassify;
 #endif
 }


