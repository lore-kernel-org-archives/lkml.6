Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D5C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C13218C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joLSwRTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C13218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeHEVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36053 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeHEVLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so11947509wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uDJmmPrzdKoW28Dg3FWH4BE+Zu6fV5gE4dUPmthPKe8=;
        b=joLSwRTKvESobnoabhQy/nGNIO8TRQ7nN8KDtYbIIg5y6YPEskGaEqYHdONf5Zjoet
         Pc8J/N6JJulo1w348YUhZ1/S93XPO5hs02TeSgCcVLzxw/l+M65l/uSsXRDO7Rp+/w9G
         DntxAFzJOy3kH2Kn7RyBrYmobz2bbtACPPOmf8tGs+IpP41FSCx1PbkNGUBQFHCDpBit
         SQCdCLMAGEWEV57ULpBSMEN8pe/XwgYDr+dbfw+Y8uY8TOxxEgSLlG2QADdEyG16aPmc
         9h6jAiYTxzMgQkV9TgbSwHgtvbeDNMFGcM6XGsqdQJQeemwqo2zsv9RrhAvg8fKh+DDD
         ysYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uDJmmPrzdKoW28Dg3FWH4BE+Zu6fV5gE4dUPmthPKe8=;
        b=p0ILzi5jhbqnSqQsippE5JJL0Cf+ZK6JN7VTnAbja8HpY28fSVNVkZch/tBcoBdv4M
         aFtcf9QdXeGSKB1DktoLSIdva7pQRZKC5900rzZ279zjHbZqs36CziU8ZwpWU/wuX7uv
         flE9rCFLKiq18rEzOrwQU4LA7fqpTQ4gZjHxan4QdmY87qkDmRFg6SYR8Z+xHJdyld1m
         NUHgb71bZn0g2m2cSzrYroIyYoGBM5P7tQdbKDfcW4pOzcuyvBD8Ys1588LS1pU8zU7s
         EiqdhNKeYBZi9j/W3uFHE8FJHmcDiKzHZc5Flo0B2tN3Vp2hCk5V3okRPRzBoXWQg70+
         KCFw==
X-Gm-Message-State: AOUpUlGT4C828tsNsZn6aCMTfodcNFagVBZ5V8H4j8DjwmlYBiifg+yz
        TTX6tAjF+0G/LeFkG0xBmfrt6e2x
X-Google-Smtp-Source: AAOMgpeKs8c/o2LrH1y7NH43hxf6rUnG611q/wfreuvA40vtWlnLYS9XKTi9fvMKliE+/kxZxk3vmw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr9372775wmd.18.1533495926898;
        Sun, 05 Aug 2018 12:05:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/6] staging: rtl8188eu: use is_multicast_ether_addr in recv_linux.c
Date:   Sun,  5 Aug 2018 21:05:11 +0200
Message-Id: <20180805190516.2133-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
os_dep/recv_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: changed duplicate subjects

 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index deadf26ea2aa..6f74f49bf3ab 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -84,11 +84,11 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-		int bmcast = IS_MCAST(pattrib->dst);
+		bool mcast = is_multicast_ether_addr(pattrib->dst);
 
 		if (memcmp(pattrib->dst, myid(&padapter->eeprompriv),
 			   ETH_ALEN)) {
-			if (bmcast) {
+			if (mcast) {
 				psta = rtw_get_bcmc_stainfo(padapter);
 				pskb2 = skb_clone(skb, GFP_ATOMIC);
 			} else {
@@ -104,7 +104,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 
 				rtw_xmit_entry(skb, pnetdev);
 
-				if (bmcast)
+				if (mcast)
 					skb = pskb2;
 				else
 					goto _recv_indicatepkt_end;
-- 
2.18.0

