Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226sydqYIchw3GfkAw/x64XRDBhlPhFz53JCfC3V5oL/K8N05HovLlo62l0Psx89XToN+jvy
ARC-Seal: i=1; a=rsa-sha256; t=1517591457; cv=none;
        d=google.com; s=arc-20160816;
        b=XY7az5EumwyWQQnP9HiFEB//fDjFpr/B68rn0MBhsO8STbJeyXhTXSuqhdKqr+Ci+k
         L/Q/g6VHwQ6x//smzhGP1Rzdf/wiAhDZLrZwWnsoNaC0huzSrTVcOt1hCsI4G/ShPaKc
         KIHWPYn93HeiHnUwjOdbdf6b3bmRpsnDqGOT9RE2AUCjo1m+xRS+oUtNTZeFk7pthEKv
         GadiXk8EuEqrF7Fn+2X4K1W/9Zhbttm4kIhskoVRknptj8vHejy3mMnCLN2Q5rMHgK4X
         YbqC8SXxIj0qtFEKHbPLT2UtQ2VxuSkZDerwGjHZWVHvFOEiTkf6aWW34cLo/KerzdHf
         qPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o/gsRs7EL/RccI5TFyDvKteSVu2xtYVZxydDk3br7tE=;
        b=B9iAQFnThNMg35yox3Ohm7gbz8GeUVorAglezUwNK0TiJVDl4P6y9OPaXjDxqBJjbH
         9NvBpr1+mai8i/jj0gkw3E6b1rBc1Dgi0mYzVFYEFJ10i7G3FD80oAAmAxpqS9/ZpA+/
         5jEImj+aMuj9xk/V4acE2VYJ3URj6CBLuWGhszx9nJRtGp5/BIrqrHX1iXLb1WlyBr8S
         DDC8qung3zp77H5SA+L2kQDKL8ylcU96HakHyzMUN8IHJCH/D8kg46g1j2CxjhuwSOlo
         pk6ec1bqrWtrsBGBxhKKZYeKwGDmG+YsBXQdtBHslf1zWxL4yvDih6dfw1gmOnTiVsT6
         iDsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 069/156] mac80211: use QoS NDP for AP probing
Date: Fri,  2 Feb 2018 17:57:30 +0100
Message-Id: <20180202140843.413258202@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309979556514778?=
X-GMAIL-MSGID: =?utf-8?q?1591309979556514778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 7b6ddeaf27eca72795ceeae2f0f347db1b5f9a30 ]

When connected to a QoS/WMM AP, mac80211 should use a QoS NDP
for probing it, instead of a regular non-QoS one, fix this.

Change all the drivers to *not* allow QoS NDP for now, even
though it looks like most of them should be OK with that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath9k/channel.c |    2 +-
 drivers/net/wireless/st/cw1200/sta.c     |    4 ++--
 drivers/net/wireless/ti/wl1251/main.c    |    2 +-
 drivers/net/wireless/ti/wlcore/cmd.c     |    5 +++--
 include/net/mac80211.h                   |    8 +++++++-
 net/mac80211/mlme.c                      |    2 +-
 net/mac80211/tx.c                        |   29 +++++++++++++++++++++++++++--
 7 files changed, 42 insertions(+), 10 deletions(-)

--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1112,7 +1112,7 @@ ath_chanctx_send_vif_ps_frame(struct ath
 		if (!avp->assoc)
 			return false;
 
-		skb = ieee80211_nullfunc_get(sc->hw, vif);
+		skb = ieee80211_nullfunc_get(sc->hw, vif, false);
 		if (!skb)
 			return false;
 
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -198,7 +198,7 @@ void __cw1200_cqm_bssloss_sm(struct cw12
 
 		priv->bss_loss_state++;
 
-		skb = ieee80211_nullfunc_get(priv->hw, priv->vif);
+		skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
 		WARN_ON(!skb);
 		if (skb)
 			cw1200_tx(priv->hw, NULL, skb);
@@ -2266,7 +2266,7 @@ static int cw1200_upload_null(struct cw1
 		.rate = 0xFF,
 	};
 
-	frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif);
+	frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
 	if (!frame.skb)
 		return -ENOMEM;
 
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -566,7 +566,7 @@ static int wl1251_build_null_data(struct
 		size = sizeof(struct wl12xx_null_data_template);
 		ptr = NULL;
 	} else {
-		skb = ieee80211_nullfunc_get(wl->hw, wl->vif);
+		skb = ieee80211_nullfunc_get(wl->hw, wl->vif, false);
 		if (!skb)
 			goto out;
 		size = skb->len;
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1069,7 +1069,8 @@ int wl12xx_cmd_build_null_data(struct wl
 		ptr = NULL;
 	} else {
 		skb = ieee80211_nullfunc_get(wl->hw,
-					     wl12xx_wlvif_to_vif(wlvif));
+					     wl12xx_wlvif_to_vif(wlvif),
+					     false);
 		if (!skb)
 			goto out;
 		size = skb->len;
@@ -1096,7 +1097,7 @@ int wl12xx_cmd_build_klv_null_data(struc
 	struct sk_buff *skb = NULL;
 	int ret = -ENOMEM;
 
-	skb = ieee80211_nullfunc_get(wl->hw, vif);
+	skb = ieee80211_nullfunc_get(wl->hw, vif, false);
 	if (!skb)
 		goto out;
 
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4470,18 +4470,24 @@ struct sk_buff *ieee80211_pspoll_get(str
  * ieee80211_nullfunc_get - retrieve a nullfunc template
  * @hw: pointer obtained from ieee80211_alloc_hw().
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @qos_ok: QoS NDP is acceptable to the caller, this should be set
+ *	if at all possible
  *
  * Creates a Nullfunc template which can, for example, uploaded to
  * hardware. The template must be updated after association so that correct
  * BSSID and address is used.
  *
+ * If @qos_ndp is set and the association is to an AP with QoS/WMM, the
+ * returned packet will be QoS NDP.
+ *
  * Note: Caller (or hardware) is responsible for setting the
  * &IEEE80211_FCTL_PM bit as well as Duration and Sequence Control fields.
  *
  * Return: The nullfunc template. %NULL on error.
  */
 struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif);
+				       struct ieee80211_vif *vif,
+				       bool qos_ok);
 
 /**
  * ieee80211_probereq_get - retrieve a Probe Request template
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -908,7 +908,7 @@ void ieee80211_send_nullfunc(struct ieee
 	struct ieee80211_hdr_3addr *nullfunc;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	skb = ieee80211_nullfunc_get(&local->hw, &sdata->vif);
+	skb = ieee80211_nullfunc_get(&local->hw, &sdata->vif, true);
 	if (!skb)
 		return;
 
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4404,13 +4404,15 @@ struct sk_buff *ieee80211_pspoll_get(str
 EXPORT_SYMBOL(ieee80211_pspoll_get);
 
 struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif)
+				       struct ieee80211_vif *vif,
+				       bool qos_ok)
 {
 	struct ieee80211_hdr_3addr *nullfunc;
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_if_managed *ifmgd;
 	struct ieee80211_local *local;
 	struct sk_buff *skb;
+	bool qos = false;
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return NULL;
@@ -4419,7 +4421,17 @@ struct sk_buff *ieee80211_nullfunc_get(s
 	ifmgd = &sdata->u.mgd;
 	local = sdata->local;
 
-	skb = dev_alloc_skb(local->hw.extra_tx_headroom + sizeof(*nullfunc));
+	if (qos_ok) {
+		struct sta_info *sta;
+
+		rcu_read_lock();
+		sta = sta_info_get(sdata, ifmgd->bssid);
+		qos = sta && sta->sta.wme;
+		rcu_read_unlock();
+	}
+
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
+			    sizeof(*nullfunc) + 2);
 	if (!skb)
 		return NULL;
 
@@ -4429,6 +4441,19 @@ struct sk_buff *ieee80211_nullfunc_get(s
 	nullfunc->frame_control = cpu_to_le16(IEEE80211_FTYPE_DATA |
 					      IEEE80211_STYPE_NULLFUNC |
 					      IEEE80211_FCTL_TODS);
+	if (qos) {
+		__le16 qos = cpu_to_le16(7);
+
+		BUILD_BUG_ON((IEEE80211_STYPE_QOS_NULLFUNC |
+			      IEEE80211_STYPE_NULLFUNC) !=
+			     IEEE80211_STYPE_QOS_NULLFUNC);
+		nullfunc->frame_control |=
+			cpu_to_le16(IEEE80211_STYPE_QOS_NULLFUNC);
+		skb->priority = 7;
+		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
+		skb_put_data(skb, &qos, sizeof(qos));
+	}
+
 	memcpy(nullfunc->addr1, ifmgd->bssid, ETH_ALEN);
 	memcpy(nullfunc->addr2, vif->addr, ETH_ALEN);
 	memcpy(nullfunc->addr3, ifmgd->bssid, ETH_ALEN);
