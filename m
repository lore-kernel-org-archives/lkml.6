Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163799AbeCBA0x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:26:53 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44750 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163500AbeCBAZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:25:38 -0500
X-Google-Smtp-Source: AG47ELtepuLq5CoyipkbWZCM/f80cFHM6M98gh/6/nxkRXqKxgJt8lREAQNx1tRzgIfz3P03NRSoMg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/4] net: dsa: b53: Use strncpy() for ethtool::get_strings
Date: Thu,  1 Mar 2018 16:25:26 -0800
Message-Id: <20180302002529.15226-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302002529.15226-1-f.fainelli@gmail.com>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use memcpy() which is not safe, but instead use strncpy() which
will make sure that the string is NUL terminated (in the Linux
implementation) if the string is smaller than the length specified. This
fixes KASAN out of bounds warnings while fetching port statistics.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index db830a1141d9..c64ebb82df83 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -814,8 +814,8 @@ void b53_get_strings(struct dsa_switch *ds, int port, uint8_t *data)
 	unsigned int i;
 
 	for (i = 0; i < mib_size; i++)
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       mibs[i].name, ETH_GSTRING_LEN);
+		strncpy(data + i * ETH_GSTRING_LEN,
+			mibs[i].name, ETH_GSTRING_LEN);
 }
 EXPORT_SYMBOL(b53_get_strings);
 
-- 
2.14.1
