Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeBTGMS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 01:12:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41457 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbeBTGMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 01:12:17 -0500
From: Benjamin Poirier <bpoirier@suse.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-queue] e1000e: Fix check_for_link return value with autoneg off.
Date: Tue, 20 Feb 2018 15:12:00 +0900
Message-Id: <20180220061200.17708-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When autoneg is off, the .check_for_link callback functions clear the
get_link_status flag and systematically return a "pseudo-error". This means
that the link is not detected as up until the next execution of the
e1000_watchdog_task() 2 seconds later.

Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 31277d3bb7dc..ff308b05d68c 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1602,7 +1602,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return -E1000_ERR_CONFIG;
+		return 1;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index f457c5703d0c..db735644b312 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -450,7 +450,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return -E1000_ERR_CONFIG;
+		return 1;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
-- 
2.16.1
