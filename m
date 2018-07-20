Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB39720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFdNejTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB39720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeGTVMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54964 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbeGTVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so10570253wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFMgylf5oMoSG98CBlBVM7xuyGwUx+upm/KW1e8IQ8o=;
        b=fFdNejTGrdwEIgg5jaPDo9k+OnVfflwOvVhvDZ5rTiC1+SI7RfAJ177JYoDc9/Mzkp
         6yW6jMZBo9LZMx1+0Hng/3r+UvrjvzRezLI0kR2huJWAW3Y6nslteBnRNSep0KSmmE+O
         MOEwiK6a13lKeBSi2sAafknKPNR8VN5ACwpb5Hqztp0S2qwAlpLyz5LCcKKFLSuRV1Ss
         p7EGZdIwqvjlL2IFSNUhp+AHEz6AcoMUVot2+WDtVJd7JsiGT6RllE4yr4PjB0pJ5EVJ
         ah9fRSnPG3x3L1pAMqgrS3jLlU+x0OR37oePpIySKSuLKMcSXKCvYWl4WeUnvurSqTJ3
         3zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pFMgylf5oMoSG98CBlBVM7xuyGwUx+upm/KW1e8IQ8o=;
        b=nNvnZkKc+PpzyIOxxO1PUmXndCYaPPYTMrtYJeU0gzs2I7uAsuzrrx96faAxp5MYbX
         CQdIA1N1wqDZnthjaDYCbTqjtzF4vWSgsTMbF1IDVgxDXr6NJY0POL4UHdTHbWwhSHFC
         hINADNPU7lzPRehpc5RH6OzvSqGOInsHokF+wj105wPCtcVNk3J73TPO85L+gSFceFfA
         vH9FnN7LXjyJZytVbeeJPJ8R3RgZXInsPU2EKsYMSBJwHCSuE4vrw+X6xQnsbbFbQCGM
         wax/1BhrdkMidm8G7ZaKzGdB3xk3gT90TqaeZVfDllfCPej9cFr0tp4XGCI2FlIeUqXH
         RkoQ==
X-Gm-Message-State: AOUpUlE8PVTohernfic7Hv3b5jG6k04ptBjs23jri6b3ODKMZi1uAt/h
        b/dABVF3kcocWrgyNwpsI/HCHypSU4Q=
X-Google-Smtp-Source: AAOMgpdIjx+UwlC3oPK8NshaViCWKr0bGkgkEQyeYVeYExb/21ZyeBdqlOUZRKE95dY6pps71zwIkA==
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr2276986wmb.118.1532118134198;
        Fri, 20 Jul 2018 13:22:14 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/14] staging:rtl8192u: Rename CountryIeSrcAddr > country_ie_src_addr - Style
Date:   Fri, 20 Jul 2018 21:21:39 +0100
Message-Id: <20180720202142.26312-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable CountryIeSrcAddr to country_ie_src_addr, this change
clears the checkpatch issue with CamelCase naming. This coding style
change should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 109b82e69b5e..e5087291d64a 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -23,7 +23,7 @@ struct rt_dot11d_info {
 
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
 	u8  country_ie_buf[MAX_IE_LEN];
-	u8  CountryIeSrcAddr[6]; /* Source AP of the country IE. */
+	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
 	u8  CountryIeWatchdog;
 
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
@@ -44,8 +44,8 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->CountryIeSrcAddr, __pTa)
+#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define IS_COUNTRY_IE_CHANGED(__pIeeeDev, __Ie) \
 	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->country_ie_len) ? \
-- 
2.18.0

