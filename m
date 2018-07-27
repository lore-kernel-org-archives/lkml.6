Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0451C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DFB208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hcywg3eZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SLAmOHHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DFB208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbeG0Qny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbeG0Qnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D564560BDE; Fri, 27 Jul 2018 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704889;
        bh=z57x3kTRV2Kfa/bgAAXopQMiUscqL3vNVmmMM9E57Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcywg3eZ+CFnqUpk3LpSIqnACdV0VMFzYOvpJJ5xL4dieBatYYu+1VjKYO2fwsAlz
         LWCAmrJVz3AD8qJl5+L273oG9nz8+ogPRhyo46NSHu6Iw9ptqjVYoM3i8/WD7lcWjI
         jNXVdHlQPJhXyB3akXkuwD3tEfYp6loE60ZJ2cG0=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B96760B19;
        Fri, 27 Jul 2018 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704888;
        bh=z57x3kTRV2Kfa/bgAAXopQMiUscqL3vNVmmMM9E57Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLAmOHHlgdDixtHlOr506QoYq98USVpJwEGFu1yQSEd+Z3ENVShI4zib5yucKOUE4
         3YUZaXIwvlDt5rIbCaXXU33DrFBbntdTg2VrD8xXNURgcOBy2BWupd+8LSQcHqQJrD
         GJ9lRCDqvsWHQK+U5fmwIEOG8f/MuNlUy1gaMbc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B96760B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 4/6] remoteproc: qcom: q6v5-pil: Add custom dump function for modem
Date:   Fri, 27 Jul 2018 20:50:01 +0530
Message-Id: <20180727152003.11663-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per segment dump function is responsible for loading the mba
before device memory segments associated with coredump can be populated
and for cleaning up the resources post coredump.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index eacf9f0bf49e..ac3342f9ea5a 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -182,6 +182,7 @@ struct q6v5 {
 	struct qcom_sysmon *sysmon;
 	bool need_mem_protection;
 	bool has_alt_reset;
+	u32 valid_mask;
 	int mpss_perm;
 	int mba_perm;
 	int version;
@@ -924,6 +925,30 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	return ret < 0 ? ret : 0;
 }
 
+static void qcom_q6v5_dump_segment(struct rproc *rproc, void *ptr, size_t len,
+								   void *priv)
+{
+	int ret = 0;
+	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	static u32 pending_mask;
+
+	/* Unlock mba before copying segments */
+	if (!qproc->mba_loaded)
+		ret = q6v5_mba_load(qproc);
+
+	if (!ptr || ret)
+		memset(priv, 0xff, len);
+	else
+		memcpy(priv, ptr, len);
+
+	pending_mask++;
+	if (pending_mask == qproc->valid_mask) {
+		if (qproc->mba_loaded)
+			q6v5_mba_reclaim(qproc);
+		pending_mask = 0;
+	}
+}
+
 static int q6v5_start(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

