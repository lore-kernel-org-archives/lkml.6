Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6C4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0721A8D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXdogOGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D0721A8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeHHXWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33890 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbeHHXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so1901934eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+eCCSBl1UjweY7gbTnwmCAIDQe2HZbmIBulllbMgI8U=;
        b=DXdogOGHnr4ONUiiAOS660eNfbfVtYvx2Lr3Zx389sbuVciO2EwhZ9CwF/os6fZVOc
         Tp+ARzO6pSGZGhG78Smeta4rL5tV96cDk7YMjH4ybshAU4d4NKRYi+aL9e5j6SFvcTq+
         r68uVVtWlRsS1s3goRJo1da0EAPr3l16UEQwHhwoPx+mfKbTZuVgttJrXVlmmIL1Rwl3
         XCZ5KFV/RK0UMdxroZ0m395cS594kfQEKsWoIhk8fU3I4vvtx4PRJOv7+8kVpgWKjuao
         3UltNpjQllWt5RKP3JInEipRw+9u+5x4ECc6smb/+/1sfTnErwBYQIopqMnaY++muLbc
         A9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+eCCSBl1UjweY7gbTnwmCAIDQe2HZbmIBulllbMgI8U=;
        b=X5WmBsTBMo0funeO+T3VMpVKWNO/RC/sBk7Tz0dwkzFjTcRxfNNzqjAKtjDja60Wbw
         podbSEmszq99DHvnzZ/jwgULX55fekEYCan53OEfs4YMLZUwxhRCNahwUTCFcSE5K/OM
         Lby7o6OBifk93xRJsIL2gGYvxLTDa0ViBUz3EiOtbyhFcgS4izWjfo88CK2CaqbpfKCk
         4X4xeVWYdlsfpQto8aECV34v2BI69KPztpUW0rGUeUbXT5guf6hVDEtOxrW2N0+46hBa
         ta6A+koObXCbN+jKomRgvFDPvELpc34b4toUVEitMAND5hAK4a39A3f8GVAfauIbAuAP
         UG8A==
X-Gm-Message-State: AOUpUlHJL8Oj6m/ZBWhn9iDP16dJl1Oaxt86py7XnrzGXuFahWSjAGXS
        vGZYU3klAOgedOElZJ++fdhxfqwldeY=
X-Google-Smtp-Source: AA+uWPyB+O9KBiPoA1e0DKMrx/jDO718MOMoyScMYr7xf53I13r0hLjN+6zF7AoSGfc70wXA3F1Ccw==
X-Received: by 2002:aa7:d993:: with SMTP id u19-v6mr4828731eds.125.1533762064323;
        Wed, 08 Aug 2018 14:01:04 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 06/15] staging:rtl8192u: Lines should not end with a '(' - Style
Date:   Wed,  8 Aug 2018 22:00:27 +0100
Message-Id: <20180808210036.22580-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of function prototypes cause a checkpatch issue - "Lines
should not end with a '(' ". This issue has been cleared by moving
function prototype parameters to the same line as the function name.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 47 +++++----------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 0263eca375fe..0856d5ea7991 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -43,42 +43,15 @@ struct rt_dot11d_info {
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
-void
-Dot11d_Init(
-	struct ieee80211_device *dev
-	);
+void Dot11d_Init(struct ieee80211_device *dev);
+void Dot11d_Reset(struct ieee80211_device *dev);
+void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
+			    u8 *pTaddr,
+			    u16 CoutryIeLen,
+			    u8 *pCoutryIe);
+u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
+void DOT11D_ScanComplete(struct ieee80211_device *dev);
+int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
+int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
 
-void
-Dot11d_Reset(
-	struct ieee80211_device *dev
-	);
-
-void
-Dot11d_UpdateCountryIe(
-	struct ieee80211_device *dev,
-	u8 *pTaddr,
-	u16 CoutryIeLen,
-	u8 *pCoutryIe
-	);
-
-u8
-DOT11D_GetMaxTxPwrInDbm(
-	struct ieee80211_device *dev,
-	u8 Channel
-	);
-
-void
-DOT11D_ScanComplete(
-	struct ieee80211_device *dev
-	);
-
-int IsLegalChannel(
-	struct ieee80211_device *dev,
-	u8 channel
-);
-
-int ToLegalChannel(
-	struct ieee80211_device *dev,
-	u8 channel
-);
 #endif /* #ifndef __INC_DOT11D_H */
-- 
2.18.0

