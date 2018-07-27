Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB62208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPVItMJW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xd6XU8J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB62208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeG0Qnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbeG0Qnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CBE060481; Fri, 27 Jul 2018 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704872;
        bh=jUEUG1Zoe9hQ6lqR7Oo6DNpf4+svISBtdkV6AjUBcZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPVItMJW17kMoJmrEqJKtwE5Y5MUzCL4BySaWyIE6k6duZ8bhGQVvPJdh97CVnBeZ
         KYmwufgYQaFdDH1cr8PO8uZJ/KJXIDmG0mpXIOXjuVJrlfEOIK9dRRGxHRJRh//l/m
         yArW0HSZIcpGTOmcYI7Y4EufYA+7XmxtmANgp29I=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A0FF60B15;
        Fri, 27 Jul 2018 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704871;
        bh=jUEUG1Zoe9hQ6lqR7Oo6DNpf4+svISBtdkV6AjUBcZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xd6XU8J09MsWXsq/l0nc9aNrg6URyTek0f/FPpsBYEBJXRsifAW2uQ6aBvkAeTrXa
         h/zdXZqs+GiQ4GpCmf6NRmOFIvQEPbvekQd//h077/m0gjjT79mjg8mzAZ0i2Cp1tm
         uNPl2SP12Gf/TBeoIAd51oS7uimDKdvfFoR9SxPs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A0FF60B15
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/6] remoteproc: Introduce custom dump function for each remoteproc segment
Date:   Fri, 27 Jul 2018 20:49:58 +0530
Message-Id: <20180727152003.11663-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce custom dump function per remoteproc segment. It is responsible
for filling the device memory segment associated with coredump

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 15 ++++++++++-----
 include/linux/remoteproc.h           |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 283b258f5e0f..ec56cd822b26 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1183,13 +1183,18 @@ static void rproc_coredump(struct rproc *rproc)
 		phdr->p_align = 0;
 
 		ptr = rproc_da_to_va(rproc, segment->da, segment->size);
-		if (!ptr) {
-			dev_err(&rproc->dev,
+
+		if (segment->dump) {
+			segment->dump(rproc, ptr, segment->size, data + offset);
+		} else {
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
index e3c5d856b6da..0fbb01a9955c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -399,6 +399,8 @@ enum rproc_crash_type {
  * @node:	list node related to the rproc segment list
  * @da:		device address of the segment
  * @size:	size of the segment
+ * @dump:	custom dump function to fill device memory segment associated
+ *		with coredump
  */
 struct rproc_dump_segment {
 	struct list_head node;
@@ -406,6 +408,7 @@ struct rproc_dump_segment {
 	dma_addr_t da;
 	size_t size;
 
+	void (*dump)(struct rproc *rproc, void *ptr, size_t len, void *priv);
 	loff_t offset;
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

