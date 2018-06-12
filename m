Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 713FFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4A220891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j9++/qjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4A220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934846AbeFLU7j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:59:39 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:65159 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934156AbeFLU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836998; x=1560372998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8yVx+fhxiJVPeOdXRafxKd/h88vCdvFuGApot6cY/oE=;
  b=j9++/qjPqAHK6+1RGHeIf16CIuH9GR2ELyYb+YsZLxUtIHGntDGbEkk+
   VKhYyaWXaZr3/RlShXHS4SRoI0Z0U7q66zYBl54HIhoP7xru8TVtCppdt
   dsQpsoseZHpbAOKLavyyNFt7JBbw9AF8NkxK9sKUXP7K1fTDEtEU+B4FH
   Q=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="745800150"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuYMg122817
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:34 GMT
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:33 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:33 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.60.129)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:32 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 07/12] xen-netfront: add callbacks for PM suspend and hibernation support
Date:   Tue, 12 Jun 2018 20:56:14 +0000
Message-ID: <20180612205619.28156-8-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Add freeze and restore callbacks for PM suspend and hibernation support.
The freeze handler simply disconnects the frotnend from the backend and
frees resources associated with queues after disabling the net_device
from the system. The restore handler just changes the frontend state and
let the xenbus handler to re-allocate the resources and re-connect to the
backend. This can be performed transparently to the rest of the system.
The handlers are used for both PM suspend and hibernation so that we can
keep the existing suspend/resume callbacks for Xen suspend without
modification. Freezing netfront devices is normally expected to finish within a few
hundred milliseconds, but it can rarely take more than 5 seconds and
hit the hard coded timeout, it would depend on backend state which may
be congested and/or have complex configuration. While it's rare case,
longer default timeout seems a bit more reasonable here to avoid hitting
the timeout. Also, make it configurable via module parameter so that we
can cover broader setups than what we know currently.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
---
 drivers/net/xen-netfront.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 4dd0668..4ea9284 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -43,6 +43,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/completion.h>
 #include <net/ip.h>
 
 #include <xen/xen.h>
@@ -56,6 +57,12 @@
 #include <xen/interface/memory.h>
 #include <xen/interface/grant_table.h>
 
+enum netif_freeze_state {
+	NETIF_FREEZE_STATE_UNFROZEN,
+	NETIF_FREEZE_STATE_FREEZING,
+	NETIF_FREEZE_STATE_FROZEN,
+};
+
 /* Module parameters */
 #define MAX_QUEUES_DEFAULT 8
 static unsigned int xennet_max_queues;
@@ -63,6 +70,12 @@ module_param_named(max_queues, xennet_max_queues, uint, 0644);
 MODULE_PARM_DESC(max_queues,
 		 "Maximum number of queues per virtual interface");
 
+static unsigned int netfront_freeze_timeout_secs = 10;
+module_param_named(freeze_timeout_secs,
+		   netfront_freeze_timeout_secs, uint, 0644);
+MODULE_PARM_DESC(freeze_timeout_secs,
+		 "timeout when freezing netfront device in seconds");
+
 static const struct ethtool_ops xennet_ethtool_ops;
 
 struct netfront_cb {
@@ -160,6 +173,10 @@ struct netfront_info {
 	struct netfront_stats __percpu *tx_stats;
 
 	atomic_t rx_gso_checksum_fixup;
+
+	int freeze_state;
+
+	struct completion wait_backend_disconnected;
 };
 
 struct netfront_rx_info {
@@ -723,6 +740,21 @@ static int xennet_close(struct net_device *dev)
 	return 0;
 }
 
+static int xennet_disable_interrupts(struct net_device *dev)
+{
+	struct netfront_info *np = netdev_priv(dev);
+	unsigned int num_queues = dev->real_num_tx_queues;
+	unsigned int i;
+	struct netfront_queue *queue;
+
+	for (i = 0; i < num_queues; ++i) {
+		queue = &np->queues[i];
+		disable_irq(queue->tx_irq);
+		disable_irq(queue->rx_irq);
+	}
+	return 0;
+}
+
 static void xennet_move_rx_slot(struct netfront_queue *queue, struct sk_buff *skb,
 				grant_ref_t ref)
 {
@@ -1296,6 +1328,8 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 
 	np->queues = NULL;
 
+	init_completion(&np->wait_backend_disconnected);
+
 	err = -ENOMEM;
 	np->rx_stats = netdev_alloc_pcpu_stats(struct netfront_stats);
 	if (np->rx_stats == NULL)
@@ -1782,6 +1816,50 @@ static int xennet_create_queues(struct netfront_info *info,
 	return 0;
 }
 
+static int netfront_freeze(struct xenbus_device *dev)
+{
+	struct netfront_info *info = dev_get_drvdata(&dev->dev);
+	unsigned long timeout = netfront_freeze_timeout_secs * HZ;
+	int err = 0;
+
+	xennet_disable_interrupts(info->netdev);
+
+	netif_device_detach(info->netdev);
+
+	info->freeze_state = NETIF_FREEZE_STATE_FREEZING;
+
+	/* Kick the backend to disconnect */
+	xenbus_switch_state(dev, XenbusStateClosing);
+
+	/* We don't want to move forward before the frontend is diconnected
+	 * from the backend cleanly.
+	 */
+	timeout = wait_for_completion_timeout(&info->wait_backend_disconnected,
+					      timeout);
+	if (!timeout) {
+		err = -EBUSY;
+		xenbus_dev_error(dev, err, "Freezing timed out;"
+				 "the device may become inconsistent state");
+		return err;
+	}
+
+	/* Tear down queues */
+	xennet_disconnect_backend(info);
+	xennet_destroy_queues(info);
+
+	info->freeze_state = NETIF_FREEZE_STATE_FROZEN;
+
+	return err;
+}
+
+static int netfront_restore(struct xenbus_device *dev)
+{
+	/* Kick the backend to re-connect */
+	xenbus_switch_state(dev, XenbusStateInitialising);
+
+	return 0;
+}
+
 /* Common code used when first setting up, and when resuming. */
 static int talk_to_netback(struct xenbus_device *dev,
 			   struct netfront_info *info)
@@ -1986,6 +2064,8 @@ static int xennet_connect(struct net_device *dev)
 		spin_unlock_bh(&queue->rx_lock);
 	}
 
+	np->freeze_state = NETIF_FREEZE_STATE_UNFROZEN;
+
 	return 0;
 }
 
@@ -2025,11 +2105,23 @@ static void netback_changed(struct xenbus_device *dev,
 
 	case XenbusStateClosed:
 		wake_up_all(&module_unload_q);
-		if (dev->state == XenbusStateClosed)
+		if (dev->state == XenbusStateClosed) {
+			/* dpm context is waiting for the backend */
+			if (np->freeze_state == NETIF_FREEZE_STATE_FREEZING)
+				complete(&np->wait_backend_disconnected);
 			break;
+		}
 		/* Missed the backend's CLOSING state -- fallthrough */
 	case XenbusStateClosing:
 		wake_up_all(&module_unload_q);
+		/* We may see unexpected Closed or Closing from the backend.
+		 * Just ignore it not to prevent the frontend from being
+		 * re-connected in the case of PM suspend or hibernation.
+		 */
+		if (np->freeze_state == NETIF_FREEZE_STATE_FROZEN &&
+		    dev->state == XenbusStateInitialising) {
+			break;
+		}
 		xenbus_frontend_closed(dev);
 		break;
 	}
@@ -2176,6 +2268,9 @@ static struct xenbus_driver netfront_driver = {
 	.probe = netfront_probe,
 	.remove = xennet_remove,
 	.resume = netfront_resume,
+	.freeze = netfront_freeze,
+	.thaw	= netfront_restore,
+	.restore = netfront_restore,
 	.otherend_changed = netback_changed,
 };
 
-- 
2.7.4

