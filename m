Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D768244D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCUrtfql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D768244D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933940AbeFVPbI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:31:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33639 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933915AbeFVPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:31:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so7135193wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2ZlH7xDrgjT/fKc6oUH6UXBQrzwxrrlfmjK56mp0p4M=;
        b=mCUrtfqlGxXa83cn0/VaEL2TbcwRh9FM0AtVIudRuhEGQXA8RVHJFauUeVh0feWbVM
         RkZsLtLLNhyUn34C8kD47FruokSzGMq9E3Ox6SbT1a6tO+p57o8nJR5NLxb1wT+zBhPl
         QNgcqMWAiQjCQLi01ZbM80J5sZLytHg2lALroJDB1gbmpbrqJHAUSe3M8+6xUlJzIn/p
         Ti+QJyE+YXetrGzIHD/25B5R9xkwAqnIUE3WbOfkDx2+i8CQQ78DBL37kzwJ6NOU49jV
         zacEaMH+FpUYnzgi/bQCgD0DKK3ASaOfdFzCNAQQbP/muLCgm/IEAQh4y0ij1zanptls
         RLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ZlH7xDrgjT/fKc6oUH6UXBQrzwxrrlfmjK56mp0p4M=;
        b=bW0T81v43vP8/UqotLehAdWJIfhDHA2T8de+5+DOdPrg4nnsti7SeWVrfyjROv2cFl
         eGacfT5hwqfAbLMlGg7kO1oyLrk7nm2BtqU0bwnUE1OUcxoqgUVxKfYOG0Ns/l02a84n
         etdPwjeXAHlTMxKoVQKAUCUfDsqtktfJiJv1Hsw4l4dw/k4C8H/TBmN+jM5jwJZN0+gd
         LPLcocCYArb0Ofq/pKsnyzeT+wMtmj3+N+dbq9blfd9h0unXIg5rzDmoOu6Fna/0H/FP
         Q0G9USs0qi74Au9vZLDfGHAcLKk/3LB0Ya+55Vhrdd2/DGeoVDc2CwDdKCuTOOpFdX+h
         iNqw==
X-Gm-Message-State: APt69E1gXbYCG6NHXc6sY0yldr1FqSr8OzDXCogj5Jqm3o7dgajeZYLf
        cBgrbI5u/C8euPz8CT8xUB0=
X-Google-Smtp-Source: AAOMgpcXJvmRiAWr+gxZclxvxS75l6N7jtnhoKxhTJMN/VY/MRJJUANrxHGiduaxb/Jq8rK6WUAOiA==
X-Received: by 2002:adf:b297:: with SMTP id g23-v6mr1970925wrd.218.1529681464067;
        Fri, 22 Jun 2018 08:31:04 -0700 (PDT)
Received: from localhost.localdomain ([165.165.77.132])
        by smtp.googlemail.com with ESMTPSA id c201-v6sm2923291wmh.18.2018.06.22.08.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 08:31:03 -0700 (PDT)
From:   Chris Opperman <eklikeroomys@gmail.com>
Cc:     eklikeroomys@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: improved readability of function prism2_add_key
Date:   Fri, 22 Jun 2018 17:29:02 +0200
Message-Id: <1529681344-25764-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability of prism2_add_key:
a) Reduce nesting and removed goto statement by using more return statements.

Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 40 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 4291225..8320318 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -148,40 +148,26 @@ static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
 	struct wlandevice *wlandev = dev->ml_priv;
 	u32 did;
 
-	int err = 0;
-	int result = 0;
-
 	if (key_index >= NUM_WEPKEYS)
 		return -EINVAL;
 
-	switch (params->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		result = prism2_domibset_uint32(wlandev,
-						DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
-						key_index);
-		if (result)
-			goto exit;
-
-		/* send key to driver */
-		did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(key_index + 1);
-
-		result = prism2_domibset_pstr32(wlandev, did,
-						params->key_len, params->key);
-		if (result)
-			goto exit;
-		break;
-
-	default:
+	if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
+	    params->cipher != WLAN_CIPHER_SUITE_WEP104) {
 		pr_debug("Unsupported cipher suite\n");
-		result = 1;
+		return -EFAULT;
 	}
 
-exit:
-	if (result)
-		err = -EFAULT;
+	if (prism2_domibset_uint32(wlandev,
+				   DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
+				   key_index))
+		return -EFAULT;
 
-	return err;
+	/* send key to driver */
+	did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(key_index + 1);
+
+	if (prism2_domibset_pstr32(wlandev, did, params->key_len, params->key))
+		return -EFAULT;
+	return 0;
 }
 
 static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
-- 
2.1.4

