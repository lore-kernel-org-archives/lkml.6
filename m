Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73702C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2809B24EA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxr8yojP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2809B24EA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeF2SLB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:11:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40390 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935576AbeF2SK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:10:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so2946573wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4flmnPjT8vkR+6GoyurWGLCqeJhzlxP9VWMDyEY3q4g=;
        b=gxr8yojPJQpAti2mIsIOfjT5vAMXu65e6a54kpZhiHGedLaUHsPvsfU6oGKvgRy+M3
         ig9/VMxmDdeCSnvp12E9Q3fKXv1jlmMIdNST41xIgqk4m54vAbx/r87tMd4O6nqEq1l8
         WT6b5QPqLwDWOUsYHnaDdHdeYefI0nKbbT8BCHV/h37jdBLxAjKB828xd4vYJkCLVuLX
         xcpLGyb1AO+flAcVMZpn96TG4dDuPxaT6rck34e9up2e0X9+a6FmAMVp9hJLWnnR/zZl
         /6aGymCcSJzZW54HCgqhWJ4KBCYxcXW8kumqPyXCCwNuDde6GcGdEGKau1ibed1NZbaJ
         slOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4flmnPjT8vkR+6GoyurWGLCqeJhzlxP9VWMDyEY3q4g=;
        b=X52fuDSs7xRIHo21HUE4EmAD4uWzWMZ6omL16bpBsRnab8ofTjoCVn2lCGqZyZu0+z
         dkbxXLGlra1fjKz8KdWLsveR5mtsvQiBKhLxHyCYsnIG1l/IOKvrqK8R08isxzVmosd2
         aASSyMjSooD9CS7SLmh+WI4SIlxTtke2azCcCM4piYobSU9zkIPw/+J5KWCuP2320Ff/
         ab2sgBbo0RFATf1a6gMtnWdfB18SapcuA+Kp0pYY8wBgrO5H5DgxcrzikMw77Cs6vkuw
         0LryJVbPChea4/FO10Sp8UzbdqNV1sv2Wz4py1oNAP3oEON8EXljw5tz+f2knmyJcs/T
         pd1g==
X-Gm-Message-State: APt69E0iHY7/iNJf6oBt1LlXLJJvyF1+aENX+tXXOcSCu5ndCgYIZJQO
        UKpRL4UkptUm8bZKwQJL9bA=
X-Google-Smtp-Source: AAOMgpeKDmGHIGD4DnRhxB9IWvV7Idj5TKuJRpOxByNcdQ0vdXe4OWdgWvcczfzOzzAFLLASC5pQow==
X-Received: by 2002:a1c:6bda:: with SMTP id a87-v6mr1067198wmi.144.1530295856204;
        Fri, 29 Jun 2018 11:10:56 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id t10-v6sm11071491wrq.74.2018.06.29.11.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:10:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192u: Use __func__ instead of hardcoded string - Style
Date:   Fri, 29 Jun 2018 19:10:05 +0100
Message-Id: <20180629181007.18071-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629181007.18071-1-johnfwhitmore@gmail.com>
References: <20180629181007.18071-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chnaged logging statements to use %s and __func__ instead of hard coding the
function name in a string.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 1dd4c6ae7319..a4fbc0435de5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -534,7 +534,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -645,7 +645,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
 
@@ -709,7 +709,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -758,7 +758,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	u8					i;
 
 	if (!pOperateMCS) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
 
@@ -820,7 +820,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -900,7 +900,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== %s: HT_DISABLE\n", __func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.17.1

