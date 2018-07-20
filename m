Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189F320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189F320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbeGTN3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389077AbeGTN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:15 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 569B9D28;
        Fri, 20 Jul 2018 12:36:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 029/101] net/sched: act_ife: preserve the action control in case of error
Date:   Fri, 20 Jul 2018 14:13:35 +0200
Message-Id: <20180720121424.203799275@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit cbf56c29624fa056a0c1c3d177e67aa51a7fd8d6 ]

in the following script

 # tc actions add action ife encode allow prio pass index 42
 # tc actions replace action ife encode allow tcindex drop index 42

the action control should remain equal to 'pass', if the kernel failed
to replace the TC action. Pospone the assignment of the action control,
to ensure it is not overwritten in the error path of tcf_ife_init().

Fixes: ef6980b6becb ("introduce IFE action")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -517,8 +517,6 @@ static int tcf_ife_init(struct net *net,
 			saddr = nla_data(tb[TCA_IFE_SMAC]);
 	}
 
-	ife->tcf_action = parm->action;
-
 	if (parm->flags & IFE_ENCODE) {
 		if (daddr)
 			ether_addr_copy(p->eth_dst, daddr);
@@ -575,6 +573,7 @@ metadata_parse_err:
 		}
 	}
 
+	ife->tcf_action = parm->action;
 	if (exists)
 		spin_unlock_bh(&ife->tcf_lock);
 


