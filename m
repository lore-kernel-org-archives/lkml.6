Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A9F208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="DFhQUbFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A9F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbeGMRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:55:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45669 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:55:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id m13-v6so27812587lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CJFL3Tjfaz4goDPyuaTSoTuKkAhldVh/wuxnng17vQU=;
        b=DFhQUbFxEdNGoFRXT8h8nMfsbZi20AIWXVxtim+5c3V+jFv0B10aT+k/+FTQ8F97hJ
         YUFiJKec6ueI0T9l++SzenKcVEKlrkkcm/i8ukIKPveLYo7ALxbDq+p9t7T86sBokAGt
         RuNQbsN+ipTkRdoh/I5kPxQMQUCipXObdl1TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CJFL3Tjfaz4goDPyuaTSoTuKkAhldVh/wuxnng17vQU=;
        b=Vj+TSky7KzggyvumIDCnERNvlUCnrwy41owWI/jYzAdUSwLCUEDI1lzR0uBlgABybD
         4lSPAuJEhFVl1Clow4g6S0ACFTSw6WuBJER0jMyvWhjctXubdfffweMX/5jo2srRWHch
         r/YazmkQnPhBDcF7E8GS5Kvn1FXDIGwrOhfsDdVu4Qh0NifjpwvONy5BSCzKEmUu97So
         adcynzG+W2t5cJkqSkGuNpjooDDerTNkSG2n2r4RRRS9gO1AGGnLOab5gIpaUWKi6DU1
         00OOYieptZDS+rK0fSNmdwuH+rpKI7gK4pL3zBtY3X2ck/JMhawboGlKosfFAKeviY02
         8q7Q==
X-Gm-Message-State: AOUpUlEj/MDtRjOX+1g3RSOzTA5FHbxGnH21x517frpLLTwRSDhCROJF
        tXTQPGAt0hXX6kjlt4u/mYwTSw==
X-Google-Smtp-Source: AAOMgpeEegsiNJeg2V4yGGGZRFvrGtoWl8UzxH0eS0+wHLrs/ntp/eu2qLFuC3L10W2t1/blspFAzA==
X-Received: by 2002:a19:e119:: with SMTP id y25-v6mr6040352lfg.3.1531503575942;
        Fri, 13 Jul 2018 10:39:35 -0700 (PDT)
Received: from roman-VirtualBox.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id j12-v6sm6973662lfg.42.2018.07.13.10.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 10:39:35 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     akarwar@marvell.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] mwifiex: Fix skipped vendor specific IEs
Date:   Fri, 13 Jul 2018 20:37:33 +0300
Message-Id: <1531503453-27343-1-git-send-email-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Only microsoft specific IE is added by FW
Let other IEs to pass from userspace

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/net/wireless/marvell/mwifiex/ie.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/ie.c b/drivers/net/wireless/marvell/mwifiex/ie.c
index c488c30..c58b345 100644
--- a/drivers/net/wireless/marvell/mwifiex/ie.c
+++ b/drivers/net/wireless/marvell/mwifiex/ie.c
@@ -353,8 +353,16 @@ static int mwifiex_uap_parse_tail_ies(struct mwifiex_private *priv,
 		case WLAN_EID_HT_OPERATION:
 		case WLAN_EID_VHT_CAPABILITY:
 		case WLAN_EID_VHT_OPERATION:
-		case WLAN_EID_VENDOR_SPECIFIC:
 			break;
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Skip only Microsoft IE that added by FW
+			 * Let other vendor specific IE to pass
+			 */
+			if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+						    WLAN_OUI_TYPE_MICROSOFT_WMM,
+						    (const u8 *)hdr,
+						    hdr->len + sizeof(struct ieee_types_header)))
+				break;
 		default:
 			memcpy(gen_ie->ie_buffer + ie_len, hdr,
 			       hdr->len + sizeof(struct ieee_types_header));
-- 
2.7.4

