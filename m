Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELurYMX6yvTSdlQu+Y7mtAxtW7TNCiCDYXMa/D6DcHC5AorifyVLrcGGjmvFSJhWO25+CBv3
ARC-Seal: i=1; a=rsa-sha256; t=1521800316; cv=none;
        d=google.com; s=arc-20160816;
        b=vg0L4VMSXNN9BkQkWhtnLxMRHyqpdqi9APa7KlZonx04KvgIffLoiiO+GhHg/Gx4zf
         qM2sHtTmNGJ1trGmOnI6+oDKKWNW4dwuviq15HLEPr2pmP4Bcwo+Mo04aegGT4TSW9MT
         j0VBlLGbAFaP1v04PiS/9quLjmR7z/F4fgijA2peX/tUEASvLe604JJPCOT90NocILZP
         xwiICSfEK0zjX4YLmF7kFWI7AZe7MSOrg2VFMr+oqIinq0ydj48Hsp8WCd19gWQVJScY
         pVUd6bomHkHe7vnHfR9Tw8wvSnSvlKXObXJJ3umJkAfgAAj206ZtTAMBd8GDFUutnqz/
         VEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q4xYuh0Sz/WmaD7zfkItrgmvLcEmTObKnBpGn49Dmuc=;
        b=04LwxiCQJfyo1FFjd5xVvf0ff+oEKIdggdiAZe2L06vQ7NoAOKklIUocCQ5/0HH5cb
         nVACYaEX2MPf0LH+EQ7Qg/bIdiI/Sd5T08m1cvWwXyjOFFlHY1irtwEIR9P/4V4eXzWu
         mWgycX6pDnEe/CUBT4DewCwK4lW58MLuIEWJ1j6AAHs0dXyc0hoLktkp0xZrx3cO0rKd
         2yXr/H+LgNF3DzTnMdomGF01EqSV1rnnF+5m+FPOOfBjJDCGAouCXvh2U774ZaK6USsk
         ZJdEIGiKTaOBPl7wyRUdHKSBYqzR800Fjpr6q56heoPoCpyZU2M/0lpyP9kEWUaAG1XB
         nPrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/47] ath: Fix updating radar flags for coutry code India
Date: Fri, 23 Mar 2018 10:55:02 +0100
Message-Id: <20180323094248.604803239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722475232914260?=
X-GMAIL-MSGID: =?utf-8?q?1595723288494518335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit c0c345d4cacc6a1f39d4856f37dcf6e34f51a5e4 ]

As per latest regulatory update for India, channel 52, 56, 60, 64
is no longer restricted to DFS. Enabling DFS/no infra flags in driver
results in applying all DFS related restrictions (like doing CAC etc
before this channel moves to 'available state') for these channels
even though the country code is programmed as 'India' in he hardware,
fix this by relaxing the frequency range while applying RADAR flags
only if the country code is programmed to India. If the frequency range
needs to modified based on different country code, ath_is_radar_freq
can be extended/modified dynamically.

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/regd.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -254,8 +254,12 @@ bool ath_is_49ghz_allowed(u16 regdomain)
 EXPORT_SYMBOL(ath_is_49ghz_allowed);
 
 /* Frequency is one where radar detection is required */
-static bool ath_is_radar_freq(u16 center_freq)
+static bool ath_is_radar_freq(u16 center_freq,
+			      struct ath_regulatory *reg)
+
 {
+	if (reg->country_code == CTRY_INDIA)
+		return (center_freq >= 5500 && center_freq <= 5700);
 	return (center_freq >= 5260 && center_freq <= 5700);
 }
 
@@ -306,7 +310,7 @@ __ath_reg_apply_beaconing_flags(struct w
 				enum nl80211_reg_initiator initiator,
 				struct ieee80211_channel *ch)
 {
-	if (ath_is_radar_freq(ch->center_freq) ||
+	if (ath_is_radar_freq(ch->center_freq, reg) ||
 	    (ch->flags & IEEE80211_CHAN_RADAR))
 		return;
 
@@ -395,8 +399,9 @@ ath_reg_apply_ir_flags(struct wiphy *wip
 	}
 }
 
-/* Always apply Radar/DFS rules on freq range 5260 MHz - 5700 MHz */
-static void ath_reg_apply_radar_flags(struct wiphy *wiphy)
+/* Always apply Radar/DFS rules on freq range 5500 MHz - 5700 MHz */
+static void ath_reg_apply_radar_flags(struct wiphy *wiphy,
+				      struct ath_regulatory *reg)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_channel *ch;
@@ -409,7 +414,7 @@ static void ath_reg_apply_radar_flags(st
 
 	for (i = 0; i < sband->n_channels; i++) {
 		ch = &sband->channels[i];
-		if (!ath_is_radar_freq(ch->center_freq))
+		if (!ath_is_radar_freq(ch->center_freq, reg))
 			continue;
 		/* We always enable radar detection/DFS on this
 		 * frequency range. Additionally we also apply on
@@ -505,7 +510,7 @@ void ath_reg_notifier_apply(struct wiphy
 	struct ath_common *common = container_of(reg, struct ath_common,
 						 regulatory);
 	/* We always apply this */
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
 
 	/*
 	 * This would happen when we have sent a custom regulatory request
@@ -653,7 +658,7 @@ ath_regd_init_wiphy(struct ath_regulator
 	}
 
 	wiphy_apply_custom_regulatory(wiphy, regd);
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
 	ath_reg_apply_world_flags(wiphy, NL80211_REGDOM_SET_BY_DRIVER, reg);
 	return 0;
 }
