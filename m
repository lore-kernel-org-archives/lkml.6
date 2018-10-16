Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F916C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30CF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IczcbV7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30CF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeJPMCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeJPMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E35021471;
        Tue, 16 Oct 2018 04:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663252;
        bh=fO/z6IaOYlZ6Zub8JFUUqIR6e2MjUL4nACMyJ8HxZPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IczcbV7Cg3aW3XdAJh3gU0QngI65i74yoGAt1VVYmu/G+EENC5X1h40FPf2WqFHmE
         XtPgslmgNeqBmMPfI6OPcTVpmGbMMk/XcT9egGC99ZXt/bf1Stw0+v+PIEkFuD+XKM
         5YbcBTlhBYX7AdK5n+eoeGE6fFcLM+8lssYB/rk8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 08/61] cfg80211: Address some corner cases in scan result channel updating
Date:   Tue, 16 Oct 2018 00:13:10 -0400
Message-Id: <20181016041403.135678-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Malinen <jouni@codeaurora.org>

[ Upstream commit 119f94a6fefcc76d47075b83d2b73d04c895df78 ]

cfg80211_get_bss_channel() is used to update the RX channel based on the
available frame payload information (channel number from DSSS Parameter
Set element or HT Operation element). This is needed on 2.4 GHz channels
where frames may be received on neighboring channels due to overlapping
frequency range.

This might of some use on the 5 GHz band in some corner cases, but
things are more complex there since there is no n:1 or 1:n mapping
between channel numbers and frequencies due to multiple different
starting frequencies in different operating classes. This could result
in ieee80211_channel_to_frequency() returning incorrect frequency and
ieee80211_get_channel() returning incorrect channel information (or
indication of no match). In the previous implementation, this could
result in some scan results being dropped completely, e.g., for the 4.9
GHz channels. That prevented connection to such BSSs.

Fix this by using the driver-provided channel pointer if
ieee80211_get_channel() does not find matching channel data for the
channel number in the frame payload and if the scan is done with 5 MHz
or 10 MHz channel bandwidth. While doing this, also add comments
describing what the function is trying to achieve to make it easier to
understand what happens here and why.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 58 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f6c5fe482506..5ed0ed0559dc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1055,13 +1055,23 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	return NULL;
 }
 
+/*
+ * Update RX channel information based on the available frame payload
+ * information. This is mainly for the 2.4 GHz band where frames can be received
+ * from neighboring channels and the Beacon frames use the DSSS Parameter Set
+ * element to indicate the current (transmitting) channel, but this might also
+ * be needed on other bands if RX frequency does not match with the actual
+ * operating channel of a BSS.
+ */
 static struct ieee80211_channel *
 cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
-			 struct ieee80211_channel *channel)
+			 struct ieee80211_channel *channel,
+			 enum nl80211_bss_scan_width scan_width)
 {
 	const u8 *tmp;
 	u32 freq;
 	int channel_number = -1;
+	struct ieee80211_channel *alt_channel;
 
 	tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
 	if (tmp && tmp[1] == 1) {
@@ -1075,16 +1085,45 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 		}
 	}
 
-	if (channel_number < 0)
+	if (channel_number < 0) {
+		/* No channel information in frame payload */
 		return channel;
+	}
 
 	freq = ieee80211_channel_to_frequency(channel_number, channel->band);
-	channel = ieee80211_get_channel(wiphy, freq);
-	if (!channel)
-		return NULL;
-	if (channel->flags & IEEE80211_CHAN_DISABLED)
+	alt_channel = ieee80211_get_channel(wiphy, freq);
+	if (!alt_channel) {
+		if (channel->band == NL80211_BAND_2GHZ) {
+			/*
+			 * Better not allow unexpected channels when that could
+			 * be going beyond the 1-11 range (e.g., discovering
+			 * BSS on channel 12 when radio is configured for
+			 * channel 11.
+			 */
+			return NULL;
+		}
+
+		/* No match for the payload channel number - ignore it */
+		return channel;
+	}
+
+	if (scan_width == NL80211_BSS_CHAN_WIDTH_10 ||
+	    scan_width == NL80211_BSS_CHAN_WIDTH_5) {
+		/*
+		 * Ignore channel number in 5 and 10 MHz channels where there
+		 * may not be an n:1 or 1:n mapping between frequencies and
+		 * channel numbers.
+		 */
+		return channel;
+	}
+
+	/*
+	 * Use the channel determined through the payload channel number
+	 * instead of the RX channel reported by the driver.
+	 */
+	if (alt_channel->flags & IEEE80211_CHAN_DISABLED)
 		return NULL;
-	return channel;
+	return alt_channel;
 }
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
@@ -1109,7 +1148,8 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 		    (data->signal < 0 || data->signal > 100)))
 		return NULL;
 
-	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan);
+	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan,
+					   data->scan_width);
 	if (!channel)
 		return NULL;
 
@@ -1207,7 +1247,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		return NULL;
 
 	channel = cfg80211_get_bss_channel(wiphy, mgmt->u.beacon.variable,
-					   ielen, data->chan);
+					   ielen, data->chan, data->scan_width);
 	if (!channel)
 		return NULL;
 
-- 
2.17.1

