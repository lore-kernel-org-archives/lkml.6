Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 021wLh1JGVsTTgAAmS7hNA
	; Thu, 07 Jun 2018 15:04:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B540608B8; Thu,  7 Jun 2018 15:04:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96848601C3;
	Thu,  7 Jun 2018 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96848601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936050AbeFGPEL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:04:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41566 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936025AbeFGPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:04:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005hO-7g; Thu, 07 Jun 2018 15:09:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003II-ST; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Ursula Braun" <ubraun@linux.vnet.ibm.com>,
        "Julian Wiedmann" <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.331967330@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 390/410] s390/qeth: free netdevice when removing a card
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

commit 6be687395b3124f002a653c1a50b3260222b3cd7 upstream.

On removal, a qeth card's netdevice is currently not properly freed
because the call chain looks as follows:

qeth_core_remove_device(card)
	lx_remove_device(card)
		unregister_netdev(card->dev)
		card->dev = NULL			!!!
	qeth_core_free_card(card)
		if (card->dev)				!!!
			free_netdev(card->dev)

Fix it by free'ing the netdev straight after unregistering. This also
fixes the sysfs-driven layer switch case (qeth_dev_layer2_store()),
where the need to free the current netdevice was not considered at all.

Note that free_netdev() takes care of the netif_napi_del() for us too.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 drivers/s390/net/qeth_l2_main.c   | 2 +-
 drivers/s390/net/qeth_l3_main.c   | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4857,8 +4857,6 @@ static void qeth_core_free_card(struct q
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
-	if (card->dev)
-		free_netdev(card->dev);
 	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -922,8 +922,8 @@ static void qeth_l2_remove_device(struct
 		qeth_l2_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 	return;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3340,8 +3340,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
