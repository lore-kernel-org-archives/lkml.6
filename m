Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C979C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFCB21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOXajAGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFCB21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeJPMCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeJPMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E2121477;
        Tue, 16 Oct 2018 04:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663253;
        bh=wewJR5sNonhkjMqNCq65W8G27nOvAqwLvzL3VWgsGOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOXajAGC9HrRYnn80cMwqL99oCR5zIygkIgNAoDbXgIhSrFi9xHCp8Rs6HSBpuJxZ
         crTxQM1bPfxHGEHC6t71nyqKgspe82iQc4KgD0U2t8LCYSXoyMCwFp2N5mhMnH2N3W
         mBrJg6u70BZ4Y8lV77m6cfx6KEU2Dt/yqw1O8Ozg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 09/61] mac80211: TDLS: fix skb queue/priority assignment
Date:   Tue, 16 Oct 2018 00:13:11 -0400
Message-Id: <20181016041403.135678-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

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

