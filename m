Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142ABC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A924BDE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZWSgkA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35A924BDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934955AbeFYPNm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:13:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38981 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934884AbeFYPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so8638348wro.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vMbC7me8qNkOxK4Ddp6UZnSI0/+rni3gGHPFEZKB0WE=;
        b=GZWSgkA+tdlUd10D+Rmqj1VyhytXvuTfIc5+T2vr4THReYTue1BxyYk7aKxIL9ykxN
         YgpRx+Q4k7ENp1aP1M0Ih6n1L9KUNfexUkPpY75WdH7MtDn1LsbMVJV2V4u31QsIsnR9
         ipvrlI56QWWkSOlKLPQ9mRZJIDbTQg8nBscPR+55jpu42vF0ZYGuKFTA+ypFlp4jn+PV
         2DS2ZHkJF7ocvHxCLz/vn3ttA4BZ5bZuqXFXl53n900o7q5sx788kPRvbna2jgplcK/b
         Y4KoX2Tswudj2V0O+EYZzQT+kT2Xg3BGqlGwvnNH8rxPxQImrkmE1pMaYib2EcH3E172
         W3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vMbC7me8qNkOxK4Ddp6UZnSI0/+rni3gGHPFEZKB0WE=;
        b=GrGlSPlLNqiz7D36zmwhAdfu+Hp3nYhSEvceN+LSk8lXogSE+vVBs5YS+OZlrMPl5R
         DEckmzjs3FpEeYvGU4/dE8vIs9YJuqP481USMlTl5oEFK06TEt9Di4RuNnRf0IvY7HIB
         g3H+IPd4ZPylCpjerdceyZzeetKm0YqNx7iWme/qLjHVvY1kVlUc/mjzaCylQMA4U9xL
         e79X8gLQmmUlMNVyfiH5YzlP6lkvnXFZj34jayoTr4bdJkvLKZZoAbdhLyWmWkzFYNaH
         JeXzyEclIV5vwC0ek+4UK7HxLtRC+PXIWYKLntqI1K3aBYxgv5St/DiZo4t+Fs60Ncs3
         5QhQ==
X-Gm-Message-State: APt69E3mfACsCA1tMn5cEpxLz3Fdb+AG9ckdTg/VACwAFMfCyp/ZVi1A
        vdZKESOV9fLtUyfnUjfq/u4=
X-Google-Smtp-Source: AAOMgpf6e/EMnzBeYW6pgJLkm6+zj/59Oh0H62u32wz+qbH6+4dsZ1lboxL82CQe7jBN+eCRR49XTw==
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr6672601wrk.221.1529939588585;
        Mon, 25 Jun 2018 08:13:08 -0700 (PDT)
Received: from arch.localdomain (x590e3931.dyn.telefonica.de. [89.14.57.49])
        by smtp.gmail.com with ESMTPSA id l78-v6sm15368283wmb.39.2018.06.25.08.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:13:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/4] staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
Date:   Mon, 25 Jun 2018 17:12:37 +0200
Message-Id: <20180625151238.23147-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625151238.23147-1-straube.linux@gmail.com>
References: <20180625151238.23147-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() instead of memcpy() to copy the mac address.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 7aa00d1391f7..8af4a89e632f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1172,15 +1172,15 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
 			mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
 		}
-		memcpy(mac_addr, mac, ETH_ALEN);
+		ether_addr_copy(mac_addr, mac);
 	} else{	/* 	Use the mac address stored in the Efuse */
-		memcpy(mac, mac_addr, ETH_ALEN);
+		ether_addr_copy(mac, mac_addr);
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
 		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
-			memcpy(mac_addr, addr, ETH_ALEN);
+			ether_addr_copy(mac_addr, addr);
 		} else {
 			eth_random_addr(mac_addr);
 			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
-- 
2.18.0

