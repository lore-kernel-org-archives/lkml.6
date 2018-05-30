Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeE3LmZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751984AbeE3LG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:59 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Ursula Braun" <ubraun@linux.vnet.ibm.com>,
        "Julian Wiedmann" <jwi@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.422910969@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 141/153] s390/qeth: free netdevice when removing a card
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 drivers/s390/net/qeth_l2_main.c   | 2 +-
 drivers/s390/net/qeth_l3_main.c   | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4578,8 +4578,6 @@ static void qeth_core_free_card(struct q
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
@@ -897,8 +897,8 @@ static void qeth_l2_remove_device(struct
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
@@ -3395,8 +3395,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
