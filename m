Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeCRSXP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 14:23:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39499 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeCRSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 14:23:11 -0400
X-Google-Smtp-Source: AG47ELtDpislsrFSUWzr9zrrnjfqGoxCR7epbDKInPMyTJk7bGspc3KlQHE4clQ6HHgL+bJ5e+Q8Ng==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: mv88e6xxx: Fix missing register lock in serdes_get_stats
Date: Sun, 18 Mar 2018 11:23:05 -0700
Message-Id: <20180318182305.24952-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can hit the register lock not held assertion with the following path:

[   34.170631] mv88e6085 0.1:00: Switch registers lock not held!
[   34.176510] CPU: 0 PID: 950 Comm: ethtool Not tainted 4.16.0-rc4 #143
[   34.182985] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[   34.189519] Backtrace:
[   34.192033] [<8010c4b4>] (dump_backtrace) from [<8010c788>] (show_stack+0x20/0x24)
[   34.199680]  r6:9f5dc010 r5:00000011 r4:9f5dc010 r3:00000000
[   34.205434] [<8010c768>] (show_stack) from [<80679d38>] (dump_stack+0x24/0x28)
[   34.212719] [<80679d14>] (dump_stack) from [<804844a8>] (mv88e6xxx_read+0x70/0x7c)
[   34.220376] [<80484438>] (mv88e6xxx_read) from [<804870dc>] (mv88e6xxx_port_get_cmode+0x34/0x4c)
[   34.229257]  r5:a09cd128 r4:9ee31d07
[   34.232880] [<804870a8>] (mv88e6xxx_port_get_cmode) from [<80487e6c>] (mv88e6352_port_has_serdes+0x24/0x64)
[   34.242690]  r4:9f5dc010
[   34.245309] [<80487e48>] (mv88e6352_port_has_serdes) from [<804880b8>] (mv88e6352_serdes_get_stats+0x28/0x12c)
[   34.255389]  r4:00000001
[   34.257973] [<80488090>] (mv88e6352_serdes_get_stats) from [<804811e8>] (mv88e6xxx_get_ethtool_stats+0xb0/0xc0)
[   34.268156]  r10:00000000 r9:00000000 r8:00000000 r7:a09cd020 r6:00000001 r5:9f5dc01c
[   34.276052]  r4:9f5dc010
[   34.278631] [<80481138>] (mv88e6xxx_get_ethtool_stats) from [<8064f740>] (dsa_slave_get_ethtool_stats+0xbc/0xc4)

mv88e6xxx_get_ethtool_stats() calls mv88e6xxx_get_stats() which calls both
chip->info->ops->stats_get_stats(), which holds the register lock, and
chip->info->ops->serdes_get_stats() which does not. Have
chip->info->ops->serdes_get_stats() be running with the register lock held to
avoid such assertions.

Fixes: 436fe17d273b ("net: dsa: mv88e6xxx: Allow the SERDES interfaces to have statistics")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index bd3ee84770c7..c22c18ed2de3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -849,7 +849,9 @@ static void mv88e6xxx_get_stats(struct mv88e6xxx_chip *chip, int port,
 
 	if (chip->info->ops->serdes_get_stats) {
 		data += count;
+		mutex_lock(&chip->reg_lock);
 		chip->info->ops->serdes_get_stats(chip, port, data);
+		mutex_unlock(&chip->reg_lock);
 	}
 }
 
-- 
2.14.1
