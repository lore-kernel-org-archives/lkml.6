Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C0521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VT3MTbU3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IV/8CfOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C0521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJQVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:52:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeJQVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:52:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3CEE161323; Wed, 17 Oct 2018 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784572;
        bh=+LblrXMLhtDQ9Kdc3zpoX4sqvJus1UMjS5/fDiaXT64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VT3MTbU33k5rppo7Bbg41U9AOPHQ/0NYt/Cm/3B9nO3YVP06uEW4IzQ3fut5GlZ9V
         KjSdbpzaLdP+m2Z1mpMnbi78/FRbVyqNbbriRP/IJ+GeeZoU/INNx6yNCIwvVmiQqC
         EMMtijOBT6SVUycOswFyRwNeanKADPH4+yY5VCWc=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98A9261400;
        Wed, 17 Oct 2018 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539784571;
        bh=+LblrXMLhtDQ9Kdc3zpoX4sqvJus1UMjS5/fDiaXT64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IV/8CfOjzdQeMbL7ub/51AcPjN5bYP2ThGz85hI0iH6ZA80CHilEyBcQTmM0Y3+NH
         bqKXK7x0g9MTvBrDB4ygBiKLmzb6KCG19ON9Pj1oO2LmlOUzx6ZM0FewUPseCMovAP
         2IPfPR0XI25VnLWSBh9A+LxfO44lWobeLl2KZg2E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98A9261400
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 5/5] remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump
Date:   Wed, 17 Oct 2018 19:25:27 +0530
Message-Id: <20181017135527.30592-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017135527.30592-1-sibis@codeaurora.org>
References: <20181017135527.30592-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the MDT segments, custom dumpfn and private data with the
remoteproc core dump functionality.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 0d3b9d70823e..8ceebde75d02 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1064,10 +1064,52 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
 	return qproc->mpss_region + offset;
 }
 
+static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
+				const struct firmware *mba_fw)
+{
+	const struct firmware *fw;
+	const struct elf32_phdr *phdrs;
+	const struct elf32_phdr *phdr;
+	const struct elf32_hdr *ehdr;
+	struct q6v5 *qproc = rproc->priv;
+	unsigned long i;
+	int ret;
+
+	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	if (ret < 0) {
+		dev_err(qproc->dev, "unable to load modem.mdt\n");
+		return ret;
+	}
+
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+	qproc->dump_complete_mask = 0;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		if (!q6v5_phdr_valid(phdr))
+			continue;
+
+		ret = rproc_coredump_add_custom_segment(rproc, phdr->p_paddr,
+							phdr->p_memsz,
+							(void *)i,
+							qcom_q6v5_dump_segment);
+		if (ret)
+			break;
+
+		qproc->dump_complete_mask |= BIT(i);
+	}
+
+	release_firmware(fw);
+	return ret;
+}
+
 static const struct rproc_ops q6v5_ops = {
 	.start = q6v5_start,
 	.stop = q6v5_stop,
 	.da_to_va = q6v5_da_to_va,
+	.parse_fw = qcom_q6v5_register_dump_segments,
 	.load = q6v5_load,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

