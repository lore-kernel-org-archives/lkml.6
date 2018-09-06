Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55278C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085612077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085612077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeIFNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41188 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbeIFNn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCF580D;
        Thu,  6 Sep 2018 02:08:58 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17A8F3F575;
        Thu,  6 Sep 2018 02:08:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 09/14] coresight: Add support for CLAIM tag protocol
Date:   Thu,  6 Sep 2018 10:08:30 +0100
Message-Id: <1536224915-31766-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight architecture defines CLAIM tags for a device to negotiate
control of the components (external agent vs self-hosted). Each device
has a pair of registers (CLAIMSET & CLAIMCLR) for managing the CLAIM
tags. However, the protocol for the CLAIM tags is IMPLEMENTATION DEFINED.
PSCI has recommendations for the use of the CLAIM tags to negotiate
controls for external agent vs self-hosted use. This patch implements
the recommended protocol by PSCI.

The claim/disclaim operations are performed from the device specific
drivers. The disadvantage is that the calls are sprinkled in each driver,
but this makes the operation much simpler.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h |  7 +++
 drivers/hwtracing/coresight/coresight.c      | 86 ++++++++++++++++++++++++++++
 include/linux/coresight.h                    | 20 +++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c11da55..579f349 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -25,6 +25,13 @@
 #define CORESIGHT_DEVID		0xfc8
 #define CORESIGHT_DEVTYPE	0xfcc
 
+
+/*
+ * Coresight device CLAIM protocol.
+ * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
+ */
+#define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
+
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index f4f5075..2b0df1a 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -128,6 +128,92 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	return -ENODEV;
 }
 
+static inline u32 coresight_read_claim_tags(void __iomem *base)
+{
+	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
+}
+
+static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
+{
+	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
+}
+
+static inline bool coresight_is_claimed_any(void __iomem *base)
+{
+	return coresight_read_claim_tags(base) != 0;
+}
+
+static inline void coresight_set_claim_tags(void __iomem *base)
+{
+	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
+	isb();
+}
+
+static inline void coresight_clear_claim_tags(void __iomem *base)
+{
+	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
+	isb();
+}
+
+/*
+ * coresight_claim_device_unlocked : Claim the device for self-hosted usage
+ * to prevent an external tool from touching this device. As per PSCI
+ * standards, section "Preserving the execution context" => "Debug and Trace
+ * save and Restore", DBGCLAIM[1] is reserved for Self-hosted debug/trace and
+ * DBGCLAIM[0] is reserved for external tools.
+ *
+ * Called with CS_UNLOCKed for the component.
+ * Returns : 0 on success
+ */
+int coresight_claim_device_unlocked(void __iomem *base)
+{
+	if (coresight_is_claimed_any(base))
+		return -EBUSY;
+
+	coresight_set_claim_tags(base);
+	if (coresight_is_claimed_self_hosted(base))
+		return 0;
+	/* There was a race setting the tags, clean up and fail */
+	coresight_clear_claim_tags(base);
+	return -EBUSY;
+}
+
+int coresight_claim_device(void __iomem *base)
+{
+	int rc;
+
+	CS_UNLOCK(base);
+	rc = coresight_claim_device_unlocked(base);
+	CS_LOCK(base);
+
+	return rc;
+}
+
+/*
+ * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
+ * Called with CS_UNLOCKed for the component.
+ */
+void coresight_disclaim_device_unlocked(void __iomem *base)
+{
+
+	if (coresight_is_claimed_self_hosted(base))
+		coresight_clear_claim_tags(base);
+	else
+		/*
+		 * The external agent may have not honoured our claim
+		 * and has manipulated it. Or something else has seriously
+		 * gone wrong in our driver.
+		 */
+		WARN_ON_ONCE(1);
+}
+
+void coresight_disclaim_device(void __iomem *base)
+{
+	CS_UNLOCK(base);
+	coresight_disclaim_device_unlocked(base);
+	CS_LOCK(base);
+}
+
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 u32 mode, void *data)
 {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5353582..46c67a7 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -257,6 +257,13 @@ extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
 extern int coresight_timeout(void __iomem *addr, u32 offset,
 			     int position, int value);
+
+extern int coresight_claim_device(void __iomem *base);
+extern int coresight_claim_device_unlocked(void __iomem *base);
+
+extern void coresight_disclaim_device(void __iomem *base);
+extern void coresight_disclaim_device_unlocked(void __iomem *base);
+
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
@@ -266,6 +273,19 @@ coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
 				     int position, int value) { return 1; }
+static inline int coresight_claim_device_unlocked(void __iomem *base)
+{
+	return -EINVAL;
+}
+
+static inline int coresight_claim_device(void __iomem *base)
+{
+	return -EINVAL;
+}
+
+static inline void coresight_disclaim_device(void __iomem *base) {}
+static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
+
 #endif
 
 #ifdef CONFIG_OF
-- 
2.7.4

