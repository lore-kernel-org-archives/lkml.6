Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69311C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0867326D1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdvdjNQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0867326D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeFZPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:39:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36309 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbeFZPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:39:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so17748382wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=huLLYyaK2Adm2Tg80X1sYBZikfNuFSFblc70dfTMv28=;
        b=IdvdjNQFuy3KR6tXhevmB7Eg6AQeuO6WyjuM4hGlWzu7tHlWhSkBwjf1ZGaVLiU0QM
         RbC9dHQntzDUaOCcxu3FyhLaN/y1S0t+0n/DSgx7FbHx/9GeX74iH5nGwnz6AlKzhkEi
         29sDMe/31Y71BOtqzcRdfDLKJOOdwLz8d6mWvzxX76xVeEr5ZQeKEWNaGxoG290IGY38
         2pnR/ZJhfEQsiKqVXP5DNF8xsqWIHeED1Xeh/YCS1HNVBH5ZiPKxwlNO/DhkloRPz4An
         TCPmCW04vDHitRqBbNgvLcz94AbyUFDsdqaP0n0d43XCVd5pm2OCjW16NFLiurwCq7UQ
         ZQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=huLLYyaK2Adm2Tg80X1sYBZikfNuFSFblc70dfTMv28=;
        b=pQPHzsAIOY/kWErpRatA7mFXCe+HO0kGv0RgSlgELMX51C4k3PnPlnyItEBQxf1iwj
         eE/uS/Eb7bHJx7/+1fI31X3DtGJNiMl+7m4l6UcfVS3nI8dflXgp/9vCRaNsKiuFwLCg
         eBR0sI+DrpV+9lE42Eoz3K5tTZ9JpTAwOqdrMvqDXJk/9TUqe4sW4S23GqMuUI/RTQ1X
         Cav3Bo9tI2Yy4zdKgz8hHUo1V/5WIMjfstUGeeUW9jEzF8Qo2lD4t2bY6sC/1wpdzqto
         8wu3D3/xtUDVRJI5fL96GPXMjE1cTfZk46Mykf57mSTmuQivsTnwmAQlE+/lEEaHmB/J
         ayfg==
X-Gm-Message-State: APt69E31p/SyIUWLt9Pg2jAyWy+E+v6E42zGQHrNyNUPf9rWZcNqNkZK
        n/UMRIKuzeWPafOgV4rNzqU=
X-Google-Smtp-Source: AAOMgpdTUNmqn6O2+Rf5HXlQ+AHpIhiPSXqGXCOlpwxZP2Vm1sqIckwOIlaskbOI22J92YupIKnJIQ==
X-Received: by 2002:adf:88e3:: with SMTP id g32-v6mr1847748wrg.62.1530027591795;
        Tue, 26 Jun 2018 08:39:51 -0700 (PDT)
Received: from arch.localdomain (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id u15-v6sm3770050wma.37.2018.06.26.08.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:39:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove blank lines
Date:   Tue, 26 Jun 2018 17:38:56 +0200
Message-Id: <20180626153856.10207-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unrequired blank lines after open and before close braces.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c        | 1 -
 drivers/staging/rtl8188eu/core/rtw_efuse.c     | 2 --
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 --
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c  | 1 -
 drivers/staging/rtl8188eu/core/rtw_recv.c      | 4 ----
 drivers/staging/rtl8188eu/core/rtw_security.c  | 2 --
 drivers/staging/rtl8188eu/core/rtw_xmit.c      | 3 ---
 7 files changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 17cd28b893a4..be1e8bf41e00 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -306,7 +306,6 @@ void	expire_timeout_chk(struct adapter *padapter)
 				spin_lock_bh(&pstapriv->auth_list_lock);
 			}
 		}
-
 	}
 	spin_unlock_bh(&pstapriv->auth_list_lock);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 5b8414c568e5..3ac3dd796ec9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -301,7 +301,6 @@ static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset
 
 void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
-
 	if (rtw_IOL_applied(Adapter)) {
 		rtw_hal_power_on(Adapter);
 		iol_mode_enable(Adapter, 1);
@@ -476,7 +475,6 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 			efuse_addr = efuse_addr + (word_cnts*2)+1;
 			ReadState = PG_STATE_HEADER;
 		}
-
 	}
 
 	if ((data[0] == 0xff) && (data[1] == 0xff) && (data[2] == 0xff)  && (data[3] == 0xff) &&
diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 785f78fe51c5..e47927b9c3b8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -178,7 +178,6 @@ u8 *rtw_get_ie(u8 *pbuf, int index, uint *len, int limit)
 
 void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 {
-
 	memset(SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	switch (mode) {
@@ -326,7 +325,6 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
 
 unsigned char *rtw_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len, int limit)
 {
-
 	return rtw_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
 }
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index c8c09ae9f5a4..f05658c9239e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -5448,7 +5448,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (peventbuf) {
 		event_callback = wlanevents[evt_code].event_callback;
 		event_callback(padapter, (u8 *)peventbuf);
-
 	}
 
 _abort_event_:
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 965fe9afda7c..79567cf470de 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -36,13 +36,11 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
-
 	memset((u8 *)psta_recvpriv, 0, sizeof(struct sta_recv_priv));
 
 	spin_lock_init(&psta_recvpriv->lock);
 
 	_rtw_init_queue(&psta_recvpriv->defrag_q);
-
 }
 
 int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
@@ -98,7 +96,6 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 	vfree(precvpriv->pallocated_frame_buf);
 
 	rtw_hal_free_recv_priv(padapter);
-
 }
 
 struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
@@ -193,7 +190,6 @@ void rtw_free_recvframe_queue(struct __queue *pframequeue,  struct __queue *pfre
 	}
 
 	spin_unlock(&pframequeue->lock);
-
 }
 
 u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 8e204dc4ab1b..5b8d7288a4e7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -185,7 +185,6 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 			}
 		}
 	}
-
 }
 
 int rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
@@ -1030,7 +1029,6 @@ static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, int a4_exists, int
 		mic_header2[14] = mpdu[30] & 0x0f;
 		mic_header2[15] = mpdu[31] & 0x00;
 	}
-
 }
 
 /************************************************/
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 2f85f58b7934..d16a7fa32a25 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -33,7 +33,6 @@ void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	_init_txservq(&psta_xmitpriv->vo_q);
 	INIT_LIST_HEAD(&psta_xmitpriv->legacy_dz);
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
-
 }
 
 s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
@@ -1146,7 +1145,6 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 		}
 		break;
 	}
-
 }
 
 void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe, int sz)
@@ -1385,7 +1383,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
 	spin_unlock_bh(&pframequeue->lock);
-
 }
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
-- 
2.18.0

