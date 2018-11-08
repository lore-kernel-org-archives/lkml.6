Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA42C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8AB20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK3JpCqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8AB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeKIHhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbeKIHhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:15 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E537321019;
        Thu,  8 Nov 2018 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714387;
        bh=a7VBmdl0t6YNAiGGNbmSFTOkoTMhbrESBTkAyyCwvKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XK3JpCqdsBx7qFjLLykQGx+iEuLc3iutbo4i3JMQ52sCQMXxQ87dkvjUixNtZFo1y
         LeuCfc+Ia4HZOAJ7uam7DUPHcOj0zgSfU+Z74+o3IV1bRgQqbGJZVS/fRmleLGSZPu
         oGnEvQB8WaBl7ADL60NYH9cOM/ALRNksi4GWIfJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Babu Moger <babu.moger@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 048/114] sparc/pci: Refactor dev_archdata initialization into pci_init_dev_archdata
Date:   Thu,  8 Nov 2018 13:51:03 -0800
Message-Id: <20181108215105.510943466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



