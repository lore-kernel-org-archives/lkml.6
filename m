Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC962080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD3nnagX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeLOQqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:46:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38368 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so8669083wml.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syNmNCrKQ5caHgAg6l/wso9zYmZfIpSQ+75/g8URmjk=;
        b=KD3nnagXGiwQE2WP7AuKTOWkLH5g2NJw8MOm0//9k/MFTyoz1TNmAYEhWUZre4GgIl
         pF7y+36Wo25PD4XJtMeaL40qaEMmoQuR807lXuP9/UnOET4oc3bEV2a/7FJHGWnZmfIt
         9ehdXjbMAZWBwAbGt7SFKIpxq9/mI3lAEsFB0yYZ7DTCi9dQz/1o69jAlMCmmoadipbI
         jZWl8AECcGMQL8a4tpk8tX2LerjJ+U6Ka40VaeZXuvertfTkCse+5hL4p8n/PgZJP62n
         +cUTVdB0xDbTTy2jR7NdBVFZyM5AhnsrJcQcat+yeHhMglERDOlhXkNS+WQzirHrQ5/E
         p6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syNmNCrKQ5caHgAg6l/wso9zYmZfIpSQ+75/g8URmjk=;
        b=W5cyvsGXFAFWRvrGELhUJTDVDVo5YdC3Gtpv+Lw8m145ypjsfugGUMrRvi2lERm31w
         sHF0SCJbE8nB6l6mfodMFN2RSWetxad8J9qwlAnDquKpVtdwVnQJ1hPXV/lHOp5gMGvg
         /Piadnyvqf+DmrWfHme9hJGhBafD65tMs1De0Eo0YemI146fDY6x2cOH9cqISI96r6z+
         HCNhFMwlP39/FKXNG4y+X+lddRHVq604ooVooTdpYREEhP3MmuZaf5bI3u2gnzTbLNmO
         NuBQ7vFRx1r+kkR5qIm84UAgKI5C48moqDrXWMeaIz5LaJ4zmC7+dT1mOvh1oPRtFt58
         uhBg==
X-Gm-Message-State: AA+aEWZF5k2NCsDp2vlMVWeC4VEi4NXqJmI2xS3kVMMoww92UoG9JlR/
        HB3M9EBD4ggmu6Zzig3uLRo=
X-Google-Smtp-Source: AFSGD/VbzjA0wcVuMN0CBlXZ27is7wnROYU7HxCedmf5z5r7ulXUhpShUlMHq/jYhLcoHpWM7sCMGQ==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr6479215wmf.111.1544892388083;
        Sat, 15 Dec 2018 08:46:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/9] staging: rtl8188eu: cleanup declarations in rtw_mlme_ext.c
Date:   Sat, 15 Dec 2018 17:46:08 +0100
Message-Id: <20181215164616.2643-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces in declarations.
Remove unused/commented declarations, remove unnecessary comment,
remove blank lines between declarations and add missing lines after
declarations. Also clears some line over 80 characters checkpatch
warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 484 +++++++++---------
 1 file changed, 241 insertions(+), 243 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 6790b840aef8..4996227b6a2e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -22,14 +22,14 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 /**************************************************
 OUI definitions for the vendor specific IE
 ***************************************************/
-unsigned char	RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
+unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
-unsigned char	WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
-unsigned char	P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
-unsigned char	WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
+unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
+unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
+unsigned char WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
 
-unsigned char	WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
-unsigned char	WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
+unsigned char WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
+unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
@@ -56,7 +56,7 @@ static struct rt_channel_plan_2g RTW_ChannelPlan2G[RT_CHANNEL_DOMAIN_2G_MAX] = {
 	{{}, 0},									/*  0x05, RT_CHANNEL_DOMAIN_2G_NULL */
 };
 
-static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
+static struct rt_channel_plan_map RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
 	/*  0x00 ~ 0x1F , Old Define ===== */
 	{0x02},	/* 0x00, RT_CHANNEL_DOMAIN_FCC */
 	{0x02},	/* 0x01, RT_CHANNEL_DOMAIN_IC */
@@ -154,8 +154,8 @@ int rtw_ch_set_search_ch(struct rt_channel_info *ch_set, const u32 ch)
 
 struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 {
-	struct xmit_frame			*pmgntframe;
-	struct xmit_buf				*pxmitbuf;
+	struct xmit_frame *pmgntframe;
+	struct xmit_buf *pxmitbuf;
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pmgntframe) {
@@ -184,7 +184,7 @@ Following are some TX functions for WiFi MLME
 
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 
 	pmlmeext->tx_rate = rate;
 	DBG_88E("%s(): rate = %x\n", __func__, rate);
@@ -192,7 +192,7 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 
 	memset((u8 *)(pattrib), 0, sizeof(struct pkt_attrib));
 
@@ -313,18 +313,18 @@ static int update_hidden_ssid(u8 *ies, u32 ies_len, u8 hidden_ssid_mode)
 
 static void issue_beacon(struct adapter *padapter, int timeout_ms)
 {
-	struct xmit_frame	*pmgntframe;
-	struct pkt_attrib	*pattrib;
-	unsigned char	*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	unsigned int	rate_len;
-	struct xmit_priv	*pxmitpriv = &(padapter->xmitpriv);
+	unsigned int rate_len;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
@@ -454,22 +454,22 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 static void issue_probersp(struct adapter *padapter, unsigned char *da)
 {
-	struct xmit_frame			*pmgntframe;
-	struct pkt_attrib			*pattrib;
-	unsigned char					*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	unsigned char					*mac, *bssid;
-	struct xmit_priv	*pxmitpriv = &(padapter->xmitpriv);
+	unsigned char *mac, *bssid;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 #if defined(CONFIG_88EU_AP_MODE)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	unsigned int	rate_len;
+#endif
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	unsigned int rate_len;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
@@ -603,18 +603,18 @@ static int issue_probereq(struct adapter *padapter,
 			  bool wait_ack)
 {
 	int ret = _FAIL;
-	struct xmit_frame		*pmgntframe;
-	struct pkt_attrib		*pattrib;
-	unsigned char			*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	unsigned char			*mac;
-	unsigned char			bssrate[NumRates];
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
+	unsigned char *mac;
+	unsigned char bssrate[NumRates];
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	int	bssrate_len = 0;
-	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	int bssrate_len = 0;
+	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
 
@@ -750,9 +750,9 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 #endif
 	int use_shared_key = 0;
 	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL)
@@ -883,16 +883,16 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 			  struct sta_info *pstat, int pkt_type)
 {
-	struct xmit_frame	*pmgntframe;
+	struct xmit_frame *pmgntframe;
 	struct ieee80211_hdr *pwlanhdr;
 	struct pkt_attrib *pattrib;
-	unsigned char	*pbuf, *pframe;
+	unsigned char *pbuf, *pframe;
 	unsigned short val;
 	__le16 *fctrl;
 	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 	u8 *ie = pnetwork->ies;
 	__le16 lestatus, leval;
@@ -1008,21 +1008,21 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 static void issue_assocreq(struct adapter *padapter)
 {
 	int ret = _FAIL;
-	struct xmit_frame	*pmgntframe;
-	struct pkt_attrib	*pattrib;
-	unsigned char		*pframe, *p;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe, *p;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	unsigned int	i, j, ie_len, index = 0;
+	unsigned int i, j, ie_len, index = 0;
 	unsigned char bssrate[NumRates], sta_bssrate[NumRates];
 	struct ndis_802_11_var_ie *pIE;
-	struct registry_priv	*pregpriv = &padapter->registrypriv;
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
+	struct registry_priv *pregpriv = &padapter->registrypriv;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	int	bssrate_len = 0, sta_bssrate_len = 0;
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	int bssrate_len = 0, sta_bssrate_len = 0;
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -1187,15 +1187,15 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 			   unsigned int power_mode, bool wait_ack)
 {
 	int ret = _FAIL;
-	struct xmit_frame			*pmgntframe;
-	struct pkt_attrib			*pattrib;
-	unsigned char					*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv	*pxmitpriv;
-	struct mlme_ext_priv	*pmlmeext;
-	struct mlme_ext_info	*pmlmeinfo;
-	struct wlan_bssid_ex    *pnetwork;
+	struct xmit_priv *pxmitpriv;
+	struct mlme_ext_priv *pmlmeext;
+	struct mlme_ext_info *pmlmeinfo;
+	struct wlan_bssid_ex *pnetwork;
 
 	if (!padapter)
 		goto exit;
@@ -1262,9 +1262,9 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret;
 	int i = 0;
 	unsigned long start = jiffies;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
@@ -1308,16 +1308,16 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 			       u16 tid, bool wait_ack)
 {
 	int ret = _FAIL;
-	struct xmit_frame			*pmgntframe;
-	struct pkt_attrib			*pattrib;
-	unsigned char					*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned short *qc;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	DBG_88E("%s\n", __func__);
 
@@ -1391,9 +1391,9 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	int ret;
 	int i = 0;
 	unsigned long start = jiffies;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
@@ -1435,15 +1435,15 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 			 unsigned short reason, bool wait_ack)
 {
-	struct xmit_frame			*pmgntframe;
-	struct pkt_attrib			*pattrib;
-	unsigned char					*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 	int ret = _FAIL;
 	__le16 le_tmp;
 
@@ -1548,7 +1548,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	u16 BA_para_set;
 	u16 reason_code;
 	u16 BA_timeout_value;
-	__le16	le_tmp;
+	__le16 le_tmp;
 	u16 BA_starting_seqctrl = 0;
 	enum ht_cap_ampdu_factor max_rx_ampdu_factor;
 	struct xmit_frame *pmgntframe;
@@ -1562,7 +1562,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	struct sta_info *psta;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
 
@@ -1697,20 +1697,20 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	unsigned char category, action;
-	struct xmit_frame			*pmgntframe;
-	struct pkt_attrib			*pattrib;
-	unsigned char				*pframe;
+	struct xmit_frame *pmgntframe;
+	struct pkt_attrib *pattrib;
+	unsigned char *pframe;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	struct	wlan_network	*pnetwork = NULL;
-	struct xmit_priv			*pxmitpriv = &(padapter->xmitpriv);
+	struct wlan_network *pnetwork = NULL;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct __queue *queue = &(pmlmepriv->scanned_queue);
 	u8 InfoContent[16] = {0};
 	u8 ICS[8][15];
-	struct wlan_bssid_ex  *cur_network   = &(pmlmeinfo->network);
+	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
 
 	if ((pmlmepriv->num_FortyMHzIntolerant == 0) || (pmlmepriv->num_sta_no_ht == 0))
 		return;
@@ -1828,9 +1828,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta = NULL;
-	/* struct recv_reorder_ctrl *preorder_ctrl; */
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u16 tid;
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
@@ -1867,9 +1866,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 unsigned int send_beacon(struct adapter *padapter)
 {
 	u8 bxmitok = false;
-	int	issue = 0;
+	int issue = 0;
 	int poll = 0;
-
 	unsigned long start = jiffies;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_BCN_VALID, NULL);
@@ -1908,10 +1906,10 @@ Following are some utility functions for WiFi MLME
 
 static void site_survey(struct adapter *padapter)
 {
-	unsigned char		survey_channel = 0, val8;
+	unsigned char survey_channel = 0, val8;
 	enum rt_scan_type ScanType = SCAN_PASSIVE;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u32 initialgain = 0;
 	struct rtw_ieee80211_channel *ch;
 
@@ -2016,16 +2014,16 @@ static u8 collect_bss_info(struct adapter *padapter,
 			   struct recv_frame *precv_frame,
 			   struct wlan_bssid_ex *bssid)
 {
-	int	i;
-	u32	len;
+	int i;
+	u32 len;
 	u8 *p;
 	u16 val16, subtype;
 	u8 *pframe = precv_frame->pkt->data;
 	u32 packet_len = precv_frame->pkt->len;
 	u8 ie_offset;
-	struct registry_priv	*pregistrypriv = &padapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct registry_priv *pregistrypriv = &padapter->registrypriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
@@ -2184,11 +2182,11 @@ static u8 collect_bss_info(struct adapter *padapter,
 
 static void start_create_ibss(struct adapter *padapter)
 {
-	unsigned short	caps;
+	unsigned short caps;
 	u8 val8;
 	u8 join_type;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
@@ -2236,10 +2234,10 @@ static void start_create_ibss(struct adapter *padapter)
 
 static void start_clnt_join(struct adapter *padapter)
 {
-	unsigned short	caps;
+	unsigned short caps;
 	u8 val8;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	int beacon_timeout;
 
@@ -2291,8 +2289,8 @@ static void start_clnt_join(struct adapter *padapter)
 
 static void start_clnt_auth(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	del_timer_sync(&pmlmeext->link_timer);
 
@@ -2320,8 +2318,8 @@ static void start_clnt_auth(struct adapter *padapter)
 
 static void start_clnt_assoc(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	del_timer_sync(&pmlmeext->link_timer);
 
@@ -2337,9 +2335,9 @@ static unsigned int receive_disconnect(struct adapter *padapter,
 				       unsigned char *MacAddr,
 				       unsigned short reason)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex    *pnetwork = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
 	/* check A3 */
 	if (memcmp(MacAddr, pnetwork->MacAddress, ETH_ALEN))
@@ -2511,11 +2509,11 @@ Following are the callback functions for each subtype of the management frames
 static unsigned int OnProbeReq(struct adapter *padapter,
 			       struct recv_frame *precv_frame)
 {
-	unsigned int	ielen;
-	unsigned char	*p;
+	unsigned int ielen;
+	unsigned char *p;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
@@ -2546,7 +2544,7 @@ static unsigned int OnProbeReq(struct adapter *padapter,
 static unsigned int OnProbeRsp(struct adapter *padapter,
 			       struct recv_frame *precv_frame)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		report_survey_event(padapter, precv_frame);
@@ -2560,11 +2558,11 @@ static unsigned int OnBeacon(struct adapter *padapter,
 			     struct recv_frame *precv_frame)
 {
 	int cam_idx;
-	struct sta_info	*psta;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct sta_info *psta;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct sta_priv	*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 	struct wlan_bssid_ex *pbss;
@@ -2651,17 +2649,17 @@ static unsigned int OnBeacon(struct adapter *padapter,
 static unsigned int OnAuth(struct adapter *padapter,
 			   struct recv_frame *precv_frame)
 {
-	unsigned int	auth_mode, ie_len;
+	unsigned int auth_mode, ie_len;
 	u16 seq;
-	unsigned char	*sa, *p;
+	unsigned char *sa, *p;
 	u16 algorithm;
-	int	status;
+	int status;
 	static struct sta_info stat;
-	struct	sta_info	*pstat = NULL;
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_info *pstat = NULL;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	uint len = precv_frame->pkt->len;
 
@@ -2820,11 +2818,11 @@ static unsigned int OnAuth(struct adapter *padapter,
 static unsigned int OnAuthClient(struct adapter *padapter,
 				 struct recv_frame *precv_frame)
 {
-	unsigned int	seq, len, status, offset;
-	unsigned char	*p;
-	unsigned int	go2asoc = 0;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	unsigned int seq, len, status, offset;
+	unsigned char *p;
+	unsigned int go2asoc = 0;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
@@ -2899,18 +2897,18 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 #ifdef CONFIG_88EU_AP_MODE
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
-	struct sta_info	*pstat;
-	unsigned char		reassoc, *p, *pos, *wpa_ie;
+	struct sta_info *pstat;
+	unsigned char reassoc, *p, *pos, *wpa_ie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
-	int		i, wpa_ie_len, left;
-	unsigned char		supportRate[16];
-	int					supportRateNum;
-	unsigned short		status = _STATS_SUCCESSFUL_;
-	unsigned short		frame_type, ie_offset = 0;
+	int i, wpa_ie_len, left;
+	unsigned char supportRate[16];
+	int supportRateNum;
+	unsigned short status = _STATS_SUCCESSFUL_;
+	unsigned short frame_type, ie_offset = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *cur = &(pmlmeinfo->network);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->pkt->data;
@@ -3333,12 +3331,11 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 {
 	uint i;
 	int res;
-	unsigned short	status;
+	unsigned short status;
 	struct ndis_802_11_var_ie *pIE;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	/* struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network); */
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
@@ -3420,10 +3417,10 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 static unsigned int OnDeAuth(struct adapter *padapter,
 			     struct recv_frame *precv_frame)
 {
-	unsigned short	reason;
+	unsigned short reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
@@ -3476,8 +3473,8 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 {
 	u16 reason;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
 
@@ -3588,13 +3585,14 @@ static unsigned int OnAction_back(struct adapter *padapter,
 	u8 *addr;
 	struct sta_info *psta = NULL;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	unsigned char		*frame_body;
-	unsigned char		category, action;
-	unsigned short	tid, status, reason_code = 0;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	unsigned char *frame_body;
+	unsigned char category, action;
+	unsigned short tid, status, reason_code = 0;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+
 	/* check RA matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe),
 		   ETH_ALEN))/* for if1, sta/ap mode */
@@ -3812,9 +3810,9 @@ static unsigned int OnAction(struct adapter *padapter,
 			     struct recv_frame *precv_frame)
 {
 	int i;
-	unsigned char	category;
+	unsigned char category;
 	struct action_handler *ptable;
-	unsigned char	*frame_body;
+	unsigned char *frame_body;
 	u8 *pframe = precv_frame->pkt->data;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
@@ -3854,7 +3852,7 @@ static struct mlme_handler mlme_sta_tbl[] = {
 
 int init_hw_mlme_ext(struct adapter *padapter)
 {
-	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
 	return _SUCCESS;
@@ -3862,14 +3860,14 @@ int init_hw_mlme_ext(struct adapter *padapter)
 
 static void init_mlme_ext_priv_value(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	unsigned char	mixed_datarate[NumRates] = {
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	unsigned char mixed_datarate[NumRates] = {
 		_1M_RATE_, _2M_RATE_, _5M_RATE_, _11M_RATE_, _6M_RATE_,
 		_9M_RATE_, _12M_RATE_, _18M_RATE_, _24M_RATE_, _36M_RATE_,
-		 _48M_RATE_, _54M_RATE_, 0xff
+		_48M_RATE_, _54M_RATE_, 0xff
 	};
-	unsigned char	mixed_basicrate[NumRates] = {
+	unsigned char mixed_basicrate[NumRates] = {
 		_1M_RATE_, _2M_RATE_, _5M_RATE_, _11M_RATE_, _6M_RATE_,
 		_12M_RATE_, _24M_RATE_, 0xff,
 	};
@@ -4025,12 +4023,12 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan,
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+int init_mlme_ext_priv(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmlmeext->padapter = padapter;
 
@@ -4227,8 +4225,8 @@ void report_surveydone_event(struct adapter *padapter)
 	u8 *pevtcmd;
 	u32 cmdsz;
 	struct surveydone_event *psurveydone_evt;
-	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+	struct C2HEvent_Header *pc2h_evt_hdr;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -4269,10 +4267,10 @@ void report_join_res(struct adapter *padapter, int res)
 	struct cmd_obj *pcmd_obj;
 	u8 *pevtcmd;
 	u32 cmdsz;
-	struct joinbss_event		*pjoinbss_evt;
-	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct joinbss_event *pjoinbss_evt;
+	struct C2HEvent_Header *pc2h_evt_hdr;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
@@ -4319,10 +4317,10 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	u8 *pevtcmd;
 	u32 cmdsz;
 	struct sta_info *psta;
-	int	mac_id;
-	struct stadel_event			*pdel_sta_evt;
-	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+	int mac_id;
+	struct stadel_event *pdel_sta_evt;
+	struct C2HEvent_Header *pc2h_evt_hdr;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -4373,9 +4371,9 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	struct cmd_obj *pcmd_obj;
 	u8 *pevtcmd;
 	u32 cmdsz;
-	struct stassoc_event		*padd_sta_evt;
-	struct C2HEvent_Header	*pc2h_evt_hdr;
-	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+	struct stassoc_event *padd_sta_evt;
+	struct C2HEvent_Header *pc2h_evt_hdr;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -4422,8 +4420,8 @@ Following are the event callback functions
 void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 {
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	/* ERP */
 	VCS_update(padapter, psta);
@@ -4461,11 +4459,11 @@ void update_sta_info(struct adapter *padapter, struct sta_info *psta)
 
 void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 {
-	struct sta_info		*psta, *psta_bmc;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct sta_info *psta, *psta_bmc;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
-	struct sta_priv		*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 join_type;
 	u16 media_status;
 
@@ -4541,8 +4539,8 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 join_type;
 
 	DBG_88E("%s\n", __func__);
@@ -4578,8 +4576,8 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 
 void mlmeext_sta_del_event_callback(struct adapter *padapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
 		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_DISCONNECT, NULL);
@@ -4630,12 +4628,12 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 
 void linked_status_chk(struct adapter *padapter)
 {
-	u32	i;
-	struct sta_info		*psta;
-	struct xmit_priv		*pxmitpriv = &(padapter->xmitpriv);
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct sta_priv		*pstapriv = &padapter->stapriv;
+	u32 i;
+	struct sta_info *psta;
+	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if (is_client_associated_to_ap(padapter)) {
 		/* linked infrastructure client mode */
@@ -4750,10 +4748,10 @@ void survey_timer_hdl(struct timer_list *t)
 {
 	struct adapter *padapter = from_timer(padapter, t,
 					      mlmeextpriv.survey_timer);
-	struct cmd_obj	*ph2c;
-	struct sitesurvey_parm	*psurveyPara;
-	struct cmd_priv					*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
+	struct cmd_obj *ph2c;
+	struct sitesurvey_parm *psurveyPara;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	/* issue rtw_sitesurvey_cmd */
 	if (pmlmeext->sitesurvey_res.state > SCAN_START) {
@@ -4789,9 +4787,9 @@ void survey_timer_hdl(struct timer_list *t)
 void link_timer_hdl(struct timer_list *t)
 {
 	struct adapter *padapter = from_timer(padapter, t,
-					    mlmeextpriv.link_timer);
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+					      mlmeextpriv.link_timer);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 		DBG_88E("%s:no beacon while connecting\n", __func__);
@@ -4842,8 +4840,8 @@ void addba_timer_hdl(struct timer_list *t)
 u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	u8 type;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct setopmode_parm *psetop = (struct setopmode_parm *)pbuf;
 
 	if (psetop->mode == Ndis802_11APMode) {
@@ -4867,8 +4865,8 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 
 u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 	/* u32	initialgain; */
@@ -4929,9 +4927,9 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	u8 join_type;
 	struct ndis_802_11_var_ie *pIE;
-	struct registry_priv	*pregpriv = &padapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct registry_priv *pregpriv = &padapter->registrypriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 	u32 i;
@@ -5041,8 +5039,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct disconnect_parm *param = (struct disconnect_parm *)pbuf;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 	u8 val8;
 
@@ -5088,7 +5086,7 @@ static int rtw_scan_ch_decision(struct adapter *padapter,
 {
 	int i, j;
 	int set_idx;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	/* clear out first */
 	memset(out, 0, sizeof(struct rtw_ieee80211_channel)*out_num);
@@ -5127,12 +5125,12 @@ static int rtw_scan_ch_decision(struct adapter *padapter,
 
 u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 {
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct sitesurvey_parm	*pparm = (struct sitesurvey_parm *)pbuf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct sitesurvey_parm *pparm = (struct sitesurvey_parm *)pbuf;
 	u8 bdelayscan = false;
 	u8 val8;
-	u32	initialgain;
-	u32	i;
+	u32 initialgain;
+	u32 i;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_DISABLE) {
 		/* for first time sitesurvey_cmd */
@@ -5199,9 +5197,9 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	struct setauth_parm		*pparm = (struct setauth_parm *)pbuf;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct setauth_parm *pparm = (struct setauth_parm *)pbuf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (pparm->mode < 4)
 		pmlmeinfo->auth_algo = pparm->mode;
@@ -5210,11 +5208,11 @@ u8 setauth_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 {
-	unsigned short				ctrl;
-	struct setkey_parm		*pparm = (struct setkey_parm *)pbuf;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	unsigned char					null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	unsigned short ctrl;
+	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	/* main tx key for wep. */
 	if (pparm->set_tx)
@@ -5234,9 +5232,9 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	u16 ctrl = 0;
 	u8 cam_id;/* cam_entry */
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct set_stakey_parm	*pparm = (struct set_stakey_parm *)pbuf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct set_stakey_parm *pparm = (struct set_stakey_parm *)pbuf;
 
 	/* cam_entry: */
 	/* 0~3 for default key */
@@ -5303,9 +5301,9 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	struct addBaReq_parm	*pparm = (struct addBaReq_parm *)pbuf;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct addBaReq_parm *pparm = (struct addBaReq_parm *)pbuf;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, pparm->addr);
 
@@ -5325,11 +5323,11 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 set_tx_beacon_cmd(struct adapter *padapter)
 {
-	struct cmd_obj	*ph2c;
-	struct wlan_bssid_ex	*ptxBeacon_parm;
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct cmd_obj *ph2c;
+	struct wlan_bssid_ex *ptxBeacon_parm;
+	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
@@ -5364,7 +5362,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	u8 evt_code;
 	u16 evt_sz;
-	uint	*peventbuf;
+	uint *peventbuf;
 	void (*event_callback)(struct adapter *dev, u8 *pbuf);
 
 	peventbuf = (uint *)pbuf;
@@ -5454,7 +5452,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct set_ch_parm *set_ch_parm;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!pbuf)
 		return H2C_PARAMETERS_ERROR;
@@ -5477,7 +5475,7 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	struct SetChannelPlan_param *setChannelPlan_param;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!pbuf)
 		return H2C_PARAMETERS_ERROR;
-- 
2.20.0

