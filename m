Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163114AbeBOTMc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:12:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161027AbeBOTM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:12:28 -0500
From: Colin King <colin.king@canonical.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: mv88e6xxx: avoid unintended sign extension on a 16 bit shift
Date: Thu, 15 Feb 2018 19:12:18 +0000
Message-Id: <20180215191218.27936-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shifting of timehi by 16 bits to the left will be promoted to
a 32 bit signed int and then sign-extended to an u64. If the top bit
of timehi is set then all then all the upper bits of ns end up as also
being set because of the sign-extension. Fix this by casting timehi
to u64 before the shift.

Detected by CoverityScan, CID#1465288 ("Unintended sign extension")

Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index b251d534b70d..758e35fa69ab 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -321,7 +321,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 	 */
 	for ( ; skb; skb = skb_dequeue(rxq)) {
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
-			u64 ns = timehi << 16 | timelo;
+			u64 ns = (u64)timehi << 16 | timelo;
 
 			mutex_lock(&chip->reg_lock);
 			ns = timecounter_cyc2time(&chip->tstamp_tc, ns);
-- 
2.15.1
