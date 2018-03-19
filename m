Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWdCdMGy3dhZGAKmSZpCxbZr/tfyNV2IsXKPgXm4AnLSdnvgh7IJAf/2tB2WRhro2LW8aS
ARC-Seal: i=1; a=rsa-sha256; t=1521483900; cv=none;
        d=google.com; s=arc-20160816;
        b=Uyh12CorTcA8IlaBxpBqX6wyT4u907VUYhwtxPmyVlcKm41zQUQPC4V7bVm9peXHw8
         f+Uho+TEfPapKzXWV3Ij5xr3p128hKUZ+BPDfK7/nzZ5walEdg9P4h6prXnBKPygmxuP
         YHZvo7vX51hywxMmX/EGFcpV2Gq6oVo9rjvGIHgs0+Nb3DQ9hbCNnDosWuJN1219rQ4n
         3sbocwRNAZddAIg4jc7YvNoOwrIOxvwKid8oRl5rWuswtYW51LDA41/ldDIOSt5HbmqA
         8z5bnhs9dcFYWgaNWnH2OVtyWpXQOowCiYvGXmE4HjrMh8ARwUQ9UmUkPUPTAVH7RFLR
         trRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xM5QaWEK+6CuKtfAO1tHklt4/z8Foo1EufC6fSGh0Xw=;
        b=J816rX9Jf251CwROpm60iSxWecGkZwvIQjayo5iRQpqg5vw4/tVrgsYenuwJAfnvyT
         lgO1VDZH9Tm9KqxHriBVkGZeR7dEDWzU2RDhhaKIOS5+6tahjbMy1LsM1xig+71EaZjl
         LzqHqNZph9qoIZeGO3DKZru9CIpIr/5GFnqnVe5gJgUw56waFUgzaegTxJgzDA4+09vU
         aBzYDWota3eNfLS+68a95FM44kCl+fLsO1FfiGTtETEj20UQyeRBNsPYuaC89AIsjDzx
         3PrEPok9TebR9Zwbw1DImKZRPuT3mIxeRVQ0we9Ewwd1Ox1eAbocbagD2JakwNqdfJ1B
         tzVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 158/241] mac80211_hwsim: use per-interface power level
Date: Mon, 19 Mar 2018 19:07:03 +0100
Message-Id: <20180319180757.708132844@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391502047672023?=
X-GMAIL-MSGID: =?utf-8?q?1595391502047672023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 1d5e9f80ab021e3e1f9436627a4ad07a143ccb2c ]

When channel contexts are used, there's no global power level
(the power_level is always 0). Use the per-interface TX power
in mac80211_hwsim to have a proper setting for both cases.

This fixes the bgscan_simple and bgscan_learn test cases when
the number of channels advertised by hwsim is >1 by default.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -552,8 +552,6 @@ struct mac80211_hwsim_data {
 	/* wmediumd portid responsible for netgroup of this radio */
 	u32 wmediumd;
 
-	int power_level;
-
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
 	s64 bcn_delta;
@@ -1208,7 +1206,9 @@ static bool mac80211_hwsim_tx_frame_no_n
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
 		rx_status.flag |= RX_FLAG_SHORT_GI;
 	/* TODO: simulate real signal strength (and optional packet loss) */
-	rx_status.signal = data->power_level - 50;
+	rx_status.signal = -50;
+	if (info->control.vif)
+		rx_status.signal += info->control.vif->bss_conf.txpower;
 
 	if (data->ps != PS_DISABLED)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -1607,7 +1607,6 @@ static int mac80211_hwsim_config(struct
 
 	WARN_ON(data->channel && data->use_chanctx);
 
-	data->power_level = conf->power_level;
 	if (!data->started || !data->beacon_int)
 		tasklet_hrtimer_cancel(&data->beacon_timer);
 	else if (!hrtimer_is_queued(&data->beacon_timer.timer)) {
@@ -2212,7 +2211,6 @@ static const char mac80211_hwsim_gstring
 	"d_tx_failed",
 	"d_ps_mode",
 	"d_group",
-	"d_tx_power",
 };
 
 #define MAC80211_HWSIM_SSTATS_LEN ARRAY_SIZE(mac80211_hwsim_gstrings_stats)
@@ -2249,7 +2247,6 @@ static void mac80211_hwsim_get_et_stats(
 	data[i++] = ar->tx_failed;
 	data[i++] = ar->ps;
 	data[i++] = ar->group;
-	data[i++] = ar->power_level;
 
 	WARN_ON(i != MAC80211_HWSIM_SSTATS_LEN);
 }
