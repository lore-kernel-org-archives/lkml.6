Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeCUAbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:31:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42690 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCUAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:31:14 -0400
X-Google-Smtp-Source: AG47ELv15xtA55+rVmHk5EeJfSrTwWBqgiQFS5I83L6F88nbBfHHWcz3bWZWrVekEeb5fNs2OMmdeQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Fix functional dsa-loop dependency on FIXED_PHY
Date: Tue, 20 Mar 2018 17:31:10 -0700
Message-Id: <20180321003110.1699-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a functional dependency on the FIXED_PHY MDIO bus because we register
fixed PHY devices "the old way" which only works if the code that does this has
had a chance to run before the fixed MDIO bus is probed. Make sure we account
for that and have dsa_loop_bdinfo.o be either built-in or modular depending on
whether CONFIG_FIXED_PHY reflects that too.

Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d040aeb45172..15c2a831edf1 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
 bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
-obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o dsa_loop_bdinfo.o
+obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
+ifdef CONFIG_NET_DSA_LOOP
+obj-$(CONFIG_FIXED_PHY)		+= dsa_loop_bdinfo.o
+endif
 obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
 obj-$(CONFIG_NET_DSA_MV88E6060) += mv88e6060.o
 obj-$(CONFIG_NET_DSA_QCA8K)	+= qca8k.o
-- 
2.14.1
