Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0209C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2EE2150A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CLsZZ5BQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V22xvL3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2EE2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeHNNmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:42:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:42:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5B8560B62; Tue, 14 Aug 2018 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244152;
        bh=rT8NUqC878iuBndcOZzhJBA0BDamjCjcvH88eZ3kR6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLsZZ5BQPtnuN/v3F6zzVqiBgPgnYMsSOQelomqCQ57gjcv/Kazp97nP8GUufkhoM
         K1O+fHNfNg2GzGSIfgYjih5qB1A9x61BdTBp0WJWXylchRsuypxHyc78NqeahXw19i
         +f7+j0RqjZxOUnfRZZ7sgfVEpWnlznHaK9k8/IvI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A06F360B84;
        Tue, 14 Aug 2018 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244149;
        bh=rT8NUqC878iuBndcOZzhJBA0BDamjCjcvH88eZ3kR6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V22xvL3UOua6Hr8LXMdX6htlboGtGIu1jPZSavGZ/TXpwEDOvpzMwfcWQqWRtt49V
         98odCEtSlNsw1LzGbT1JIseo9BHxQtFxXewdH+NZDabo+g3iCg3zZFglzgcXxhcbIo
         /M3XV1quLaeAHUAr3Ak7j1QJZqviVf8lqb9KOD3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A06F360B84
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/5] firmware/qcom_scm: Add atomic version of io read/write APIs
Date:   Tue, 14 Aug 2018 16:25:25 +0530
Message-Id: <20180814105528.20592-3-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic versions of qcom_scm_io_readl/writel to enable
reading/writing secure registers from atomic context.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 12 ++++++++++++
 drivers/firmware/qcom_scm-64.c | 32 ++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.c    | 12 ++++++++++++
 drivers/firmware/qcom_scm.h    |  4 ++++
 include/linux/qcom_scm.h       |  4 ++++
 5 files changed, 64 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 4e24e591ae74..7293e5efad69 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -627,3 +627,15 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	return qcom_scm_call_atomic2(QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 				     addr, val);
 }
+
+int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+			       unsigned int *val)
+{
+	return -ENODEV;
+}
+
+int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				unsigned int val)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 3a8c867cdf51..6bf55403f6e3 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -558,3 +558,35 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 			     &desc, &res);
 }
+
+int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+			       unsigned int *val)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	desc.args[0] = addr;
+	desc.arginfo = QCOM_SCM_ARGS(1);
+
+	ret = qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_READ,
+				   &desc, &res);
+	if (ret >= 0)
+		*val = res.a1;
+
+	return ret < 0 ? ret : 0;
+}
+
+int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				unsigned int val)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+
+	desc.args[0] = addr;
+	desc.args[1] = val;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
+				    &desc, &res);
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e778af766fae..36da0000b37f 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -365,6 +365,18 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 }
 EXPORT_SYMBOL(qcom_scm_io_writel);
 
+int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val)
+{
+	return __qcom_scm_io_readl_atomic(__scm->dev, addr, val);
+}
+EXPORT_SYMBOL(qcom_scm_io_readl_atomic);
+
+int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val)
+{
+	return __qcom_scm_io_writel_atomic(__scm->dev, addr, val);
+}
+EXPORT_SYMBOL(qcom_scm_io_writel_atomic);
+
 static void qcom_scm_set_download_mode(bool enable)
 {
 	bool avail;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index dcd7f7917fc7..bb176107f51e 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -37,6 +37,10 @@ extern void __qcom_scm_cpu_power_down(u32 flags);
 #define QCOM_SCM_IO_WRITE		0x2
 extern int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr, unsigned int *val);
 extern int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val);
+extern int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+				      unsigned int *val);
+extern int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				       unsigned int val);
 
 #define QCOM_SCM_SVC_INFO		0x6
 #define QCOM_IS_CALL_AVAIL_CMD		0x1
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 5d65521260b3..6a5d0c98b328 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -64,6 +64,8 @@ extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
+extern int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val);
 #else
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
@@ -100,5 +102,7 @@ static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { ret
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
 static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
+static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
+static inline int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val) { return -ENODEV; }
 #endif
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

