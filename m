Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10721C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70E7208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gGtnxDm3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="neXPn40a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70E7208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeG0Qnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbeG0Qnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 053DE60B15; Fri, 27 Jul 2018 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704877;
        bh=JJKdiMhCOpy/wg/pc2M43YVTGwRSA5EPGVCe9iEl3W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGtnxDm3UC52RwY+x01axLH0rEmcAmUlOrbURxL2r92pF7SzdnTdbxg4FLJh72Vrc
         SvJfPR7eBaOdsjszabocmkMzVwaX+b+miuOrYiVraEDsFQj5vXVofzayA/rtepks5j
         hu/61wSKbFZ2iOPHz7Y/laT6V91OybFmulh8sX+c=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C863660B7A;
        Fri, 27 Jul 2018 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704876;
        bh=JJKdiMhCOpy/wg/pc2M43YVTGwRSA5EPGVCe9iEl3W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neXPn40aT2B6KcgcbdtYbQeXncCD7+RutYH8eTF2Gpo1O6iw+JYkbB8hI73BNRBmE
         Rv+Dxd+RO4TgXBQchDR+7uhm1jnlHPJZGeOqQOcx9ANav0Z+XFA0v2HU+5MdfRHNo/
         Nh/Y/6AFrRB9Y8FB8lZFxNhyEoNlPCRTDtkO/QO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C863660B7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 2/6] remoteproc: Add mechanism for custom dump function assignment
Date:   Fri, 27 Jul 2018 20:49:59 +0530
Message-Id: <20180727152003.11663-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a mechanism for assigning each rproc segment with
a custom dump function. It is to be called for each rproc segment
during coredump if assigned.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 37 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  5 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ec56cd822b26..3d70b7dd1f18 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1120,6 +1120,43 @@ int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
 }
 EXPORT_SYMBOL(rproc_coredump_add_segment);
 
+/**
+ * rproc_coredump_add_custom_segment() - add segment of device memory to
+ *					 coredump and extend it with custom
+ *					 dump function
+ * @rproc:	handle of a remote processor
+ * @da:		device address
+ * @size:	size of segment
+ * @dumpfn:	custom dump function called for each segment during coredump
+ *
+ * Add device memory to the list of segments to be included in a coredump for
+ * the remoteproc and associate the segment with the given custom dump
+ * function.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int rproc_coredump_add_custom_segment(struct rproc *rproc,
+				      dma_addr_t da, size_t size,
+				      void (*dumpfn)(struct rproc *rproc,
+						     void *ptr, size_t len,
+						     void *priv))
+{
+	struct rproc_dump_segment *segment;
+
+	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
+	if (!segment)
+		return -ENOMEM;
+
+	segment->da = da;
+	segment->size = size;
+	segment->dump = dumpfn;
+
+	list_add_tail(&segment->node, &rproc->dump_segments);
+
+	return 0;
+}
+EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
+
 /**
  * rproc_coredump() - perform coredump
  * @rproc:	rproc handle
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0fbb01a9955c..5a1ad008ec28 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -560,6 +560,11 @@ int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
+int rproc_coredump_add_custom_segment(struct rproc *rproc,
+				      dma_addr_t da, size_t size,
+				      void (*dumpfn)(struct rproc *rproc,
+						     void *ptr, size_t len,
+						     void *priv));
 
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

