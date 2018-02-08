Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBHGr0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:47:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:54988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeBHGrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:47:24 -0500
From: Benjamin Poirier <bpoirier@suse.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-queue 2/3] e1000e: Fix queue interrupt re-raising in Other interrupt.
Date: Thu,  8 Feb 2018 15:47:13 +0900
Message-Id: <20180208064714.6042-2-bpoirier@suse.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180208064714.6042-1-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

restores the ICS write for rx/tx queue interrupts which was present before
commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt",
v4.5-rc1) but was not restored in commit 4aea7a5c5e94 ("e1000e: Avoid
receiver overrun interrupt bursts", v4.15-rc1).

This re-raises the queue interrupts in case the txq or rxq bits were set in
ICR and the Other interrupt handler read and cleared ICR before the queue
interrupt was raised.

Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3b36efa6228d..2c9609bee2ae 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1919,6 +1919,9 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 	icr = er32(ICR);
 	ew32(ICR, E1000_ICR_OTHER);
 
+	if (icr & adapter->eiac_mask)
+		ew32(ICS, (icr & adapter->eiac_mask));
+
 	if (icr & E1000_ICR_LSC) {
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
-- 
2.16.1
