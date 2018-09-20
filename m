Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB326C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B621533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzF8OFIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707B621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbeIUBER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbeIUBEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id q5-v6so1323495pli.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XYoLsNZfR03NjVkAKkp/jGU/bTSOzZPT2U9//grQAEE=;
        b=kzF8OFIE3qtMuejYaqTvZvL95QYKOlQZrKK0uIFM9dhVnqAohTiniPi63WKR/L4rXZ
         8ftWAmzB7wE8tzhg88XaTWaEzQG01u1WpXMQvsfWwBOJ6rf7pYv1Tq/SJrowH0y87S/2
         i942xsdc98ln3Gw7RtqOwvNja2yIw3cSbug9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XYoLsNZfR03NjVkAKkp/jGU/bTSOzZPT2U9//grQAEE=;
        b=klKjpeI70OwiX3glbq8mSxUCBqdZGEW9Q/2Qa6trO3qWs488fO/ppMX89U2Kr3a9ke
         DbLqrAmG+rSMntP0WB7SHLBU7uDIkrjXT8fqa+HAaAyN2DaRkrS3JstXvTtxrUxIfRTL
         RzOsAvHY2j0UnKsIKXeA6jak08bIqgUGVgYizjOWAfwjIUp8JW0RbXgmEGDQ43OTIhEV
         F9CgOQ3SRXsbf2bT3KW6xQ2JvAB5BxlzFic7uRtj/6id1T/wPUqAu29Ww0U+Jh2YvU3O
         qRwV944srOb8167mbf+iWmpFHQX+KaVpRFnosjBHd1Q0U+3cnZfOClbYiQiioPMHmEFu
         celg==
X-Gm-Message-State: APzg51AdZpf+u8LzOGpaeaf0YLjQ+yVSW37+qpSZxQ4t8iaYPxoZJqiP
        dk7T+9zMNG/X/srGIqS0nAUo0Y1Ku5o=
X-Google-Smtp-Source: ANB0VdbMN+qhuP4avpgOm10zOdgVjDW38abr4kPReSPLT4itOJLkiKgTGDihrtvXpGYRasPvXPhwjA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21-v6mr40817654plq.61.1537471156580;
        Thu, 20 Sep 2018 12:19:16 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 36/44] coresight: Add support for CLAIM tag protocol
Date:   Thu, 20 Sep 2018 13:18:11 -0600
Message-Id: <1537471099-19781-37-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h |  7 +++
 drivers/hwtracing/coresight/coresight.c      | 86 ++++++++++++++++++++++++++++
 include/linux/coresight.h                    | 20 +++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c11da5564a67..579f34943bf1 100644
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
index f4f50753cf75..2b0df1a0a8df 100644
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
index 53535821dc25..46c67a764877 100644
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

