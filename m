Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165346AbeE1NfM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162385AbeE1Kpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 074/496] ibmvnic: Clean RX pool buffers during device close
Date: Mon, 28 May 2018 11:57:39 +0200
Message-Id: <20180528100322.895006759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit d0869c0071e40c4407d1a4d7c9497653cf47253b ]

During device close or reset, there were some cases of outstanding
RX socket buffers not being freed. Include a function similar to the
one that already exists to clean TX socket buffers in this case.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -933,6 +933,35 @@ static int ibmvnic_open(struct net_devic
 	return rc;
 }
 
+static void clean_rx_pools(struct ibmvnic_adapter *adapter)
+{
+	struct ibmvnic_rx_pool *rx_pool;
+	u64 rx_entries;
+	int rx_scrqs;
+	int i, j;
+
+	if (!adapter->rx_pool)
+		return;
+
+	rx_scrqs = be32_to_cpu(adapter->login_rsp_buf->num_rxadd_subcrqs);
+	rx_entries = adapter->req_rx_add_entries_per_subcrq;
+
+	/* Free any remaining skbs in the rx buffer pools */
+	for (i = 0; i < rx_scrqs; i++) {
+		rx_pool = &adapter->rx_pool[i];
+		if (!rx_pool)
+			continue;
+
+		netdev_dbg(adapter->netdev, "Cleaning rx_pool[%d]\n", i);
+		for (j = 0; j < rx_entries; j++) {
+			if (rx_pool->rx_buff[j].skb) {
+				dev_kfree_skb_any(rx_pool->rx_buff[j].skb);
+				rx_pool->rx_buff[j].skb = NULL;
+			}
+		}
+	}
+}
+
 static void clean_tx_pools(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_tx_pool *tx_pool;
@@ -1010,7 +1039,7 @@ static int __ibmvnic_close(struct net_de
 			}
 		}
 	}
-
+	clean_rx_pools(adapter);
 	clean_tx_pools(adapter);
 	adapter->state = VNIC_CLOSED;
 	return rc;
