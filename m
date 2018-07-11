Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C65C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401D420835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkHJsnsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401D420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbeGKL23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39963 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732586AbeGKL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so18938379edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kx8tvCbBy1mMU7WGFBL4/CvzhC+0eFSv5pOZ65pnSfo=;
        b=QkHJsnsa/oSTlgo5kU4cr5r7apGA4rHmbcsd508XvAB/bgFCfseCFSWsQphBQZ7Xlf
         I42l64oANAL3bKar19jST4RKGIBqabZV9ooZWWUFfhB7UDmqOHbAbDigfjIzC77PlYe0
         Jl0Uv1/oNpFpWS/W1Vi8nnhsc8gPGjEufuoL/bnYz1ofnGZED4Z+PnkVO1zKDx7a+ya+
         UGqu4qNpQ2tG1nMzDeBe2HjNhCk+NopvPDtP7JlnlMI0rLBE1D0PpBJXeWbB8CBLLQdA
         WVUvfiOM+qGMiQVlvPCMsoeqfthVYjBcPb43h5//juJ9o5QECgIj2T0cZRj5mw1z0OW8
         I8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kx8tvCbBy1mMU7WGFBL4/CvzhC+0eFSv5pOZ65pnSfo=;
        b=XaCrub1XK1CZ8cJFfziNIaJXe6q+891mtpBh8xtQ8BZ6I4pGgQUnKv7ld0O5T0kocb
         TENhGnD4y0SJ4JQRGZCBZb9VdvGUJXV5ZotngLi73M5GxauZHaDT0kQjATswiwn/9NdR
         T9XJfAX4G9Yvn+f6JsoP5/W5t1v+UMcUrXy7UjQFjzrwtb2TO42krGnUBLLnVX6+Rp67
         K3FRwehtF4CI2nNSMU1Gz/A7cqogHwND9y2gDYoTtmPIdoSRX3Yvp6CE43TosyuUfYZS
         fYDB91VfdvZF0bt7ZLqabvfuJcxerzxSslY1HMDQcGFIMe67btGIkcz927GPr8O7VawW
         9/mQ==
X-Gm-Message-State: APt69E2pX2YhiBij6j+0TmDQM958K88tsN8fF6eeWnYDZB5WSwbirw69
        OxjcCSYaqHRey0JMmMmUVSWKJSkmO7s=
X-Google-Smtp-Source: AAOMgpd4jz8ayl9oq0trfJM5NLXAzy9TIb1HQyXcI0vosM9SAqX+mESpswzTJcr1jBeIBo2RpFgRtg==
X-Received: by 2002:a50:d7cb:: with SMTP id m11-v6mr30718058edj.19.1531308274006;
        Wed, 11 Jul 2018 04:24:34 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id h1-v6sm8186346eds.68.2018.07.11.04.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:24:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: simplify ratetbl_val_2wifirate()
Date:   Wed, 11 Jul 2018 13:23:30 +0200
Message-Id: <20180711112330.28020-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711112330.28020-1-straube.linux@gmail.com>
References: <20180711112330.28020-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify ratetbl_val_2wifirate() by not using extra variable
for the return value.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 53 +++++--------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index fef04310ccd8..2c65af319a60 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -140,59 +140,34 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 unsigned char ratetbl_val_2wifirate(unsigned char rate);
 unsigned char ratetbl_val_2wifirate(unsigned char rate)
 {
-	unsigned char val = 0;
-
 	switch (rate & 0x7f) {
 	case 0:
-		val = IEEE80211_CCK_RATE_1MB;
-		break;
-
+		return IEEE80211_CCK_RATE_1MB;
 	case 1:
-		val = IEEE80211_CCK_RATE_2MB;
-		break;
-
+		return IEEE80211_CCK_RATE_2MB;
 	case 2:
-		val = IEEE80211_CCK_RATE_5MB;
-		break;
-
+		return IEEE80211_CCK_RATE_5MB;
 	case 3:
-		val = IEEE80211_CCK_RATE_11MB;
-		break;
-
+		return IEEE80211_CCK_RATE_11MB;
 	case 4:
-		val = IEEE80211_OFDM_RATE_6MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_6MB;
 	case 5:
-		val = IEEE80211_OFDM_RATE_9MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_9MB;
 	case 6:
-		val = IEEE80211_OFDM_RATE_12MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_12MB;
 	case 7:
-		val = IEEE80211_OFDM_RATE_18MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_18MB;
 	case 8:
-		val = IEEE80211_OFDM_RATE_24MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_24MB;
 	case 9:
-		val = IEEE80211_OFDM_RATE_36MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_36MB;
 	case 10:
-		val = IEEE80211_OFDM_RATE_48MB;
-		break;
-
+		return IEEE80211_OFDM_RATE_48MB;
 	case 11:
-		val = IEEE80211_OFDM_RATE_54MB;
-		break;
+		return IEEE80211_OFDM_RATE_54MB;
+	default:
+		return 0;
 	}
-
-	return val;
 }
 
 int is_basicrate(struct adapter *padapter, unsigned char rate);
-- 
2.18.0

