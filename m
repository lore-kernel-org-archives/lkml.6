Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB47C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1412084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1412084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeHWM1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D203AC83;
        Thu, 23 Aug 2018 08:58:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 157/324] s390/qeth: consistently re-enable device features
Date:   Thu, 23 Aug 2018 09:53:43 +0200
Message-Id: <20180823075003.893331994@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit d025da9eb1e48d3e5f2a2ff13ac5ac536ba4be43 ]

commit e830baa9c3f0 ("qeth: restore device features after recovery") and
commit ce3443564145 ("s390/qeth: rely on kernel for feature recovery")
made sure that the HW functions for device features get re-programmed
after recovery.

But we missed that the same handling is also required when a card is
first set offline (destroying all HW context), and then online again.
Fix this by moving the re-enable action out of the recovery-only path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h      |    2 +-
 drivers/s390/net/qeth_core_main.c |   23 +++++++++++------------
 drivers/s390/net/qeth_l2_main.c   |    5 ++---
 drivers/s390/net/qeth_l3_main.c   |    3 ++-
 4 files changed, 16 insertions(+), 17 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1003,7 +1003,7 @@ struct qeth_cmd_buffer *qeth_get_setassp
 						 __u16, __u16,
 						 enum qeth_prot_versions);
 int qeth_set_features(struct net_device *, netdev_features_t);
-void qeth_recover_features(struct net_device *dev);
+void qeth_enable_hw_features(struct net_device *dev);
 netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
 netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6432,28 +6432,27 @@ static int qeth_set_ipa_tso(struct qeth_
 #define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO)
 
 /**
- * qeth_recover_features() - Restore device features after recovery
- * @dev:	the recovering net_device
- *
- * Caller must hold rtnl lock.
+ * qeth_enable_hw_features() - (Re-)Enable HW functions for device features
+ * @dev:	a net_device
  */
-void qeth_recover_features(struct net_device *dev)
+void qeth_enable_hw_features(struct net_device *dev)
 {
-	netdev_features_t features = dev->features;
 	struct qeth_card *card = dev->ml_priv;
+	netdev_features_t features;
 
+	rtnl_lock();
+	features = dev->features;
 	/* force-off any feature that needs an IPA sequence.
 	 * netdev_update_features() will restart them.
 	 */
 	dev->features &= ~QETH_HW_FEATURES;
 	netdev_update_features(dev);
-
-	if (features == dev->features)
-		return;
-	dev_warn(&card->gdev->dev,
-		 "Device recovery failed to restore all offload features\n");
+	if (features != dev->features)
+		dev_warn(&card->gdev->dev,
+			 "Device recovery failed to restore all offload features\n");
+	rtnl_unlock();
 }
-EXPORT_SYMBOL_GPL(qeth_recover_features);
+EXPORT_SYMBOL_GPL(qeth_enable_hw_features);
 
 int qeth_set_features(struct net_device *dev, netdev_features_t features)
 {
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1130,6 +1130,8 @@ static int __qeth_l2_set_online(struct c
 		netif_carrier_off(card->dev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
+
+	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
 		if (recovery_mode &&
 		    card->info.type != QETH_CARD_TYPE_OSN) {
@@ -1141,9 +1143,6 @@ static int __qeth_l2_set_online(struct c
 		}
 		/* this also sets saved unicast addresses */
 		qeth_l2_set_rx_mode(card->dev);
-		rtnl_lock();
-		qeth_recover_features(card->dev);
-		rtnl_unlock();
 	}
 	/* let user_space know that device is online */
 	kobject_uevent(&gdev->dev.kobj, KOBJ_CHANGE);
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2792,6 +2792,8 @@ static int __qeth_l3_set_online(struct c
 		netif_carrier_on(card->dev);
 	else
 		netif_carrier_off(card->dev);
+
+	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
 		rtnl_lock();
 		if (recovery_mode)
@@ -2799,7 +2801,6 @@ static int __qeth_l3_set_online(struct c
 		else
 			dev_open(card->dev);
 		qeth_l3_set_rx_mode(card->dev);
-		qeth_recover_features(card->dev);
 		rtnl_unlock();
 	}
 	qeth_trace_features(card);


