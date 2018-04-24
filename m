Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbeDXNQr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54434 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933721AbeDXNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:40 -0400
X-Google-Smtp-Source: AIpwx4/vctWpu4pmzS0ts1VbP4fTMtjkljmxDUXALBgls0ffASkN4c4Gzu/nqe8geVLUE6YJeAhGzA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        netdev@vger.kernel.org
Subject: [PATCH] liquidio: fix liquidio_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:37 +0200
Message-Id: <20180424131637.3707-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementations in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 603a144d3..6d6f16815 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -2491,7 +2491,7 @@ static inline int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct lio *lio;
 	struct octnet_buf_free_info *finfo;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index f92dfa411..13ef46a85 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -1560,7 +1560,7 @@ static int send_nic_timestamp_pkt(struct octeon_device *oct,
  * @returns whether the packet was transmitted to the device okay or not
  *             (NETDEV_TX_OK or NETDEV_TX_BUSY)
  */
-static int liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liquidio_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct octnet_buf_free_info *finfo;
 	union octnic_cmd_setup cmdsetup;
-- 
2.17.0
