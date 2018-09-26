Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD93C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D96920657
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D96920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeIZTdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:33:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:33:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6t3Z-1fhDTK30P9-018NiY; Wed, 26 Sep 2018 15:20:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] phy: mscc: fix printf format
Date:   Wed, 26 Sep 2018 15:20:11 +0200
Message-Id: <20180926132021.2933754-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:behdl5ImikeaUmM9kv+B3TQeYIgg1qSeX2uRr7hnq3nMzMyN0Ux
 nqPWyRSOcqXdnFqLZV4NUfkpDx/NkdGeVdEf43R6uDhamWu2TUmS/6S6e9SIDsp6ODHyG8b
 q6+0ZynYNA2T5k9aaJ665IkTaDWvir180cx0XJki6bJ4vWocikQfmUdu8+fkngPOSnDK+Ue
 QOsvA7WQDooILzOmcyQIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:13x7nZJE5wk=:1BeVTDfjafCMgsvY1Pm1ca
 SLV40bQd07cC4UJvhcrcopXjZRnTWr2/is1ZmZL42xf6lV1BGJJITGnQgB83zVMAIqcuCI56x
 KwznwRE86lU23Yqyc2iDXWuT6/4JmZksiJ7+pRUEnZgd2LlTc1ZO5FRsbr2eaDb3rtPAyxY2h
 y2zLWYvXWsXZW1ya+OplPuUcDX6Vv/0mbb/Vnd448omHn64AZzaptxhQ3OT+2xDu3kEFQ5urI
 JwEH+Ku3PS8M72xNmWGrq5XfP+fCR93pBjgmVZsT6HSmuZmwhusFBP8w7MSrV0fPAYt29tFpG
 cn6bVbm8obbl4GifgPWvsJmoaZzmudYBD7d2W4pSew9lr7nhsy7+wo9tGApbojiuDw0DPmr0a
 11V8ORINl2rGJ2BdTd5nmReaKpU8rIbXEBMpZGm7n5acwNgW04HdpFvwBT2peqlOyN3FQLgTh
 YkgQPHu3ZuqEBMGRbD8H+bXDGba2Lkht/sNdnq4rN/WoLQ54Ht9BFDKim0UqJB0NZt4cRTNGs
 uBY7Y7fu2myKf3Pk0aJ575O0kNbYTyHOZlhU9jo7PgrtopX9Vdi9BqwxK2UkSCyfp/Y4SDIz2
 u/Sv1878LOnm/YJTdNfqvsiZjlf/pYOpvV+9M1uNRyzcF1tpBxSDAj24fIWW+9q29wfOAQjGk
 8MM2+6lLTOC97cFpowhHbtfhyzGpBifqUBnbHxLqDh+NIEvHzV1Rs3jdLywkppFWzdCk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out that the length of the temporary buffer may not be sufficient for
large numbers of leds:

drivers/net/phy/mscc.c: In function 'vsc85xx_probe':
drivers/net/phy/mscc.c:460:45: error: '-mode' directive writing 5 bytes into a region of size between 0 and 9 [-Werror=format-overflow=]
   ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
                                             ^~~~~
drivers/net/phy/mscc.c:460:9: note: 'sprintf' output between 19 and 28 bytes into a destination of size 22
   ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While we can make a reasonable assumption that the number of LEDs is small,
the cost of making the buffer a little bigger is insignificant as well.

Fixes: 11bfdabb7ff5 ("net: phy: mscc: factorize code for LEDs mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 2d9676d78d3f..7d0384e26c99 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -453,7 +453,7 @@ static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
 				    u32 *default_mode)
 {
 	struct vsc8531_private *priv = phydev->priv;
-	char led_dt_prop[19];
+	char led_dt_prop[28];
 	int i, ret;
 
 	for (i = 0; i < priv->nleds; i++) {
-- 
2.18.0

