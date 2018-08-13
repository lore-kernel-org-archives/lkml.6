Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A197C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5321536
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5321536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeHNADw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:03:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:03:52 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MHaGK-1fsd6G3pxE-003QeE; Mon, 13 Aug 2018 23:19:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: lan743x: select CRC16
Date:   Mon, 13 Aug 2018 23:19:21 +0200
Message-Id: <20180813211938.2375199-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:aerfOqeGt7V2aMaBJ6hEkWk0PoIwAGxI3/K1N9nDEgRmZx7K0OO
 6YuL8P27a+Ujquv+Y7kUKcmlfDtH/7uWZtxiomhn6I7LIiFji9gohoDaCn2j3HHORKZCi2P
 CVfdiuugMdWnp4pHQtKN2oQGbuRHNb2YH/ysEzfM1fBWakUXjVmbjTbwLCUim+Vsub3Wn8R
 ojKXzwuA9p1mnDFbcKxFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WoNWIU4j55k=:Qi+ky8Dm8WJLaMTkcdzfQS
 ViQyStUnvq5OjpTekqDlkrVdL5YaYYSUQu2WxGKSabjMUZjKipGCLDPe0wFvJMv4DXmOElM6d
 +oB/Er/4WorOhUKZL066WLRAf1Gll81osgp5LI+SOUr5aIQ9ZeIGttnC1BEDJTNh3/Lw/+4dz
 eHs4FcA/qxYwLPNjWqkbNC1X90ISIJGzxcIrLEl5xPkcoQiiM/9Dfg/NJdnlbroff7LMKpau9
 Ai6WO1Vloo6cljZ3Ia4sxIM/+8vNu9qn9jAizXnOUang7j5FOwte6JwSeI6v+ysZhIn9KxYp0
 0yXYXVBFQVKO1Zi1CBeho8UbLhrHa5Nb01BoEhthb+w8Nmufn6UwgU9MVUoeJSfxyMNQUa0V8
 3gyNGH3lYUOhAGoLzRGtdCbuwbymZLjPehMz+TWwm+RHgbFTxNd/NDBoPOjpUxvP2xPV6Amxq
 CmD4bbpjU/IS8hCuDGvKhYuSCiWSVNlq+tfYpw+EHFAut5JvKVbz4aBSF6bYiLc5ereGEctHr
 NfAXh/wTMtCakdaJfj6o7jXqBCrcc+Esyzab3aB38TuIBBF4unADLXjMf1miz4gVQkIGFzInu
 evMrUBqQUdCHfxvIaXfiQFdEuDrplVXxMpTfVgIdJCAQ7toGdUvfveN1P+oOyStmPYum+Pksi
 LzWuMZ2INpVFPhq58QMOvz5o49R2nVk+7cRtKYFWbkobwjVi5f0izBBNJLuRqG6aM5nk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lan743x now fails to build when CONFIG_CRC16 is disabled:

drivers/net/ethernet/microchip/lan743x_main.o: In function crc16'

Force it on like all other users do.

Fixes: 4d94282afd95 ("lan743x: Add power management support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/microchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 71dca8bd51ac..16bd3f44dbe8 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,6 +46,7 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	select PHYLIB
+	select CRC16
 	---help---
 	  Support for the Microchip LAN743x PCI Express Gigabit Ethernet chip
 
-- 
2.18.0

