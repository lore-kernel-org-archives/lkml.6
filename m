Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C15C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A31C20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCdmfuhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A31C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeLESbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36534 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLESbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so14011008wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0El18dIbpocP0K6yKLPsm89tnnonihpeWlupp4ghgQ=;
        b=WCdmfuhSWiPT6grewOs4KvT/i1hlhLeRMhiD1qyr3ApwsjnmtDvV+tQTH4JL423+fi
         SDeELOnmj59/AGxL9Iv6vF3VYIY+2KRaarMjO1QtgkAxEFE+VP8XEOrO4NtxtOPFqmvM
         6WzwgpxXZcA/mnkF3cfiQKbrLxhLBsc7ZpOr2AOA0ut0WIdYrueNjtZeTEKRau0oTeIy
         S4CdanKHVWOyHCm1t9MOiviEBoXeP16NMWEscBhteRkQ0dFiqPANewzFfYIIM8h2Z7GS
         wr2oTw75Pw6R0oUIvQe8EPH1glu1kSe8emBaJCex3rkZTWGAtlXnKHbFzbKbrNAgY+h/
         QPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0El18dIbpocP0K6yKLPsm89tnnonihpeWlupp4ghgQ=;
        b=VDVm9020hjqfOuTjHcbMOAHe6Gg/kyGLAA0TTa6O3KHns0Cjx0jjuY907UtcRmas0q
         VVozDd8lGifgieX4+smnRy693/n91pfXO/y+sYyTc5kqMDQXC3/OHqcmDnFENzc9Ph0w
         oXvAOntRs0suErSAT8wPCU/4fCA+ORdEZzKCbo3MAUPISzaIkgbbD5muePX1O9I8tfzf
         bcER996Mzs0rDABnJ7wPJbv4fWbie/6XPPZIbUxjoGay8rwt/Ykzpv0Coy5/V1b5B2Nj
         K+QU9wKjelGznXTXscsOCtI9XJWIBI5wYzyQzu7cgBrHLdMvmt8FRT6FRy+nrTMhPr7O
         jhfw==
X-Gm-Message-State: AA+aEWajbKlQRWrlbt35TBuvqBINYRR6ocv96L4vi01FsxOL+uhdfVvS
        3drM3bgtyp9rc8JS4BcqchY=
X-Google-Smtp-Source: AFSGD/X19ROy/a3AJQU20xrEsXeU2CHkDGpZfIieposvTVWaOsk6SxYwAK5JjiPX+WGeLxKM6lpesQ==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr17293527wme.73.1544034674348;
        Wed, 05 Dec 2018 10:31:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:13 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 01/12] staging: rtl8188eu: refactor cckrates_included()
Date:   Wed,  5 Dec 2018 19:30:49 +0100
Message-Id: <20181205183100.16828-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor cckrates_included() to improve readability and slightly
reduce object file size. Also change the return type to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Changed patch 10/12 in the series.
v1: staging: rtl8188eu: correct indentation in update_wireless_mode()
v2: staging: rtl8188eu: replace if else with ternary

 drivers/staging/rtl8188eu/core/rtw_wlan_util.c   | 9 +++++----
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 24918223499b..90160d5fc292 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -56,13 +56,14 @@ static u8 rtw_basic_rate_mix[7] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-int cckrates_included(unsigned char *rate, int ratelen)
+bool cckrates_included(unsigned char *rate, int ratelen)
 {
-	int	i;
+	int i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+		u8 r = rate[i] & 0x7f;
+
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
 	}
 	return false;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 9526da3efcc4..c86dec12dec2 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -580,7 +580,7 @@ void addba_timer_hdl(struct timer_list *t);
 	mod_timer(&mlmeext->link_timer, jiffies +	\
 		  msecs_to_jiffies(ms))
 
-int cckrates_included(unsigned char *rate, int ratelen);
+bool cckrates_included(unsigned char *rate, int ratelen);
 int cckratesonly_included(unsigned char *rate, int ratelen);
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
-- 
2.19.2

