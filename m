Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvOLwYX2c2aeLWzqeALHtquQjCpnHR9/Zkuf8Z0ceQcMnVB/F0gvlIK+x6dJ1qcODkXDAgR
ARC-Seal: i=1; a=rsa-sha256; t=1519981426; cv=none;
        d=google.com; s=arc-20160816;
        b=JaFal43oDfV/PfejjhcyiITrFe/uPV/Hk6LCgE6REts9l0AVgOrzmjQ2t68X7qL7YR
         L1bjhZ0JR+OlV0yHB13PhTZwE0V1USUsMsxo+as/mkPw8DU6KQOaJ+Q4qbLRqWHOkfcf
         zC++GEZpcpZNpQBYTjOy7D5zCHdodWZMQc8KkKqfMoyfVox69F7DJzGuGOoxNmcYez4+
         eFzL4heixkcQWRzXXIxolMiad9ufE+nwJECv0hkUt2Jh2lkxZ1J02wWxu5pN6TvXUt3Y
         XWw5CyBfH6Ja6a7rlNvHjH8rRLktN9La9drYbV271UDor4w0YESelch7SDTxGaMvdZ9k
         8VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j30JUOZM71mCnUAp506XCceJTp2qL9rdEgAQekHIvAM=;
        b=swxH5goX0FmgTTPd7roFtEhCdJb+ArMfvvkHWzW67HcONqKmEG/6I+Zo3W3GKHMLhk
         ZbILCMKyl5ny3nfwY52bi8s0Uw/sKTlIsnlr/LbECWDEziTHLH2RZF8KxpefKjhos3nC
         VNIwUZcjayF/30xg/bwU03DzvW9VMX+2VpR1u3ONx4wizpV+QYdrI9g8GxMqC3WldgoS
         WgAieIfhD2F/4OK/R6yLVCY0anCiBbtIBOVhlVdu9K+ZF4vvKk6YfxVCGgGZcuZvamQN
         IawPuimkOdMrlS+Imu10Qu44kpaRIgXPuAdpSi8W6o1bfQgvrjIVqh1kGfQ3Jqt+3ACs
         d0dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 087/115] wcn36xx: Fix dynamic power saving
Date: Fri,  2 Mar 2018 09:51:30 +0100
Message-Id: <20180302084507.369603779@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816044086911434?=
X-GMAIL-MSGID: =?utf-8?q?1593816044086911434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>


[ Upstream commit 0856655a25476d4431005e39d606e349050066b0 ]

Since driver does not report hardware dynamic power saving cap,
this is up to the mac80211 to manage power saving timeout and
state machine, using the ieee80211 config callback to report
PS changes. This patch enables/disables PS mode according to
the new configuration.

Remove old behaviour enabling PS mode in a static way, this make
the device unusable when power save is enabled since device is
forced to PS regardless RX/TX traffic.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c |   23 ++++++++++++-----------
 drivers/net/wireless/ath/wcn36xx/pmc.c  |    6 ++++--
 2 files changed, 16 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -384,6 +384,18 @@ static int wcn36xx_config(struct ieee802
 		}
 	}
 
+	if (changed & IEEE80211_CONF_CHANGE_PS) {
+		list_for_each_entry(tmp, &wcn->vif_list, list) {
+			vif = wcn36xx_priv_to_vif(tmp);
+			if (hw->conf.flags & IEEE80211_CONF_PS) {
+				if (vif->bss_conf.ps) /* ps allowed ? */
+					wcn36xx_pmc_enter_bmps_state(wcn, vif);
+			} else {
+				wcn36xx_pmc_exit_bmps_state(wcn, vif);
+			}
+		}
+	}
+
 	mutex_unlock(&wcn->conf_mutex);
 
 	return 0;
@@ -747,17 +759,6 @@ static void wcn36xx_bss_info_changed(str
 		vif_priv->dtim_period = bss_conf->dtim_period;
 	}
 
-	if (changed & BSS_CHANGED_PS) {
-		wcn36xx_dbg(WCN36XX_DBG_MAC,
-			    "mac bss PS set %d\n",
-			    bss_conf->ps);
-		if (bss_conf->ps) {
-			wcn36xx_pmc_enter_bmps_state(wcn, vif);
-		} else {
-			wcn36xx_pmc_exit_bmps_state(wcn, vif);
-		}
-	}
-
 	if (changed & BSS_CHANGED_BSSID) {
 		wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss changed_bssid %pM\n",
 			    bss_conf->bssid);
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -45,8 +45,10 @@ int wcn36xx_pmc_exit_bmps_state(struct w
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 
 	if (WCN36XX_BMPS != vif_priv->pw_state) {
-		wcn36xx_err("Not in BMPS mode, no need to exit from BMPS mode!\n");
-		return -EINVAL;
+		/* Unbalanced call or last BMPS enter failed */
+		wcn36xx_dbg(WCN36XX_DBG_PMC,
+			    "Not in BMPS mode, no need to exit\n");
+		return -EALREADY;
 	}
 	wcn36xx_smd_exit_bmps(wcn, vif);
 	vif_priv->pw_state = WCN36XX_FULL_POWER;
