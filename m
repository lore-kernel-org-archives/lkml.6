Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeDILf1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:35:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38052 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDILfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:35:23 -0400
X-Google-Smtp-Source: AIpwx49LXnshQybqhrAKgXH12qDa58/+P0mK4q1jnESWvwRhOwq9/QTTRTxFkn+s8YFCaosyhqc62g==
From: AceLan Kao <acelan.kao@canonical.com>
To: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rakesh Pandit <rakesh@tuxera.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] alx: add disable_wol paramenter
Date: Mon,  9 Apr 2018 19:35:14 +0800
Message-Id: <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WoL feature was reported broken and will lead to
the system resume immediately after suspending.
This symptom is not happening on every system, so adding
disable_wol option and disable WoL by default to prevent the issue from
happening again.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61651
Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/net/ethernet/atheros/alx/ethtool.c | 7 ++++++-
 drivers/net/ethernet/atheros/alx/main.c    | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index 859e272..e50129d 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -46,6 +46,8 @@
 #include "reg.h"
 #include "hw.h"
 
+extern const bool disable_wol;
+
 /* The order of these strings must match the order of the fields in
  * struct alx_hw_stats
  * See hw.h
@@ -315,6 +317,9 @@ static void alx_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	struct alx_priv *alx = netdev_priv(netdev);
 	struct alx_hw *hw = &alx->hw;
 
+	if (disable_wol)
+		return;
+
 	wol->supported = WAKE_MAGIC | WAKE_PHY;
 	wol->wolopts = 0;
 
@@ -329,7 +334,7 @@ static int alx_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	struct alx_priv *alx = netdev_priv(netdev);
 	struct alx_hw *hw = &alx->hw;
 
-	if (wol->wolopts & ~(WAKE_MAGIC | WAKE_PHY))
+	if (disable_wol || (wol->wolopts & ~(WAKE_MAGIC | WAKE_PHY)))
 		return -EOPNOTSUPP;
 
 	hw->sleep_ctrl = 0;
diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index c0e2bb2..c27fdf7 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -51,6 +51,11 @@
 
 const char alx_drv_name[] = "alx";
 
+/* disable WoL by default */
+bool disable_wol = 1;
+module_param(disable_wol, bool, 0);
+MODULE_PARM_DESC(disable_wol, "Disable Wake on Lan feature");
+
 static void alx_free_txbuf(struct alx_tx_queue *txq, int entry)
 {
 	struct alx_buffer *txb = &txq->bufs[entry];
-- 
2.7.4
