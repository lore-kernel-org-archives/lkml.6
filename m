Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728CC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426D220652
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQsjy2de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426D220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGGLjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:39:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38204 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeGGLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:38:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id a5-v6so10467158edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0k0ynH80YSSPGre+McJzT8HWdEwidpuRy7bbMQ1vTw=;
        b=kQsjy2deXCpxeKwV4HJNHJ2EjHt2T8W5NVn1PDRGZx+/CI6ZhFSy5psR7IQ3A+Iti2
         HS6Qsm8FFY/VncOZABcRayWsOS8Ikd8TZq7anrWMQEbq+RkvmLF7tAoStOQk6zbS3T6m
         p3y7gTrdlMeKBmDZC9yOzt1Lxzb4lyAnpEUERg15RRGyIiARHug6PHUEY0izuA/TvviP
         JuR7tYPCtNyO9EcPhTnhgQoqfla5eJ0UN7wYfFpbwXl5J8rSJuUiPpRw5WMCzalwD5tT
         7puJIydlIOJQP/udVmwRpSQtt0GvwOuhh8D7f3gKlLCqOgKWmAnkml5DqBMHuVCchSl3
         xRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0k0ynH80YSSPGre+McJzT8HWdEwidpuRy7bbMQ1vTw=;
        b=pzkg2wZdKrEepfPqjPk+f1ncs46HAr5oQViADVwdOnddGcryl2ftQBhDuYm0MshM2I
         LKg0Ds0cyHSKbb+hEwXvu18WEZUXMU7AN3Ctueihyfk5OnOz19i/R6Y1yjMi01ySTR4P
         nROugROwzybwcRJytUKGTVEN79aO/uDHtAyi+KdVKLB74uXjn+bCtsyPUxrpmwHD+5QP
         MeoV4vFu8iUoEezT9gHvefYzwdW87eP2kA3ySVcS5ZuC/8m/Xi+JMyt4BOsrSD0Wh8Ga
         7VVPFtFVKibrOoi30mjay26UZKbbLkZBn/jvDg+71W9ugxs+czpB43Yo5qbaOiYUWH2w
         efgg==
X-Gm-Message-State: APt69E3NlHZ5+RCH7vISav5wZhfefaIa4v1tLUdrSNn8fzMAW3vkxmPZ
        NU3yfdMTBwPdrZwP2rSeL5s=
X-Google-Smtp-Source: AAOMgpetZO4IHx2A6hekSN6EtT4Ce9vqxhaafjWkHi49Ga/K6LBrKTWKwvhsPXhD2vVGAyxDBfu8Bg==
X-Received: by 2002:a50:86a1:: with SMTP id r30-v6mr14681593eda.138.1530963536215;
        Sat, 07 Jul 2018 04:38:56 -0700 (PDT)
Received: from arch.localdomain (x590e632c.dyn.telefonica.de. [89.14.99.44])
        by smtp.gmail.com with ESMTPSA id y89-v6sm5150306edy.80.2018.07.07.04.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 04:38:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove rtw_beamforming.h
Date:   Sat,  7 Jul 2018 13:38:41 +0200
Message-Id: <20180707113841.23245-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707113841.23245-1-straube.linux@gmail.com>
References: <20180707113841.23245-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header rtw_beamforming.h is not used anywhere.
'git grep rtw_beamforming.h' returns nothing, remove the file.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8723bs/include/rtw_beamforming.h       | 127 ------------------
 1 file changed, 127 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_beamforming.h

diff --git a/drivers/staging/rtl8723bs/include/rtw_beamforming.h b/drivers/staging/rtl8723bs/include/rtw_beamforming.h
deleted file mode 100644
index 031496c8c02c..000000000000
--- a/drivers/staging/rtl8723bs/include/rtw_beamforming.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __RTW_BEAMFORMING_H_
-#define __RTW_BEAMFORMING_H_
-
-#define BEAMFORMING_ENTRY_NUM		2
-#define GET_BEAMFORM_INFO(_pmlmepriv)	((struct beamforming_info *)(&(_pmlmepriv)->beamforming_info))
-
-typedef enum _BEAMFORMING_ENTRY_STATE
-{
-	BEAMFORMING_ENTRY_STATE_UNINITIALIZE,
-	BEAMFORMING_ENTRY_STATE_INITIALIZEING,
-	BEAMFORMING_ENTRY_STATE_INITIALIZED,
-	BEAMFORMING_ENTRY_STATE_PROGRESSING,
-	BEAMFORMING_ENTRY_STATE_PROGRESSED,
-}BEAMFORMING_ENTRY_STATE, *PBEAMFORMING_ENTRY_STATE;
-
-
-typedef enum _BEAMFORMING_STATE
-{
-	BEAMFORMING_STATE_IDLE,
-	BEAMFORMING_STATE_START,
-	BEAMFORMING_STATE_END,
-}BEAMFORMING_STATE, *PBEAMFORMING_STATE;
-
-
-typedef enum _BEAMFORMING_CAP
-{
-	BEAMFORMING_CAP_NONE = 0x0,
-	BEAMFORMER_CAP_HT_EXPLICIT = 0x1,
-	BEAMFORMEE_CAP_HT_EXPLICIT = 0x2,
-	BEAMFORMER_CAP_VHT_SU = 0x4,			/*  Self has er Cap, because Reg er  & peer ee */
-	BEAMFORMEE_CAP_VHT_SU = 0x8,			/*  Self has ee Cap, because Reg ee & peer er */
-	BEAMFORMER_CAP = 0x10,
-	BEAMFORMEE_CAP = 0x20,
-}BEAMFORMING_CAP, *PBEAMFORMING_CAP;
-
-
-typedef enum _SOUNDING_MODE
-{
-	SOUNDING_SW_VHT_TIMER = 0x0,
-	SOUNDING_SW_HT_TIMER = 0x1,
-	SOUNDING_STOP_All_TIMER = 0x2,
-	SOUNDING_HW_VHT_TIMER = 0x3,
-	SOUNDING_HW_HT_TIMER = 0x4,
-	SOUNDING_STOP_OID_TIMER = 0x5,
-	SOUNDING_AUTO_VHT_TIMER = 0x6,
-	SOUNDING_AUTO_HT_TIMER = 0x7,
-	SOUNDING_FW_VHT_TIMER = 0x8,
-	SOUNDING_FW_HT_TIMER = 0x9,
-}SOUNDING_MODE, *PSOUNDING_MODE;
-
-
-enum BEAMFORMING_CTRL_TYPE
-{
-	BEAMFORMING_CTRL_ENTER = 0,
-	BEAMFORMING_CTRL_LEAVE = 1,
-	BEAMFORMING_CTRL_START_PERIOD = 2,
-	BEAMFORMING_CTRL_END_PERIOD = 3,
-	BEAMFORMING_CTRL_SOUNDING_FAIL =4,
-	BEAMFORMING_CTRL_SOUNDING_CLK =5,
-};
-
-struct beamforming_entry {
-	bool	bUsed;
-	bool	bSound;
-	u16 aid;			/*  Used to construct AID field of NDPA packet. */
-	u16 mac_id;		/*  Used to Set Reg42C in IBSS mode. */
-	u16 p_aid;		/*  Used to fill Reg42C & Reg714 to compare with P_AID of Tx DESC. */
-	u8 mac_addr[6];/*  Used to fill Reg6E4 to fill Mac address of CSI report frame. */
-	enum CHANNEL_WIDTH	sound_bw;	/*  Sounding BandWidth */
-	u16 sound_period;
-	BEAMFORMING_CAP	beamforming_entry_cap;
-	BEAMFORMING_ENTRY_STATE	beamforming_entry_state;
-	u8 LogSeq;
-	u8 LogRetryCnt;
-	u8 LogSuccessCnt;
-	u8 LogStatusFailCnt;
-	u8 PreCsiReport[327];
-	u8 DefaultCsiCnt;
-	bool	bDefaultCSI;
-};
-
-struct sounding_info {
-	u8 		sound_idx;
-	enum CHANNEL_WIDTH	sound_bw;
-	SOUNDING_MODE	sound_mode;
-	u16 			sound_period;
-};
-
-struct beamforming_info {
-	BEAMFORMING_CAP		beamforming_cap;
-	BEAMFORMING_STATE		beamforming_state;
-	struct beamforming_entry	beamforming_entry[BEAMFORMING_ENTRY_NUM];
-	u8 				beamforming_cur_idx;
-	u8 				beamforming_in_progress;
-	u8 				sounding_sequence;
-	struct sounding_info 	sounding_info;
-};
-
-struct rtw_ndpa_sta_info {
-	u16 aid:12;
-	u16 feedback_type:1;
-	u16 nc_index:3;
-};
-
-BEAMFORMING_CAP beamforming_get_entry_beam_cap_by_mac_id(void *pmlmepriv , u8 mac_id);
-void beamforming_notify(struct adapter * adapter);
-BEAMFORMING_CAP beamforming_get_beamform_cap(struct beamforming_info *pBeamInfo);
-
-u32 beamforming_get_report_frame(struct adapter * Adapter, union recv_frame *precv_frame);
-
-bool	beamforming_send_ht_ndpa_packet(struct adapter * Adapter, u8 *ra, enum CHANNEL_WIDTH bw, u8 qidx);
-bool	beamforming_send_vht_ndpa_packet(struct adapter * Adapter, u8 *ra, u16 aid, enum CHANNEL_WIDTH bw, u8 qidx);
-
-void beamforming_check_sounding_success(struct adapter * Adapter, bool status);
-
-void beamforming_watchdog(struct adapter * Adapter);
-
-void beamforming_wk_hdl(struct adapter *padapter, u8 type, u8 *pbuf);
-u8 beamforming_wk_cmd(struct adapter *padapter, s32 type, u8 *pbuf, s32 size, u8 enqueue);
-
-#endif
-- 
2.18.0

