Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D713CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C26215EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C26215EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeHNAEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:04:06 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:04:05 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LqWMz-1gJhCL24ZN-00e7JT; Mon, 13 Aug 2018 23:20:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: lan743x: fix building without CONFIG_PTP_1588_CLOCK
Date:   Mon, 13 Aug 2018 23:19:22 +0200
Message-Id: <20180813211938.2375199-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180813211938.2375199-1-arnd@arndb.de>
References: <20180813211938.2375199-1-arnd@arndb.de>
X-Provags-ID: V03:K1:moEVRf07NMLFxf+iDqWR6M0Hs21tiTq49UasZD4a0HDGzIIP8TC
 kOLzqd7Z7y5C74spOjG8IhGVHZy73rqrm+IoXOflR6EvPv7ILobJSO3Pzt3g6pC2Ks2Gpmn
 zijj5b9dhPlNN4C8P9rTl2qlnEVjE2JTaxOEzbRK2d/g7UvugyyHNVH6/+6zygnwyuGo43N
 tljhqK3kPymBEby7MVluQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lh8ARA3Pq7w=:gH8RVdv8ndlPsph2F8UkIk
 20RLrJnnbYmruKA80QjNXO2hGphqhdrcsSbeuQkeY6cVbhOrolzkPWgwjfb4i59XcDPiRSP3r
 bY3M+S9HneNULddbJTpb6CHvyj3gbebzcH6P/jqk+AZpZu94SjuXRQz36UHHUiTVqshliyTP1
 WS5bjYziB1teFvpO7B+SuF9+da+pQUTnv/KoDrOwuxVa0m96Ge4FFDzDLE7m5ymLXDmESpfjG
 QjFWcJTVJ8Je+XPLYm6aGVVKPLAFd9QMBipXLr5rXAro/vZPC6PajMAySWTS+iH+J5waUAgJw
 +waWpL8zr9/WZH1jkuTTtjytiiniRvhfSRAFJ/ZPuTeIUEgxw/khbTkcqORv+d132L4sUNYTT
 /6f63knPiqJSIBK8UfECyk7/NkdaqnoI2dtBOoJ3ZoMbuPGmvtjTo2pmQ2lqEroTjDyDGsM3k
 xpAhJFeBozWdvLwiLAhIrvYyPhZlvEEkIC23YmIoIDjTNJdrJWJ2LUsdcDrh9LmWEht7I6sVX
 E8vaZinmUDkMqy9vZqipWBJYb4YykFI9D5XFMrjWFnmhgBMAogcPgv4e5esGLeFxQCZ5vwM/2
 Spj/XfE6xm76/kHmsAPYpBvyELtAWCqz0Kq+VXVUmPHRJwsoIWOgBzEGIwLUzS0u8ya5OAJWW
 4YrIg0G6jNmbDUc82havqzriaQkN9HJQdo3qwl/zjFVmfneTbW7Se+Xw//QGu7HFbGnc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_PTP_1588_CLOCK results in multiple failures,
this was obviously not well tested:

drivers/net/ethernet/microchip/lan743x_ptp.c: In function 'lan743x_ptp_isr':
drivers/net/ethernet/microchip/lan743x_ptp.c:781:28: error: 'struct lan743x_ptp' has no member named 'ptp_clock'; did you mean 'tx_ts_lock'?
   ptp_schedule_worker(ptp->ptp_clock, 0);
                            ^~~~~~~~~
                            tx_ts_lock
drivers/net/ethernet/microchip/lan743x_ptp.c: In function 'lan743x_ptp_open':
drivers/net/ethernet/microchip/lan743x_ptp.c:879:6: error: unused variable 'ret' [-Werror=unused-variable]
  int ret = -ENODEV;
      ^~~
At top level:
drivers/net/ethernet/microchip/lan743x_ptp.c:63:13: error: 'lan743x_ptp_tx_ts_enqueue_ts' defined but not used [-Werror=unused-function]
 static void lan743x_ptp_tx_ts_enqueue_ts(struct lan743x_adapter *adapter,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
drivers/net/ethernet/microchip/lan743x_ethtool.c: In function 'lan743x_ethtool_get_ts_info':
drivers/net/ethernet/microchip/lan743x_ethtool.c:558:19: error: 'struct lan743x_ptp' has no member named 'ptp_clock'; did you mean 'tx_ts_lock'?

Those #ifdef checks are hard to get right, replace them all with
IS_ENABLED() checks that leave the same code visible to the compiler
but let it optimize out the unused bits based on the configuration.

Fixes: 07624df1c9ef ("lan743x: lan743x: Add PTP support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 15 ++++++---------
 drivers/net/ethernet/microchip/lan743x_ptp.h |  2 --
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 42064fd2beb5..66e7568a0e7c 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include "lan743x_main.h"
 
+#include <linux/ptp_clock_kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
@@ -139,7 +140,6 @@ static void lan743x_ptp_tx_ts_complete(struct lan743x_adapter *adapter)
 	spin_unlock_bh(&ptp->tx_ts_lock);
 }
 
-#ifdef CONFIG_PTP_1588_CLOCK
 static int lan743x_ptp_reserve_event_ch(struct lan743x_adapter *adapter)
 {
 	struct lan743x_ptp *ptp = &adapter->ptp;
@@ -761,7 +761,6 @@ static void lan743x_ptp_clock_step(struct lan743x_adapter *adapter,
 		mutex_unlock(&ptp->command_lock);
 	}
 }
-#endif /* CONFIG_PTP_1588_CLOCK */
 
 void lan743x_ptp_isr(void *context)
 {
@@ -890,7 +889,9 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter)
 			  PTP_INT_BIT_TX_SWTS_ERR_ | PTP_INT_BIT_TX_TS_);
 	ptp->flags |= PTP_FLAG_ISR_ENABLED;
 
-#ifdef CONFIG_PTP_1588_CLOCK
+	if (!IS_ENABLED(CONFIG_PTP_1588_CLOCK))
+		return 0;
+
 	snprintf(ptp->pin_config[0].name, 32, "lan743x_ptp_pin_0");
 	ptp->pin_config[0].index = 0;
 	ptp->pin_config[0].func = PTP_PF_PEROUT;
@@ -932,9 +933,6 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter)
 done:
 	lan743x_ptp_close(adapter);
 	return ret;
-#else
-	return 0;
-#endif
 }
 
 void lan743x_ptp_close(struct lan743x_adapter *adapter)
@@ -942,15 +940,14 @@ void lan743x_ptp_close(struct lan743x_adapter *adapter)
 	struct lan743x_ptp *ptp = &adapter->ptp;
 	int index;
 
-#ifdef CONFIG_PTP_1588_CLOCK
-	if (ptp->flags & PTP_FLAG_PTP_CLOCK_REGISTERED) {
+	if (IS_ENABLED(CONFIG_PTP_1588_CLOCK) &&
+	    ptp->flags & PTP_FLAG_PTP_CLOCK_REGISTERED) {
 		ptp_clock_unregister(ptp->ptp_clock);
 		ptp->ptp_clock = NULL;
 		ptp->flags &= ~PTP_FLAG_PTP_CLOCK_REGISTERED;
 		netif_info(adapter, drv, adapter->netdev,
 			   "ptp clock unregister\n");
 	}
-#endif
 
 	if (ptp->flags & PTP_FLAG_ISR_ENABLED) {
 		lan743x_csr_write(adapter, PTP_INT_EN_CLR,
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index 20f2223024dc..5fc1b3cd5e33 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -49,11 +49,9 @@ struct lan743x_ptp {
 	/* command_lock: used to prevent concurrent ptp commands */
 	struct mutex	command_lock;
 
-#ifdef CONFIG_PTP_1588_CLOCK
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	struct ptp_pin_desc pin_config[1];
-#endif /* CONFIG_PTP_1588_CLOCK */
 
 #define LAN743X_PTP_NUMBER_OF_EVENT_CHANNELS (2)
 	unsigned long used_event_ch;
-- 
2.18.0

