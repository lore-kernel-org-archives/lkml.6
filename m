Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5CC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8408206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8408206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJMEap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:30:45 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:51402
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725743AbeJMEap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:30:45 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id B4T0gPGYLwkZtB4T0gO6oq; Fri, 12 Oct 2018 13:55:26 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gB4T0-00065N-7G; Fri, 12 Oct 2018 13:55:26 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2] hv_netvsc: fix vf serial matching with pci slot info
Date:   Fri, 12 Oct 2018 20:55:15 +0000
Message-Id: <20181012205515.23355-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfKEzHapas58IyylVXkAXOeOYnXFsWfI5FveW+kReS9CZHMx4wSz+haycsIPtav0PIr3NDIcgoqFv7Ub+o7Gya+Nso4BrgriMj1fiZHYDTC+oRdTwFLt6
 Tu3LtPE7TKjh2d4eO8IzCp2kviFjv6QR9160/AfGVXGootvqPTDk668e1s7h9mWdY5gfAfs4OXW+YHjzXRIsMELWOdQ45XRzC+1LUv/heZyO3pOTnw/peWJD
 OpiqZOShG/rJdnD0zXLzDbO+uPLncmw0a+zDqdcR8+7PtP7OTI7X1Qqb0oJHrSNYE+WN3WCkfaRRdwEuBNUUlHjjG/rJSbjudcK3v0yR0Tt95QE+zbyvLYy5
 KVshvCvrfocEONtAihG9pNgNFwqzUoVxR0buFQ/jFsphtgQXkR/8vPxBdJkRq5T569nZUUY4JmD3Tp7X/Lo2RM4axWD+QAI0VcRU0ulXsrhqGpYQ2HEdzitc
 XLJaYKAHbnL7P8xRhabPxuq4Owti1HfMsjVNbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The VF device's serial number is saved as a string in PCI slot's
kobj name, not the slot->number. This patch corrects the netvsc
driver, so the VF device can be successfully paired with synthetic
NIC.

Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9bcaf204a7d4..ded623862003 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2030,14 +2030,15 @@ static void netvsc_vf_setup(struct work_struct *w)
 	rtnl_unlock();
 }
 
-/* Find netvsc by VMBus serial number.
- * The PCI hyperv controller records the serial number as the slot.
+/* Find netvsc by VF serial number.
+ * The PCI hyperv controller records the serial number as the slot kobj name.
  */
 static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 {
 	struct device *parent = vf_netdev->dev.parent;
 	struct net_device_context *ndev_ctx;
 	struct pci_dev *pdev;
+	u32 serial;
 
 	if (!parent || !dev_is_pci(parent))
 		return NULL; /* not a PCI device */
@@ -2048,16 +2049,22 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 		return NULL;
 	}
 
+	if (kstrtou32(kobject_name(&pdev->slot->kobj), 10, &serial)) {
+		netdev_notice(vf_netdev, "Invalid vf serial:%s\n",
+			      pdev->slot->kobj.name);
+		return NULL;
+	}
+
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		if (!ndev_ctx->vf_alloc)
 			continue;
 
-		if (ndev_ctx->vf_serial == pdev->slot->number)
+		if (ndev_ctx->vf_serial == serial)
 			return hv_get_drvdata(ndev_ctx->device_ctx);
 	}
 
 	netdev_notice(vf_netdev,
-		      "no netdev found for slot %u\n", pdev->slot->number);
+		      "no netdev found for vf serial:%u\n", serial);
 	return NULL;
 }
 
-- 
2.18.0

