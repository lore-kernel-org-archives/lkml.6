Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0FD208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="okUjbF9b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="okUjbF9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0FD208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeG0Qn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:43:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbeG0Qn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C078F60B81; Fri, 27 Jul 2018 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704892;
        bh=jmvOYhAM99oDfrUOYVrn3B7+tmkxBw4h+TdgSkaaj7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okUjbF9bHh9nMuny8Q/I/GItpbaU+bJ5CLltQ0QVSmHcQULGDs8b7A0Lisy0OwZ0c
         LPkEaKITU4uHU15UaTe8SGW6b3u4AUr3cDRJ9BfYVijdUml4kyn3TkKzP4AbxteA1J
         /1XbSOR5kzSLBPhhVwS41iW3GUMSJADFRgJDpOYU=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A17C560B7E;
        Fri, 27 Jul 2018 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704892;
        bh=jmvOYhAM99oDfrUOYVrn3B7+tmkxBw4h+TdgSkaaj7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okUjbF9bHh9nMuny8Q/I/GItpbaU+bJ5CLltQ0QVSmHcQULGDs8b7A0Lisy0OwZ0c
         LPkEaKITU4uHU15UaTe8SGW6b3u4AUr3cDRJ9BfYVijdUml4kyn3TkKzP4AbxteA1J
         /1XbSOR5kzSLBPhhVwS41iW3GUMSJADFRgJDpOYU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A17C560B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 5/6] remoteproc: qcom: q6v5-pil: Register segments/dumpfn for coredump
Date:   Fri, 27 Jul 2018 20:50:02 +0530
Message-Id: <20180727152003.11663-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the MDT segments and custom dumpfn with the remoteproc core
dump functionality.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index ac3342f9ea5a..22bb049c3e7f 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1058,10 +1058,50 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
 	return qproc->mpss_region + offset;
 }
 
+static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
+				const struct firmware *fw_unused)
+{
+	const struct firmware *fw;
+	const struct elf32_phdr *phdrs;
+	const struct elf32_phdr *phdr;
+	const struct elf32_hdr *ehdr;
+	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	int ret;
+	int i;
+
+	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	if (ret < 0) {
+		dev_err(qproc->dev, "unable to load modem.mdt\n");
+		return ret;
+	}
+
+	qproc->valid_mask = 0;
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		if (!q6v5_phdr_valid(phdr))
+			continue;
+
+		ret = rproc_coredump_add_custom_segment(rproc, phdr->p_paddr,
+					phdr->p_memsz, qcom_q6v5_dump_segment);
+		if (ret)
+			break;
+
+		qproc->valid_mask++;
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

