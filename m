Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C00C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80974218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762207;
	bh=n0kRVq9QpyAu7Slo0WmDiiedmmGXvLL0g6oW/x6ihuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IM3QFM+ubnh8lY9oTIdhHD40+n1KfvEwyFK10PspcQnxLgfR0PYo1f8/rmWque7Jp
	 8v7eOpfJ6gIGUysWswtJlw4lEnSfE+tR1NM6qcLQZEhOYCAlTs7k30qXvLbam7DXPu
	 lQH4m0lySlvV+0amND5hIY6qeZpYRy33SlYPKcYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfA2LnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbfA2LnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B0720856;
        Tue, 29 Jan 2019 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762203;
        bh=n0kRVq9QpyAu7Slo0WmDiiedmmGXvLL0g6oW/x6ihuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQu3wF39EKLR7cZXBw5FPUV9AYenZ2wyLOl1cEQcpXqD5AidUTGwtWX4Sg9LjL1Gv
         PO6KZc1TIQ+oQZe2ON95/x6tCLGC6KW8uiCLGduqKGs+3O6LcbZV5xnYMDCozlii74
         /2LBc3LSb6pkF+C8wH4G088s1Ij8mWbjqRvZOU6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Olsson <martin.olsson+netdev@sentorsecurity.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 008/103] net_sched: refetch skb protocol for each filter
Date:   Tue, 29 Jan 2019 12:34:45 +0100
Message-Id: <20190129113200.023547747@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 net/sched/cls_api.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -960,7 +960,6 @@ static int tcf_block_cb_call(struct tcf_
 int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		 struct tcf_result *res, bool compat_mode)
 {
-	__be16 protocol = tc_skb_protocol(skb);
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 4;
 	const struct tcf_proto *orig_tp = tp;
@@ -970,6 +969,7 @@ int tcf_classify(struct sk_buff *skb, co
 reclassify:
 #endif
 	for (; tp; tp = rcu_dereference_bh(tp->next)) {
+		__be16 protocol = tc_skb_protocol(skb);
 		int err;
 
 		if (tp->protocol != protocol &&
@@ -1002,7 +1002,6 @@ reset:
 	}
 
 	tp = first_tp;
-	protocol = tc_skb_protocol(skb);
 	goto reclassify;
 #endif
 }


