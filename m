Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C27FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B0F21778
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bRhXvr3c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NTE7h6JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B0F21778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeHNNmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:42:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:42:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58C3C60BE6; Tue, 14 Aug 2018 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244156;
        bh=Sig3S3nqLVQgtJah7yF0obv4wxXNMBznIsHnP9yZ7RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRhXvr3cx3RCYEVYPoZIFmFa8Wyv6iR5j6TgD3G8veDUQnZ1o4d5W3YciZNWQRtxt
         WkyTlaHqB96bylUfd7hPu5QsUdu0zv7DtPhNanAp++csGC0tiYhEt4AdAq2gMTAL/Q
         cIIjxebf1z3NQgWe9Qh5T8pxGrq2g+PrmE6iXHqQ=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79EE060BE5;
        Tue, 14 Aug 2018 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244155;
        bh=Sig3S3nqLVQgtJah7yF0obv4wxXNMBznIsHnP9yZ7RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTE7h6JAOFoPJlWzMG1i4e46hj9nXJl6dZPGwFDKa2olQW5cg5Nopcx8rB2GUCzYE
         0C53ux8Z0FdaxPZXJ8bomdNFt6Cc/d10I73pLeP/9TESVn3w4xQfDURxkm7M7N9vDy
         ecHrNBOeSsVscMhHzevITn8hUv4tuhckYom2YYis=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79EE060BE5
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
Subject: [PATCH 3/5] firmware/qcom_scm: Add scm call to handle smmu errata
Date:   Tue, 14 Aug 2018 16:25:26 +0530
Message-Id: <20180814105528.20592-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's smmu-500 needs to toggle wait-for-safe sequence to
handle TLB invalidation sync's.
Few firmwares allow doing that through SCM interface.
Add API to toggle wait for safe from firmware through a
SCM call.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c |  5 +++++
 drivers/firmware/qcom_scm-64.c | 13 +++++++++++++
 drivers/firmware/qcom_scm.c    |  6 ++++++
 drivers/firmware/qcom_scm.h    |  5 +++++
 include/linux/qcom_scm.h       |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 7293e5efad69..2d301ad053f8 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -639,3 +639,8 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
 {
 	return -ENODEV;
 }
+
+int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool enable)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 6bf55403f6e3..f13bcabc5d78 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -590,3 +590,16 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
 	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 				    &desc, &res);
 }
+
+int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+
+	desc.args[0] = QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL;
+	desc.args[1] = en;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_SMMU_PROGRAM,
+				    QCOM_SCM_CONFIG_ERRATA1, &desc, &res);
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 36da0000b37f..5f15cc2e9f69 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -353,6 +353,12 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 }
 EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
 
+int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
+{
+	return __qcom_scm_qsmmu500_wait_safe_toggle(__scm->dev, en);
+}
+EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
+
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 {
 	return __qcom_scm_io_readl(__scm->dev, addr, val);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index bb176107f51e..89a822c23e33 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -103,10 +103,15 @@ extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 				      u32 spare);
 #define QCOM_SCM_IOMMU_SECURE_PTBL_SIZE	3
 #define QCOM_SCM_IOMMU_SECURE_PTBL_INIT	4
+#define QCOM_SCM_SVC_SMMU_PROGRAM	0x15
+#define QCOM_SCM_CONFIG_ERRATA1		0x3
+#define QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL	0x2
 extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 					     size_t *size);
 extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
 					     u32 size, u32 spare);
+extern int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev,
+						bool enable);
 #define QCOM_MEM_PROT_ASSIGN_ID	0x16
 extern int  __qcom_scm_assign_mem(struct device *dev,
 				  phys_addr_t mem_region, size_t mem_sz,
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 6a5d0c98b328..46e6b1692998 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -62,6 +62,7 @@ extern int qcom_scm_set_remote_state(u32 state, u32 id);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
+extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
@@ -100,6 +101,7 @@ qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
 static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
+static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en) { return -ENODEV; }
 static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
 static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
 static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

