Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD1DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2991A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2991A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeFRIYM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936039AbeFRIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BB77BAD;
        Mon, 18 Jun 2018 08:24:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 190/279] mac80211: Adjust SAE authentication timeout
Date:   Mon, 18 Jun 2018 10:12:55 +0200
Message-Id: <20180618080616.786646674@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -35,6 +35,7 @@
 #define IEEE80211_AUTH_TIMEOUT		(HZ / 5)
 #define IEEE80211_AUTH_TIMEOUT_LONG	(HZ / 2)
 #define IEEE80211_AUTH_TIMEOUT_SHORT	(HZ / 10)
+#define IEEE80211_AUTH_TIMEOUT_SAE	(HZ * 2)
 #define IEEE80211_AUTH_MAX_TRIES	3
 #define IEEE80211_AUTH_WAIT_ASSOC	(HZ * 5)
 #define IEEE80211_ASSOC_TIMEOUT		(HZ / 5)
@@ -3788,16 +3789,19 @@ static int ieee80211_auth(struct ieee802
 			    tx_flags);
 
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
 
@@ -3868,8 +3872,15 @@ void ieee80211_sta_work(struct ieee80211
 		ifmgd->status_received = false;
 		if (ifmgd->auth_data && ieee80211_is_auth(fc)) {
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


