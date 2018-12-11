Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9378EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6BA2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543744;
	bh=kahmAVU3V2hTfUIEQLu51DgB6uldFuSIe5UdYE2PZOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WFbwOfyXgrrP9HIPKN947hE/dLpgpgZCXZz9koHvRbv41aNslZVeNZeSQlM1NOX7G
	 vU9beNma3VSumXsE9NBUDq2ChmtEWBYqkv8Y0iWCnY/rEo2o4+xh8jn6Y/P06phHx1
	 HQY4qzK6jhDp+MimPqT3qYXCdWY0ovVOWiKE76nw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6BA2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbeLKPzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbeLKPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2587421104;
        Tue, 11 Dec 2018 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543739;
        bh=kahmAVU3V2hTfUIEQLu51DgB6uldFuSIe5UdYE2PZOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmcEMQcKa0tUifRl3p1QFikniOspqv7vERu4pXgtJkqABINiY+QsAymoK+PYYTUHG
         MzIvqkRX/MWI3HWFamjzAJEUjnKDl5V6bI71u+glTFQEljGWP1k3qQ8t0H47PkmoAl
         J5e6gaUwTB7B6SPrrP1p+HBeYqWyCqtGdPT6Ax/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juliet Kim <julietk@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/118] net/ibmnvic: Fix deadlock problem in reset
Date:   Tue, 11 Dec 2018 16:41:05 +0100
Message-Id: <20181211151646.104154615@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a5681e20b541a507c7d4fd48ae4a4040d32ee1ef ]

This patch changes to use rtnl_lock only during a reset to avoid
deadlock that could occur when a thread operating close is holding
rtnl_lock and waiting for reset_lock acquired by another thread,
which is waiting for rtnl_lock in order to set the number of tx/rx
queues during a reset.

Also, we now setting the number of tx/rx queues during a soft reset
for failover or LPM events.

Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 59 +++++++++++-------------------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7661064c815b..a646de07cbdc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1103,20 +1103,15 @@ static int ibmvnic_open(struct net_device *netdev)
 		return 0;
 	}
 
-	mutex_lock(&adapter->reset_lock);
-
 	if (adapter->state != VNIC_CLOSED) {
 		rc = ibmvnic_login(netdev);
-		if (rc) {
-			mutex_unlock(&adapter->reset_lock);
+		if (rc)
 			return rc;
-		}
 
 		rc = init_resources(adapter);
 		if (rc) {
 			netdev_err(netdev, "failed to initialize resources\n");
 			release_resources(adapter);
-			mutex_unlock(&adapter->reset_lock);
 			return rc;
 		}
 	}
@@ -1124,8 +1119,6 @@ static int ibmvnic_open(struct net_device *netdev)
 	rc = __ibmvnic_open(netdev);
 	netif_carrier_on(netdev);
 
-	mutex_unlock(&adapter->reset_lock);
-
 	return rc;
 }
 
@@ -1269,10 +1262,8 @@ static int ibmvnic_close(struct net_device *netdev)
 		return 0;
 	}
 
-	mutex_lock(&adapter->reset_lock);
 	rc = __ibmvnic_close(netdev);
 	ibmvnic_cleanup(netdev);
-	mutex_unlock(&adapter->reset_lock);
 
 	return rc;
 }
@@ -1820,20 +1811,15 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
 			   adapter->req_tx_queues != old_num_tx_queues) {
-			adapter->map_id = 1;
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
-			rc = init_rx_pools(netdev);
-			if (rc)
-				return rc;
-			rc = init_tx_pools(netdev);
-			if (rc)
-				return rc;
-
 			release_napi(adapter);
-			rc = init_napi(adapter);
+			release_vpd_data(adapter);
+
+			rc = init_resources(adapter);
 			if (rc)
 				return rc;
+
 		} else {
 			rc = reset_tx_pools(adapter);
 			if (rc)
@@ -1917,17 +1903,8 @@ static int do_hard_reset(struct ibmvnic_adapter *adapter,
 		adapter->state = VNIC_PROBED;
 		return 0;
 	}
-	/* netif_set_real_num_xx_queues needs to take rtnl lock here
-	 * unless wait_for_reset is set, in which case the rtnl lock
-	 * has already been taken before initializing the reset
-	 */
-	if (!adapter->wait_for_reset) {
-		rtnl_lock();
-		rc = init_resources(adapter);
-		rtnl_unlock();
-	} else {
-		rc = init_resources(adapter);
-	}
+
+	rc = init_resources(adapter);
 	if (rc)
 		return rc;
 
@@ -1986,13 +1963,21 @@ static void __ibmvnic_reset(struct work_struct *work)
 	struct ibmvnic_rwi *rwi;
 	struct ibmvnic_adapter *adapter;
 	struct net_device *netdev;
+	bool we_lock_rtnl = false;
 	u32 reset_state;
 	int rc = 0;
 
 	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
 	netdev = adapter->netdev;
 
-	mutex_lock(&adapter->reset_lock);
+	/* netif_set_real_num_xx_queues needs to take rtnl lock here
+	 * unless wait_for_reset is set, in which case the rtnl lock
+	 * has already been taken before initializing the reset
+	 */
+	if (!adapter->wait_for_reset) {
+		rtnl_lock();
+		we_lock_rtnl = true;
+	}
 	reset_state = adapter->state;
 
 	rwi = get_next_rwi(adapter);
@@ -2020,12 +2005,11 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (rc) {
 		netdev_dbg(adapter->netdev, "Reset failed\n");
 		free_all_rwi(adapter);
-		mutex_unlock(&adapter->reset_lock);
-		return;
 	}
 
 	adapter->resetting = false;
-	mutex_unlock(&adapter->reset_lock);
+	if (we_lock_rtnl)
+		rtnl_unlock();
 }
 
 static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
@@ -4709,7 +4693,6 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
-	mutex_init(&adapter->reset_lock);
 	mutex_init(&adapter->rwi_lock);
 	adapter->resetting = false;
 
@@ -4781,8 +4764,8 @@ static int ibmvnic_remove(struct vio_dev *dev)
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 
 	adapter->state = VNIC_REMOVING;
-	unregister_netdev(netdev);
-	mutex_lock(&adapter->reset_lock);
+	rtnl_lock();
+	unregister_netdevice(netdev);
 
 	release_resources(adapter);
 	release_sub_crqs(adapter, 1);
@@ -4793,7 +4776,7 @@ static int ibmvnic_remove(struct vio_dev *dev)
 
 	adapter->state = VNIC_REMOVED;
 
-	mutex_unlock(&adapter->reset_lock);
+	rtnl_unlock();
 	device_remove_file(&dev->dev, &dev_attr_failover);
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index f06eec145ca6..735f481b1870 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1068,7 +1068,7 @@ struct ibmvnic_adapter {
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
 	enum ibmvnic_reset_reason reset_reason;
-	struct mutex reset_lock, rwi_lock;
+	struct mutex rwi_lock;
 	struct list_head rwi_list;
 	struct work_struct ibmvnic_reset;
 	bool resetting;
-- 
2.19.1



