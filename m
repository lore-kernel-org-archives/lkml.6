Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeBUJkt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:40:49 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39270 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeBUJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:40:46 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/3] ARC: mcip: setup MCIP debug mask according to cpu possible mask
Date: Wed, 21 Feb 2018 12:40:26 +0300
Message-Id: <20180221094027.12674-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
References: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup MCIP debug mask according cpu possible mask instead of
use hardcoded one.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/mcip.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index e87a4ea..da73258 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -112,6 +112,7 @@ static void mcip_ipi_clear(int irq)
 static void mcip_probe_n_setup(void)
 {
 	struct mcip_bcr mp;
+	u32 i, mcip_mask = 0;
 
 	READ_BCR(ARC_REG_MCIP_BCR, mp);
 
@@ -126,8 +127,16 @@ static void mcip_probe_n_setup(void)
 	cpuinfo_arc700[0].extn.gfrc = mp.gfrc;
 
 	if (mp.dbg) {
-		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, 0xf);
-		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xf, 0xf);
+		for_each_possible_cpu(i)
+			mcip_mask |= BIT(i);
+
+		__mcip_cmd_data(CMD_DEBUG_SET_SELECT, 0, mcip_mask);
+		/*
+		 * Parameter specified halt cause:
+		 * STATUS32[H]/actionpoint/breakpoint/self-halt
+		 * We choose all of them (0xF).
+		 */
+		__mcip_cmd_data(CMD_DEBUG_SET_MASK, 0xF, mcip_mask);
 	}
 }
 
-- 
2.9.3
