Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C616C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFC120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFC120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeGYPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:20:13 -0400
Received: from gateway20.websitewelcome.com ([192.185.55.25]:30525 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbeGYPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:20:12 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3A509400D4CFD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 09:08:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id iKRrf0XoAbXuJiKSOf77Fs; Wed, 25 Jul 2018 09:08:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.68] (port=39364 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fiKRq-0004yk-TO; Wed, 25 Jul 2018 09:07:26 -0500
Date:   Wed, 25 Jul 2018 09:07:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jiri Pirko <jiri@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: sched: cls_api: fix dead code in switch
Message-ID: <20180725140724.GA23053@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.102.68
X-Source-L: No
X-Exim-ID: 1fiKRq-0004yk-TO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.68]:39364
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code at line 1850 is unreachable. Fix this by removing the break
statement above it, so the code for case RTM_GETCHAIN can be
properly executed.

Addresses-Coverity-ID: 1472050 ("Structurally dead code")
Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/sched/cls_api.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 5f7098b..f3d78c2 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1846,7 +1846,6 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 		tcf_chain_put_explicitly_created(chain);
 		break;
 	case RTM_GETCHAIN:
-		break;
 		err = tc_chain_notify(chain, skb, n->nlmsg_seq,
 				      n->nlmsg_seq, n->nlmsg_type, true);
 		if (err < 0)
-- 
2.7.4

