Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UIEIEv9AGVsYZgAAmS7hNA
	; Thu, 07 Jun 2018 14:28:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D541F6089E; Thu,  7 Jun 2018 14:28:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4B6B2602FC;
	Thu,  7 Jun 2018 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B6B2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeFGO2q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:28:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39417 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933064AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zn-G0; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00033I-DL; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.841046844@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 233/410] net: fix race on decreasing number of TX queues
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

commit ac5b70198adc25c73fba28de4f78adcee8f6be0b upstream.

netif_set_real_num_tx_queues() can be called when netdev is up.
That usually happens when user requests change of number of
channels/rings with ethtool -L.  The procedure for changing
the number of queues involves resetting the qdiscs and setting
dev->num_tx_queues to the new value.  When the new value is
lower than the old one, extra care has to be taken to ensure
ordering of accesses to the number of queues vs qdisc reset.

Currently the queues are reset before new dev->num_tx_queues
is assigned, leaving a window of time where packets can be
enqueued onto the queues going down, leading to a likely
crash in the drivers, since most drivers don't check if TX
skbs are assigned to an active queue.

Fixes: e6484930d7c7 ("net: allocate tx queues in register_netdevice")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2084,8 +2084,11 @@ EXPORT_SYMBOL(netif_set_xps_queue);
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
 
+	disabling = txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
 
@@ -2101,15 +2104,19 @@ int netif_set_real_num_tx_queues(struct
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
-		if (txq < dev->real_num_tx_queues) {
+		dev->real_num_tx_queues = txq;
+
+		if (disabling) {
+			synchronize_net();
 			qdisc_reset_all_tx_gt(dev, txq);
 #ifdef CONFIG_XPS
 			netif_reset_xps_queues_gt(dev, txq);
 #endif
 		}
+	} else {
+		dev->real_num_tx_queues = txq;
 	}
 
-	dev->real_num_tx_queues = txq;
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
