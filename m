Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5711820C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP/AgOiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5711820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeJIBtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbeJIBtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885762064A;
        Mon,  8 Oct 2018 18:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023796;
        bh=Yw81BTvmEy4fejksy2gfxFzeCBv73SjXQau32nM6yVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XP/AgOiuO3QO0da7BGX4QlFGzJuoPPbmHtlUb2t3dX2QMOtPBYaNbbLdYvzcor1mp
         T5xaE2MjV7bv38GjnQhMLEvcc8fvpU7Ty7XIH3YNO57obWn9K+UitVmQO3nIbW6DRS
         rGBmGpfNfotqT85PpulI9XERKmEtHJHXP/urBlq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 087/113] mac80211: Fix station bandwidth setting after channel switch
Date:   Mon,  8 Oct 2018 20:31:28 +0200
Message-Id: <20181008175536.124518511@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 0007e94355fdb71a1cf5dba0754155cba08f0666 ]

When performing a channel switch flow for a managed interface, the
flow did not update the bandwidth of the AP station and the rate
scale algorithm. In case of a channel width downgrade, this would
result with the rate scale algorithm using a bandwidth that does not
match the interface channel configuration.

Fix this by updating the AP station bandwidth and rate scaling algorithm
before the actual channel change in case of a bandwidth downgrade, or
after the actual channel change in case of a bandwidth upgrade.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mlme.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1021,6 +1021,10 @@ static void ieee80211_chswitch_work(stru
 	 */
 
 	if (sdata->reserved_chanctx) {
+		struct ieee80211_supported_band *sband = NULL;
+		struct sta_info *mgd_sta = NULL;
+		enum ieee80211_sta_rx_bandwidth bw = IEEE80211_STA_RX_BW_20;
+
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
@@ -1029,6 +1033,48 @@ static void ieee80211_chswitch_work(stru
 		if (sdata->reserved_ready)
 			goto out;
 
+		if (sdata->vif.bss_conf.chandef.width !=
+		    sdata->csa_chandef.width) {
+			/*
+			 * For managed interface, we need to also update the AP
+			 * station bandwidth and align the rate scale algorithm
+			 * on the bandwidth change. Here we only consider the
+			 * bandwidth of the new channel definition (as channel
+			 * switch flow does not have the full HT/VHT/HE
+			 * information), assuming that if additional changes are
+			 * required they would be done as part of the processing
+			 * of the next beacon from the AP.
+			 */
+			switch (sdata->csa_chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			default:
+				bw = IEEE80211_STA_RX_BW_20;
+				break;
+			case NL80211_CHAN_WIDTH_40:
+				bw = IEEE80211_STA_RX_BW_40;
+				break;
+			case NL80211_CHAN_WIDTH_80:
+				bw = IEEE80211_STA_RX_BW_80;
+				break;
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+				bw = IEEE80211_STA_RX_BW_160;
+				break;
+			}
+
+			mgd_sta = sta_info_get(sdata, ifmgd->bssid);
+			sband =
+				local->hw.wiphy->bands[sdata->csa_chandef.chan->band];
+		}
+
+		if (sdata->vif.bss_conf.chandef.width >
+		    sdata->csa_chandef.width) {
+			mgd_sta->sta.bandwidth = bw;
+			rate_control_rate_update(local, sband, mgd_sta,
+						 IEEE80211_RC_BW_CHANGED);
+		}
+
 		ret = ieee80211_vif_use_reserved_context(sdata);
 		if (ret) {
 			sdata_info(sdata,
@@ -1039,6 +1085,13 @@ static void ieee80211_chswitch_work(stru
 			goto out;
 		}
 
+		if (sdata->vif.bss_conf.chandef.width <
+		    sdata->csa_chandef.width) {
+			mgd_sta->sta.bandwidth = bw;
+			rate_control_rate_update(local, sband, mgd_sta,
+						 IEEE80211_RC_BW_CHANGED);
+		}
+
 		goto out;
 	}
 


