Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759000AbeBPRrn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:47:43 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:39619 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758985AbeBPRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:47:42 -0500
Date: Fri, 16 Feb 2018 11:47:39 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] net: dsa: mv88e6xxx: hwtstamp: remove unnecessary range
 checking tests
Message-ID: <20180216174739.GA8415@embeddedgus>
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
X-Exim-ID: 1emk6n-001TJ9-0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:43966
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_port_ is already known to be a valid index in the callers [1]. So
these checks are unnecessary.

[1] https://lkml.org/lkml/2018/2/16/469

Addresses-Coverity-ID: 1465287
Addresses-Coverity-ID: 1465291
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index b251d53..c6d6a35 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -179,9 +179,6 @@ int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	if (port < 0 || port >= mv88e6xxx_num_ports(chip))
-		return -EINVAL;
-
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
 
@@ -206,9 +203,6 @@ int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	if (port < 0 || port >= mv88e6xxx_num_ports(chip))
-		return -EINVAL;
-
 	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
 		-EFAULT : 0;
 }
@@ -255,9 +249,6 @@ static u8 *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip, int port,
 	if (!chip->info->ptp_support)
 		return NULL;
 
-	if (port < 0 || port >= mv88e6xxx_num_ports(chip))
-		return NULL;
-
 	hdr = parse_ptp_header(skb, type);
 	if (!hdr)
 		return NULL;
-- 
2.7.4
