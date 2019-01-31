Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAC6C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0992081B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAaA1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:27:48 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.187]:33253 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfAaA1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:27:47 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 13ADF378F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:27:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p0CogmLAkiQerp0Cog4GiN; Wed, 30 Jan 2019 18:27:46 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=38472 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gp0Cn-001ewm-FP; Wed, 30 Jan 2019 18:27:45 -0600
Date:   Wed, 30 Jan 2019 18:27:44 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] cxgb4: smt: use struct_size() in kvzalloc()
Message-ID: <20190131002744.GA26706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gp0Cn-001ewm-FP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:38472
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is
finding the size of a structure that has a zero-sized array at
the end, along with memory for some number of elements for that
array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = kvzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kvzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/chelsio/cxgb4/smt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.c b/drivers/net/ethernet/chelsio/cxgb4/smt.c
index 7b2207a2a130..eaf1fb74689c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/smt.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/smt.c
@@ -47,8 +47,7 @@ struct smt_data *t4_init_smt(void)
 
 	smt_size = SMT_SIZE;
 
-	s = kvzalloc(sizeof(*s) + smt_size * sizeof(struct smt_entry),
-		     GFP_KERNEL);
+	s = kvzalloc(struct_size(s, smtab, smt_size), GFP_KERNEL);
 	if (!s)
 		return NULL;
 	s->smt_size = smt_size;
-- 
2.20.1

