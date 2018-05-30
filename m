Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeE3LP0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:15:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751746AbeE3LH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:26 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kalle Valo" <kvalo@qca.qualcomm.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.618788242@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 032/153] ath9k_htc: Add a sanity check in
 ath9k_htc_ampdu_action()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 413fd2f5c0233d3cde391679b967c1f14cd2cb27 upstream.

Smatch generates a warning here:

    drivers/net/wireless/ath/ath9k/htc_drv_main.c:1688 ath9k_htc_ampdu_action()
    error: buffer overflow 'ista->tid_state' 8 <= 15

I don't know if it's a real bug or not but the other paths through this
function all ensure that "tid" is less than ATH9K_HTC_MAX_TID (8) so
checking here makes things more consistent.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1640,6 +1640,10 @@ static int ath9k_htc_ampdu_action(struct
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		if (tid >= ATH9K_HTC_MAX_TID) {
+			ret = -EINVAL;
+			break;
+		}
 		ista = (struct ath9k_htc_sta *) sta->drv_priv;
 		spin_lock_bh(&priv->tx.tx_lock);
 		ista->tid_state[tid] = AGGR_OPERATIONAL;
