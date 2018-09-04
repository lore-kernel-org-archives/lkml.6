Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D5C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2000B20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2000B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeIDRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:45:45 -0400
Received: from gateway20.websitewelcome.com ([192.185.49.40]:33128 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbeIDRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:45:45 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 6C847400D403D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 08:20:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xBFVfqSoMbXuJxBFpfAlox; Tue, 04 Sep 2018 08:20:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=39348 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fxBFU-002Miz-EJ; Tue, 04 Sep 2018 08:20:04 -0500
Date:   Tue, 4 Sep 2018 08:20:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mac80211: remove unnecessary NULL check
Message-ID: <20180904132001.GA31932@embeddedor.com>
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
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1fxBFU-002Miz-EJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:39348
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both old and new cannot be NULL at the same time, hence checking
new when old is not NULL is unnecessary.

Also, notice that new is being dereferenced before it is checked:
	
	idx = new->conf.keyidx;

The above triggers a static code analysis warning.

Address this by removing the NULL check on new and adding a code
comment based on the following piece of code:

387        /* caller must provide at least one old/new */
388        if (WARN_ON(!new && !old))
389                return 0;

Addresses-Coverity-ID: 1473176 ("Dereference before null check")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/mac80211/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index d6eeace..4700718 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -401,8 +401,9 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		 * pairwise keys.*/
 		ret = ieee80211_hw_key_replace(old, new, pairwise);
 	} else {
+		/* new must be provided in case old is not */
 		idx = new->conf.keyidx;
-		if (new && !new->local->wowlan)
+		if (!new->local->wowlan)
 			ret = ieee80211_key_enable_hw_accel(new);
 		else
 			ret = 0;
-- 
2.7.4

