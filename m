Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934303AbeCBXI6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:08:58 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44815 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeCBXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:53 -0500
X-Google-Smtp-Source: AG47ELt2/mbikKUTdb1qKflESPxI9JlMYzd7bUeYmkvXl7baKKAIvyzdbgWK/hFYjKaL8rL4n9dWsQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: david.laight@aculab.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH v2 1/4] net: dsa: b53: Use strlcpy() for ethtool::get_strings
Date: Fri,  2 Mar 2018 15:08:36 -0800
Message-Id: <20180302230839.31468-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302230839.31468-1-f.fainelli@gmail.com>
References: <20180302230839.31468-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our statistics strings are allocated at initialization without being
bound to a specific size, yet, we would copy ETH_GSTRING_LEN bytes using
memcpy() which would create out of bounds accesses, this was flagged by
KASAN. Replace this with strlcpy() to make sure we are bound the source
buffer size and we also always NUL-terminate strings.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index db830a1141d9..63e02a54d537 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -814,8 +814,8 @@ void b53_get_strings(struct dsa_switch *ds, int port, uint8_t *data)
 	unsigned int i;
 
 	for (i = 0; i < mib_size; i++)
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       mibs[i].name, ETH_GSTRING_LEN);
+		strlcpy(data + i * ETH_GSTRING_LEN,
+			mibs[i].name, ETH_GSTRING_LEN);
 }
 EXPORT_SYMBOL(b53_get_strings);
 
-- 
2.14.1
