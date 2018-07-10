Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E17BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2198A2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2198A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGJOtM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:49:12 -0400
Received: from gateway20.websitewelcome.com ([192.185.48.38]:16091 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933678AbeGJOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:49:07 -0400
X-Greylist: delayed 1678 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 10:49:07 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id F197C400CF49F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:54:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ct5WfNcq7bXuJct5lfWpBn; Tue, 10 Jul 2018 08:54:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58648 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fct5V-001nCg-6u; Tue, 10 Jul 2018 08:53:53 -0500
Date:   Tue, 10 Jul 2018 08:53:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vlad Buslov <vladbu@mellanox.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: sched: act_ife: fix memory leak
Message-ID: <20180710135347.GA15889@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fct5V-001nCg-6u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58648
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *p* are allocated, release them
before return.

Addresses-Coverity-ID: 1471714 ("Resource leak")
Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/sched/act_ife.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index a3eef00..3d6e265 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -485,8 +485,10 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 		return -ENOMEM;
 
 	err = tcf_idr_check_alloc(tn, &parm->index, a, bind);
-	if (err < 0)
+	if (err < 0) {
+		kfree(p);
 		return err;
+	}
 	exists = err;
 	if (exists && bind) {
 		kfree(p);
-- 
2.7.4

