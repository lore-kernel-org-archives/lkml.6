Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeJPCx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:53:58 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:60302
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbeJPCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:53:58 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id C8C7gCss9wkZtC8C7g25D5; Mon, 15 Oct 2018 12:06:24 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gC8C7-0007yf-NO; Mon, 15 Oct 2018 12:06:23 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v3] hv_netvsc: fix vf serial matching with pci slot info
Date:   Mon, 15 Oct 2018 19:06:15 +0000
Message-Id: <20181015190615.30628-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfIVdSSeCnp+/h3mrNYRpq7qOQN0bz2f1R5JENVGGNEjfq+YnZ1LalclIw9cxA6TBpbkyOTAjFk4G+iwRg4l3ia7IfvIaUoguxqFIqF//fgkldrrxJJOg
 mIAfwSGPV4UXzOg6OrC5x+QKFb/LBzLLTFbIFS4jHSZPyaQ/AFyijMx/6DuSA5n4B4dhg70GF5y4lpD2hDqOOyGPgK2FJF7b9LgC071iVedX5l7U1KbxL+Lm
 AreuxZheOsbyUMy+QL89hWcfdub73tC0BRtZ7hMIBljlNlAaR57dWQUSaZXFPtU/kBZhjaaV5vt9vAfholnRLHHicBC3prw9o1iYqJlV9kkVgAiPRyHX9H8B
 bqASbzuK79egWslL7DRW5/2Xh1vyttblTTbXXKbqliXqOIx1Bi00h/JJlsfUz8s1piO7cKpD9bMsco1pLWU7YCm7eemDvTWDeeyujZoJx6+SW4PajbQ2radA
 ogY9E4r6V6uGvfbNDaaj7zokCL/lUY/k5n+iag==
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
index 9bcaf204a7d4..cf36e7ff3191 100644
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
 
+	if (kstrtou32(pci_slot_name(pdev->slot), 10, &serial)) {
+		netdev_notice(vf_netdev, "Invalid vf serial:%s\n",
+			      pci_slot_name(pdev->slot));
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

