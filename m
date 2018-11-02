Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C5C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974620837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrGkLru4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8974620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeKCD53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CBC2082D;
        Fri,  2 Nov 2018 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184554;
        bh=xCbiC9JEDOfHYPpr+cfqSyuYwsqZ66v2vPCeNJW8Rxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrGkLru4wuVG5TPO9XH8dp+Apkf0qgIeWlELDx7pADF73MvH9UUKoTgh7vQURqFuL
         r2ocn0payIepssKW3LTNOfdhK+7kwHdWqrJa7QbXpHRlppOmZMxYBN7Lv/6KG0a9xU
         yFQ5e3wvC/A8RQKEO+iIPIO/jr9yBwBSiCH4DNRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 009/143] mac80211: TDLS: fix skb queue/priority assignment
Date:   Fri,  2 Nov 2018 19:33:14 +0100
Message-Id: <20181102182857.821303427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cb59bc14e830028d2244861216df038165d7625d ]

If the TDLS setup happens over a connection to an AP that
doesn't have QoS, we nevertheless assign a non-zero TID
(skb->priority) and queue mapping, which may confuse us or
drivers later.

Fix it by just assigning the special skb->priority and then
using ieee80211_select_queue() just like other data frames
would go through.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tdls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 91093d4a2f84..6e7aa65cf345 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -16,6 +16,7 @@
 #include "ieee80211_i.h"
 #include "driver-ops.h"
 #include "rate.h"
+#include "wme.h"
 
 /* give usermode some time for retries in setting up the TDLS session */
 #define TDLS_PEER_SETUP_TIMEOUT	(15 * HZ)
@@ -1006,14 +1007,13 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 	switch (action_code) {
 	case WLAN_TDLS_SETUP_REQUEST:
 	case WLAN_TDLS_SETUP_RESPONSE:
-		skb_set_queue_mapping(skb, IEEE80211_AC_BK);
-		skb->priority = 2;
+		skb->priority = 256 + 2;
 		break;
 	default:
-		skb_set_queue_mapping(skb, IEEE80211_AC_VI);
-		skb->priority = 5;
+		skb->priority = 256 + 5;
 		break;
 	}
+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
 
 	/*
 	 * Set the WLAN_TDLS_TEARDOWN flag to indicate a teardown in progress.
-- 
2.17.1



