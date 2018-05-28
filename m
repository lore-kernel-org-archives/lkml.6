Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938966AbeE1Mi0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937815AbeE1K6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:58:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arjun Vynipadath <arjun@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 381/496] cxgb4: Setup FW queues before registering netdev
Date: Mon, 28 May 2018 12:02:46 +0200
Message-Id: <20180528100335.840612163@linuxfoundation.org>
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

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit 843bd7db79c861b49e2912d723625f5fa8e94502 ]

When NetworkManager is enabled, there are chances that interface up
is called even before probe completes. This means we have not yet
allocated the FW sge queues, hence rest of ingress queue allocation
wont be proper. Fix this by calling setup_fw_sge_queues() before
register_netdev().

Fixes: 0fbc81b3ad51 ('chcr/cxgb4i/cxgbit/RDMA/cxgb4: Allocate resources dynamically for all cxgb4 ULD's')
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -815,8 +815,6 @@ static int setup_fw_sge_queues(struct ad
 
 	err = t4_sge_alloc_rxq(adap, &s->fw_evtq, true, adap->port[0],
 			       adap->msi_idx, NULL, fwevtq_handler, NULL, -1);
-	if (err)
-		t4_free_sge_resources(adap);
 	return err;
 }
 
@@ -5116,6 +5114,13 @@ static int init_one(struct pci_dev *pdev
 	if (err)
 		goto out_free_dev;
 
+	err = setup_fw_sge_queues(adapter);
+	if (err) {
+		dev_err(adapter->pdev_dev,
+			"FW sge queue allocation failed, err %d", err);
+		goto out_free_dev;
+	}
+
 	/*
 	 * The card is now ready to go.  If any errors occur during device
 	 * registration we do not fail the whole card but rather proceed only
@@ -5164,7 +5169,6 @@ static int init_one(struct pci_dev *pdev
 		cxgb4_ptp_init(adapter);
 
 	print_adapter_info(adapter);
-	setup_fw_sge_queues(adapter);
 	return 0;
 
 sriov:
@@ -5220,6 +5224,7 @@ free_mbox_log:
 #endif
 
  out_free_dev:
+	t4_free_sge_resources(adapter);
 	free_some_resources(adapter);
 	if (adapter->flags & USING_MSIX)
 		free_msix_info(adapter);
