Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935103AbeBMMOT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:14:19 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41667 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934938AbeBMMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:14:18 -0500
X-Google-Smtp-Source: AH8x2259ui+YEg+U3fsfR4rg3GdkX62U52178pBRJCXY1oXhZ1Tv4225yKgtACv2WgYPnHmBD/XGLg==
From: Philipp Rossak <embed3d@gmail.com>
To: wens@csie.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com
Cc: linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-rtc@vger.kernel.org
Subject: [PATCH v2] rtc: ac100: Fix ac100 determine rate bug
Date: Tue, 13 Feb 2018 13:14:14 +0100
Message-Id: <20180213121414.7000-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug, that prevents the Allwinner A83T and the A80
from a successful boot. You can find the shortend trace below:

Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = (ptrval)
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
Hardware name: Allwinner sun8i Family
Workqueue: events deferred_probe_work_func
PC is at clk_hw_get_rate+0x0/0x34
LR is at ac100_clkout_determine_rate+0x48/0x19c

[ ... ]

(clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
(ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
(clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
(clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
(of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)

To fix that bug, we first check if the return of the
clk_hw_get_parent_by_index is non zero. If it is zero we skip that
clock parent.

The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198

Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---

Changes in v2:
	* add tag Fixes: ... to commit message
	* add comment to if statement why we are doing this check

 drivers/rtc/rtc-ac100.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 8ff9dc3fe5bf..ba73201d8cc1 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -183,7 +183,17 @@ static int ac100_clkout_determine_rate(struct clk_hw *hw,
 
 	for (i = 0; i < num_parents; i++) {
 		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
-		unsigned long tmp, prate = clk_hw_get_rate(parent);
+		unsigned long tmp, prate;
+
+		/*
+		 * We purposefully left open the possibility to use the clock
+		 * from the codec side but it is not implemented right now.
+		 * Thus we need to check if the parent exists.
+		 */
+		if (!parent)
+			continue;
+
+		prate = clk_hw_get_rate(parent);
 
 		tmp = ac100_clkout_round_rate(hw, req->rate, prate);
 
-- 
2.11.0
