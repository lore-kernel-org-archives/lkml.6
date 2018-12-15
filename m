Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2597C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F42080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICGDzmxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeLOQqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:46:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeLOQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so8106941wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcyOSZ26DyHNiYs8TZnhJAN7t6Pvik/6V+HgFXLXULI=;
        b=ICGDzmxw7Ao7d/ZmQerJX+YYp3eM/beaJAB0UShPZS5RNbEuxKdo+NbN7R6FPb3ePn
         xDfC0tVkPv2NJOP2szyFpBnoP4Qtv0WANu/OKm2I0QxemE6PBHXdhgqNokY41CNCMjMU
         gOXY/gxoGOqVG1W1QUDXzp1gO53h7SWtbtREY7A7xn03Os0xRDwnwlg/B0NXwaMOs3qs
         UPYhdcve85XeNDa+tL+vcIO/id7KHZg0PhspjgAWsL9GbBwvOojB0zpte3/yUNdPcJLg
         pUugPNgF8zFnzOwXmZ7CM+O3khmLm0NS9JYKM/z1FrRMSLP7SD9ui2plu+3+ReKTP+Vu
         zVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcyOSZ26DyHNiYs8TZnhJAN7t6Pvik/6V+HgFXLXULI=;
        b=CAIUy/lifgHaIJG8TH7FujpKF8iZKkOD9GElcHYIcyeIudJJcfg2Xup7b9RCcz6q9R
         hP2Pph8AWh4TJqbEBH+Sl5OtEpdeWrDFCsEg96IseLfnkvcRKyDMkkT1+BQCFYTLQtC7
         eQgHTNiuTM/5BbzIcV3SFqruYy6k4xOJ/1mswvyhmG0KJ5QT3UoLmCy//ngdIiIiSO/X
         4Upn+ERvxv90C98xNEpTb9U4tiygXOK0iRCs+TkG+NdPZ7noZnuFT75dPbqDGF8VN2Ev
         0svZzwD0UG7vwLHpdg8FiwY/PSAt6SSZCs9mRtb0/gu0njHzYihtb7VlG7KJTrVRnaZA
         bOWg==
X-Gm-Message-State: AA+aEWYHmqnl0BZdIpUsyQFaszmx9f2DOmmFdk1oqUmeLd9pbQsu3PIC
        OGU5S3/PvfrvBP4CS2F4DFw=
X-Google-Smtp-Source: AFSGD/UUnKaSEunpksBL1j82smS6aXMeAT2TbCbhFcZ5/p1PRfVViWmDzRNnv/ktjt5WY1M8+KSIHA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr5583529wrm.328.1544892392903;
        Sat, 15 Dec 2018 08:46:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/9] staging: rtl8188eu: simplify null array initializations
Date:   Sat, 15 Dec 2018 17:46:13 +0100
Message-Id: <20181215164616.2643-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy initialization of null arrays to improve readability
and save some lines.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_xmit.c     | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index b5cd9f6c4e30..a7d85070281a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -17,7 +17,7 @@
 #include <mlme_osdep.h>
 #include <recv_osdep.h>
 
-static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
+static u8 null_addr[ETH_ALEN] = {};
 
 /**************************************************
 OUI definitions for the vendor specific IE
@@ -5208,7 +5208,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[ETH_ALEN] = {};
 
 	/* main tx key for wep. */
 	if (pparm->set_tx)
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 14e3f59b9009..3b1ccd138c3f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -592,7 +592,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct	pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
+	u8 priority[4] = {};
 	u8 hw_hdr_offset = 0;
 
 	if (pattrib->psta)
@@ -605,9 +605,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	if (pattrib->encrypt == _TKIP_) {
 		/* encode mic code */
 		if (stainfo) {
-			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0};
+			u8 null_key[16] = {};
 
 			pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
-- 
2.20.0

