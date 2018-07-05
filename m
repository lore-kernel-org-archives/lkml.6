Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27CA219E8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27CA219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeGEO4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:56:43 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:42856 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753353AbeGEO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:56:42 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3DE36386F9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 09:56:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id b5fvfMFhQRPojb5gIfwddQ; Thu, 05 Jul 2018 09:56:40 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=44328 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fb5fu-003fYA-NL; Thu, 05 Jul 2018 09:56:02 -0500
Date:   Thu, 5 Jul 2018 09:56:00 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: Mark expected switch fall-throughs
Message-ID: <20180705145600.GA22099@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fb5fu-003fYA-NL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:44328
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
 drivers/pci/hotplug/shpchp_ctrl.c | 2 ++
 drivers/pci/pci.c                 | 1 +
 drivers/pci/quirks.c              | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index c684faa..cfc46e8 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -436,6 +436,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -473,6 +474,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 1047b56..1267dcc 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -654,6 +654,7 @@ int shpchp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -689,6 +690,7 @@ int shpchp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..f5c6ab1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2045,6 +2045,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
 				break;
+			/* else: fall through */
 		default:
 			target_state = state;
 		}
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de8..502275c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2105,6 +2105,7 @@ static void quirk_netmos(struct pci_dev *dev)
 		if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 				dev->subsystem_device == 0x0299)
 			return;
+		/* else: fall through */
 	case PCI_DEVICE_ID_NETMOS_9735:
 	case PCI_DEVICE_ID_NETMOS_9745:
 	case PCI_DEVICE_ID_NETMOS_9845:
-- 
2.7.4

