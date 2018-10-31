Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EE12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyMuJUC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EE12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKAIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeKAIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D332520821;
        Wed, 31 Oct 2018 23:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027151;
        bh=uiIlivfjhieJ8WKAcPSmgEjxtZvoDTvb5mWZlOpjfH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyMuJUC/H3LW7IpQx+/fFTW0MxUip56LZSgYUxf1CvyQqgjN6yG3BVplPPHc0yhqA
         QmfFmAbIcI0yPVquvWUdQVZkc0LFXFMNZD6Uw3ao/sRaF3UQdQ9UOdv8X0IZNwIIXq
         NAoCNJ78KLPQu9OZwX9ubMdMnU1iH41PdzPqVivw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 009/146] hv_netvsc: fix vf serial matching with pci slot info
Date:   Wed, 31 Oct 2018 19:03:24 -0400
Message-Id: <20181031230541.28822-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 005479556197f80139771960dda0dfdcd2d2aad5 ]

The VF device's serial number is saved as a string in PCI slot's
kobj name, not the slot->number. This patch corrects the netvsc
driver, so the VF device can be successfully paired with synthetic
NIC.

Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3af6d8d15233..1c37a821895b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2022,14 +2022,15 @@ static void netvsc_vf_setup(struct work_struct *w)
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
@@ -2040,16 +2041,22 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
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
2.17.1

