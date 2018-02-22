Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeBVLpr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:45:47 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeBVLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:45:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Brandon Streiff <brandon.streiff@ni.com>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dsa: ptp; mark dummy helpers as 'inline'
Date: Thu, 22 Feb 2018 12:44:40 +0100
Message-Id: <20180222114459.1272945-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:zsRxBT14S56IH6i64adfbVCcNdQ07QEW/LJOR6dAw3326UNBV21
 4mw/w2Ieqmzb67Nwafi8NGNA3Mu71LTHfQRMES5FhnEyJs6tc5+e/RaxazJsnuYzzQMi9r7
 JvGQ5TK7JM4qVOJJFFvKUIDqC7KuqAhUQngTpWj7i48jq9/2J3sq8Ee5BL3HmJUWYCNaiMi
 2Y+WSzmFx4TfAQ65BjwTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E1vmtr2I1yA=:dG0IIGl+l3QAoawwBcqvBk
 NsfBPN9EwUs63rzV18hHZZlrX0Hhg7mAspnHX63lWDC7QgEIjituo4uz1opX7wc4GxUYH1L0H
 CROk6O9Igsg5KzDGeogVX6q54wSqIeS/G0DxrWPsnByJPK6dRdS2TECQZD0mWSGWeKvxkXZiK
 oj/sNlOkcGLgTZq4PvqpSgqjJXHD7jfXcx5j0tA5FeHtCvew0CSsbk//wMtv/ZP+e/IvUQtXx
 98MzWF0sZj2F0HTsZOd4E9KV5e+VV//r48CYk/7W1oCEBFw6fv/DvoofRmxTroTvEhm270ZL3
 fGPGyZls46LIDQR2ALVvDsSQ9i9CegqKKug0znwiUE5Q3b/cNOvCdDU1a+/rkdU1KUFzoXXoy
 F9kwa52W6/oGD4IDtsmwTkY9lqQpwzO5OZKq98W7aoQ5HK2mNXtJ+ClaG5CRY/9WW9BkX5Tbo
 AzGy4o925cGscCu8O9Ls3NJnAw8YO0hd2QtR8Prc2z9j3ytiBQynlgIJVxyfwGOxdiaUxFOOO
 ZqIU5Kkxk5MBp0qKpxQdWUeHfvNdgTmcZVOSLEsJk0IIvsOvQHN/uO6Q7tj/kw5vfEodY0IDC
 H/jhw9xn2DcY5GC0XykmuU4eNnJAy7F68sC4bNB9KjkVIGO9kjwt3HraJ6nIdiqPrJNiYp49H
 CnRn/e4qfMUsNbXT6eFAQpDKLioeLTegSaGnKcSaRzgVmFNAxDF/BGGDbC3yKHZlHivb7gn7t
 ZOT8xBnqO4SPePSg360NZ9h7DbBgKPY52rFMqw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring a static function in a header leads to a warning every
time that header gets included without the function being used:

In file included from drivers/net/dsa/mv88e6xxx/chip.c:42:
drivers/net/dsa/mv88e6xxx/ptp.h:92:13: error: 'mv88e6xxx_hwtstamp_work' defined but not used [-Werror=unused-function]
 static long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
In file included from drivers/net/dsa/mv88e6xxx/chip.c:38:
drivers/net/dsa/mv88e6xxx/global2.h:355:12: error: 'mv88e6xxx_g2_wait' defined but not used [-Werror=unused-function]
 static int mv88e6xxx_g2_wait(struct mv88e6xxx_chip *chip, int reg, u16 mask)
            ^~~~~~~~~~~~~~~~~
drivers/net/dsa/mv88e6xxx/global2.h:350:12: error: 'mv88e6xxx_g2_update' defined but not used [-Werror=unused-function]
 static int mv88e6xxx_g2_update(struct mv88e6xxx_chip *chip, int reg, u16 update)
            ^~~~~~~~~~~~~~~~~~~
drivers/net/dsa/mv88e6xxx/global2.h:345:12: error: 'mv88e6xxx_g2_write' defined but not used [-Werror=unused-function]
 static int mv88e6xxx_g2_write(struct mv88e6xxx_chip *chip, int reg, u16 val)
            ^~~~~~~~~~~~~~~~~~
drivers/net/dsa/mv88e6xxx/global2.h:340:12: error: 'mv88e6xxx_g2_read' defined but not used [-Werror=unused-function]
 static int mv88e6xxx_g2_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)

This marks all such functions in dsa inline to make sure we don't warn
about them.

Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
Fixes: 0d632c3d6fe3 ("net: dsa: mv88e6xxx: add accessors for PTP/TAI registers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/mv88e6xxx/global2.h | 8 ++++----
 drivers/net/dsa/mv88e6xxx/ptp.h     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 25f92b3d7157..2a7c4f9b070c 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -337,22 +337,22 @@ static inline int mv88e6xxx_g2_require(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
-static int mv88e6xxx_g2_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)
+static inline int mv88e6xxx_g2_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)
 {
 	return -EOPNOTSUPP;
 }
 
-static int mv88e6xxx_g2_write(struct mv88e6xxx_chip *chip, int reg, u16 val)
+static inline int mv88e6xxx_g2_write(struct mv88e6xxx_chip *chip, int reg, u16 val)
 {
 	return -EOPNOTSUPP;
 }
 
-static int mv88e6xxx_g2_update(struct mv88e6xxx_chip *chip, int reg, u16 update)
+static inline int mv88e6xxx_g2_update(struct mv88e6xxx_chip *chip, int reg, u16 update)
 {
 	return -EOPNOTSUPP;
 }
 
-static int mv88e6xxx_g2_wait(struct mv88e6xxx_chip *chip, int reg, u16 mask)
+static inline int mv88e6xxx_g2_wait(struct mv88e6xxx_chip *chip, int reg, u16 mask)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 992818ade746..10f271ab650d 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -89,7 +89,7 @@ void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 
 #else /* !CONFIG_NET_DSA_MV88E6XXX_PTP */
 
-static long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
+static inline long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
 {
 	return -1;
 }
@@ -99,7 +99,7 @@ static inline int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
-static void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
+static inline void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 {
 }
 
-- 
2.9.0
