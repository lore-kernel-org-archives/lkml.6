Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED5AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B60205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="VLabVMhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B60205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbeGXMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:54:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45089 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388280AbeGXMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:54:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so2745568lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6/xTPi+7emPRzJtrBwUgC57J7A0FSIrj/WYjfZ7oaf4=;
        b=VLabVMhF6/dzX4q4AC0VprUmCH5ZMIa+nXlUWMcjs2izy0faCA4elenWbgzTq5+2f+
         SVkzKCKxFl3BZug8WLHOLCFBltAiHK0eXMqTE8JBu2pyxWB11BgDObE/1jKfjXi+kqb4
         rvYZKbJogIsnX0sU7TskircZu2tnagJRvExcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6/xTPi+7emPRzJtrBwUgC57J7A0FSIrj/WYjfZ7oaf4=;
        b=dfEemSdpLokLFDPVnjB1IYxG4WlrrB2+WRDtC/NnVPrldM9Sg4bTc+APkwENJbd+sL
         BLTFrI2WTdeJiH6v/F/u4w01D33Fn/92uQZvFigMZ4COfy0zm4fQZXnw1F9Cila9cJVC
         fhjuD1BaXihORbtbqZortKfty0lounHY3hBAIiAvko+9lC1OQB0vkfOVm4v/HIx91KsT
         nvn7nn3jqiHy506im+E5sViSme8uTmTz2Glm3sZJvRqgitx3XG+fd8CTsUdGGjufB7RO
         HsoaDcaKUaK5xbMAlItGawAzYxMH5UWv+W7Ar6CUQLt6jfFzg+vn1pDwCwI0oKQ9m+TR
         svTQ==
X-Gm-Message-State: AOUpUlEh4pB5/57SI/nkcsEpeUWn15MgcfbKq0j32Eksxj0KvYmI/Xlr
        Q0NMj4aOSFVTOJ1C+7uHRcxTrg==
X-Google-Smtp-Source: AAOMgpdo1bB2l657lmq22wvCVNCQ+rKewfl59s0gUNt9jFWAi9I+lohN4GQapOyb2d0NCttiVn7yDg==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr9676012lfe.60.1532432879477;
        Tue, 24 Jul 2018 04:47:59 -0700 (PDT)
Received: from roman-VirtualBox.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id 16-v6sm1792477lfp.23.2018.07.24.04.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 04:47:58 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     akarwar@marvell.com
Cc:     nishants@marvell.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] mwifiex: Fix skipped vendor specific IEs
Date:   Tue, 24 Jul 2018 14:47:27 +0300
Message-Id: <1532432847-2885-1-git-send-email-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Mwifiex firmware inserts only Microsoft information element
Allow other vendor specific IEs to pass from userspace

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/net/wireless/marvell/mwifiex/ie.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/ie.c b/drivers/net/wireless/marvell/mwifiex/ie.c
index b10baac..75cbd60 100644
--- a/drivers/net/wireless/marvell/mwifiex/ie.c
+++ b/drivers/net/wireless/marvell/mwifiex/ie.c
@@ -355,8 +355,14 @@ static int mwifiex_uap_parse_tail_ies(struct mwifiex_private *priv,
 		case WLAN_EID_HT_OPERATION:
 		case WLAN_EID_VHT_CAPABILITY:
 		case WLAN_EID_VHT_OPERATION:
-		case WLAN_EID_VENDOR_SPECIFIC:
 			break;
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Skip only Microsoft WMM IE */
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

