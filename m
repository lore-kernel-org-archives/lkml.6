Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDDC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C035620659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C035620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJLDob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:44:31 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:44306
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbeJLDob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:44:31 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id AhM0g45NFsezkAhM0gxxcV; Thu, 11 Oct 2018 13:14:40 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gAhM0-00080Q-1t; Thu, 11 Oct 2018 13:14:40 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot info
Date:   Thu, 11 Oct 2018 20:14:34 +0000
Message-Id: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfFnwcjx6JFlEEGuMjOb8+BMOllCBiVUDJ76oQpckmkFPobcQEvqf/j1gCSZQPL9ctku/X2EGGzgRzdY4Z8X4+JSPPlHVwBguoy7qTBOcR2yYdTyOGEha
 b31mMgpH75Bwa61h9BeKkyc6qu6VmRey3gfwcmxpq6CU89YQ0SUw0VMxkGkWLyUMYnFtSEzrWeyj7kFyqA4HTfAMuCkjuxMYnvJshSiZcpHjlpD0KlNHd1yX
 rAE97mj/35JYPkR95sP/Bp5GWBUHVGKVUW4OXcSmgWELuH8XBkicrNtAvNSI81EtoEdSuDY3UmF91kqnN6AiAHzxnpujF+m8qjbXsGTT58W1ZgW3jFz7X+tF
 lOFPHA3EQCIivGAVJNXnFUdO+WV0HzO6WXhgTBpYvmhI9u2gWLP2nJL5vPVyfHIXZMfgyIe9QgntXsE4KGamKXBkyXHHMhl3oBnAU0qiHUZ+3htjBnsKqpdw
 EQrJn19+zI4o++GvotcWSVij7WlRy+DOyu+T7A==
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
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9bcaf204a7d4..8121ce34a39f 100644
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
 
+	if (kstrtou32(pdev->slot->kobj.name, 10, &serial)) {
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

