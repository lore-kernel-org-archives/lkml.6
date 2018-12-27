Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C8B218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pWzvAz30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeL0GOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:14:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeL0GOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:14:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6Dwqw077491;
        Thu, 27 Dec 2018 00:13:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545891238;
        bh=wc0qXJpbcR8cHhskuY/DuYtHtah2MMAK//SpwXb0iXY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pWzvAz30Fp1CdR7w4MzRd6o2QZT/lBw03ppyOUI8O7pQAejT64HlbSiTpdSye9fNK
         wIbC2cC7qSGIiFC3WX6/TnmiCe1j1yoEJEWh17eb+twoW91V7UutnciXRSQlH/0tvS
         HYJU/XjunDtDUPRNsVkPxb5nhaJWfIU3GVzB3MaY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6Dwxm108549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 00:13:58 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:13:57 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:13:57 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrE026064;
        Thu, 27 Dec 2018 00:13:54 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating single MSI for a device
Date:   Thu, 27 Dec 2018 11:43:08 +0530
Message-ID: <20181227061313.5451-8-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously all msi for a device are allocated in one go
by calling msi_domain_alloc_irq() from a bus layer. This might
not be the case when a device is trying to allocate interrupts
dynamically based on a request to it.

So introduce msi_domain_alloc/free_irq() apis to allocate a single
msi. prepare and activate operations to be handled by bus layer
calling msi_domain_alloc/free_irq() apis.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 784fb52b9900..474490826f8c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -301,8 +301,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
+int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
+			 struct msi_desc *desc,  msi_alloc_info_t *arg);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+void msi_domain_free_irq(struct msi_desc *desc);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ad26fbcfbfc8..eb7459324113 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
 }
 
+int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
+			 struct msi_desc *desc,  msi_alloc_info_t *arg)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+	int i, ret, virq;
+
+	ops->set_desc(arg, desc);
+
+	virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
+				       dev_to_node(dev), arg, false,
+				       desc->affinity);
+	if (virq < 0) {
+		ret = -ENOSPC;
+		if (ops->handle_error)
+			ret = ops->handle_error(domain, desc, ret);
+		if (ops->msi_finish)
+			ops->msi_finish(arg, ret);
+		return ret;
+	}
+
+	for (i = 0; i < desc->nvec_used; i++) {
+		irq_set_msi_desc_off(virq, i, desc);
+		irq_debugfs_copy_devname(virq + i, dev);
+	}
+
+	return 0;
+}
+
 /**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
@@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct irq_data *irq_data;
 	struct msi_desc *desc;
 	msi_alloc_info_t arg;
-	int i, ret, virq;
+	int ret, virq;
 	bool can_reserve;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
@@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		return ret;
 
 	for_each_msi_entry(desc, dev) {
-		ops->set_desc(&arg, desc);
-
-		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
-					       dev_to_node(dev), &arg, false,
-					       desc->affinity);
-		if (virq < 0) {
-			ret = -ENOSPC;
-			if (ops->handle_error)
-				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
+		ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
+		if (ret)
 			return ret;
-		}
-
-		for (i = 0; i < desc->nvec_used; i++) {
-			irq_set_msi_desc_off(virq, i, desc);
-			irq_debugfs_copy_devname(virq + i, dev);
-		}
 	}
 
 	if (ops->msi_finish)
@@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return ret;
 }
 
+void msi_domain_free_irq(struct msi_desc *desc)
+{
+	irq_domain_free_irqs(desc->irq, desc->nvec_used);
+	desc->irq = 0;
+}
+
 /**
  * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
  * @domain:	The domain to managing the interrupts
@@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		 * enough that there is no IRQ associated to this
 		 * entry. If that's the case, don't do anything.
 		 */
-		if (desc->irq) {
-			irq_domain_free_irqs(desc->irq, desc->nvec_used);
-			desc->irq = 0;
-		}
+		if (desc->irq)
+			msi_domain_free_irq(desc);
 	}
 }
 
-- 
2.19.2

