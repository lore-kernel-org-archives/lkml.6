Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424391AbeE1LOP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424331AbeE1LOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 224/272] ibmvnic: Allocate statistics buffers during probe
Date: Mon, 28 May 2018 12:04:17 +0200
Message-Id: <20180528100259.244142209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

[ Upstream commit 53cc7721fdf12e649994cfb7d8f562acb0e4510b ]

Currently, buffers holding individual queue statistics are allocated
when the device is opened. If an ibmvnic interface is hotplugged or
initialized but never opened, an attempt to get statistics with
ethtool will result in a kernel panic.

Since the driver allocates a constant number, the maximum supported
queues, of buffers, these can be allocated during device probe and
freed when the device is hot-unplugged or the module is removed.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -812,8 +812,6 @@ static void release_resources(struct ibm
 	release_tx_pools(adapter);
 	release_rx_pools(adapter);
 
-	release_stats_token(adapter);
-	release_stats_buffers(adapter);
 	release_error_buffers(adapter);
 
 	if (adapter->napi) {
@@ -953,14 +951,6 @@ static int init_resources(struct ibmvnic
 	if (rc)
 		return rc;
 
-	rc = init_stats_buffers(adapter);
-	if (rc)
-		return rc;
-
-	rc = init_stats_token(adapter);
-	if (rc)
-		return rc;
-
 	adapter->vpd = kzalloc(sizeof(*adapter->vpd), GFP_KERNEL);
 	if (!adapter->vpd)
 		return -ENOMEM;
@@ -4390,6 +4380,14 @@ static int ibmvnic_init(struct ibmvnic_a
 		release_crq_queue(adapter);
 	}
 
+	rc = init_stats_buffers(adapter);
+	if (rc)
+		return rc;
+
+	rc = init_stats_token(adapter);
+	if (rc)
+		return rc;
+
 	return rc;
 }
 
@@ -4497,6 +4495,9 @@ static int ibmvnic_remove(struct vio_dev
 	release_sub_crqs(adapter);
 	release_crq_queue(adapter);
 
+	release_stats_token(adapter);
+	release_stats_buffers(adapter);
+
 	adapter->state = VNIC_REMOVED;
 
 	mutex_unlock(&adapter->reset_lock);
