Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756455AbeEIN66 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:58:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756427AbeEIN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:58:56 -0400
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ixgbe: fix memory leak on ipsec allocation
Date: Wed,  9 May 2018 14:58:48 +0100
Message-Id: <20180509135848.20530-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error clean up path kfree's adapter->ipsec and should be
instead kfree'ing ipsec. Fix this.  Also, the err1 error exit path
does not need to kfree ipsec because this failure path was for
the failed allocation of ipsec.

Detected by CoverityScan, CID#146424 ("Resource Leak")

Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 41af2b81e960..195c0b65eee2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -919,8 +919,8 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 	kfree(ipsec->ip_tbl);
 	kfree(ipsec->rx_tbl);
 	kfree(ipsec->tx_tbl);
+	kfree(ipsec);
 err1:
-	kfree(adapter->ipsec);
 	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
 }
 
-- 
2.17.0
