Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0780ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BAE21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BAE21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeITUvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:51:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47942 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbeITUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:51:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 510A41A00A5;
        Thu, 20 Sep 2018 17:07:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4499A1A00A0;
        Thu, 20 Sep 2018 17:07:08 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D374220618;
        Thu, 20 Sep 2018 17:07:07 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 4/4] soc/fsl_qbman: export coalesce change API
Date:   Thu, 20 Sep 2018 18:06:51 +0300
Message-Id: <1537456011-10769-5-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow changing the QMan portal interrupt coalescing settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
 include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 7f4c57999e08..c270471a6e47 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1011,6 +1011,37 @@ static inline void put_affine_portal(void)
 
 static struct workqueue_struct *qm_portal_wq;
 
+void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
+{
+	if (!portal)
+		return;
+
+	qm_dqrr_set_ithresh(&portal->p, ithresh);
+	portal->p.dqrr.ithresh = ithresh;
+}
+EXPORT_SYMBOL(qman_dqrr_set_ithresh);
+
+void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
+{
+	if (portal && ithresh)
+		*ithresh = portal->p.dqrr.ithresh;
+}
+EXPORT_SYMBOL(qman_dqrr_get_ithresh);
+
+void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
+{
+	if (portal && iperiod)
+		*iperiod = qm_in(&portal->p, QM_REG_ITPR);
+}
+EXPORT_SYMBOL(qman_portal_get_iperiod);
+
+void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
+{
+	if (portal)
+		qm_out(&portal->p, QM_REG_ITPR, iperiod);
+}
+EXPORT_SYMBOL(qman_portal_set_iperiod);
+
 int qman_wq_alloc(void)
 {
 	qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index d4dfefdee6c1..42f50eb51529 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1186,4 +1186,31 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
  */
 int qman_release_cgrid(u32 id);
 
+/**
+ * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
+ * @portal: portal to get the value for
+ * @ithresh: threshold pointer
+ */
+void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
+
+/**
+ * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
+ * @portal: portal to set the new value on
+ * @ithresh: new threshold value
+ */
+void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
+
+/**
+ * qman_dqrr_get_iperiod - Get coalesce interrupt period
+ * @portal: portal to get the value for
+ * @iperiod: period pointer
+ */
+void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
+/*
+ * qman_dqrr_set_iperiod - Set coalesce interrupt period
+ * @portal: portal to set the new value on
+ * @ithresh: new period value
+ */
+void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
+
 #endif	/* __FSL_QMAN_H */
-- 
2.1.0

