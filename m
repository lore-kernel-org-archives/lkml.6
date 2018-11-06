Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5072C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73C20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE73C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbeKFSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:06:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeKFSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:06:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68g1mL092045;
        Tue, 6 Nov 2018 02:42:01 -0600
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68g1lS128251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:42:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:42:00 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:42:00 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3s032677;
        Tue, 6 Nov 2018 02:41:57 -0600
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
Subject: [RFC PATCH v3 09/13] genirq/msi: Add support for .msi_unprepare callback
Date:   Tue, 6 Nov 2018 14:11:01 +0530
Message-ID: <20181106084105.32483-10-lokeshvutla@ti.com>
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

Add an optional callback .msi_unprepare to struct msi_domain_ops.
This is used to clear any effect that is done by .msi_prepare callback.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- New patch

 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 021f789226b5..1e37aa569a3c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -237,6 +237,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*msi_unprepare)(struct irq_domain *domain, int nvec,
+					 void *data);
 	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
@@ -317,6 +319,7 @@ void platform_msi_domain_free_irqs(struct device *dev);
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec, void *data);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e37238317fab..87ce5a5d0c6d 100644
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
2.19.1

