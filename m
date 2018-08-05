Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA8C46473
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3513218D7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG3ubbKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3513218D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeHEVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHEVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so10268456wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Dmlu67sax7CAqxxrePaf1+hkI+XMm++rNx/gbZNK0A=;
        b=lG3ubbKnM7Tttp8aTB9sbN32gDon3Cn51jIhudJCbXx/nxPUwr+WhSE/yDk5zc23bY
         GxUwRZVChwMhd3V4VFgZh+BEKuV/WlONZFLpqp7NS/4ASdmF8Tix53ylRKOl6qcCQd9p
         i+i2gGzPCqXvwen2X+tuZ8TYvvcDtq3LpxElW/5APupOHGm0FZU0TvtokNy+rtxL4glL
         XacsFQ27Kc+OxYw2Nt9Inp0JJz4/DuYDlsXe2oiNhJZ75FfGCJWc3IDJMQLGFaUuDRT6
         2fGVRPUPvoXM02msFtESd3ZhbLMix1sTk2NKY43s2RQeEf5TqHNu0ev2ppLoC7cSOYVs
         pXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Dmlu67sax7CAqxxrePaf1+hkI+XMm++rNx/gbZNK0A=;
        b=UmZAfsW8QDgO8vVlZCEVDr9A5SseBFSi6FgD9fVVNci6M+SDNVsW7deB4X0MN1QnSf
         MQztk04vX99pqqv8H9xMww4YIgvkVXVOVr5zGkPp6XJulAA9P6ZfSSzWgWe76UX98c/U
         G9kcWqj4YVKOv3na39tpaH3h/CZDv5MDSw7JgIbDVeJtPc1o629t/ESUHWtEahoVg8/B
         Qvs3sfHXvNbBI/s9JdbjOQtNI0N2iOB64fBfaZc/jaCfbHl8ENV+NJG0KUimDFfcx/um
         zi6HjtOTVjwQNtsgSaml3FKnMwKysdM6O4gMxgr6QnoJjxqhAYoaqYFsPiPhofEluCg2
         3XNQ==
X-Gm-Message-State: AOUpUlG4qxvaRRfz8y+C6Ir6hvygHsk2oV4rrbek3w6PHGyZ4INBE6Ng
        cymFtmTYdvLsVMIqdJHhdwY=
X-Google-Smtp-Source: AAOMgpcPz9DDOyNcEgZi8+6XeTYD42tZKTSLLz5P2nDbwMVTh7k//y5+U4tJv3OP7VdZdXIsDqlRpw==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr7956627wrd.187.1533495931308;
        Sun, 05 Aug 2018 12:05:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/6] staging: rtl8188eu: remove whitespace - style
Date:   Sun,  5 Aug 2018 21:05:14 +0200
Message-Id: <20180805190516.2133-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805190516.2133-1-straube.linux@gmail.com>
References: <20180805190516.2133-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 6925ec48dff1..a11bee16d070 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -15,7 +15,7 @@
 
 s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 {
-	struct xmit_priv	*pxmitpriv = &adapt->xmitpriv;
+	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
 
 	tasklet_init(&pxmitpriv->xmit_tasklet,
 		     (void(*)(unsigned long))rtl8188eu_xmit_tasklet,
@@ -30,8 +30,8 @@ static u8 urb_zero_packet_chk(struct adapter *adapt, int sz)
 
 static void rtl8188eu_cal_txdesc_chksum(struct tx_desc	*ptxdesc)
 {
-	u16	*usptr = (u16 *)ptxdesc;
-	u32 count = 16;		/*  (32 bytes / 2 bytes per XOR) => 16 times */
+	u16 *usptr = (u16 *)ptxdesc;
+	u32 count = 16; /* (32 bytes / 2 bytes per XOR) => 16 times */
 	u32 index;
 	u16 checksum = 0;
 
@@ -160,15 +160,15 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 
 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
-	uint	qsel;
+	int pull = 0;
+	uint qsel;
 	u8 data_rate, pwr_status, offset;
-	struct adapter		*adapt = pxmitframe->padapter;
-	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct adapter *adapt = pxmitframe->padapter;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct odm_dm_struct *odmpriv = &adapt->HalData->odmpriv;
-	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
-	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct tx_desc *ptxdesc = (struct tx_desc *)pmem;
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -328,7 +328,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	return pull;
 }
 
-/* for non-agg data frame or  management frame */
+/* for non-agg data frame or management frame */
 static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 {
 	s32 ret = _SUCCESS;
-- 
2.18.0

