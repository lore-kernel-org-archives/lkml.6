Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0871A20890
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0871A20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeGAQNi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:13:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeGAQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:13:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F16AB4A3;
        Sun,  1 Jul 2018 16:13:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 24/85] mac80211: Adjust SAE authentication timeout
Date:   Sun,  1 Jul 2018 18:01:42 +0200
Message-Id: <20180701153123.326973852@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 407879b690ba3a6bf29be896d02dad63463bd1c0 ]

The IEEE P802.11-REVmd D1.0 specification updated the SAE authentication
timeout to be 2000 milliseconds (see dot11RSNASAERetransPeriod). Update
the SAE timeout setting accordingly.

While at it, reduce some code duplication in the timeout configuration.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mlme.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -34,6 +34,7 @@
 #define IEEE80211_AUTH_TIMEOUT		(HZ / 5)
 #define IEEE80211_AUTH_TIMEOUT_LONG	(HZ / 2)
 #define IEEE80211_AUTH_TIMEOUT_SHORT	(HZ / 10)
+#define IEEE80211_AUTH_TIMEOUT_SAE	(HZ * 2)
 #define IEEE80211_AUTH_MAX_TRIES	3
 #define IEEE80211_AUTH_WAIT_ASSOC	(HZ * 5)
 #define IEEE80211_ASSOC_TIMEOUT		(HZ / 5)
@@ -3464,16 +3465,19 @@ static int ieee80211_probe_auth(struct i
 	}
 
 	if (tx_flags == 0) {
-		auth_data->timeout = jiffies + IEEE80211_AUTH_TIMEOUT;
-		auth_data->timeout_started = true;
-		run_again(sdata, auth_data->timeout);
+		if (auth_data->algorithm == WLAN_AUTH_SAE)
+			auth_data->timeout = jiffies +
+				IEEE80211_AUTH_TIMEOUT_SAE;
+		else
+			auth_data->timeout = jiffies + IEEE80211_AUTH_TIMEOUT;
 	} else {
 		auth_data->timeout =
 			round_jiffies_up(jiffies + IEEE80211_AUTH_TIMEOUT_LONG);
-		auth_data->timeout_started = true;
-		run_again(sdata, auth_data->timeout);
 	}
 
+	auth_data->timeout_started = true;
+	run_again(sdata, auth_data->timeout);
+
 	return 0;
 }
 
@@ -3545,8 +3549,15 @@ void ieee80211_sta_work(struct ieee80211
 		if (ifmgd->auth_data &&
 		    (ieee80211_is_probe_req(fc) || ieee80211_is_auth(fc))) {
 			if (status_acked) {
-				ifmgd->auth_data->timeout =
-					jiffies + IEEE80211_AUTH_TIMEOUT_SHORT;
+				if (ifmgd->auth_data->algorithm ==
+				    WLAN_AUTH_SAE)
+					ifmgd->auth_data->timeout =
+						jiffies +
+						IEEE80211_AUTH_TIMEOUT_SAE;
+				else
+					ifmgd->auth_data->timeout =
+						jiffies +
+						IEEE80211_AUTH_TIMEOUT_SHORT;
 				run_again(sdata, ifmgd->auth_data->timeout);
 			} else {
 				ifmgd->auth_data->timeout = jiffies - 1;


