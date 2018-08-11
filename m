Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C4C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D7921546
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGcalZnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D7921546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHKLt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:49:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42078 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeHKLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:49:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id u202-v6so8146463lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0ZoJg7K8PpMHNm7a12YqvLnLDVg4zrqFUOLY8IjMbRU=;
        b=hGcalZnYzp16Zy9Gz23I9fTcwV16Mqqo++qUrfmXp1r3wgJ9c1ri4JMJ8AzXHhG1F/
         s9xb6oYkxm1NqqypAGmserO5eolazYD1gOBlXOhE8Myd8w7pYqddhrafl3Jc3D565jr0
         0cjttvivvBgspOqYebsuJzFW8/U+XNk6FBY9ZNSCmk9spKEuGeaY5IvUfem6o0piJQ2Z
         21oj+siLsIg9Lz38y4yIrhGSgiopoVfprcm9rbIgP9UO2eaeTBbTF1tdxqsCpdXrRTMP
         se1JjR6+BYAC5/PrtOjcNzd7CPa3RUpv3F9VOOM8LRW1jn2pgbKQoTMpa4z7fRqPLdNO
         E+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0ZoJg7K8PpMHNm7a12YqvLnLDVg4zrqFUOLY8IjMbRU=;
        b=XNu/RnbuRuQxl/u68T25mWtHS+YMnpRBc7FKzw8HVmEjtnOXfch6il8e0PbjASyrmx
         XrnKmxHl8Y1Ce/D+/CaeVtljAW60lU27f59u5CV37ZU5WRxya7ZPqpX/Pj46MEYzPCMB
         scZi9wZzkg0D0P7DDzPpUWMIJh0Qiv3SVZNZnI62zpRWT74zkdyF2Neur0MPw5pZo/9m
         sYa2ygRon/8ZwQ+mgRGpVqf8q248dCBJrdeIlPaP2HysulhjQMG6D/K06XSt4OxuZNhs
         8KFwFqLPvinNgl2Pa0c0YZ/4XwzNT5P0E5PqCkN7yR9ZuVmPtmF+b8XfX6Ut6uFbo4hr
         ORyA==
X-Gm-Message-State: AOUpUlEnlj2FZERCI/617k1J3y0GC5oIKnX8/bv2+1sCLWlEjju202AM
        qUQqWZjeqGNrP61/sVeEiOc=
X-Google-Smtp-Source: AA+uWPwMX25O21KjG4XENLNYS6ag/gUOgCftUFpPy/dtx/DqPHXoNoYd9S0ud3JkMRFca3GegNcOaA==
X-Received: by 2002:a19:6b03:: with SMTP id d3-v6mr6490109lfa.81.1533978949759;
        Sat, 11 Aug 2018 02:15:49 -0700 (PDT)
Received: from alpha (ppp89-110-0-201.pppoe.avangarddsl.ru. [89.110.0.201])
        by smtp.gmail.com with ESMTPSA id j64-v6sm2340949lfe.56.2018.08.11.02.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 02:15:49 -0700 (PDT)
Received: (nullmailer pid 11985 invoked by uid 1000);
        Sat, 11 Aug 2018 09:17:03 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Janani Sankara Babu <jananis37@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Aastha Gupta <aastha.gupta4104@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:r8188eu: load lib80211 crypto ops from interruptible context
Date:   Sat, 11 Aug 2018 12:16:43 +0300
Message-Id: <20180811091643.11939-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preloading lib80211_crypt_* modules from an ioctl handlers
prevents the module loading from a tasklet.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c          |  4 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c         |  8 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c   |  6 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c        | 14 ++--
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    |  4 +-
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c     |  2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c        |  2 +-
 drivers/staging/rtl8188eu/core/rtw_security.c    |  1 -
 drivers/staging/rtl8188eu/core/rtw_xmit.c        |  4 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c      |  2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c      |  2 +-
 drivers/staging/rtl8188eu/include/rtw_security.h | 54 ++++++++++---
 drivers/staging/rtl8188eu/include/sta_info.h     |  2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c   | 98 ++++++++++++------------
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c    |  4 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c      |  4 +-
 16 files changed, 122 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 676d549ef786..3a78bf115e9f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -642,8 +642,8 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 		/* WEP Key will be set before this function, do not
 		 * clear CAM.
 		 */
-		if ((psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
-		    (psecuritypriv->dot11PrivacyAlgrthm != _WEP104_))
+		if ((psecuritypriv->dot11PrivacyAlgrthm.id != _WEP40_) &&
+		    (psecuritypriv->dot11PrivacyAlgrthm.id != _WEP104_))
 			flush_all_cam_entry(padapter);	/* clear CAM */
 	}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 59039211dad2..499cfbebe6b9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -448,9 +448,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		 * the connection to avoid some IOT issue.
 		 * Especially for Realtek 8192u SoftAP.
 		 */
-		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
-		    (padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
-		    (padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
+		if ((padapter->securitypriv.dot11PrivacyAlgrthm.id != _WEP40_) &&
+		    (padapter->securitypriv.dot11PrivacyAlgrthm.id != _WEP104_) &&
+		    (padapter->securitypriv.dot11PrivacyAlgrthm.id != _TKIP_)) {
 			/* rtw_restructure_ht_ie */
 			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0],
 									pnetwork->network.ie_length, &psecnetwork->ie_length);
@@ -570,7 +570,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key)
 	ether_addr_copy(psetstakey_para->addr, sta->hwaddr);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm;
+		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm.id;
 	else
 		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index c040f185074b..e57a15940ea7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -481,15 +481,15 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 
 	switch (wep->KeyLength) {
 	case 5:
-		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
+		psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 5\n"));
 		break;
 	case 13:
-		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
+		psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP104_);
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 13\n"));
 		break;
 	default:
-		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+		psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength!= 5 or 13\n"));
 		break;
 	}
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index eca06f05c0c4..2323962220e4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -286,10 +286,10 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	int ret = true;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
-	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
+	if ((psecuritypriv->dot11PrivacyAlgrthm.id != _NO_PRIVACY_) &&
 	    (pnetwork->network.Privacy == 0))
 		ret = false;
-	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
+	else if ((psecuritypriv->dot11PrivacyAlgrthm.id == _NO_PRIVACY_) &&
 		 (pnetwork->network.Privacy == 1))
 		ret = false;
 	else
@@ -1591,12 +1591,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	}
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
-		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
+		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy.id;
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 			 ("\n rtw_set_key: psetkeyparm->algorithm=(unsigned char)psecuritypriv->dot118021XGrpPrivacy=%d\n",
 			 psetkeyparm->algorithm));
 	} else {
-		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
+		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm.id;
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 			 ("\n rtw_set_key: psetkeyparm->algorithm=(u8)psecuritypriv->dot11PrivacyAlgrthm=%d\n",
 			 psetkeyparm->algorithm));
@@ -1632,7 +1632,7 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	default:
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 			 ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
-			 psecuritypriv->dot11PrivacyAlgrthm));
+			 psecuritypriv->dot11PrivacyAlgrthm.id));
 		res = _FAIL;
 		goto err_free_parm;
 	}
@@ -1804,7 +1804,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	security_priv *psecuritypriv = &adapter->securitypriv;
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
-	pdev_network->Privacy = psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0; /*  adhoc no 802.1x */
+	pdev_network->Privacy = psecuritypriv->dot11PrivacyAlgrthm.id > 0 ? 1 : 0; /*  adhoc no 802.1x */
 
 	pdev_network->Rssi = 0;
 
@@ -1935,7 +1935,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 		ht_cap.ampdu_params_info = max_rx_ampdu_factor & 0x03;
 
-		if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
+		if (padapter->securitypriv.dot11PrivacyAlgrthm.id == _AES_)
 			ht_cap.ampdu_params_info |= IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2);
 		else
 			ht_cap.ampdu_params_info |= IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 1115050077e4..96d3fd9fde99 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2686,8 +2686,8 @@ static unsigned int OnAuth(struct adapter *padapter,
 
 	DBG_88E("auth alg=%x, seq=%X\n", algorithm, seq);
 
-	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
-	    psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
+	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm.id != _WEP40_ &&
+	    psecuritypriv->dot11PrivacyAlgrthm.id != _WEP104_)
 		auth_mode = 0;
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 5ab6fc22a156..31a760a6403d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -173,7 +173,7 @@ int ips_leave(struct adapter *padapter)
 
 		DBG_88E_LEVEL(_drv_info_, "nolinked power save leave\n");
 
-		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
+		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm.id) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm.id)) {
 			DBG_88E("==>%s, channel(%d), processing(%x)\n", __func__, padapter->mlmeextpriv.cur_channel, pwrpriv->bips_processing);
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 17b4b9257b49..8b4173536469 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1973,7 +1973,7 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		if (check_fwstate(mlmepriv, WIFI_STATION_STATE) &&
 		    !IS_MCAST(prxattrib->ra) && prxattrib->encrypt > 0 &&
 		    prxattrib->bdecrypted == 0 &&
-		    !is_wep_enc(psecuritypriv->dot11PrivacyAlgrthm) &&
+		    !is_wep_enc(psecuritypriv->dot11PrivacyAlgrthm.id) &&
 		    !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
 			DBG_88E("%s: no key, enqueue uc_swdec_pending_queue\n", __func__);
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 2a48b09ea9ae..6a6e3f21ae5e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -10,7 +10,6 @@
 #include <drv_types.h>
 #include <wifi.h>
 #include <osdep_intf.h>
-#include <net/lib80211.h>
 
 /* WEP related ===== */
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 2130d78e0d9f..42313e185187 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -273,7 +273,7 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 		while (true) {
 			/* IOT action */
 			if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_ATHEROS) && pattrib->ampdu_en &&
-			    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
+			    (padapter->securitypriv.dot11PrivacyAlgrthm.id == _AES_)) {
 				pattrib->vcs_mode = CTS_TO_SELF;
 				break;
 			}
@@ -605,7 +605,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 	hw_hdr_offset = TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
-	if (pattrib->encrypt == _TKIP_) {/* if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_PRIVACY_) */
+	if (pattrib->encrypt == _TKIP_) {/* if (psecuritypriv->dot11PrivacyAlgrthm.id == _TKIP_PRIVACY_) */
 		/* encode mic code */
 		if (stainfo) {
 			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 545d6a6102f1..80555e70d302 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -97,7 +97,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->pNumRxBytesUnicast = &Adapter->recvpriv.rx_bytes;
 	dm_odm->pWirelessMode = &pmlmeext->cur_wireless_mode;
 	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
-	dm_odm->pSecurity = (u8 *)&Adapter->securitypriv.dot11PrivacyAlgrthm;
+	dm_odm->pSecurity = (u8 *)&Adapter->securitypriv.dot11PrivacyAlgrthm.id;
 	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
 	dm_odm->pChannel = &hal_data->CurrentChannel;
 	dm_odm->pbNet_closed = (bool *)&Adapter->net_closed;
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 12864b648fa8..283f8a706b90 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1560,7 +1560,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 
 			MinSpacingToSet = *((u8 *)val);
 			if (MinSpacingToSet <= 7) {
-				switch (Adapter->securitypriv.dot11PrivacyAlgrthm) {
+				switch (Adapter->securitypriv.dot11PrivacyAlgrthm.id) {
 				case _NO_PRIVACY_:
 				case _AES_:
 					SecMinSpace = 0;
diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index f8d9151fe6e3..33d7e4f719b8 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -9,6 +9,7 @@
 
 #include <osdep_service.h>
 #include <drv_types.h>
+#include <net/lib80211.h>
 
 #define _NO_PRIVACY_			0x0
 #define _WEP40_				0x1
@@ -19,6 +20,39 @@
 #define _WEP_WPA_MIXED_			0x07  /*  WEP + WPA */
 #define _SMS4_				0x06
 
+struct crypto_algorithm {
+	u32 id;
+	struct lib80211_crypto_ops *ops;
+};
+
+inline static struct crypto_algorithm create_crypto_algorithm(int algo_id)
+{
+	struct crypto_algorithm algo = {
+		.id = algo_id
+	};
+
+	switch (algo_id) {
+	case _WEP40_:
+	case _WEP104_:
+		algo.ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
+		break;
+	case _TKIP_:
+		algo.ops = try_then_request_module(lib80211_get_crypto_ops("TKIP"), "lib80211_crypt_tkip");
+		break;
+	case _AES_:
+		algo.ops = try_then_request_module(lib80211_get_crypto_ops("CCMP"), "lib80211_crypt_ccmp");
+		break;
+	case _NO_PRIVACY_:
+		algo.ops = NULL;
+		break;
+	default:
+		algo.ops = NULL;
+		break;
+	}
+
+	return algo;
+}
+
 #define is_wep_enc(alg) (((alg) == _WEP40_) || ((alg) == _WEP104_))
 
 #define _WPA_IE_ID_	0xdd
@@ -94,18 +128,18 @@ struct security_priv {
 	u32	  dot11AuthAlgrthm;	/*  802.11 auth, could be open,
 					 * shared, 8021x and authswitch
 					 */
-	u32	  dot11PrivacyAlgrthm;	/*  This specify the privacy for
-					 * shared auth. algorithm.
-					 */
+
+	/* This specify the privacy for shared auth. algorithm. */
+	struct crypto_algorithm dot11PrivacyAlgrthm;
+
 	/* WEP */
 	u32	  dot11PrivacyKeyIndex;	/*  this is only valid for legendary
 					 * wep, 0~3 for key id.(tx key index)
 					 */
 	union Keytype dot11DefKey[4];	/*  this is only valid for def. key */
 	u32	dot11DefKeylen[4];
-	u32 dot118021XGrpPrivacy;	/*  This specify the privacy algthm.
-					 * used for Grp key
-					 */
+	/* This specify the privacy algthm. used for Grp key */
+	struct crypto_algorithm dot118021XGrpPrivacy;
 	u32	dot118021XGrpKeyid;	/*  key id used for Grp Key
 					 * ( tx key index)
 					 */
@@ -168,16 +202,16 @@ do {									\
 	case dot11AuthAlgrthm_Open:					\
 	case dot11AuthAlgrthm_Shared:					\
 	case dot11AuthAlgrthm_Auto:					\
-		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;	\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm.id;	\
 		break;							\
 	case dot11AuthAlgrthm_8021X:					\
 		if (bmcst)						\
-			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
+			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy.id;\
 		else							\
-			encry_algo = (u8)psta->dot118021XPrivacy;	\
+			encry_algo = (u8)psta->dot118021XPrivacy.id;	\
 		break;							\
 	case dot11AuthAlgrthm_WAPI:					\
-		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;	\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm.id;	\
 		break;							\
 	}								\
 } while (0)
diff --git a/drivers/staging/rtl8188eu/include/sta_info.h b/drivers/staging/rtl8188eu/include/sta_info.h
index dc685a14aeb8..08b6ae57b8dd 100644
--- a/drivers/staging/rtl8188eu/include/sta_info.h
+++ b/drivers/staging/rtl8188eu/include/sta_info.h
@@ -84,7 +84,7 @@ struct sta_info {
 	u8	hwaddr[ETH_ALEN];
 
 	uint	ieee8021x_blocked;	/* 0: allowed, 1:blocked */
-	uint	dot118021XPrivacy; /* aes, tkip... */
+	struct crypto_algorithm dot118021XPrivacy; /* aes, tkip... */
 	union Keytype	dot11tkiptxmickey;
 	union Keytype	dot11tkiprxmickey;
 	union Keytype	dot118021x_UncstKey;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index bee3c3a7a7a9..72a7b596380f 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -375,8 +375,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		DBG_88E("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
+		padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
+		padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
@@ -401,8 +401,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 			if (wep_key_len == 13) {
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-				padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
+				padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP104_);
+				padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_WEP104_);
 			}
 		} else {
 			ret = -EINVAL;
@@ -539,46 +539,46 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 		switch (group_cipher) {
 		case WPA_CIPHER_NONE:
-			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
-			padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
-			padapter->securitypriv.dot118021XGrpPrivacy = _TKIP_;
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_TKIP_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
-			padapter->securitypriv.dot118021XGrpPrivacy = _AES_;
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_AES_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
-			padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_WEP104_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		}
 
 		switch (pairwise_cipher) {
 		case WPA_CIPHER_NONE:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_TKIP_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_AES_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
-			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP104_);
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		}
@@ -1591,8 +1591,8 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	if (erq->flags & IW_ENCODE_DISABLED) {
 		DBG_88E("EncryptionDisabled\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+		padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
+		padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
@@ -1616,16 +1616,16 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		DBG_88E("rtw_wx_set_enc():IW_ENCODE_OPEN\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+		padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
+		padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
 		DBG_88E("rtw_wx_set_enc():IW_ENCODE_RESTRICTED\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
+		padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
+		padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 		authmode = Ndis802_11AuthModeShared;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
@@ -1633,8 +1633,8 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+		padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
+		padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	}
@@ -1655,13 +1655,13 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
 			case 5:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
+				padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
 				break;
 			case 13:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
+				padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP104_);
 				break;
 			default:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
+				padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
 				break;
 			}
 
@@ -1818,8 +1818,8 @@ static int rtw_wx_set_auth(struct net_device *dev,
 
 		if (param->value) {
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+			padapter->securitypriv.dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
+			padapter->securitypriv.dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 		}
@@ -2097,7 +2097,7 @@ static u8 set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
 
-	psetstakey_para->algorithm = (u8)psta->dot118021XPrivacy;
+	psetstakey_para->algorithm = (u8)psta->dot118021XPrivacy.id;
 
 	memcpy(psetstakey_para->addr, psta->hwaddr, ETH_ALEN);
 
@@ -2257,12 +2257,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			DBG_88E("wep, set_tx = 1\n");
 
 			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
-			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
+			psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP40_);
+			psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 
 			if (pwep->KeyLength == 13) {
-				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+				psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_WEP104_);
+				psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP104_);
 			}
 
 			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
@@ -2296,12 +2296,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 
-				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
+				psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 				if (param->u.crypt.key_len == 13)
-					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP104_);
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				DBG_88E("%s, set group_key, TKIP\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
+				psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_TKIP_);
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 				/* set mic key */
@@ -2311,17 +2311,17 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				psecuritypriv->busetkipkey = true;
 			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 				DBG_88E("%s, set group_key, CCMP\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _AES_;
+				psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_AES_);
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 			} else {
 				DBG_88E("%s, set group_key, none\n", __func__);
-				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+				psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 			}
 			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
 			psecuritypriv->binstallGrpkey = true;
 			psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
-			set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
+			set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy.id, param->u.crypt.idx);
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
 			if (pbcmc_sta) {
 				pbcmc_sta->ieee8021x_blocked = false;
@@ -2339,13 +2339,13 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 					DBG_88E("%s, set pairwise key, WEP\n", __func__);
 
-					psta->dot118021XPrivacy = _WEP40_;
+					psta->dot118021XPrivacy = create_crypto_algorithm(_WEP40_);
 					if (param->u.crypt.key_len == 13)
-						psta->dot118021XPrivacy = _WEP104_;
+						psta->dot118021XPrivacy = create_crypto_algorithm(_WEP104_);
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					DBG_88E("%s, set pairwise key, TKIP\n", __func__);
 
-					psta->dot118021XPrivacy = _TKIP_;
+					psta->dot118021XPrivacy = create_crypto_algorithm(_TKIP_);
 
 					/* set mic key */
 					memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
@@ -2355,11 +2355,11 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 					DBG_88E("%s, set pairwise key, CCMP\n", __func__);
 
-					psta->dot118021XPrivacy = _AES_;
+					psta->dot118021XPrivacy = create_crypto_algorithm(_AES_);
 				} else {
 					DBG_88E("%s, set pairwise key, none\n", __func__);
 
-					psta->dot118021XPrivacy = _NO_PRIVACY_;
+					psta->dot118021XPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 				}
 
 				set_pairwise_key(padapter, psta);
@@ -2369,11 +2369,11 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 						    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
-					psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
+					psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP40_);
 					if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+						psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_WEP104_);
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
+					psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_TKIP_);
 
 					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 						    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
@@ -2384,12 +2384,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 					psecuritypriv->busetkipkey = true;
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					psecuritypriv->dot118021XGrpPrivacy = _AES_;
+					psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_AES_);
 
 					memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 						    param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 				} else {
-					psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+					psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 				}
 
 				psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
@@ -2398,7 +2398,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->dot11PrivacyAlgrthm = psecuritypriv->dot118021XGrpPrivacy;/*  */
 
-				set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy, param->u.crypt.idx);
+				set_group_key(padapter, param->u.crypt.key, psecuritypriv->dot118021XGrpPrivacy.id, param->u.crypt.idx);
 
 				pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
 				if (pbcmc_sta) {
diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 238c1d9cdc7b..9c365b3469a1 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -65,9 +65,9 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 		struct security_priv *psec_priv = &adapter->securitypriv;
 
 		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+		psec_priv->dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
 		psec_priv->dot11PrivacyKeyIndex = 0;
-		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+		psec_priv->dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 		psec_priv->dot118021XGrpKeyid = 1;
 		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
 		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 62294bdc465e..be50b91f9a06 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -380,9 +380,9 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	/* security_priv */
 	psecuritypriv->binstallGrpkey = _FAIL;
 	psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
-	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+	psecuritypriv->dot11PrivacyAlgrthm = create_crypto_algorithm(_NO_PRIVACY_);
 	psecuritypriv->dot11PrivacyKeyIndex = 0;
-	psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+	psecuritypriv->dot118021XGrpPrivacy = create_crypto_algorithm(_NO_PRIVACY_);
 	psecuritypriv->dot118021XGrpKeyid = 1;
 	psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
 	psecuritypriv->ndisencryptstatus = Ndis802_11WEPDisabled;
-- 
2.16.4

