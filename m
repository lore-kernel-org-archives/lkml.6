Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5895BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C81027C40
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C81027C40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936807AbeF2SwR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:52:17 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.212]:27137 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934629AbeF2SwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:52:15 -0400
X-Greylist: delayed 1444 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2018 14:52:15 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 56D6816DE9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:28:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yy7tf6iMbRPojYy7tfiDwb; Fri, 29 Jun 2018 13:28:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=46382 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fYy7s-000jwk-QD; Fri, 29 Jun 2018 13:28:08 -0500
Date:   Fri, 29 Jun 2018 13:28:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Chas Williams <3chas3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] atm: zatm: Fix potential Spectre v1
Message-ID: <20180629182807.GA26287@embeddedor.com>
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
X-Exim-ID: 1fYy7s-000jwk-QD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:46382
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pool can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/atm/zatm.c:1491 zatm_ioctl() warn: potential spectre issue
'zatm_dev->pool_info' (local cap)

Fix this by sanitizing pool before using it to index
zatm_dev->pool_info

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/atm/zatm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index a8d2eb0..2c288d1 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1483,6 +1483,8 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned int cmd,void __user *arg)
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				if (copy_from_user(&info,
 				    &((struct zatm_pool_req __user *) arg)->info,
 				    sizeof(info))) return -EFAULT;
-- 
2.7.4

