Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE442C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE024B95
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="imFW+Zjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BE024B95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFWJrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:47:12 -0400
Received: from mout01.posteo.de ([185.67.36.65]:45624 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbeFWJrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:47:11 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3201E211CD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 11:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529747229; bh=Z4Tc2aCnxe8rajCwCQuvE4a4QXJZ1a5UvpE4ofxjAIk=;
        h=From:To:Cc:Subject:Date:From;
        b=imFW+ZjvbijOXsb6e+QMXPxeZodS4KoT65q0TlBFDy/eB0ClAFNYJNw1TpENSmVRf
         wOU/7SCYCIKAkg+zoqZ5B07AGECYG4qXi9RkosGO9Vrd1usTBaC0F5b90OogO96tsF
         7SYsBMziz6J27jG3WvU1i6g1ZIkva1Yt0yWjsWQ1zTogkTpxX9YmjPq1NQv0B5/eZm
         IjbwBx/FmPcynn6U+5UE2ovnNvioYuaRh6DGiMrHZC2yfx6oSfHx3sfm1SmuIxkvbs
         bQpaGaUsPvZVFvNFH7WEQaL0tyYmYmxmQWTKDmS5tyRB+/SuQeVQ+H2TH4TWoxdWKd
         NoL3PeOVHXAVw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41CVvt6p2Xz9rxQ;
        Sat, 23 Jun 2018 11:47:06 +0200 (CEST)
From:   Michael Straube <michael.straube@posteo.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        Michael Straube <michael.straube@posteo.de>
Subject: [PATCH] staging: rtl8723bs: refactor rtw_macaddr_cfg()
Date:   Sat, 23 Jun 2018 11:45:32 +0200
Message-Id: <20180623094532.12316-1-michael.straube@posteo.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
testing each byte of the mac[] array for 0xff and 0x00 shortens the
code and improves readability.

If np == NULL, of_get_property() returns NULL, hence the "np" check
is not needed.

Instead of a fixed default mac address use a random one to reduce the
likelihood of mac address collision.

Thanks to Joe Perches and Dan Carpenter.

Signed-off-by: Michael Straube <michael.straube@posteo.de>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0822e440204e..584695df0a48 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1177,24 +1177,13 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
-	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
-		if (np &&
-		    (addr = of_get_property(np, "local-mac-address", &len)) &&
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
 			memcpy(mac_addr, addr, ETH_ALEN);
 		} else {
-			mac[0] = 0x00;
-			mac[1] = 0xe0;
-			mac[2] = 0x4c;
-			mac[3] = 0x87;
-			mac[4] = 0x00;
-			mac[5] = 0x00;
-			/*  use default mac addresss */
-			memcpy(mac_addr, mac, ETH_ALEN);
-			DBG_871X("MAC Address from efuse error, assign default one !!!\n");
+			eth_random_addr(mac_addr);
+			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
 		}
 	}
 
-- 
2.18.0

