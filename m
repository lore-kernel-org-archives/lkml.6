Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A74C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF21215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsyZVfzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF21215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHRTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43223 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHRTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id j21-v6so6099045edp.10;
        Sat, 18 Aug 2018 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7Ii+1aA/6JZymqo3d+Pz9bBuI5kUlICfu7rmoEnHD8=;
        b=RsyZVfzb4znRlM3ipGOXHA8k9oOISmFuLyc/T0KrkJ6tfgemnm/+ufEQSyPhYAcU6+
         3sgTB6lxIHFwtrc03XpgzmY7BdKQK24cVfGwoTEIGfmYygSqzByTkxxjjWrubICZnaMp
         HmvM5VQgWRrVolc63jZHBr5+0akqtMNUCae0axXhZ1qbVcOUan8X7PjRqd/x7DRIkNZN
         xdCm8cpWlhH6gRDbv0PzkOZKoBXePnHNs3JeeSjhHOVHzSMZi+SRvQa9SyZzCDiMqkCg
         RLMkkydT6fDD/0gnj+T6EhUSp/Db66LwoNSOZc8d1lkjnmN2V4PLmaObjPgF3thGqJQe
         2T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7Ii+1aA/6JZymqo3d+Pz9bBuI5kUlICfu7rmoEnHD8=;
        b=MpJtW7pm5roLQ5J0wDyiAODlQz2jO69K8m09ZkywHf+SqqqWTCuhMBA54vbj7MOuIA
         BkEZ0B9RGH8ln6Y5rqCb4Q34NjU3rJXJE4TaDOGwERLWL526KCOd1AGwZNKWSb+snN88
         LM4jAcPaRRvGblVPg3IfdODqRHwE5/Qp1M776YSBD3S+xFnq8q/QdQQpKWzGFmvOg5qK
         Q792HNgZjntgDqEmn7ShsoyJxZo9hsyQVqjMoNqt59CdhMKKjMnDxxxR7NLnJw7RNM1f
         e0QmyEZmqhaasbECLahJRfsCvL6+CU1TfygxpkXtm8BNpvVpXId33GagaocE3riCUZ+8
         alrA==
X-Gm-Message-State: AOUpUlHhIuCjO2lntzjurKVSM0x7abwbyLjgMtC+9EOGbT3m4iIvMvf7
        dlYTmoqt7BawtK6jPTB1b+s=
X-Google-Smtp-Source: AA+uWPyJNDxMD6kqdZJ9xSvXfjfw9CU3nrpHz2G/dve95v7Iwg13amUPKEqPNk48ff72jMJW/thruQ==
X-Received: by 2002:a50:b53a:: with SMTP id y55-v6mr2536618edd.191.1534607756760;
        Sat, 18 Aug 2018 08:55:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/19] iommu/tegra: gart: Prepend error/debug messages with "GART:"
Date:   Sat, 18 Aug 2018 18:54:27 +0300
Message-Id: <20180818155430.5586-17-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "GART:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index d019ae8ecfc9..284cddf90888 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -96,7 +96,7 @@ static inline void gart_set_pte(struct gart_device *gart,
 	writel(offs, gart->regs + GART_ENTRY_ADDR);
 	writel(pte, gart->regs + GART_ENTRY_DATA);
 
-	dev_dbg(gart->dev, "%s %08lx:%08x\n",
+	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
 		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
 }
 
@@ -134,7 +134,7 @@ static void gart_dump_table(struct gart_device *gart)
 
 		pte = gart_read_pte(gart, iova);
 
-		dev_dbg(gart->dev, "%s %08lx:%08lx\n",
+		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
 			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
 			iova, pte & GART_PAGE_MASK);
 	}
@@ -179,21 +179,22 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	spin_lock(&gart->client_lock);
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
+			dev_err(gart->dev, "GART: %s is already attached\n",
+				dev_name(dev));
 			err = -EINVAL;
 			goto fail;
 		}
 	}
 	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev, "Only one domain can be active at a time\n");
+		dev_err(gart->dev,
+			"GART: Only one domain can be active at a time\n");
 		err = -EINVAL;
 		goto fail;
 	}
 	gart->active_domain = domain;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
+	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
 	return 0;
 
 fail:
@@ -215,12 +216,14 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
+			dev_dbg(gart->dev, "GART: Detached %s\n",
+				dev_name(dev));
 			return;
 		}
 	}
 
-	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
+		dev_name(dev));
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
@@ -293,7 +296,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
+		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
@@ -301,7 +304,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pte = gart_read_pte(gart, iova);
 		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
 			spin_unlock_irqrestore(&gart->pte_lock, flags);
-			dev_err(gart->dev, "Page entry is in-use\n");
+			dev_err(gart->dev, "GART: Page entry is in-use\n");
 			return -EBUSY;
 		}
 	}
@@ -344,7 +347,7 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = (pte & GART_PAGE_MASK);
 	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08llx:%pa\n",
+		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
 			 (unsigned long long)iova, &pa);
 		gart_dump_table(gart);
 		return -EINVAL;
@@ -455,19 +458,17 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	res_remap = platform_get_resource(to_platform_device(dev),
 					  IORESOURCE_MEM, 1);
 	if (!res_remap) {
-		dev_err(dev, "GART memory aperture expected\n");
+		dev_err(dev, "GART: Memory aperture resource unavailable\n");
 		return ERR_PTR(-ENXIO);
 	}
 
 	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
-	if (!gart) {
-		dev_err(dev, "failed to allocate gart_device\n");
+	if (!gart)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU in sysfs\n");
+		dev_err(dev, "GART: Failed to register IOMMU sysfs\n");
 		goto free_gart;
 	}
 
@@ -476,7 +477,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-		dev_err(dev, "Failed to register IOMMU\n");
+		dev_err(dev, "GART: Failed to register IOMMU\n");
 		goto remove_sysfs;
 	}
 
@@ -491,7 +492,6 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
-		dev_err(dev, "failed to allocate context save area\n");
 		ret = -ENOMEM;
 		goto unregister_iommu;
 	}
-- 
2.18.0

