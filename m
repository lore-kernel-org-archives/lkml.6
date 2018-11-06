Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061BF2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061BF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbeKFSGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:06:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34736 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeKFSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:06:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68fvU7092030;
        Tue, 6 Nov 2018 02:41:57 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68fvtm096280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:41:57 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:41:56 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:41:56 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3r032677;
        Tue, 6 Nov 2018 02:41:53 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH v3 08/13] genirq/msi: Add support for allocating single MSI for a device
Date:   Tue, 6 Nov 2018 14:11:00 +0530
Message-ID: <20181106084105.32483-9-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously all MSIs for a device are allocated in one go
by calling msi_domain_alloc_irq() from a bus layer. This might
not be the case when a device is trying to allocate interrupts
dynamically based on a request to it.

So introduce msi_domain_alloc/free_irq() apis to allocate a single
msi. prepare and activate operations to be handled by bus layer
calling msi_domain_alloc/free_irq() apis.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- New patch

 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0e9c50052ff3..021f789226b5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -299,8 +299,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
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
index 4ca2fd46645d..e37238317fab 100644
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
2.19.1

