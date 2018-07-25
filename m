Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9BAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC72820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeGYQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:34:37 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.142]:15695 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728559AbeGYQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:34:37 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D26862EF3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:22:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id iLcSf1GM7aSeyiLcSfbqf5; Wed, 25 Jul 2018 10:22:28 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.68] (port=41548 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fiLcS-000nok-45; Wed, 25 Jul 2018 10:22:28 -0500
Date:   Wed, 25 Jul 2018 10:22:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rds: send: Fix dead code in rds_sendmsg
Message-ID: <20180725152227.GA26303@embeddedor.com>
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
X-Exim-ID: 1fiLcS-000nok-45
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.68]:41548
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, code at label *out* is unreachable. Fix this by updating
variable *ret* with -EINVAL, so the jump to *out* can be properly
executed instead of directly returning from function.

Addresses-Coverity-ID: 1472059 ("Structurally dead code")
Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/rds/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 9604e1f..18e2b4d 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1126,7 +1126,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 				if (addr4 == htonl(INADDR_ANY) ||
 				    addr4 == htonl(INADDR_BROADCAST) ||
 				    IN_MULTICAST(ntohl(addr4))) {
-					return -EINVAL;
+					ret = -EINVAL;
 					goto out;
 				}
 			}
-- 
2.7.4

