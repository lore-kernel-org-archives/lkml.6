Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6514F2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfA2RF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:05:26 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.102]:45818 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728914AbfA2RF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:05:26 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B840226A83
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:05:25 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oWpBg0eSgYTGMoWpBghyB5; Tue, 29 Jan 2019 11:05:25 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42828 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1goWpA-003TjV-2d; Tue, 29 Jan 2019 11:05:25 -0600
Date:   Tue, 29 Jan 2019 11:05:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Arjun Vynipadath <arjun@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] cxgb4: cxgb4_tc_u32: use struct_size() in kvzalloc()
Message-ID: <20190129170523.GA29824@embeddedor>
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
X-Exim-ID: 1goWpA-003TjV-2d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:42828
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
index c7d2b4dc7568..02fc63fa7f25 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
@@ -444,8 +444,7 @@ struct cxgb4_tc_u32_table *cxgb4_init_tc_u32(struct adapter *adap)
 	if (!max_tids)
 		return NULL;
 
-	t = kvzalloc(sizeof(*t) +
-			 (max_tids * sizeof(struct cxgb4_link)), GFP_KERNEL);
+	t = kvzalloc(struct_size(t, table, max_tids), GFP_KERNEL);
 	if (!t)
 		return NULL;
 
-- 
2.20.1

