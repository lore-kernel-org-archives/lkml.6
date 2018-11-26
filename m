Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA0CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148420672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LviRcGJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeKZSqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36546 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeKZSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rZFm102536;
        Mon, 26 Nov 2018 01:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218815;
        bh=yMp3d2Rx8hr0SIVsWuzA4gvgTZR/TBf2/mu894sSCew=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LviRcGJwxprVYWAxm7GATeIJpx9o7ddCWekgO+yKKB8KCXvlRJDKD34Z8RyzOgg/S
         210+EeaHqJf9b0TxcwOqfhmHa7esIf+3G7JLuwhjxQc8u5YhevrG5x0jL6c7EIC/Xb
         eyfOlYsEKRdjUtjQW3AtO29gRQ/lUEQsuHJhtz8E=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rZEK103677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:35 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:35 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rYJa002594;
        Mon, 26 Nov 2018 01:53:34 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1O024490;
        Mon, 26 Nov 2018 01:53:31 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 10/16] remoteproc/pru: add pru_rproc_get_id() API to retrieve the PRU id
Date:   Mon, 26 Nov 2018 09:52:43 +0200
Message-ID: <1543218769-5507-11-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Export an API pru_rproc_get_id() to allow other PRUSS platform
drivers to clients to retrieve the PRU id from a remoteproc handle
associated with a PRU. The new function takes in a struct rproc
pointer as argument.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 27 +++++++++++++++++++++++++--
 include/linux/pruss.h          | 15 +++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2aa05b0..d8b823d 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -238,6 +238,29 @@ void pru_rproc_put(struct rproc *rproc)
 EXPORT_SYMBOL_GPL(pru_rproc_put);
 
 /**
+ * pru_rproc_get_id() - get PRU id from a previously acquired PRU remoteproc
+ * @rproc: the rproc instance of the PRU
+ *
+ * Returns the PRU id of the PRU remote processor that has been acquired through
+ * a pru_rproc_get(), or a negative value on error
+ */
+enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc)
+{
+	struct pru_rproc *pru;
+
+	if (IS_ERR_OR_NULL(rproc) || !rproc->dev.parent)
+		return -EINVAL;
+
+	/* TODO: replace the crude string based check to make sure it is PRU */
+	if (!strstr(dev_name(rproc->dev.parent), "pru"))
+		return -EINVAL;
+
+	pru = rproc->priv;
+	return pru->id;
+}
+EXPORT_SYMBOL_GPL(pru_rproc_get_id);
+
+/**
  * pru_rproc_set_ctable() - set the constant table index for the PRU
  * @rproc: the rproc instance of the PRU
  * @c: constant table index to set
@@ -643,9 +666,9 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
 	u32 mask2 = 0x38000;
 
 	if ((pru->mem_regions[0].pa & mask1) == mask1)
-		pru->id = 0;
+		pru->id = PRUSS_PRU0;
 	else if ((pru->mem_regions[0].pa & mask2) == mask2)
-		pru->id = 1;
+		pru->id = PRUSS_PRU1;
 	else
 		ret = -EINVAL;
 
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 405039a..c0a3b3e 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -10,6 +10,15 @@
 #ifndef __LINUX_PRUSS_H
 #define __LINUX_PRUSS_H
 
+/**
+ * enum pruss_pru_id - PRU core identifiers
+ */
+enum pruss_pru_id {
+	PRUSS_PRU0 = 0,
+	PRUSS_PRU1,
+	PRUSS_NUM_PRUS,
+};
+
 /*
  * PRU_ICSS_CFG registers
  * SYSCFG, ISRP, ISP, IESP, IECP, SCRP applicable on AMxxxx devices only
@@ -251,6 +260,7 @@ int pruss_intc_unconfigure(struct pruss *pruss,
 
 struct rproc *pru_rproc_get(struct device_node *node, int index);
 void pru_rproc_put(struct rproc *rproc);
+enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc);
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
 
 #else
@@ -262,6 +272,11 @@ static inline struct rproc *pru_rproc_get(struct device_node *node, int index)
 
 static inline void pru_rproc_put(struct rproc *rproc) { }
 
+static inline enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc)
+{
+	return -ENOTSUPP;
+}
+
 static inline int pru_rproc_set_ctable(struct rproc *rproc,
 				       enum pru_ctable_idx c, u32 addr)
 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

