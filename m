Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF20C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugpBfrZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3324220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbeKZV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B73920645;
        Mon, 26 Nov 2018 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230215;
        bh=TG8aDctJoDtVF3vrNzspnwNZ6dCIhXsK8SbmMXGD1jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugpBfrZ69DFPyEgVJPxxqiLxT+HMm4MtNihz5z/9hhTiqcfjZKAvxggFvCqyWC4q3
         dffmWG5vsySuQ6s+l/EMFONqtuOhS/lWLFC8RpdyRS7LO/NpV3U3Zh6v5VKuoEhPmj
         f2pS1VqcfdY+ldNQQTP5fJapVLB/hH7CEHSMootk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/118] s390/qeth: unregister netdevice only when registered
Date:   Mon, 26 Nov 2018 11:50:46 +0100
Message-Id: <20181126105102.907093016@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



