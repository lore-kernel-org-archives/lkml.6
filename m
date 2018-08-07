Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F25C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E556021987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esbVGkgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E556021987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeHGXai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:30:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42708 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeHGX30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so51319wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgfLYmxA/BSp827gUwemSLaDUI/UpWu7sz6iy50AqoE=;
        b=esbVGkgssw5ffmVrUY1mjlDNtyZjzAEHWz0Vu/5nkLIZsvMsbB+BsahVUoA9A271Ye
         OsOJ6+8V2Rc8Z2GcaWXbWbJaR+nMKz50gLSEUSfDkvc0n7B6ycFNWxHXrgRYmukECOS6
         Q/d+6OR+jJjTtL7zAlqPWEZW4W1WJJ48OpsJDb1KtVjcEjjFT6Xj5BuxI1T330bP8GUD
         2wk2z9QEjBdYCUCqnpkdbraO8FxWyzJrizHsbD1rVJNVS1iLvpqt/KZ6HclzifbzkodN
         HitULQk+vhmy5Xa75rwwMaqohghiu6z55QrAiNmMHkDxvwQGKcqLvZv7fc9N+ALuFOYk
         Kxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgfLYmxA/BSp827gUwemSLaDUI/UpWu7sz6iy50AqoE=;
        b=YlU8iMsxRcdKJVRrPwaUGLqPrcnzsWTszcA1aVklK1b0CQK2DygBNc2lnF9WL/zZDR
         iuzkgaIAfBkTF6mJlqBaZqfBTkjV3+IT5B/Jj5SqvjEQpZ7porJOTPweBUZ4TqtmtM0S
         YySDQAQSWybj1My4Kc5GDnaBsiEECoQeUQcJWs++lAsFEZaeoRt+UlUc1aEkRp8uDxX9
         C73izqMA3VYy5a+5uzF3x96y72xIcsm3C66Yr5yxPCTdESPHnihc2K7wtb6CVWgFyHsR
         JuyCcltcLRZtYOVUTCrVOOtH5olWOZ+WyBogHlhmjJMT7rpnhEkcSRjzNT3HUp+UboB6
         FXhA==
X-Gm-Message-State: AOUpUlHGr9VlzYgkfjvI5+uDoJ1vm6l3ZhZzHtDC+x3TxcpEfBrl+ktj
        9nL2tXd7V35MKrnTlui3Uplv1gmM
X-Google-Smtp-Source: AA+uWPx6ysScmpWJwtLIWKCptkA4cst9tmwcUyDo7nCVw7dcg7LjCsCKjQ4F6d3g0fS5ujbkg5pYkQ==
X-Received: by 2002:a5d:6748:: with SMTP id l8-v6mr38937wrw.197.1533676387796;
        Tue, 07 Aug 2018 14:13:07 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/17] staging:rtl8192u: Rename cpMacAddr Macro - Style
Date:   Tue,  7 Aug 2018 22:12:43 +0100
Message-Id: <20180807211255.29343-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the Macro cpMacAddr(des, src), as it causes a checkpatch issue
due its use of CamelCase naming, to cp_mac_addr(des, src).

This is a coding style change so should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h       | 4 ++--
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 81a0bb20f662..a53f6454262a 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -33,7 +33,7 @@ struct rt_dot11d_info {
 #define eq_mac_addr(a, b)		(((a)[0] == (b)[0] &&		    \
 	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
 	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
-#define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
+#define cp_mac_addr(des, src)	      ((des)[0] = (src)[0], \
 	(des)[1] = (src)[1], (des)[2] = (src)[2], \
 	(des)[3] = (src)[3], (des)[4] = (src)[4], \
 	(des)[5] = (src)[5])
@@ -43,7 +43,7 @@ struct rt_dot11d_info {
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
 #define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eq_mac_addr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cp_mac_addr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(__pIeeeDev) (GET_CIE_WATCHDOG(__pIeeeDev) = 0)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 28cae82d795c..2f1886b4e977 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1944,7 +1944,7 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 					{
 						network->bMBssidValid = true;
 						network->MBssidMask = 0xff << (network->MBssidMask);
-						cpMacAddr(network->MBssid, network->bssid);
+						cp_mac_addr(network->MBssid, network->bssid);
 						network->MBssid[5] &= network->MBssidMask;
 					}
 					else
-- 
2.18.0

