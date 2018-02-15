Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166553AbeBOSbs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:31:48 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:45432 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1163152AbeBOSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:31:45 -0500
Date: Thu, 15 Feb 2018 12:31:39 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Brandon Streiff <brandon.streiff@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
Message-ID: <20180215183139.GA23076@embeddedor.com>
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
X-Exim-ID: 1emOJq-001qRF-Kc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:36502
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_port_ is being used as index to array port_hwtstamp before verifying
it is a non-negative number and a valid index at line 209 and 258:

if (port < 0 || port >= mv88e6xxx_num_ports(chip))

Fix this by checking _port_ before using it as index to array
port_hwtstamp.

Addresses-Coverity-ID: 1465287 ("Negative array index read")
Addresses-Coverity-ID: 1465291 ("Negative array index read")
Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 -Fix the same issue in mv88e6xxx_should_tstamp.
 -Update commit message.

 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index b251d53..5a665aa 100644
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
@@ -249,7 +252,7 @@ static u8 *parse_ptp_header(struct sk_buff *skb, unsigned int type)
 static u8 *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip, int port,
 				   struct sk_buff *skb, unsigned int type)
 {
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
+	struct mv88e6xxx_port_hwtstamp *ps;
 	u8 *hdr;
 
 	if (!chip->info->ptp_support)
@@ -262,6 +265,7 @@ static u8 *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip, int port,
 	if (!hdr)
 		return NULL;
 
+	ps = &chip->port_hwtstamp[port];
 	if (!test_bit(MV88E6XXX_HWTSTAMP_ENABLED, &ps->state))
 		return NULL;
 
-- 
2.7.4
