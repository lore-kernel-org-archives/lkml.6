Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F57ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5B720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="SRuWWUeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5B720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeGWOdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:33:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32863 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbeGWOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:33:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so573201ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CJFL3Tjfaz4goDPyuaTSoTuKkAhldVh/wuxnng17vQU=;
        b=SRuWWUeFZnkzIM9U/0uITU7edtRhvBYAQ3l3t/O5jb1dqn+rLM7dCslYuecIlrY4Uk
         JZtu5iXsRTzf2KoimVDWYzWXnLz7WB0KEAB34OVJCrAPAIGqPE7vezvT7MOyxsXsVkIf
         5tG3mrC835bRggE0YGZZ5Vrr0RDGu5QGAdMf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CJFL3Tjfaz4goDPyuaTSoTuKkAhldVh/wuxnng17vQU=;
        b=MBZ5frluGNoWR97yf7I4vO88Vg+1vhqiIhY6nhaGLUyQ75BkVqaOEj+EHT4QAlrX4m
         H7FUO9KhQKAB6mbgsvj9PpdqnTNVPqo8brYVO9IBz+CAvOK9VpkVM5gOvkhC+eVv4EGr
         sJy6Ox5Ipyb3kBtEU/Zo+Moiyxv8NYGXlen6aMa7a4/88Jf7Kyh734dzNKsrKRooxL0X
         o9tR+caD1Wadg7DaNMzutpaYk8M4xDLj26MXO3N7TLaOTByknFtfAEoXdi4AZnQL0y09
         cc1SFYe8iWEyqR5rli0QSmMHcQDKup5TnVIClyhKSAjNisorBUydCPRlzDdSx+GlGURL
         HV3Q==
X-Gm-Message-State: AOUpUlG3LwoUI7whm8M3oqDemcKRsMH5LytHq6cgKT05lWhJ4o10snl+
        VpdOmYmg7uQWkR6+69ZznOvNXg==
X-Google-Smtp-Source: AAOMgpdkBsIFMvAMdmyYqBJh23x5s9Yju1rQIt87xP6yw+GygE3v6j4T+L0P/LRPrDLQn2YgPGL0yQ==
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr8687333ljb.106.1532352736406;
        Mon, 23 Jul 2018 06:32:16 -0700 (PDT)
Received: from roman-VirtualBox.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id x23-v6sm1853054ljj.86.2018.07.23.06.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:32:15 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     akarwar@marvell.com
Cc:     nishants@marvell.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] mwifiex: Fix skipped vendor specific IEs
Date:   Mon, 23 Jul 2018 16:31:39 +0300
Message-Id: <1532352699-3232-1-git-send-email-roman.stratiienko@globallogic.com>
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

