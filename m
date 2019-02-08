Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1421924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663592;
	bh=8tDVX17sRWin87vNxwlD55rXBkN0csn6rNuDjvlpSVk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=TraVJOc8BUNLk2ToPCtYHChPNvYfzMPbrfmnNwzUkJVq/1a4j1pCJm38xSYLRKzxC
	 G9hXAdtBRNYTWx+NmFv9jW6+exYjErtzY9xZ4X+Xjviysvym6SMu8lncoH+Q09xqQS
	 PF3l15MprL82KQUGWE0F8pLnZOdXJ0QD8SpasfV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBHWGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfBHWGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:06:30 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D6821908;
        Fri,  8 Feb 2019 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663590;
        bh=8tDVX17sRWin87vNxwlD55rXBkN0csn6rNuDjvlpSVk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qsXrSu/OEbVX5GEjmN9dSod+irSrwiHMWkZ6FsQwS3oAHcSDebCB/FvPPzNTawwPh
         JVgYxZ7VYYhkOQs15/fHAYnsGfcGQRDdmjoywLj+VshvZqSyH/kXRNh5O59L9N7kd7
         /OiM+cqgGgLY6zSgMsbQ+PHzMc7V+soMRl6HqkIU=
Subject: [PATCH v1 7/7] iommu/vt-d: Simplify control flow
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:06:28 -0600
Message-ID: <154966358874.132359.3411695261972962024.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify control flow by returning immediately when we know the result.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b0860a8c48d4..6eaa4ada6e1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -509,12 +509,12 @@ static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
-	void *vaddr = NULL;
 
 	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
+	if (!page)
+		return NULL;
+
+	return page_address(page);
 }
 
 void free_pgtable_page(void *vaddr)
@@ -2606,20 +2606,19 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 
 		/* DMA alias already has a domain, use it */
 		if (info)
-			goto out;
+			return domain;
 	}
 
 	/* Allocate and initialize new domain for the device */
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
+
 	if (domain_init(domain, iommu, gaw)) {
 		domain_exit(domain);
 		return NULL;
 	}
 
-out:
-
 	return domain;
 }
 
@@ -2665,11 +2664,11 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 
 	domain = find_domain(dev);
 	if (domain)
-		goto out;
+		return domain;
 
 	domain = find_or_alloc_domain(dev, gaw);
 	if (!domain)
-		goto out;
+		return NULL;
 
 	tmp = set_domain_for_dev(dev, domain);
 	if (!tmp || domain != tmp) {
@@ -2677,8 +2676,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		domain = tmp;
 	}
 
-out:
-
 	return domain;
 }
 
@@ -3558,11 +3555,13 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 
 	domain = find_domain(dev);
 	if (domain)
-		goto out;
+		return domain;
 
 	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		goto out;
+	if (!domain) {
+		dev_err(dev, "Allocating domain failed\n");
+		return NULL;
+	}
 
 	/* We have a new domain - setup possible RMRRs for the device */
 	rcu_read_lock();
@@ -3587,12 +3586,8 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 		domain = tmp;
 	}
 
-out:
-
 	if (!domain)
 		dev_err(dev, "Allocating domain failed\n");
-
-
 	return domain;
 }
 

