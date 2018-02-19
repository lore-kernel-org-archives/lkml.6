Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBSLiv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:38:51 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:40781 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeBSLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:38:50 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] clocksource/arc_timer: Halt GFRC together with ARC cores
Date: Mon, 19 Feb 2018 14:38:46 +0300
Message-Id: <20180219113846.2312-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GFRC is running regardless state of ARC cores in the SMP cluster.
That means even if ARC cores are halted when doing JTAG debugging GFRC
[our source of wall-time] continues to run giving us unexpected warnings
once we allow ARC cores to run due to some tasks being stuck for too
long.

Starting from ARC HS v3.0 it's possible to tie GFRC to state of up-to 4
ARC cores with help of GFRC's CORE register where we set a mask for
cores which state we need to rely on.

For now we set GFRC to be halted whenever either of 4 ARC cores
(currently max number of ARC cores in SMP cluster) is halted.

That setting is safe for clusters with fewer ARC cores as well because
bits for missign cores won't be written anyways.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/clocksource/arc_timer.c | 7 +++++++
 include/soc/arc/mcip.h          | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 4927355f9cbe..6c21b3634be0 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -93,6 +93,13 @@ static int __init arc_cs_setup_gfrc(struct device_node *node)
 		return -ENXIO;
 	}
 
+	/*
+	 * Halt GFRC if either of 4 cores in SMP cluster is halted.
+	 * Only works for ARC HS v3.0+, on earlier versions has no effect.
+	 * 	TODO: set mask only for used cores.
+	 */
+	__mcip_cmd_data(CMD_GFRC_SET_CORE, 0, 0xf);
+
 	ret = arc_get_timer_clk(node);
 	if (ret)
 		return ret;
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index c2d1b15da136..1dd1d1317907 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -40,6 +40,7 @@ struct mcip_cmd {
 
 #define CMD_GFRC_READ_LO		0x42
 #define CMD_GFRC_READ_HI		0x43
+#define CMD_GFRC_SET_CORE		0x47
 
 #define CMD_IDU_ENABLE			0x71
 #define CMD_IDU_DISABLE			0x72
-- 
2.14.3
