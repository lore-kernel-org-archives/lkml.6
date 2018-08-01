Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ABC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C56020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C56020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeHAUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:09:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404416AbeHATDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F925FEA;
        Wed,  1 Aug 2018 16:59:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 087/336] qtnfmac: fix invalid STA state on EAPOL failure
Date:   Wed,  1 Aug 2018 18:47:02 +0200
Message-Id: <20180801165032.503020430@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit 480daa9cb62c14bbd1b87a01cd9bc10cc56dbf32 ]

Driver switches vif sta_state into QTNF_STA_CONNECTING when cfg80211
core initiates connect procedure. Further this state is changed either
to QTNF_STA_CONNECTED or to QTNF_STA_DISCONNECTED by BSS_JOIN and
BSS_LEAVE events from firmware. However it is possible that no such
events will be sent by firmware, e.g. if EAPOL timed out.

In this case vif sta_mode will remain in QTNF_STA_CONNECTING state and
all subsequent connection attempts will fail with -EBUSY error code.
Fix this by perfroming STA state transition from QTNF_STA_CONNECTING
to QTNF_STA_DISCONNECTED in cfg80211 disconnect callback.
No need to rely upon firmware events in this case.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |   21 ++++++++++++++-------
 drivers/net/wireless/quantenna/qtnfmac/event.c    |    8 +++-----
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -651,28 +651,35 @@ qtnf_disconnect(struct wiphy *wiphy, str
 {
 	struct qtnf_wmac *mac = wiphy_priv(wiphy);
 	struct qtnf_vif *vif;
-	int ret;
+	int ret = 0;
 
 	vif = qtnf_mac_get_base_vif(mac);
 	if (!vif) {
 		pr_err("MAC%u: primary VIF is not configured\n", mac->macid);
-		return -EFAULT;
+		ret = -EFAULT;
+		goto out;
 	}
 
-	if (vif->wdev.iftype != NL80211_IFTYPE_STATION)
-		return -EOPNOTSUPP;
+	if (vif->wdev.iftype != NL80211_IFTYPE_STATION) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (vif->sta_state == QTNF_STA_DISCONNECTED)
-		return 0;
+		goto out;
 
 	ret = qtnf_cmd_send_disconnect(vif, reason_code);
 	if (ret) {
 		pr_err("VIF%u.%u: failed to disconnect\n", mac->macid,
 		       vif->vifid);
-		return ret;
+		goto out;
 	}
 
-	return 0;
+out:
+	if (vif->sta_state == QTNF_STA_CONNECTING)
+		vif->sta_state = QTNF_STA_DISCONNECTED;
+
+	return ret;
 }
 
 static int
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -198,11 +198,9 @@ qtnf_event_handle_bss_leave(struct qtnf_
 		return -EPROTO;
 	}
 
-	if (vif->sta_state != QTNF_STA_CONNECTED) {
-		pr_err("VIF%u.%u: BSS_LEAVE event when STA is not connected\n",
-		       vif->mac->macid, vif->vifid);
-		return -EPROTO;
-	}
+	if (vif->sta_state != QTNF_STA_CONNECTED)
+		pr_warn("VIF%u.%u: BSS_LEAVE event when STA is not connected\n",
+			vif->mac->macid, vif->vifid);
 
 	pr_debug("VIF%u.%u: disconnected\n", vif->mac->macid, vif->vifid);
 


