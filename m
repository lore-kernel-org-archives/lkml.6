Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635C220C51
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huB5DbcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635C220C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeH0A7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:59:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35811 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:59:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so2442115edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2je0fxPJe0FPcMt9hz8p1DeVxCYBSIuigNEjubMk2A=;
        b=huB5DbcHfHufr8ylFIy97wYYv3d5y+y93n3XVrqULBQwUg087ZwbMZxOXhoG74EDVt
         nGOCc7fv8W4ACsu+dCrj7Wma8TB6al3EBjvphl1TamaSmGlJLBOo2q7qFMpurqYdDI4u
         l2PWTGQdjEDaWjRi4Csxlv79ubBFdzLR1fS+Pycm5pm5VgvcOSZBy3Lft7FJR1xvUQ4J
         iNUXzamJIHX0ENdalWsU9Bg4Xbeb93zgvlUPaWurIiAKbtqxNZyttAEqpqd5NVq5el59
         z+ZLrsyboBTkL+LsIxlk0YqO71tnTNLzmDUhMA9K1XI/KwLb5nphU1M49p+NdjRwlc+W
         nXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2je0fxPJe0FPcMt9hz8p1DeVxCYBSIuigNEjubMk2A=;
        b=dSIhXjpZCVvV6Sgy4buv4K0IcsffFvPsVE+CeU528z7FrVUpAKS0LGgtnCKh5pzbtk
         IbheCqN8qaIyhdypXsOKKN0CIXGCZm2atc7w6VbZUMsxPx+sbE90PmpNMn0xX1XpC7ju
         go8IoD2T/OtjQydbx33nhBhGsBSbGIsVxcS6pBAMxhLJRY9vps7K/VexbzyKcZ+/noc2
         yNzKcKdjMz2PL3F/ARgYHbxafSZ7OprzaQAmAvanQcEPsqFqDhdv7IKxdH5JCuSP8Qg9
         FpIaIWrpuZrJobOnH9PBgsngaXJxKYqOWShmEqN2JbbFVjXVMKQCrkYafVr5t1Ic8F2o
         Oazg==
X-Gm-Message-State: APzg51DBQ9e0UcgSJSbFttaAi9W/HZEjOTdnQs6r55UrRsDrekskkdYq
        xK9ovIs/SA/TN+1fJpPsdj+eia2y
X-Google-Smtp-Source: ANB0VdbJdp7ynX2UIDF4bo39OATPXRvIeqKHxhfYYrw+W8cNSgwLu6OKYP6icE1w2jxjgFu07SXzFw==
X-Received: by 2002:a50:86b5:: with SMTP id r50-v6mr13703187eda.201.1535318121213;
        Sun, 26 Aug 2018 14:15:21 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 19/21] staging:rtl8192u: Rename EEPROM_Default_TxPower - Style
Date:   Sun, 26 Aug 2018 22:14:37 +0100
Message-Id: <20180826211439.14326-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename the constant EEPROM_Default_TxPower to EEPROM_DEFAULT_TX_POWER,
this clears the checkpatch issue with CamelCase issue.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_hw.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 236c4dee7921..5bb0602e8a20 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2430,7 +2430,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 				return ret;
 			priv->EEPROMTxPowerDiff = ((u16)ret & 0xff00) >> 8;
 		} else
-			priv->EEPROMTxPowerDiff = EEPROM_Default_TxPower;
+			priv->EEPROMTxPowerDiff = EEPROM_DEFAULT_TX_POWER;
 		RT_TRACE(COMP_EPROM, "TxPowerDiff:%d\n", priv->EEPROMTxPowerDiff);
 		/* read ThermalMeter from EEPROM */
 		if (bLoad_From_EEPOM) {
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 923d8ab5939d..af3f84065619 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -51,7 +51,7 @@
 #define EEPROM_DEFAULT_THERNAL_METER		0x7
 #define EEPROM_DEFAULT_PW_DIFF			0x4
 #define EEPROM_DEFAULT_CRYSTAL_CAP		0x5
-#define EEPROM_Default_TxPower			0x1010
+#define EEPROM_DEFAULT_TX_POWER		0x1010
 #define EEPROM_Customer_ID			0x7B	//0x7B:CustomerID
 #define EEPROM_ChannelPlan			0x16	//0x7C
 
-- 
2.18.0

