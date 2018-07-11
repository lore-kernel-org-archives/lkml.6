Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6832FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C579208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtxwrNwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C579208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbeGKMbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:31:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34097 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:31:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id d3-v6so19100429edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEb9t61NZRx/iCqLFFfpa7OJkoCs2qmoBz2fN0u8t1s=;
        b=WtxwrNwCoCsGtKG9gesMVRXxL7HKUBuViYHgRL65oY86c/36qz9KL287tPsbwPHeP2
         yVCYe3d2szNBr5+z9IkJucsy2H97ASLMGzr9sShoRqbPVW6vsYR2HrGn/6CERifYHvB5
         qh2jk0YaK9cgclimLe6EYWfFHXaxL6A41x5eQgfuBX653YY6dF489abujfBjt5bzM6er
         /lim6MZTO86RNSRuUk1MsXKyvmx508ImQidReQB5Ftanzy+ZCd4zfYfztloKeJ5mRhoj
         bzoVeBPib1uFzC4cBSllTgr5wv6o+q/Y7cU6VsezGpGPV7dRUARsxpzSpbBtUgFGL1o2
         ljGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEb9t61NZRx/iCqLFFfpa7OJkoCs2qmoBz2fN0u8t1s=;
        b=jEoXjqKQ7/yxS30B3F3paUx7lgSoyyuk544egn+h2F60CRwFc0vJFnHqtraM+3KuCo
         2zMQrv5aadzoq/M1tL6EEL6cITOfBre1t0lkWzGox5M9dqwoKpDKFJHMoViK1OffX70U
         A5WQWVQbz1jrYt/CE5PMTUTEsMmltU9eCQg03cR6dFEsCHhp3w3IDOwm415Pg9NkvJyA
         qbgIHTlrr3gMTJgxb/FEEOBfVw/6yxdt8EXboae7IYP3d9WrpMX/xd9j7VtGjz87LFRy
         tjmjTHDtxHR2J9PBO/WDyifJL39T3Cq7BjYQ+v2s/0jeIVzzyxCM9/qx7OZydTfNgHHY
         TL1A==
X-Gm-Message-State: APt69E3TwHs4ssGusJoF/sCo2ZAUCBd2Pjp9dw0dWAzPqQYs8BUG85m7
        RBI8lFgZAV74RcsZl2k7aAY=
X-Google-Smtp-Source: AAOMgpd860yr9pE4kJoadXHauHGEeC5B5Ov0FZ3CTHl35QbprialyiqezRYVMltkHrokgr2WrtbOsQ==
X-Received: by 2002:aa7:c454:: with SMTP id n20-v6mr31302754edr.267.1531312057159;
        Wed, 11 Jul 2018 05:27:37 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id i12-v6sm11855623edf.26.2018.07.11.05.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:27:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: fix lines over 80 characters
Date:   Wed, 11 Jul 2018 14:27:14 +0200
Message-Id: <20180711122715.22234-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711122715.22234-1-straube.linux@gmail.com>
References: <20180711122715.22234-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines over 80 characters by adding appropriate line breaks.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 54a48ccfcb0d..1aed507dd7cb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -34,19 +34,25 @@ unsigned char REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 #define WAIT_FOR_BCN_TO_MAX	(20000)
 
 static u8 rtw_basic_rate_cck[4] = {
-	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 };
 
 static u8 rtw_basic_rate_ofdm[3] = {
-	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
 static u8 rtw_basic_rate_mix[7] = {
-	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-- 
2.18.0

