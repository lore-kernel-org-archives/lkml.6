Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4170E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4170E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeIFOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:33:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45028 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:33:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxr3l-00074z-2D; Thu, 06 Sep 2018 09:58:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cfg80211: remove redundant check of !scan_plan
Date:   Thu,  6 Sep 2018 10:58:44 +0100
Message-Id: <20180906095844.17071-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for !scan_plan is redunant as this has been checked
in the proceeding statement and the code returns -ENOBUFS if
it is true. Remove the redundant check.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/wireless/nl80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d5f9b5235cdd..b4908bcb0d77 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10690,8 +10690,7 @@ static int nl80211_send_wowlan_nd(struct sk_buff *msg,
 		if (!scan_plan)
 			return -ENOBUFS;
 
-		if (!scan_plan ||
-		    nla_put_u32(msg, NL80211_SCHED_SCAN_PLAN_INTERVAL,
+		if (nla_put_u32(msg, NL80211_SCHED_SCAN_PLAN_INTERVAL,
 				req->scan_plans[i].interval) ||
 		    (req->scan_plans[i].iterations &&
 		     nla_put_u32(msg, NL80211_SCHED_SCAN_PLAN_ITERATIONS,
-- 
2.17.1

