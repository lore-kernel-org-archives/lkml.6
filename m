Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186E2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ05k+WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E186E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeGMSVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:21:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47021 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbeGMSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:21:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so25230208edo.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7WX4V5QOhke0i6uZMJey8az4FUMnCTjeNcgsvdKgvVM=;
        b=pQ05k+WGRitDtK/Hm/ODxuIbHdWGVdgFHw1ujUWPO3cDgZHrKPh/Vb/W3SesAbshHF
         vIPJJdnao4+15vjKzJ6mFyJ8YtpF7vEqmnWJy6SHZIVMvbww7tlVyLVKw28X5e6OBSCZ
         zIBaTs+HDc2mZsJBYFI91vuIyTkrboBBd7BWHCl7BpjsCQzCarAhW40nchtGVxdKy3q6
         d1mGu5oRF4+elmfCegxGe2fkWGJgy7py/CVbqI2++PFciklRlOijKZHh3WcShSKC7XOh
         kBVu4M70DJR33Rl0yP45AhSxzO23fajRLCcYcaK3cXt2vvV3Qr3heOgAkp4JEKfRttOT
         vFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WX4V5QOhke0i6uZMJey8az4FUMnCTjeNcgsvdKgvVM=;
        b=i58SIH3oMUiJk7UcsEO1fpljJrKqx0gBKERC4cGdQhSl+bf/RxHIMahARB5zSFekPH
         KZwlGc0fTcWbZPNo/GCICfYxOvf0Q34BOD/Y3CHUQ5L4mlNxx/OQbfk5Yq9GyLeJ3HNJ
         +bdSq9sX6QBbae7Nq1uyaVoRedldOq4HTsxc0QOf1x+rY/xI9bPFSYZozX8uLhYqwtjV
         l99uKvuxcSj2gzWy7jrCFk9vrF7bkYRh0Vdw2fq1OH+N6qr5VY2YVwxjVF3Uyo/UyTqG
         fHMSbruW1bAAV7xZkTcyYYd8RibvEICwILhG8gFsJ59hE3oOM82wBDrcldwSl3qBo7HJ
         eRTQ==
X-Gm-Message-State: AOUpUlED4Al0S94tcHRMDRr4DIOVLpc7U99V/6sCkW+J1Oq3xJtwXaBO
        onXg8+zSVV1MCI5YTEJYN7XOLhTTaYc=
X-Google-Smtp-Source: AAOMgpdDw6PZSgcuQwQi/DSYVPWIsykjAoaAw0cfUiOnkyP0s6FqzKuhBnl8sctIfXb6tTv0Rj+tCg==
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr8054065edw.295.1531505129796;
        Fri, 13 Jul 2018 11:05:29 -0700 (PDT)
Received: from arch.localdomain (x4db1a45f.dyn.telefonica.de. [77.177.164.95])
        by smtp.gmail.com with ESMTPSA id x40-v6sm17982604ede.23.2018.07.13.11.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 11:05:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove is_{multicast,broadcast}_mac_addr
Date:   Fri, 13 Jul 2018 20:05:08 +0200
Message-Id: <20180713180508.11500-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove custom is_multicast_mac_addr() and is_broadcast_mac_addr().
Use is_multicast_ether_addr() instead.

By definition the broadcast address is also a multicast address.
is_multicast_ether_addr() returns true for broadcast addresses.
Hence checking for multicast in the conditional is sufficient.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  3 +--
 drivers/staging/rtl8188eu/include/ieee80211.h | 11 -----------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 79567cf470de..53c65d5463c0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -952,8 +952,7 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 			if (!memcmp(padapter->eeprompriv.mac_addr,
 				    GetAddr1Ptr(precv_frame->pkt->data), ETH_ALEN))
 				psta->sta_stats.rx_probersp_pkts++;
-			else if (is_broadcast_mac_addr(GetAddr1Ptr(precv_frame->pkt->data)) ||
-				 is_multicast_mac_addr(GetAddr1Ptr(precv_frame->pkt->data)))
+			else if (is_multicast_ether_addr(GetAddr1Ptr(precv_frame->pkt->data)))
 				psta->sta_stats.rx_probersp_bm_pkts++;
 			else
 				psta->sta_stats.rx_probersp_uo_pkts++;
diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index 1668bb531ead..3fbd92a95b17 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -515,17 +515,6 @@ enum ieee80211_state {
 #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
 #define DEFAULT_FTS 2346
 
-static inline int is_multicast_mac_addr(const u8 *addr)
-{
-	return ((addr[0] != 0xff) && (0x01 & addr[0]));
-}
-
-static inline int is_broadcast_mac_addr(const u8 *addr)
-{
-	return (addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&
-	       (addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff);
-}
-
 #define CFG_IEEE80211_RESERVE_FCS	BIT(0)
 #define CFG_IEEE80211_COMPUTE_FCS	BIT(1)
 
-- 
2.18.0

