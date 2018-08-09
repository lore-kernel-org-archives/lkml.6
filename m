Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2545C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3D21EA0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B3D21EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeHISVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:21:23 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.130]:26321 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731957AbeHISVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:23 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E11D5152431
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 10:55:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nnHzf1vIUBcCXnnHzfbUTC; Thu, 09 Aug 2018 10:55:51 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.46] (port=51394 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnnHz-002E2T-8G; Thu, 09 Aug 2018 10:55:51 -0500
Date:   Thu, 9 Aug 2018 10:54:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tim Waugh <tim@cyberelk.net>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] block: paride: pd: mark expected switch fall-throughs
Message-ID: <20180809155446.GA19883@embeddedor.com>
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
X-Source-IP: 189.250.54.46
X-Source-L: No
X-Exim-ID: 1fnnHz-002E2T-8G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.46]:51394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1056543 ("Missing break in switch")
Addresses-Coverity-ID: 1056544 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/paride/pd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 8961b190..7cf9475 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -426,6 +426,7 @@ static void run_fsm(void)
 				pd_claimed = 1;
 				if (!pi_schedule_claimed(pi_current, run_fsm))
 					return;
+				/* fall through */
 			case 1:
 				pd_claimed = 2;
 				pi_current->proto->connect(pi_current);
@@ -445,6 +446,7 @@ static void run_fsm(void)
 				spin_unlock_irqrestore(&pd_lock, saved_flags);
 				if (stop)
 					return;
+				/* fall through */
 			case Hold:
 				schedule_fsm();
 				return;
-- 
2.7.4

