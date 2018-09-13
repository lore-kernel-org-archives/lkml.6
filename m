Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCFD20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCFD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeIMSwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:52:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeIMSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:52:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFFB2D19;
        Thu, 13 Sep 2018 13:42:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 016/115] hv_netvsc: ignore devices that are not PCI
Date:   Thu, 13 Sep 2018 15:30:36 +0200
Message-Id: <20180913131824.514116209@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit b93c1b5ac8643cc08bb74fa8ae21d6c63dfcb23d ]

Registering another device with same MAC address (such as TAP, VPN or
DPDK KNI) will confuse the VF autobinding logic.  Restrict the search
to only run if the device is known to be a PCI attached VF.

Fixes: e8ff40d4bff1 ("hv_netvsc: improve VF device matching")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -29,6 +29,7 @@
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/pci.h>
 #include <linux/skbuff.h>
 #include <linux/if_vlan.h>
 #include <linux/in.h>
@@ -1895,11 +1896,15 @@ static int netvsc_register_vf(struct net
 {
 	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
+	struct device *pdev = vf_netdev->dev.parent;
 	struct netvsc_device *netvsc_dev;
 
 	if (vf_netdev->addr_len != ETH_ALEN)
 		return NOTIFY_DONE;
 
+	if (!pdev || !dev_is_pci(pdev) || dev_is_pf(pdev))
+		return NOTIFY_DONE;
+
 	/*
 	 * We will use the MAC address to locate the synthetic interface to
 	 * associate with the VF interface. If we don't find a matching


