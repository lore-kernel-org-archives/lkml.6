Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522BCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077F720672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gjH5dsPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077F720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394926AbeKVWTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42074 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391015AbeKVWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:19:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBeBfs022738;
        Thu, 22 Nov 2018 05:40:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886811;
        bh=Ln0fJdBQ/2H23W8baBsSHB73EdERozHgYF1vFWlnGT8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gjH5dsPEGR1IDE8HFHmkS1ZA/BQknSLubXStXPdyyquP8VpgrAZNdt8MetKdY8O7o
         vGXB9M5R7Ev/2z25ORuhNYpGzYvPTu6LEEh1oXmu9fvG5t3elbFGI42P9VmvaOg149
         ey0a7880VlEV4Bv6qqROjXfnuugHIdpdT06Avkps=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBeBJw107692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:40:11 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:40:11 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:40:11 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBeBWc018314;
        Thu, 22 Nov 2018 05:40:11 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDfC013203;
        Thu, 22 Nov 2018 05:40:07 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 13/17] soc: ti: pruss: export pruss_intc_configure/unconfigure APIs
Date:   Thu, 22 Nov 2018 13:39:09 +0200
Message-ID: <1542886753-17625-14-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRU remoteproc driver will need to configure the
Interrupt controller based on the application specific
interrupt map.

Export pruss_intc_configure() and pruss_intc_unconfigure()
to linux/pruss.h

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss.h | 21 -------------------
 include/linux/pruss.h  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
index 45de1be..ce3f96a 100644
--- a/drivers/soc/ti/pruss.h
+++ b/drivers/soc/ti/pruss.h
@@ -9,12 +9,6 @@
 #ifndef _PRUSS_H_
 #define _PRUSS_H_
 
-/* maximum number of system events */
-#define MAX_PRU_SYS_EVENTS	64
-
-/* maximum number of interrupt channels */
-#define MAX_PRU_CHANNELS	10
-
 /* minimum starting host interrupt number for MPU */
 #define MIN_PRU_HOST_INT	2
 
@@ -22,16 +16,6 @@
 #define MAX_PRU_HOST_INT	10
 
 /**
- * struct pruss_intc_config - INTC configuration info
- * @sysev_to_ch: system events to channel mapping information
- * @ch_to_host: interrupt channel to host interrupt information
- */
-struct pruss_intc_config {
-	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
-	s8 ch_to_host[MAX_PRU_CHANNELS];
-};
-
-/**
  * struct pruss - PRUSS parent structure
  * @dev: pruss device pointer
  * @cfg: regmap for config region
@@ -49,9 +33,4 @@ struct pruss {
 	struct mutex lock; /* PRU resource lock */
 };
 
-int pruss_intc_configure(struct pruss *pruss,
-			 struct pruss_intc_config *intc_config);
-int pruss_intc_unconfigure(struct pruss *pruss,
-			   struct pruss_intc_config *intc_config);
-
 #endif	/* _PRUSS_H_ */
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 3ed175a..c797fb1 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -118,6 +118,22 @@ struct pruss_mem_region {
 	size_t size;
 };
 
+/* maximum number of system events */
+#define MAX_PRU_SYS_EVENTS	64
+
+/* maximum number of interrupt channels */
+#define MAX_PRU_CHANNELS	10
+
+/**
+ * struct pruss_intc_config - INTC configuration info
+ * @sysev_to_ch: system events to channel mapping information
+ * @ch_to_host: interrupt channel to host interrupt information
+ */
+struct pruss_intc_config {
+	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
+	s8 ch_to_host[MAX_PRU_CHANNELS];
+};
+
 struct pruss;
 
 #if IS_ENABLED(CONFIG_TI_PRUSS)
@@ -136,6 +152,34 @@ int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val);
 int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
 		     unsigned int mask, unsigned int val);
 
+/**
+ * pruss_intc_configure() - configure the PRUSS INTC
+ * @pruss: the pruss instance
+ * @intc_config: PRU core-specific INTC configuration
+ *
+ * Configures the PRUSS INTC with the provided configuration from
+ * a PRU core. Any existing event to channel mappings or channel to
+ * host interrupt mappings are checked to make sure there are no
+ * conflicting configuration between both the PRU cores. The function
+ * is intended to be used only by the PRU remoteproc driver.
+ *
+ * Returns 0 on success, or a suitable error code otherwise
+ */
+int pruss_intc_configure(struct pruss *pruss,
+			 struct pruss_intc_config *intc_config);
+
+/**
+ * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
+ * @pruss: the pruss instance
+ * @intc_config: PRU core specific INTC configuration
+ *
+ * Undo whatever was done in pruss_intc_configure() for a PRU core.
+ * It should be sufficient to just mark the resources free in the
+ * global map and disable the host interrupts and sysevents.
+ */
+int pruss_intc_unconfigure(struct pruss *pruss,
+			   struct pruss_intc_config *intc_config);
+
 #else
 
 static inline struct pruss *pruss_get(struct rproc *rproc)
@@ -174,6 +218,18 @@ int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
 	return -ENOTSUPP;
 }
 
+int pruss_intc_configure(struct pruss *pruss,
+			 struct pruss_intc_config *intc_config)
+{
+	return -ENOTSUPP;
+}
+
+int pruss_intc_unconfigure(struct pruss *pruss,
+			   struct pruss_intc_config *intc_config)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

