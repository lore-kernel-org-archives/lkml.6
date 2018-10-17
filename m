Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68614ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9AF21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DlXaLHqh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MmP2j8pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9AF21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJQVv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:51:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:51:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC7586132F; Wed, 17 Oct 2018 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784567;
        bh=04y2TahKeW7N1261nI48AyV+3lS5X15YaOUQyCHohC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlXaLHqh/k0zJxxdxayV07Yw47igGXfDSXRS5HzfVlgeTdlSp5icZHrJAJA3cfWGM
         DnvJujxBhOAypI92hiyurodS9yVOJJue6FNSUMK4iYAqhKRzFeSsvHVDqzgihH+sNC
         KHguRAtPdvKakyvQpto6Qws+k4vOAJTRJ6hWZ4uM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 634A26130F;
        Wed, 17 Oct 2018 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784566;
        bh=04y2TahKeW7N1261nI48AyV+3lS5X15YaOUQyCHohC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmP2j8pdS+k4/lXflBhq7260k1PvCPFvs4X9LFUveNQN1EMdKks7zdMpHHbg/rAjO
         Fmr+kyEWkLGJlOt14ThOnJcV2yYQZX4zESDgCDYxSByYYJk+9sDmg4+/jjjcifzkay
         2yHMigCQMayEo73HXFtIuBVZWSYTFUjGuPKNv3No=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 634A26130F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 4/5] remoteproc: qcom: q6v5-mss: Add custom dump function for modem
Date:   Wed, 17 Oct 2018 19:25:26 +0530
Message-Id: <20181017135527.30592-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017135527.30592-1-sibis@codeaurora.org>
References: <20181017135527.30592-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per segment dump function is responsible for loading the mba
before device memory segments associated with coredump can be populated
and for cleaning up the resources post coredump.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 87d7f4d0c176..0d3b9d70823e 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -168,6 +168,9 @@ struct q6v5 {
 	bool running;
 
 	bool dump_mba_loaded;
+	unsigned long dump_segment_mask;
+	unsigned long dump_complete_mask;
+
 	phys_addr_t mba_phys;
 	void *mba_region;
 	size_t mba_size;
@@ -961,6 +964,33 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	return ret < 0 ? ret : 0;
 }
 
+static void qcom_q6v5_dump_segment(struct rproc *rproc,
+				   struct rproc_dump_segment *segment,
+				   void *dest)
+{
+	int ret = 0;
+	struct q6v5 *qproc = rproc->priv;
+	unsigned long mask = BIT((unsigned long)segment->priv);
+	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+
+	/* Unlock mba before copying segments */
+	if (!qproc->dump_mba_loaded)
+		ret = q6v5_mba_load(qproc);
+
+	if (!ptr || ret)
+		memset(dest, 0xff, segment->size);
+	else
+		memcpy(dest, ptr, segment->size);
+
+	qproc->dump_segment_mask |= mask;
+
+	/* Reclaim mba after copying segments */
+	if (qproc->dump_segment_mask == qproc->dump_complete_mask) {
+		if (qproc->dump_mba_loaded)
+			q6v5_mba_reclaim(qproc);
+	}
+}
+
 static int q6v5_start(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
@@ -989,6 +1019,9 @@ static int q6v5_start(struct rproc *rproc)
 	if (xfermemop_ret)
 		dev_err(qproc->dev,
 			"Failed to reclaim mba buffer system may become unstable\n");
+
+	/* Reset Dump Segment Mask */
+	qproc->dump_segment_mask = 0;
 	qproc->running = true;
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

