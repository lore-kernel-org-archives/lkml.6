Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9884F21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dIpFqriY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A0sG40g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9884F21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJQVvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:51:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:51:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14193602D7; Wed, 17 Oct 2018 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784551;
        bh=YS6bMC+ZrQm5W0ohmcG1d9cO5YpfeKnBOYZghR4rwfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIpFqriYTK1LmogPz7BTmJr7cK4uJRpNbbLzWmzBbecEd6SEVNPIMlX0oQGIMwg83
         YeHNOiWWK56NgJskEZwsgyFoHsxsbkUijBdbdiSkx5LbFqLDmS86QiB3htYRnYmnar
         YRtSYbWVhySPNLhTapDXiZKxKDiAOYUHSHJgc76g=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23C2461325;
        Wed, 17 Oct 2018 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784550;
        bh=YS6bMC+ZrQm5W0ohmcG1d9cO5YpfeKnBOYZghR4rwfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0sG40g3ciCiuIjCSwCIVdnAnGmHiOtY3m5DoMcqhPTxduzAlDZDgtdmYbrnRFDBy
         Ws6cJMsBXGWBMKC2mxu0S5uwa3KVonOv6EbAq7VI8AbwsN3DvXpY7mS4EPAd930K7t
         qg9MCBIHvCLwX0w0icRfTe18ybp2MmHvD9ru//RU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23C2461325
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 1/5] remoteproc: Introduce custom dump function for each remoteproc segment
Date:   Wed, 17 Oct 2018 19:25:23 +0530
Message-Id: <20181017135527.30592-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017135527.30592-1-sibis@codeaurora.org>
References: <20181017135527.30592-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce custom dump function and private data per remoteproc dump
segment. The dump function is responsible for filling the device memory
segment associated with coredump

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++------
 include/linux/remoteproc.h           |  6 ++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index aa6206706fe3..afa4274b6ccd 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1183,14 +1183,18 @@ static void rproc_coredump(struct rproc *rproc)
 		phdr->p_flags = PF_R | PF_W | PF_X;
 		phdr->p_align = 0;
 
-		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
-		if (!ptr) {
-			dev_err(&rproc->dev,
+		if (segment->dump) {
+			segment->dump(rproc, segment, data + offset);
+		} else {
+			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+			if (!ptr) {
+				dev_err(&rproc->dev,
 				"invalid coredump segment (%pad, %zu)\n",
 				&segment->da, segment->size);
-			memset(data + offset, 0xff, segment->size);
-		} else {
-			memcpy(data + offset, ptr, segment->size);
+				memset(data + offset, 0xff, segment->size);
+			} else {
+				memcpy(data + offset, ptr, segment->size);
+			}
 		}
 
 		offset += phdr->p_filesz;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e3c5d856b6da..2a93e102d2ad 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -399,6 +399,9 @@ enum rproc_crash_type {
  * @node:	list node related to the rproc segment list
  * @da:		device address of the segment
  * @size:	size of the segment
+ * @priv:	private data associated with the dump_segment
+ * @dump:	custom dump function to fill device memory segment associated
+ *		with coredump
  */
 struct rproc_dump_segment {
 	struct list_head node;
@@ -406,6 +409,9 @@ struct rproc_dump_segment {
 	dma_addr_t da;
 	size_t size;
 
+	void *priv;
+	void (*dump)(struct rproc *rproc, struct rproc_dump_segment *segment,
+		     void *dest);
 	loff_t offset;
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

