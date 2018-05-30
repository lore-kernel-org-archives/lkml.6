Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeE3Lhj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:37:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60800 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752301AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Sasha Neftin" <sasha.neftin@intel.com>,
        "Aaron Brown" <aaron.f.brown@intel.com>,
        "Benjamin Poirier" <bpoirier@suse.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.484117970@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 114/153] e1000e: Fix check_for_link return value with
 autoneg off
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@suse.com>

commit 4e7dc08e57c95673d2edaba8983c3de4dd1f65f5 upstream.

When autoneg is off, the .check_for_link callback functions clear the
get_link_status flag and systematically return a "pseudo-error". This means
that the link is not detected as up until the next execution of the
e1000_watchdog_task() 2 seconds later.

Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -746,7 +746,7 @@ static s32 e1000_check_for_copper_link_i
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg) {
-		ret_val = -E1000_ERR_CONFIG;
+		ret_val = 1;
 		goto out;
 	}
 
--- a/drivers/net/ethernet/intel/e1000e/lib.c
+++ b/drivers/net/ethernet/intel/e1000e/lib.c
@@ -478,10 +478,8 @@ s32 e1000e_check_for_copper_link(struct
 	 * If we are forcing speed/duplex, then we simply return since
 	 * we have already determined whether we have link or not.
 	 */
-	if (!mac->autoneg) {
-		ret_val = -E1000_ERR_CONFIG;
-		return ret_val;
-	}
+	if (!mac->autoneg)
+		return 1;
 
 	/*
 	 * Auto-Neg is enabled.  Auto Speed Detection takes care
