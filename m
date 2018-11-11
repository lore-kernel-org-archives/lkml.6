Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACBC04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FEB223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0DQDGsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FEB223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeKLIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbeKLIRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D4F216FD;
        Sun, 11 Nov 2018 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975230;
        bh=5hnr1Rmyob4ry1WzG0VAzPyEh/SadHV+wnJ4Kd6zz9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0DQDGsPenBogtYgi08NWxudEVVBd1GtJD1fUXXtfQGZjOkXnqecwMituCrultY3m
         8RdA55b0DJAUS4zbuS7J5KNfXGNqssNROX5lgsfojko9Nwpo6TO3ycFmnHo1AMWaR1
         hFJS/MYDksVAAKXXPj+YRbsddXze3G1rH1huIlxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/361] hv_netvsc: fix vf serial matching with pci slot info
Date:   Sun, 11 Nov 2018 14:16:42 -0800
Message-Id: <20181111221627.767521037@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2022,14 +2022,15 @@ static void netvsc_vf_setup(struct work_
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
@@ -2040,16 +2041,22 @@ static struct net_device *get_netvsc_bys
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
 


