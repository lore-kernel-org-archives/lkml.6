Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166105AbeBOSK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:10:29 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:46941 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1163370AbeBOSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:10:26 -0500
Date: Thu, 15 Feb 2018 12:10:05 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Brandon Streiff <brandon.streiff@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] net: dsa: mv88e6xxx: hwtstamp: fix potential negative array
 index read
Message-ID: <20180215181005.GA21263@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emNz6-001URb-6f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:36444
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_port_ is being used as index to array port_hwtstamp before verifying
it is a non-negative number and a valid index at 209:

if (port < 0 || port >= mv88e6xxx_num_ports(chip))

Fix this by checking _port_ before using it as index to array
port_hwtstamp.

Addresses-Coverity-ID: 1465287 ("Negative array index read")
Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index b251d53..761decc 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -200,8 +200,8 @@ int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 				struct ifreq *ifr)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	struct hwtstamp_config *config = &ps->tstamp_config;
+	struct mv88e6xxx_port_hwtstamp *ps;
+	struct hwtstamp_config *config;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
@@ -209,6 +209,9 @@ int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	if (port < 0 || port >= mv88e6xxx_num_ports(chip))
 		return -EINVAL;
 
+	ps = &chip->port_hwtstamp[port];
+	config = &ps->tstamp_config;
+
 	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
 		-EFAULT : 0;
 }
-- 
2.7.4
