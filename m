Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A822085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAWToL0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A822085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeJYWuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJYWuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:54 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1742085B;
        Thu, 25 Oct 2018 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477076;
        bh=e1bVWYncBIZezakR+r3Al7i8Ub1lCDlgclauFQaY6ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAWToL0higPXqlJMvN4TBd20DTTM8fuwikvHDxthNtOdrmFt44r40i+5WiDcyhYCW
         II2SQpk0t9LBlvHNt7KX4UUz3iP+O/t/ElMwU0ZJSFLZ1k1sU/y4/hnbNVt7ckvy2m
         jb8i9oHwwWibeELT8TNHXtRhPiVA53Y/CiWjhaWc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 30/65] sparc/pci: Refactor dev_archdata initialization into pci_init_dev_archdata
Date:   Thu, 25 Oct 2018 10:16:30 -0400
Message-Id: <20181025141705.213937-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit 9a78d4fc28904785ffe4c2d361e25b251b479704 ]

The function pcibios_add_device() added by commit d0c31e020057
("sparc/PCI: Fix for panic while enabling SR-IOV") initializes
the dev_archdata by doing a memcpy from the PF. This has the
problem that it erroneously copies the OF device without
explicitly refcounting it.

As David Miller pointed out: "Generally speaking we don't
really support hot-plug for OF probed devices, but if we did
all of the device tree pointers have to be refcounted properly."

To fix this error, and also avoid code duplication, this patch
creates a new helper function, pci_init_dev_archdata(), that
initializes the fields in dev_archdata, and can be invoked
by callers after they have taken the needed refcounts

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Tested-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9f9614df9e1e..c2b202d763a1 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -245,6 +245,18 @@ static void pci_parse_of_addrs(struct platform_device *op,
 	}
 }
 
+static void pci_init_dev_archdata(struct dev_archdata *sd, void *iommu,
+				  void *stc, void *host_controller,
+				  struct platform_device  *op,
+				  int numa_node)
+{
+	sd->iommu = iommu;
+	sd->stc = stc;
+	sd->host_controller = host_controller;
+	sd->op = op;
+	sd->numa_node = numa_node;
+}
+
 static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 					 struct device_node *node,
 					 struct pci_bus *bus, int devfn)
@@ -259,13 +271,10 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	if (!dev)
 		return NULL;
 
+	op = of_find_device_by_node(node);
 	sd = &dev->dev.archdata;
-	sd->iommu = pbm->iommu;
-	sd->stc = &pbm->stc;
-	sd->host_controller = pbm;
-	sd->op = op = of_find_device_by_node(node);
-	sd->numa_node = pbm->numa_node;
-
+	pci_init_dev_archdata(sd, pbm->iommu, &pbm->stc, pbm, op,
+			      pbm->numa_node);
 	sd = &op->dev.archdata;
 	sd->iommu = pbm->iommu;
 	sd->stc = &pbm->stc;
@@ -1003,9 +1012,13 @@ int pcibios_add_device(struct pci_dev *dev)
 	 * Copy dev_archdata from PF to VF
 	 */
 	if (dev->is_virtfn) {
+		struct dev_archdata *psd;
+
 		pdev = dev->physfn;
-		memcpy(&dev->dev.archdata, &pdev->dev.archdata,
-		       sizeof(struct dev_archdata));
+		psd = &pdev->dev.archdata;
+		pci_init_dev_archdata(&dev->dev.archdata, psd->iommu,
+				      psd->stc, psd->host_controller, NULL,
+				      psd->numa_node);
 	}
 	return 0;
 }
-- 
2.17.1

