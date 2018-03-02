Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163798AbeCBA0Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:26:24 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46823 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163105AbeCBAZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:25:42 -0500
X-Google-Smtp-Source: AG47ELuu6P+CI5B2dSP9jfvD0b6teucQwUbiY0sH4s8h6h2zaki2vrJKmAT1gjUn2VRU4982gzNOSQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 3/4] net: dsa: microchip: Utilize strncpy() for ethtool::get_strings
Date: Thu,  1 Mar 2018 16:25:28 -0800
Message-Id: <20180302002529.15226-4-f.fainelli@gmail.com>
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

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 663b0d5b982b..db7f5c8c1dcb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -449,8 +449,8 @@ static void ksz_get_strings(struct dsa_switch *ds, int port, uint8_t *buf)
 	int i;
 
 	for (i = 0; i < TOTAL_SWITCH_COUNTER_NUM; i++) {
-		memcpy(buf + i * ETH_GSTRING_LEN, mib_names[i].string,
-		       ETH_GSTRING_LEN);
+		strncpy(buf + i * ETH_GSTRING_LEN, mib_names[i].string,
+			ETH_GSTRING_LEN);
 	}
 }
 
-- 
2.14.1
