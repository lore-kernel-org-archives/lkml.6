Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F05C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932F321476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2JKH0tGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932F321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeJQBGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A60C2089E;
        Tue, 16 Oct 2018 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710096;
        bh=moQYg2qVn14bWam7GWXu497IpuRk2h23vEFweTOI3uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JKH0tGt+qSHADp8aZwVqNahI0+5LjdvivbH4jbZTklIn+aafPBvJPKB9xfx+JvRb
         Yiz14XFMgvRCeLrN5fE1hWSicyiujhiMrQMzWDKrO8+THGgxOWotZumViVsOv1HiTg
         INEaAdbSkvzogQC5gPzc0XbUF5rmcXcb6psO63c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Date:   Tue, 16 Oct 2018 19:05:31 +0200
Message-Id: <20181016170522.303317746@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 00d7ddba1143623b31bc2c15d18216e2da031b14 ]

Matching network device based on MAC address is problematic
since a non VF network device can be creted with a duplicate MAC
address causing confusion and problems.  The VMBus API does provide
a serial number that is a better matching method.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c     |    3 ++
 drivers/net/hyperv/netvsc_drv.c |   58 ++++++++++++++++++++++------------------
 2 files changed, 36 insertions(+), 25 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1203,6 +1203,9 @@ static void netvsc_send_vf(struct net_de
 
 	net_device_ctx->vf_alloc = nvmsg->msg.v4_msg.vf_assoc.allocated;
 	net_device_ctx->vf_serial = nvmsg->msg.v4_msg.vf_assoc.serial;
+	netdev_info(ndev, "VF slot %u %s\n",
+		    net_device_ctx->vf_serial,
+		    net_device_ctx->vf_alloc ? "added" : "removed");
 }
 
 static  void netvsc_receive_inband(struct net_device *ndev,
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1794,20 +1794,6 @@ out_unlock:
 	rtnl_unlock();
 }
 
-static struct net_device *get_netvsc_bymac(const u8 *mac)
-{
-	struct net_device_context *ndev_ctx;
-
-	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
-		struct net_device *dev = hv_get_drvdata(ndev_ctx->device_ctx);
-
-		if (ether_addr_equal(mac, dev->perm_addr))
-			return dev;
-	}
-
-	return NULL;
-}
-
 static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -1936,26 +1922,48 @@ static void netvsc_vf_setup(struct work_
 	rtnl_unlock();
 }
 
+/* Find netvsc by VMBus serial number.
+ * The PCI hyperv controller records the serial number as the slot.
+ */
+static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
+{
+	struct device *parent = vf_netdev->dev.parent;
+	struct net_device_context *ndev_ctx;
+	struct pci_dev *pdev;
+
+	if (!parent || !dev_is_pci(parent))
+		return NULL; /* not a PCI device */
+
+	pdev = to_pci_dev(parent);
+	if (!pdev->slot) {
+		netdev_notice(vf_netdev, "no PCI slot information\n");
+		return NULL;
+	}
+
+	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
+		if (!ndev_ctx->vf_alloc)
+			continue;
+
+		if (ndev_ctx->vf_serial == pdev->slot->number)
+			return hv_get_drvdata(ndev_ctx->device_ctx);
+	}
+
+	netdev_notice(vf_netdev,
+		      "no netdev found for slot %u\n", pdev->slot->number);
+	return NULL;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
-	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
-	struct device *pdev = vf_netdev->dev.parent;
 	struct netvsc_device *netvsc_dev;
+	struct net_device *ndev;
 	int ret;
 
 	if (vf_netdev->addr_len != ETH_ALEN)
 		return NOTIFY_DONE;
 
-	if (!pdev || !dev_is_pci(pdev) || dev_is_pf(pdev))
-		return NOTIFY_DONE;
-
-	/*
-	 * We will use the MAC address to locate the synthetic interface to
-	 * associate with the VF interface. If we don't find a matching
-	 * synthetic interface, move on.
-	 */
-	ndev = get_netvsc_bymac(vf_netdev->perm_addr);
+	ndev = get_netvsc_byslot(vf_netdev);
 	if (!ndev)
 		return NOTIFY_DONE;
 


