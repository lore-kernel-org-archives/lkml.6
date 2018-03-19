Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvMtCAy3AYSMklb0uBdXYdwEivLzkiuUId+YTPZkhcmVpfG44o2Dw3PvKHC+VeIv9zaL3Sb
ARC-Seal: i=1; a=rsa-sha256; t=1521483028; cv=none;
        d=google.com; s=arc-20160816;
        b=FwhoAm/lhnvG9MSz+tr5JzYkucEFAv+1IyTMK9UEX7Z8tHEzPrWYRq0dwdix8pnPQn
         KkYc7HR/oqtI3dqNwPvHg4fY1nJjSpxlj5nbbb1vQtiCESK3GFg49hVZzRMMTtZJDDcp
         SKEsfx9fxJOi0emvzQ6BSgDdAHkOmxscLjGh4SVSpeVCk9H4fIY6RxGuRQdufaxZM4bP
         pBgXTkaul5+BmL/USksV4LPumk+STpS8M7iuiim+GfesCqSOstkZkF5fBXUeMVFYeM0m
         LGGmfrorumQN3j/o2pqpCY8LAOiW7a49i35xz6n4tnL9qd8L3tD5N6FzVUzJe6qCSNTN
         h+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=23hvo6BKn1jT8316166ZFEYwU0XmdzIWxX/yt/nr3x4=;
        b=0XyAdAbjHMAho33+hLd0vRELfzUWA7L0A4/VjDug0fRoE74VHUeAyYdVowXwLaGd1t
         4tNEr6YUPK/CFwV1r8RkJUkWCKuI3BaWkSNk2aZis6VaTIE2r81Han3FnyMzi3zfwB6K
         uu7hqUmb+ziItSUfxKrMJ+bqLJCoHX/etmMXnbJM4+XKsXhK6WkhO8XXo+h12FRjWUVi
         1UMM4f/KIt1Ffb4+w+WUCUbRiLC1ywLir2Pay8aa10UyfDSTtWo7uG8IxhOWF1pZ2WaX
         IOOoFOKzGH4/pQUpez6ISdltAYgybaKk5bXok6tMXvLVBCpP7c4f0vWKhUd3z+fSUQ58
         OR/w==
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
Subject: [PATCH 3.18 09/68] ath10k: disallow DFS simulation if DFS channel is not enabled
Date: Mon, 19 Mar 2018 19:05:47 +0100
Message-Id: <20180319171829.253881556@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390588117891179?=
X-GMAIL-MSGID: =?utf-8?q?1595390588117891179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit ca07baab0b1e627ae1d4a55d190fb1c9d32a3445 ]

If DFS is not enabled in hostapd (ieee80211h=0) DFS channels shall
not be available for use even though the hardware may have the capability
to support DFS. With this configuration (DFS disabled in hostapd) trying to
bring up ath10k device in DFS channel for AP mode fails and trying to
simulate DFS in ath10k debugfs results in a warning in cfg80211 complaining
invalid channel and this should be avoided in the driver itself rather than
false propogating RADAR detection to mac80211/cfg80211. Fix this by
checking for the first vif 'is_started' state(should work for client mode
as well) as all the vifs shall be configured for the same channel

sys/kernel/debug/ieee80211/phy1/ath10k# echo 1 > dfs_simulate_radar

WARNING: at net/wireless/chan.c:265 cfg80211_radar_event+0x24/0x60
Workqueue: phy0 ieee80211_dfs_radar_detected_work [mac80211]
[<c022f2d4>] (warn_slowpath_null) from
[<bf72dab8>] (cfg80211_radar_event+0x24/0x60 [cfg80211])
[<bf72dab8>] (cfg80211_radar_event [cfg80211]) from
[<bf7813e0>] (ieee80211_dfs_radar_detected_work+0x94/0xa0 [mac80211])
[<bf7813e0>] (ieee80211_dfs_radar_detected_work [mac80211]) from
[<c0242320>] (process_one_work+0x20c/0x32c)

WARNING: at net/wireless/nl80211.c:2488 nl80211_get_mpath+0x13c/0x4cc
 Workqueue: phy0 ieee80211_dfs_radar_detected_work [mac80211]
[<c022f2d4>] (warn_slowpath_null) from
[<bf72dab8>] (cfg80211_radar_event+0x24/0x60 [cfg80211])
[<bf72dab8>] (cfg80211_radar_event [cfg80211]) from
[<bf7813e0>] (ieee80211_dfs_radar_detected_work+0x94/0xa0 [mac80211])
[<bf7813e0>] (ieee80211_dfs_radar_detected_work [mac80211]) from
[<c0242320>] (process_one_work+0x20c/0x32c)

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/debug.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1079,6 +1079,15 @@ static ssize_t ath10k_write_simulate_rad
 					   size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
+	struct ath10k_vif *arvif;
+
+	/* Just check for for the first vif alone, as all the vifs will be
+	 * sharing the same channel and if the channel is disabled, all the
+	 * vifs will share the same 'is_started' state.
+	 */
+	arvif = list_first_entry(&ar->arvifs, typeof(*arvif), list);
+	if (!arvif->is_started)
+		return -EINVAL;
 
 	ieee80211_radar_detected(ar->hw);
 
