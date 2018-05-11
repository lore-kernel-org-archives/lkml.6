Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeEKVQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:16:57 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37204 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEKVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:16:53 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 3/3] net: dsa: mv88e6xxx: add a stats setup function
Date: Fri, 11 May 2018 17:16:36 -0400
Message-Id: <20180511211636.25995-4-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
References: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Global 1 specific setup function only setup the statistics
unit, kill it in favor of a mv88e6xxx_stats_setup function.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index df92fed44674..a4efc6544c0d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -995,14 +995,6 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
 
 }
 
-static int mv88e6xxx_stats_set_histogram(struct mv88e6xxx_chip *chip)
-{
-	if (chip->info->ops->stats_set_histogram)
-		return chip->info->ops->stats_set_histogram(chip);
-
-	return 0;
-}
-
 static int mv88e6xxx_get_regs_len(struct dsa_switch *ds, int port)
 {
 	return 32 * sizeof(u16);
@@ -2267,14 +2259,16 @@ static int mv88e6xxx_set_ageing_time(struct dsa_switch *ds,
 	return err;
 }
 
-static int mv88e6xxx_g1_setup(struct mv88e6xxx_chip *chip)
+static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 {
 	int err;
 
 	/* Initialize the statistics unit */
-	err = mv88e6xxx_stats_set_histogram(chip);
-	if (err)
-		return err;
+	if (chip->info->ops->stats_set_histogram) {
+		err = chip->info->ops->stats_set_histogram(chip);
+		if (err)
+			return err;
+	}
 
 	return mv88e6xxx_g1_stats_clear(chip);
 }
@@ -2300,11 +2294,6 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 			goto unlock;
 	}
 
-	/* Setup Switch Global 1 Registers */
-	err = mv88e6xxx_g1_setup(chip);
-	if (err)
-		goto unlock;
-
 	err = mv88e6xxx_irl_setup(chip);
 	if (err)
 		goto unlock;
@@ -2368,6 +2357,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 			goto unlock;
 	}
 
+	err = mv88e6xxx_stats_setup(chip);
+	if (err)
+		goto unlock;
+
 unlock:
 	mutex_unlock(&chip->reg_lock);
 
-- 
2.17.0
