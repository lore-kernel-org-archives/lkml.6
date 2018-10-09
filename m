Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F1ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394422075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SooAi2cm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U8qZBhsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394422075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJIXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A354260BFE; Tue,  9 Oct 2018 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102256;
        bh=1dWltLmwe91CUTM1imxRwZso22fsSkOvozL34JHvkSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SooAi2cm2p7hZ7Dvu+8w055o/iieaJUXg0ThCwLPoTnojWtsKJ3UOta3A31U9D1LK
         36TcuiY2yk2olx6dVouaQmx4cZylzEIfPXSC3BgOwXIXlgsV/35jYzcVMpuelnHXvy
         hsvpF/nk7cxZsgi8kvTuteNYr4eO6aOaXFXxjhGY=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93A1860C67;
        Tue,  9 Oct 2018 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102255;
        bh=1dWltLmwe91CUTM1imxRwZso22fsSkOvozL34JHvkSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8qZBhsF3k0rQlW8XZooHFPALokhOhPwf7E4DoDxurAztdg0sJkEaoNC3rUcPLBJc
         AXcKt2/DP4e3BtcijdmDjY8nOBTcvppxJpWJN9dmRshpF+2lHnAIK+fBWbdqDZPYfc
         mpB/WVKqcroESHu+L3BiXRdvzE/MfbSgwEXJNWUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93A1860C67
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 4/5] remoteproc: qcom: q6v5-mss: Add custom dump function for modem
Date:   Tue,  9 Oct 2018 21:53:38 +0530
Message-Id: <20181009162339.30522-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009162339.30522-1-sibis@codeaurora.org>
References: <20181009162339.30522-1-sibis@codeaurora.org>
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
 drivers/remoteproc/qcom_q6v5_mss.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c475af65ba1d..85db95bfd355 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -182,6 +182,7 @@ struct q6v5 {
 	struct qcom_sysmon *sysmon;
 	bool need_mem_protection;
 	bool has_alt_reset;
+	unsigned long dump_segment_cnt;
 	int mpss_perm;
 	int mba_perm;
 	int version;
@@ -932,6 +933,30 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	return ret < 0 ? ret : 0;
 }
 
+static void qcom_q6v5_dump_segment(struct rproc *rproc,
+				   struct rproc_dump_segment *segment,
+				   void *dest)
+{
+	int ret = 0;
+	struct q6v5 *qproc = rproc->priv;
+	unsigned long dump_cnt = (unsigned long)segment->priv;
+	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+
+	/* Unlock mba before copying segments */
+	if (!dump_cnt)
+		ret = q6v5_mba_load(qproc);
+
+	if (!ptr || ret)
+		memset(dest, 0xff, segment->size);
+	else
+		memcpy(dest, ptr, segment->size);
+
+	dump_cnt++;
+	/* Reclaim mba after copying segments */
+	if (dump_cnt == qproc->dump_segment_cnt)
+		q6v5_mba_reclaim(qproc);
+}
+
 static int q6v5_start(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

