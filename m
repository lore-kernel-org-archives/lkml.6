Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4305C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE92086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAE92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeICVpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeICVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74AB0D24;
        Mon,  3 Sep 2018 17:23:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/165] enic: handle mtu change for vf properly
Date:   Mon,  3 Sep 2018 18:55:49 +0200
Message-Id: <20180903165658.285199004@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit ab123fe071c9aa9680ecd62eb080eb26cff4892c ]

When driver gets notification for mtu change, driver does not handle it for
all RQs. It handles only RQ[0].

Fix is to use enic_change_mtu() interface to change mtu for vf.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |   78 +++++++++-------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2007,28 +2007,42 @@ static int enic_stop(struct net_device *
 	return 0;
 }
 
+static int _enic_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	bool running = netif_running(netdev);
+	int err = 0;
+
+	ASSERT_RTNL();
+	if (running) {
+		err = enic_stop(netdev);
+		if (err)
+			return err;
+	}
+
+	netdev->mtu = new_mtu;
+
+	if (running) {
+		err = enic_open(netdev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int enic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct enic *enic = netdev_priv(netdev);
-	int running = netif_running(netdev);
 
 	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		return -EOPNOTSUPP;
 
-	if (running)
-		enic_stop(netdev);
-
-	netdev->mtu = new_mtu;
-
 	if (netdev->mtu > enic->port_mtu)
 		netdev_warn(netdev,
-			"interface MTU (%d) set higher than port MTU (%d)\n",
-			netdev->mtu, enic->port_mtu);
-
-	if (running)
-		enic_open(netdev);
+			    "interface MTU (%d) set higher than port MTU (%d)\n",
+			    netdev->mtu, enic->port_mtu);
 
-	return 0;
+	return _enic_change_mtu(netdev, new_mtu);
 }
 
 static void enic_change_mtu_work(struct work_struct *work)
@@ -2036,47 +2050,9 @@ static void enic_change_mtu_work(struct
 	struct enic *enic = container_of(work, struct enic, change_mtu_work);
 	struct net_device *netdev = enic->netdev;
 	int new_mtu = vnic_dev_mtu(enic->vdev);
-	int err;
-	unsigned int i;
-
-	new_mtu = max_t(int, ENIC_MIN_MTU, min_t(int, ENIC_MAX_MTU, new_mtu));
 
 	rtnl_lock();
-
-	/* Stop RQ */
-	del_timer_sync(&enic->notify_timer);
-
-	for (i = 0; i < enic->rq_count; i++)
-		napi_disable(&enic->napi[i]);
-
-	vnic_intr_mask(&enic->intr[0]);
-	enic_synchronize_irqs(enic);
-	err = vnic_rq_disable(&enic->rq[0]);
-	if (err) {
-		rtnl_unlock();
-		netdev_err(netdev, "Unable to disable RQ.\n");
-		return;
-	}
-	vnic_rq_clean(&enic->rq[0], enic_free_rq_buf);
-	vnic_cq_clean(&enic->cq[0]);
-	vnic_intr_clean(&enic->intr[0]);
-
-	/* Fill RQ with new_mtu-sized buffers */
-	netdev->mtu = new_mtu;
-	vnic_rq_fill(&enic->rq[0], enic_rq_alloc_buf);
-	/* Need at least one buffer on ring to get going */
-	if (vnic_rq_desc_used(&enic->rq[0]) == 0) {
-		rtnl_unlock();
-		netdev_err(netdev, "Unable to alloc receive buffers.\n");
-		return;
-	}
-
-	/* Start RQ */
-	vnic_rq_enable(&enic->rq[0]);
-	napi_enable(&enic->napi[0]);
-	vnic_intr_unmask(&enic->intr[0]);
-	enic_notify_timer_start(enic);
-
+	(void)_enic_change_mtu(netdev, new_mtu);
 	rtnl_unlock();
 
 	netdev_info(netdev, "interface MTU set as %d\n", netdev->mtu);


