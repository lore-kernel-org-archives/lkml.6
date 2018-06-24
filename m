Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC9C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365BA25008
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUV2vQJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365BA25008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeFXPgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:36:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36588 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755190AbeFXPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id u18-v6so2862526wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=oUV2vQJfVZ2Jf49/Pb1AyixchiAISQqVU9XcUadDbbTRP+lHO4gRYGdbbgQCT46uZB
         yVjPIa0m7oUHWFkqcZX8Steey6WwzBAcaGQ3H/IGCkp/N+AvNsZspAaRz4cKGUy0pgvh
         63F1KB5NSWlNG4Rk1kAEG4tdIKphk//YCDt8YLFZQGOT2rOWi61qbbAu1Vn/yuuUO+/N
         X9ORxHx1uzeait4qnUHCB+LzElLAPYtn9cd6bvmv9E6+nbVA+WkgtcDlGx9O7s/STzcc
         G4zgwophwcez/UDRAONKI/aO/AJjHrBr3KXKOjPoKMIRpVUtHoC5tawU19IPz3kgAjV7
         8FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=qLu6ARiBK+qR/Pv5HKwehXppUdY/H6bbmaJ9GmV06f2gs2tYKm6lmIhlRv8QSfLSjs
         fjX1ktD6biaiVn0JmGYZhBMB3YSoLENxMnOYvrkl6OgeECOZE0L0swyUAqPbTQvPZseC
         ugJRvrvjInVun2WZIeS0+aXTsRHn5eEyLRsiQ5Ed2aFNV40w5UK7/k4FhOQ4K/L4njw3
         IsxbRiAfX9A459w82XMee1z0boUdIFhYpKGk4yO5u/LRkwkliIiDSpPEoqm+YJXaJXq5
         MEfnqsBloypZQr5y5cu4HlhApKHKMWS/iAr86It1n9FKpcA9PJEZ5vYgnZg3LaPF6OV/
         254w==
X-Gm-Message-State: APt69E132a0AWErqS2eAKdvPpJATCtVfCX+iDqls4E+g7MV7f21tM4zi
        +3NYme2BVB3ILwaew6wGQ5TQmLUl
X-Google-Smtp-Source: ADUXVKLmN8Yrq7X69THBTk43bmfQ5i1sW9ZoipjHjGA1kiGne0Q3HToS2ndxLvUEA9HGfXIZxMameA==
X-Received: by 2002:a1c:1286:: with SMTP id 128-v6mr7239888wms.9.1529854560274;
        Sun, 24 Jun 2018 08:36:00 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:35:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 2/8] staging: rtl8192u: Correct indentation of switch statement - Coding Style
Date:   Sun, 24 Jun 2018 16:34:48 +0100
Message-Id: <20180624153454.27356-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra indentation from the code of the various case options in a
switch statement.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 54c48747f5fa..4bfadb49c363 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -753,28 +753,28 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
-			//legacy rate routine handled at selectedrate
+		//legacy rate routine handled at selectedrate
 
-			//no MCS rate
-			for (i = 0; i <= 15; i++)
-				pOperateMCS[i] = 0;
-			break;
+		//no MCS rate
+		for (i = 0; i <= 15; i++)
+			pOperateMCS[i] = 0;
+		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
 	case IEEE_N_5G:
-			// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
-			// Legacy part shall be handled at SelectRateSet().
-
-			//HT part
-			// TODO: may be different if we have different number of antenna
-			pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
-			pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
-			pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
-			break;
+		// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
+		// Legacy part shall be handled at SelectRateSet().
+
+		//HT part
+		// TODO: may be different if we have different number of antenna
+		pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
+		pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
+		pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
+		break;
 
 	//should never reach here
 	default:
-			break;
+		break;
 	}
 
 	return true;
-- 
2.17.1

