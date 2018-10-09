Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEDCECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAA4214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FewRzA0C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kRd4m2bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAA4214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJIXlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:41:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:41:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 767AC60866; Tue,  9 Oct 2018 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102245;
        bh=E732yZacHh5Js6UCJf8iPHfocQFXpXKKNzpzQXWw0EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FewRzA0CvsTBdUP0tY0cxM/yMNNiiCkf9aVpprYrJ2++3quQ86GL/yWTCbqDm6dBo
         jd0NO04FvKDVCsEoOcZWZnGWOwMi182ozbJcz6VXzpkIBYk2Hg0wZU4IMc6v6RmAg0
         Si8UOkz3cchHIw8SlbX6+EhC+6Wsxm66mzwYjMUE=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AAC760866;
        Tue,  9 Oct 2018 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102244;
        bh=E732yZacHh5Js6UCJf8iPHfocQFXpXKKNzpzQXWw0EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRd4m2bnwX2/oBoOrwKiiVuofYmvfl/ENAg3tgamX1tZf+ePKCC68W4w5zyxM96vz
         o5C5DnOa1dn1dsuL0Fp5Q2H3KQh4cDhrCnM2/POpkAzI1gg4zZV4RYPtA6Rj8Ugsr8
         CxU/pi7a04PJsvvSf7omorZtOxK2Hy+GipRsfkLU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AAC760866
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 2/5] remoteproc: Add mechanism for custom dump function assignment
Date:   Tue,  9 Oct 2018 21:53:36 +0530
Message-Id: <20181009162339.30522-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009162339.30522-1-sibis@codeaurora.org>
References: <20181009162339.30522-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a mechanism for assigning each rproc dump segment with
a custom dump function and private data. The dump function is to be
called for each rproc segment during coredump if assigned.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 39 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  5 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index afa4274b6ccd..076579f44c3a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1121,6 +1121,45 @@ int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
 }
 EXPORT_SYMBOL(rproc_coredump_add_segment);
 
+/**
+ * rproc_coredump_add_custom_segment() - add segment of device memory to
+ *					 coredump and extend it with custom
+ *					 dump function
+ * @rproc:	handle of a remote processor
+ * @da:		device address
+ * @size:	size of segment
+ * @priv:	private data
+ * @dumpfn:	custom dump function called for each segment during coredump
+ *
+ * Add device memory to the list of segments to be included in the coredump
+ * and associate the segment with the given custom dump function and private
+ * data.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int rproc_coredump_add_custom_segment(struct rproc *rproc,
+				      dma_addr_t da, size_t size, void *priv,
+				      void (*dumpfn)(struct rproc *rproc,
+					struct rproc_dump_segment *segment,
+					void *dest))
+{
+	struct rproc_dump_segment *segment;
+
+	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
+	if (!segment)
+		return -ENOMEM;
+
+	segment->da = da;
+	segment->size = size;
+	segment->priv = priv;
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
index 2a93e102d2ad..0003b23ab117 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -563,6 +563,11 @@ int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
+int rproc_coredump_add_custom_segment(struct rproc *rproc,
+				      dma_addr_t da, size_t size, void *priv,
+				      void (*dumpfn)(struct rproc *rproc,
+					struct rproc_dump_segment *segment,
+					void *dest));
 
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

