Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163901AbeCBAZu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:25:50 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33785 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163135AbeCBAZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:25:45 -0500
X-Google-Smtp-Source: AG47ELvsj6Qvo8vRjqIIKHJstEDErCiNQ4rBe8NFUA12YtYST0vU8yXj5qU/noI8FEfisS6Q2XgwaA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 4/4] net: dsa: mv88e6xxx: Utilize strncpy() for ethtool::get_strings
Date: Thu,  1 Mar 2018 16:25:29 -0800
Message-Id: <20180302002529.15226-5-f.fainelli@gmail.com>
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

Fixes: f5e2ed022dff ("dsa: mv88e6xxx: Add Second back of statistics")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index eb328bade225..bec7540aae2b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -636,8 +636,8 @@ static void mv88e6xxx_stats_get_strings(struct mv88e6xxx_chip *chip,
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
 		stat = &mv88e6xxx_hw_stats[i];
 		if (stat->type & types) {
-			memcpy(data + j * ETH_GSTRING_LEN, stat->string,
-			       ETH_GSTRING_LEN);
+			strncpy(data + j * ETH_GSTRING_LEN, stat->string,
+				ETH_GSTRING_LEN);
 			j++;
 		}
 	}
-- 
2.14.1
