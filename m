Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F432145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAXht+aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F432145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeKOItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbeKOI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:18 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706752251A;
        Wed, 14 Nov 2018 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234134;
        bh=6t8XfduumMFVhI2vt35t9uJVZbAdIDEHpZBYciD+MeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAXht+aYSIjXjqVZjR8kwntLqjwoV9PVgzoJpVSZ6/4hMBsMGuHFisr24H5rO44eX
         y1j8g7c/FDrG4qDH5i5a11Ij9nQuUESg1Sq1BUnn3vwqTPA4K3gibf5bDl8kYX8HCs
         5t0Slp4Adx/GmvCJwihw7MriyxFfZFXn6+rici2U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 25/73] s390/qeth: unregister netdevice only when registered
Date:   Wed, 14 Nov 2018 17:21:19 -0500
Message-Id: <20181114222207.98701-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 30356d08159d7899438e94503ae322a8b881e205 ]

qeth only registers its netdevice when the qeth device is first set
online. Thus a device that has never been set online will trigger
a WARN ("network todo 'hsi%d' but state 0") in unregister_netdev() when
removed.

Fix this by protecting the unregister step, just like we already protect
against repeated registering of the netdevice.

Fixes: d3d1b205e89f ("s390/qeth: allocate netdevice early")
Reported-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    | 5 +++++
 drivers/s390/net/qeth_l2_main.c | 5 +++--
 drivers/s390/net/qeth_l3_main.c | 5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 34e0d476c5c6..970654fcc48d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -826,6 +826,11 @@ struct qeth_trap_id {
 /*some helper functions*/
 #define QETH_CARD_IFNAME(card) (((card)->dev)? (card)->dev->name : "")
 
+static inline bool qeth_netdev_is_registered(struct net_device *dev)
+{
+	return dev->netdev_ops != NULL;
+}
+
 static inline void qeth_scrub_qdio_buffer(struct qdio_buffer *buf,
 					  unsigned int elements)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b5e38531733f..76b2fba5fba2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -854,7 +854,8 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
-	unregister_netdev(card->dev);
+	if (qeth_netdev_is_registered(card->dev))
+		unregister_netdev(card->dev);
 }
 
 static const struct ethtool_ops qeth_l2_ethtool_ops = {
@@ -894,7 +895,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 {
 	int rc;
 
-	if (card->dev->netdev_ops)
+	if (qeth_netdev_is_registered(card->dev))
 		return 0;
 
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 17e2fd584fbf..b7f6a8384543 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2514,7 +2514,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 {
 	int rc;
 
-	if (card->dev->netdev_ops)
+	if (qeth_netdev_is_registered(card->dev))
 		return 0;
 
 	if (card->info.type == QETH_CARD_TYPE_OSD ||
@@ -2611,7 +2611,8 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
-	unregister_netdev(card->dev);
+	if (qeth_netdev_is_registered(card->dev))
+		unregister_netdev(card->dev);
 	qeth_l3_clear_ip_htable(card, 0);
 	qeth_l3_clear_ipato_list(card);
 }
-- 
2.17.1

