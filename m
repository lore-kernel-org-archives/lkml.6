Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeDELoc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:44:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51203 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeDELo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:44:29 -0400
X-Google-Smtp-Source: AIpwx49bBl8xkaxAGeZ6RQDGP26LOuE4gbthS1qsHXq3bqOQAHc+GnXG5kanWRpOB5mbKlLC6W/hTw==
From: esben.haabendal@gmail.com
To: Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/2] net: phy: dp83640: Read strapped configuration settings
Date: Thu,  5 Apr 2018 13:44:24 +0200
Message-Id: <20180405114424.8519-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405114424.8519-1-esben.haabendal@gmail.com>
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Read configration settings, to allow automatic forced speed/duplex setup
by hardware strapping.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/phy/dp83640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 654f42d00092..01e21b4998ad 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1134,6 +1134,10 @@ static int dp83640_probe(struct phy_device *phydev)
 	if (!dp83640)
 		goto no_memory;
 
+	err = genphy_read_config(phydev);
+	if (err)
+		goto no_config;
+
 	dp83640->phydev = phydev;
 	INIT_DELAYED_WORK(&dp83640->ts_work, rx_timestamp_work);
 
@@ -1166,6 +1170,7 @@ static int dp83640_probe(struct phy_device *phydev)
 
 no_register:
 	clock->chosen = NULL;
+no_config:
 	kfree(dp83640);
 no_memory:
 	dp83640_clock_put(clock);
-- 
2.16.3
