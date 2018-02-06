Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeBFTsd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:48:33 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21397 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBFTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:48:31 -0500
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Feb 2018 20:48:28 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jeffrey.t.kirsher@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
Date: Tue,  6 Feb 2018 20:47:59 +0100
Message-Id: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'HWTSTAMP_TX_ON' should be handled as a value, not as a bit mask.
The modified code should behave the same, because HWTSTAMP_TX_ON is 1
and no other possible values of 'tx_type' would match the test.
However, this is more future-proof, should other values be allowed one day.

See 'struct hwtstamp_config' in 'include/uapi/linux/net_tstamp.h'

This fixes a warning reported by smatch:
   igb_xmit_frame_ring() warn: bit shifter 'HWTSTAMP_TX_ON' used for logical '&'

Fixes: 26bd4e2db06be ("igb: protect TX timestamping from API misuse")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c208753ff5b7..e945d1f7c7fe 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5727,7 +5727,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
 
-		if (adapter->tstamp_config.tx_type & HWTSTAMP_TX_ON &&
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
 		    !test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
 					   &adapter->state)) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
