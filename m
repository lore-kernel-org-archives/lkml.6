Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6FB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV2OLcHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6FB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeLERDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeLERDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so13714713wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgQuH6GqzxJS5Yj5/6li80FqNeDhRna9oF01o90a8JI=;
        b=nV2OLcHQagbZcVNtPuKVyCoQphNgtCFiFXhaPl0uG4Ru14u+dECSh0Luouygy3U+ds
         /ZQMpXEEa9lZ5wMdUjEec1LczOefVR6PHoq1opYZ7Q0Jd1V1miktI4K/9323JePGoQRk
         ukTXjNbvih4fXdKbO4Ml3jqRPxoEAJeRZQTZ7Kpy4uUbS88foUIAvayvTHh9x3v1NATo
         5wb+/1SAoI9NYVm2RK/8gTOocchkZioTT6XLckwARKTwhjZO0ci4fes40oJoe/3BoVvd
         8wX3WiUr4ceJOoUNt9knqZPKvJ9sFss7GxOAyrMW9ThBlMDtAHMwsLhN5TWlFURXn4P5
         rR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgQuH6GqzxJS5Yj5/6li80FqNeDhRna9oF01o90a8JI=;
        b=GnAOkbxvTY30Q+ephtZ3Nt4vRREJxMCp1xQEHuc3OJC1sjCe/trUm5sc3CaC08YY0R
         p1mPIVdyOW4NHNHNzXeiFtUTVGRFUqw5TPpY1k9qZguxBJ9umqcqV/D6sdUzz2ibOJ+3
         zmcFw0ytojT8vc5/vi+5xMyPYXBj/OmO7aMBbuoEj8hnX9EkXUFsp3QZoRWOx0hao3DP
         ty4wOtCtOMQHM1UgecwUyvEhyyWRYx30O9se6UFWeulT2mYrVtWv4SUhI4xu+vRIzdiZ
         fXgZfcGC/f07KYraTUEZTMVkITJHmfbQNIwRwT1eGxKL9xhJ+HwR2+RzqurAw9u5ixzX
         c+tA==
X-Gm-Message-State: AA+aEWYZmszJwV5udZmtyaFfNIAlzGnwPLQFK9kuOeLaF26tB94ANQuH
        F27c4nLdPvb3PTqUoRhCtoY=
X-Google-Smtp-Source: AFSGD/WkIx8FblD5+1Uv+7j1femYs1Xtps/X3rUvgH8kVERojzjGnu3lZvRqS2Ibef3KpPLEUEprxg==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr16147226wmb.107.1544029380239;
        Wed, 05 Dec 2018 09:03:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:02:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/12] staging: rtl8188eu: refactor cckrates_included()
Date:   Wed,  5 Dec 2018 18:02:36 +0100
Message-Id: <20181205170247.5401-1-straube.linux@gmail.com>
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

