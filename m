Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F99C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3D120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeIMTBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeIMTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 040FED10;
        Thu, 13 Sep 2018 13:52:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 032/197] nfp: wait for posted reconfigs when disabling the device
Date:   Thu, 13 Sep 2018 15:29:41 +0200
Message-Id: <20180913131842.847021013@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 9ad716b95fd6c6be46a4f2d5936e514b5bcd744d ]

To avoid leaking a running timer we need to wait for the
posted reconfigs after netdev is unregistered.  In common
case the process of deinitializing the device will perform
synchronous reconfigs which wait for posted requests, but
especially with VXLAN ports being actively added and removed
there can be a race condition leaving a timer running after
adapter structure is freed leading to a crash.

Add an explicit flush after deregistering and for a good
measure a warning to check if timer is running just before
structures are freed.

Fixes: 3d780b926a12 ("nfp: add async reconfiguration mechanism")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |   48 +++++++++++++-------
 1 file changed, 33 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -227,29 +227,16 @@ done:
 	spin_unlock_bh(&nn->reconfig_lock);
 }
 
-/**
- * nfp_net_reconfig() - Reconfigure the firmware
- * @nn:      NFP Net device to reconfigure
- * @update:  The value for the update field in the BAR config
- *
- * Write the update word to the BAR and ping the reconfig queue.  The
- * poll until the firmware has acknowledged the update by zeroing the
- * update word.
- *
- * Return: Negative errno on error, 0 on success
- */
-int nfp_net_reconfig(struct nfp_net *nn, u32 update)
+static void nfp_net_reconfig_sync_enter(struct nfp_net *nn)
 {
 	bool cancelled_timer = false;
 	u32 pre_posted_requests;
-	int ret;
 
 	spin_lock_bh(&nn->reconfig_lock);
 
 	nn->reconfig_sync_present = true;
 
 	if (nn->reconfig_timer_active) {
-		del_timer(&nn->reconfig_timer);
 		nn->reconfig_timer_active = false;
 		cancelled_timer = true;
 	}
@@ -258,14 +245,43 @@ int nfp_net_reconfig(struct nfp_net *nn,
 
 	spin_unlock_bh(&nn->reconfig_lock);
 
-	if (cancelled_timer)
+	if (cancelled_timer) {
+		del_timer_sync(&nn->reconfig_timer);
 		nfp_net_reconfig_wait(nn, nn->reconfig_timer.expires);
+	}
 
 	/* Run the posted reconfigs which were issued before we started */
 	if (pre_posted_requests) {
 		nfp_net_reconfig_start(nn, pre_posted_requests);
 		nfp_net_reconfig_wait(nn, jiffies + HZ * NFP_NET_POLL_TIMEOUT);
 	}
+}
+
+static void nfp_net_reconfig_wait_posted(struct nfp_net *nn)
+{
+	nfp_net_reconfig_sync_enter(nn);
+
+	spin_lock_bh(&nn->reconfig_lock);
+	nn->reconfig_sync_present = false;
+	spin_unlock_bh(&nn->reconfig_lock);
+}
+
+/**
+ * nfp_net_reconfig() - Reconfigure the firmware
+ * @nn:      NFP Net device to reconfigure
+ * @update:  The value for the update field in the BAR config
+ *
+ * Write the update word to the BAR and ping the reconfig queue.  The
+ * poll until the firmware has acknowledged the update by zeroing the
+ * update word.
+ *
+ * Return: Negative errno on error, 0 on success
+ */
+int nfp_net_reconfig(struct nfp_net *nn, u32 update)
+{
+	int ret;
+
+	nfp_net_reconfig_sync_enter(nn);
 
 	nfp_net_reconfig_start(nn, update);
 	ret = nfp_net_reconfig_wait(nn, jiffies + HZ * NFP_NET_POLL_TIMEOUT);
@@ -3609,6 +3625,7 @@ struct nfp_net *nfp_net_alloc(struct pci
  */
 void nfp_net_free(struct nfp_net *nn)
 {
+	WARN_ON(timer_pending(&nn->reconfig_timer) || nn->reconfig_posted);
 	if (nn->dp.netdev)
 		free_netdev(nn->dp.netdev);
 	else
@@ -3893,4 +3910,5 @@ void nfp_net_clean(struct nfp_net *nn)
 		return;
 
 	unregister_netdev(nn->dp.netdev);
+	nfp_net_reconfig_wait_posted(nn);
 }


