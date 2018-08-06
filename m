Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13E121A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13E121A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeHFPwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:52:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbeHFPwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:52:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A90169E;
        Mon,  6 Aug 2018 06:43:26 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60DD93F2EA;
        Mon,  6 Aug 2018 06:43:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 08/13] coresight: Add support for CLAIM tag protocol
Date:   Mon,  6 Aug 2018 14:41:50 +0100
Message-Id: <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the CLAIM tag protocol for negotiating the
device ownership with other agents trying to use the coresight
component (internal vs. external). The Coresight architecture
specifies CLAIM tags (managed via CLAIMSET CLAIMCLR registers)
to negotiate the ownership of the device. PSCI recommends the
reservation of the bits in CLAIM tags for self-hosted and external
debug use. This patch implements the protocol for claiming
the devices before they are actually used.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h |  7 +++
 drivers/hwtracing/coresight/coresight.c      | 85 ++++++++++++++++++++++++++++
 include/linux/coresight.h                    | 20 +++++++
 3 files changed, 112 insertions(+)

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
index e73ca6a..8f06866 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -128,6 +128,91 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
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
+		 * Either we or the external agent doesn't follow
+		 * the protocol.
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
index 5353582..16151a2 100644
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
+	return 0;
+}
+
+static inline int coresight_claim_device(void __iomem *base)
+{
+	return 0;
+}
+
+static inline void coresight_disclaim_device(void __iomem *base) {}
+static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
+
 #endif
 
 #ifdef CONFIG_OF
-- 
2.7.4

