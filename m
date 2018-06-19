Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B7C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503EA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOenxpIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503EA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030783AbeFST5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45599 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030762AbeFST47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:56:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so847950wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=GOenxpIMY/sZa6cG6FiC0+BMI1r6yDSrpt1Sslx5Z0TQD93A03aA34xOgDd1ScQRsv
         C/D7DzPB6syQhp1Q7VAnrdOTqw9sboIP4/d5P1+ZVgp5SRbPmNSYXVC1ooPf1Z6w6UJN
         4UjzBPI8V3rHjzQuKGFUbRVJSDPmlyC7/0T0W0MbSi/S48VUayOy1TtD6WVX2HOmCy/r
         pnrxixBpDWNk0ZRWzmFY4RJPjJElsOo9j/qKiivEp5DzrTPT5h4R8QQqeI3WxvrH+cKA
         C3q2bAEtOos4AmdJWrxBhjk6jpIa16va8hk2FHQXzCs76dlVpL2czanhRCGWFFViHWCM
         6F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=X9NWYoUn3mfSp999Tu6+b3nXHOeDjU3H8pQ5IoBh4qDPQR7nfcb04p5myhg3QlLcov
         /j//EjcrDuEfQZbjywX52szDUJcM3nAhwG1+2yvMfLWR8cKDSBZ8iT7Yn6l4QuoR7zNr
         Hntx1+K7K+9YPTu2VDhqsdJ3CjDJxGqa8aJgz81MG79hoWFo9TKy24nBV5RYcdvcuEyk
         BRFsKckDD4cK0+Jnlhmsr8dmXILWQMblEBcjh8Tn8j02Zx8EYG6n1QeC7JwxEJcEhBM6
         R86aYra09uJPeYrzAIFS1utB75uo3AKKd4Q08QEd5ESLEnzP3Tn9c2s4GT09SCP3o3W0
         diqA==
X-Gm-Message-State: APt69E0qkcm7b9398YxcyEjxxk6nkR3uk5ca6xm7fie++HtQo4/mCgFh
        cLVijTultM6+JB5bFD1dPpY=
X-Google-Smtp-Source: ADUXVKJE5XTcTtqOjm8elTMhDJFE5bxvUr4oLWv/Y5mBTkiVNYTgWJOnF+7o5k/NER0DYMMxwdEvBA==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr14766094wra.114.1529438217934;
        Tue, 19 Jun 2018 12:56:57 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:56:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/9] staging: rtl8192u: Correct indentation of switch statement - Coding Style
Date:   Tue, 19 Jun 2018 20:55:58 +0100
Message-Id: <20180619195605.31321-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
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

