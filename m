Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385FFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F725D27
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS4eSNaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60F725D27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965822AbeF0Rhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:37:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53886 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965537AbeF0RhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:37:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so611641wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azTkwm6uGafpvvcw/VnXF67bgltA5QbMHjEQv4NYDZQ=;
        b=aS4eSNaKIzcw1KW05c40PfLt1T/GGhd1tRh7WMX2s45rEU9KbizyB/8+AvPAOK9Oq4
         pmZA+Y4+wathP6IeHqWq8LssjYK2RBAT/FUgadB9R0blRA0o7egQEM+C5CyyLNti9N/t
         lrCbkQZ84zus/K/IMm87+8Mp1a2EYS6GNZNQMaqgECJZCAgUCQGAn6nMU6nVn1wJtlhM
         TcrtZt5/H0yvuDjxZswMm1no5Kznq82QLES6JSorQaHTeJ25sd8gdKdLoKAORwaqygp8
         PAzI2495sdKImilEV76SBpA+/LQ11VBRgApYzs2RmlIA+1ovBsJ8r33Ucy6VCv4RQLtz
         zQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azTkwm6uGafpvvcw/VnXF67bgltA5QbMHjEQv4NYDZQ=;
        b=gxgP6nCcPY2Jw02jHG69bZpUJX0+tuoJ/E0P6SA7EZReZdW1+YfRn8G/uRqB1dBI+L
         DwgNhg9mOpU7u/2UQR779C9oLaKk8VBcdfCojJ+uosOWWXCL0gdV8udywCyarhpVRC5u
         RI6Dj3Tg4WPbXIroni1S1ZUpc/NmKDesn29RbohjG4GeDeFcn7fnGSs1ADRgqf9ztwUw
         sQ2dfCTELXuqR0EqRSw73oIC7f3OEJjZ9AKcGZEb43PftGojdmYde6tXbQFggO/uKxjz
         71wjelLGjcdOUTvadqmbtfFMnTdfXPwLAIzLe2RFASqMxglmiUcDLNY0Of27OY14DfoD
         ZZIw==
X-Gm-Message-State: APt69E1QDtsQ40mDCTPX/mcaIxZtwH7XmkRQok5faUqhUfFgrJAbixfg
        BBemNVcdIPkqtBDnr75HETs=
X-Google-Smtp-Source: AAOMgpfIcVV3q/T7qIBwJ4reIK4KIDtknqLwmAW6Coru3NXdmow5F5g2jWajUBNCL2kRdRDHh66SOQ==
X-Received: by 2002:a1c:ab02:: with SMTP id u2-v6mr5353520wme.10.1530121039561;
        Wed, 27 Jun 2018 10:37:19 -0700 (PDT)
Received: from arch.localdomain (x4db2cd79.dyn.telefonica.de. [77.178.205.121])
        by smtp.gmail.com with ESMTPSA id g4-v6sm4473220wrq.32.2018.06.27.10.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:37:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 3/4] staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
Date:   Wed, 27 Jun 2018 19:36:48 +0200
Message-Id: <20180627173649.4105-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627173649.4105-1-straube.linux@gmail.com>
References: <20180627173649.4105-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() instead of memcpy() to copy the mac address.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

