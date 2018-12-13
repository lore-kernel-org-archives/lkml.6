Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBDC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215F420811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J/OCYF6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeLMKdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52701 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeLMKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:33:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so1790140wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VpODZE1tUA9HmJlRXYvptIoWG22EEkLSR0YtOLzzTLM=;
        b=J/OCYF6vgCN7SMrZnnEePHIFZhL0QFA2U6/pLuP0XZ1QxXs+GgZaLFIwEq1epSC9Nn
         JRftF8vqrr3sb7ifX8asb1JQD30xpZnj+VzteNpIpclNWVdk70KHHI+bSM0VdiBZVsSZ
         TznM+61fQ6EE75+VVzScpZB2zdq0ZrIzyc+Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VpODZE1tUA9HmJlRXYvptIoWG22EEkLSR0YtOLzzTLM=;
        b=qHMQJ08oWJFXZ3pjjr4NNX8Ip2xRVk3DFSvCyGQtZKE2c4RhVep4vPMxHWc69RPZMX
         7ZnSbdF/paqCSi/GFZWxoxVHOrWuayG6BbkdIpeQYr6iNVCM0tFAKiEtYpYBWr8MipsI
         XIZWd6l8X3I3LP41aAaJMCYSFb3XPcz8BqUlY0bud9oHiDVv/y+BfeENVDYiOKzwhZT0
         v8NiPpu5z+HZ432rZx/riiuSpBhlhiMgK0whNUfaaU2lZthWC9U1FZnBGMV5Ux0gXdzL
         Xc9r+PQzB9kQzPzaqer8Hvf9S87ia1qwxxROBXHmvKvnFw2FFNyjI5D9iBxpvRSxoP9B
         3s+Q==
X-Gm-Message-State: AA+aEWbspmVJfCwkmZT9A4iq76WsNs6zwAder7kdF5eo1mnIrZWVnkyQ
        NFBNdTK2aGqq2VW2+J9NjeSTbw==
X-Google-Smtp-Source: AFSGD/V0z4dI+qRJQ7R68nGjRRHT8k8XwDlkcbdxqMxmBtMJ/kbvttRTLDdz0lvkc8vFn8ItpA8Bqg==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr10382746wmf.144.1544697200546;
        Thu, 13 Dec 2018 02:33:20 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x76sm3327058wmd.27.2018.12.13.02.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 02:33:20 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 1/3] PCI: Add dma-resv window list
Date:   Thu, 13 Dec 2018 16:02:52 +0530
Message-Id: <1544697174-6029-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dma_resv parameter in pci host bridge structure to hold resource
entries list of memory regions for which IOVAs have to reserve.

PCIe host driver will add resource entries to this list based on its
requirements.
Few inbound address ranges can't be allowed by few PCIe host, so those
address ranges will be add to this list to avoid IOMMU mapping.

While initializing IOMMU domain of PCI EPs connected to that host bridge
IOVAs for this given list of address ranges will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec78400..bbed0e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_resv);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8d..1f0a32a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -472,6 +472,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_resv;	/* reserv dma ranges */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

