Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeC0OVz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:21:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46969 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeC0OVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:21:52 -0400
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ixgbevf: ensure xdp_ring resources are free'd on error exit
Date: Tue, 27 Mar 2018 15:21:48 +0100
Message-Id: <20180327142148.13603-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The current error handling for failed resource setup for xdp_ring
data is a break out of the loop and returning 0 indicated everying
was OK, when in fact it is not.  Fix this by exiting via the
error exit label err_setup_tx that will clean up the resources
correctly and return and error status.

Detected by CoverityScan, CID#1466879 ("Logically dead code")

Fixes: 21092e9ce8b1 ("ixgbevf: Add support for XDP_TX action")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d9033f26eff..e3d04f226d57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3420,7 +3420,7 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 		if (!err)
 			continue;
 		hw_dbg(&adapter->hw, "Allocation for XDP Queue %u failed\n", j);
-		break;
+		goto err_setup_tx;
 	}
 
 	return 0;
-- 
2.15.1
