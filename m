Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163881AbeCBAZn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:25:43 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40535 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163666AbeCBAZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:25:40 -0500
X-Google-Smtp-Source: AG47ELthHCi0WcTWnMaLndQPw2DrfnKPgo9Gu09NJ3B4j5R9pxVu453tFi0aPpcCFZOQs/ICG5BdCQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/4] net: dsa: loop: Use strncpy() for ethtool::get_strings
Date: Thu,  1 Mar 2018 16:25:27 -0800
Message-Id: <20180302002529.15226-3-f.fainelli@gmail.com>
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

Fixes: 484c01720d84 ("net: dsa: loop: Implement ethtool statistics")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 7aa84ee4e771..2e7e1cdbd2e9 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -97,8 +97,8 @@ static void dsa_loop_get_strings(struct dsa_switch *ds, int port, uint8_t *data)
 	unsigned int i;
 
 	for (i = 0; i < __DSA_LOOP_CNT_MAX; i++)
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       ps->ports[port].mib[i].name, ETH_GSTRING_LEN);
+		strncpy(data + i * ETH_GSTRING_LEN,
+			ps->ports[port].mib[i].name, ETH_GSTRING_LEN);
 }
 
 static void dsa_loop_get_ethtool_stats(struct dsa_switch *ds, int port,
-- 
2.14.1
