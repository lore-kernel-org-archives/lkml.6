Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82567208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ChQEK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82567208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH0A7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39074 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeH0A7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so9106159edi.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CcbhNEhUgjrdL59jJmcoCY4Bn61AQlI0pO8lIzNatrI=;
        b=V8ChQEK9oGpEbnZlxqqfKkn3p/mmxe8YooXsTHtD3Eig847cxDmsZHLqK1kvTPsvhl
         yva9o3t6nTsw3InRP0nrABPXPpw+EUnabU4CviODPHLRB7sQdZEQ2ImQ67cunen6FODT
         kBauB3TZMF2WZrse5hRSPAd4e4EVYo5ZZVxDxRO3UVBjRZtiG/u9B8dZzESllLdg9xGH
         ++FDhFE/p4BXfzfvzQfeYLj3suZpNfB9zUtl2YS0sxphFx1JWWpakZ/7SOa2xpAssKkl
         qrp8LHvulHakr1kUrzKvuNmp9xlROVJOyo1NPhZZjvcrrKc2eq+alDueCGWgBc/WrIFS
         LFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CcbhNEhUgjrdL59jJmcoCY4Bn61AQlI0pO8lIzNatrI=;
        b=cjnvDXb/9X61dcdMg69o057tH3gRrHpGOik74uDvQeYQEhvE/iu/hlahg7bya0zXyM
         7ArHmgZFbQRYB5BiZ5xpEYcU4AyS2BWzatET8adt/sDasejyvki4cNt9caIpUVdFDWvX
         KRrlTUiURr3E6irRY9Qct8TXP8mCNKsyWsbmK2ZeaobQZIcjvqJ0ArYx5HkG++WaXLca
         GWi7Y7w/i5f2Tp3y3oRMc7/VvTbFZz9OcOTDKoYeiF6+UeLegmODDi7Leg879n9NNxpw
         0RIVXNCKDVDfo+KVTR4ZSl+PJwxUdfjCGA8yZ/DkeTGs97nkHVgpVGQLf3NNGudbFWgw
         mXMQ==
X-Gm-Message-State: APzg51DMWaZt87PkQpi9rg9GZq6N5MbfkQhg9AkbN4GXhxF+mur8eJ9F
        iExXoLNw75TeHqNfNFoRNUhGEktX
X-Google-Smtp-Source: ANB0VdbGEFBeBbEanPwisLuBf34C/0Ivj/etEiHWAXrZ3PtjvG95Uif3BoIJdeue9POwiq6Hur6Lhg==
X-Received: by 2002:a50:d798:: with SMTP id w24-v6mr13749403edi.19.1535318123843;
        Sun, 26 Aug 2018 14:15:23 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 21/21] staging:rtl8192u: Rename EEPROM_ChannelPlan - Style
Date:   Sun, 26 Aug 2018 22:14:39 +0100
Message-Id: <20180826211439.14326-22-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant EEPROM_ChannelPlan to EEPROM_CHANNEL_PLAN,
this clears the checkpatch issue with CamelCase naming.

This is purely a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 905484ac439f..b65684ceea7a 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2382,7 +2382,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 		if (ret < 0)
 			return ret;
 		priv->eeprom_pid = (u16)ret;
-		ret = eprom_read(dev, EEPROM_ChannelPlan >> 1);
+		ret = eprom_read(dev, EEPROM_CHANNEL_PLAN >> 1);
 		if (ret < 0)
 			return ret;
 		tmpValue = (u16)ret;
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 606ab46d1a0c..5a958335681d 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -53,7 +53,7 @@
 #define EEPROM_DEFAULT_CRYSTAL_CAP		0x5
 #define EEPROM_DEFAULT_TX_POWER		0x1010
 #define EEPROM_CUSTOMER_ID			0x7B	//0x7B:CustomerID
-#define EEPROM_ChannelPlan			0x16	//0x7C
+#define EEPROM_CHANNEL_PLAN			0x16	//0x7C
 
 #define EEPROM_CID_RUNTOP				0x2
 #define EEPROM_CID_DLINK				0x8
-- 
2.18.0

