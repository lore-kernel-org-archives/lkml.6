Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45530C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146F2214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S5zyFKbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeL0GPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:15:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbeL0GOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:14:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6E2Ud077503;
        Thu, 27 Dec 2018 00:14:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545891242;
        bh=KotTqQfhijDOPactJyxRFTQKuKTL+hLoGVA66ru3C0w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S5zyFKbvAdiWjuxDAOr4DgG2JkQdmzp8CPL3wLYwNxJcGkCvUoHxs3fBi1u6j4LJ2
         wnBjNXxKp4hJqpN0+1K25CDgg2fub0OOLxbvdHiayHM05nV3QlsrQY/2KBmSnY3QFz
         haI23X0S9jmbhrD0l9etkSWsaRYQG10ll6U4ErHM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6E2SH060161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Dec 2018 00:14:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:14:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:14:01 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrF026064;
        Thu, 27 Dec 2018 00:13:58 -0600
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
Subject: [RFC PATCH v4 09/13] genirq/msi: Add support for .msi_unprepare callback
Date:   Thu, 27 Dec 2018 11:43:09 +0530
Message-ID: <20181227061313.5451-9-lokeshvutla@ti.com>
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

Add an optional callback .msi_unprepare to struct msi_domain_ops.
This is used to clear any effect that is done by .msi_prepare callback.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 474490826f8c..f35dd19f6c69 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -239,6 +239,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*msi_unprepare)(struct irq_domain *domain, int nvec,
+					 void *data);
 	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
@@ -319,6 +321,7 @@ void platform_msi_domain_free_irqs(struct device *dev);
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec, void *data);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb7459324113..1a1738690519 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -312,6 +312,16 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 	return ret;
 }
 
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec,
+			       void *data)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	if (ops->msi_unprepare)
+		ops->msi_unprepare(domain, nvec, data);
+}
+
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *arg)
 {
-- 
2.19.2

