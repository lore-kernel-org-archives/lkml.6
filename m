Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6E214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gKF671hk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V79p8rxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6E214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJIXmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJIXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB3B860B7A; Tue,  9 Oct 2018 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102262;
        bh=GebfFgA5Jw4id9n0VL+ATVp4DBrrFQQM1cn3khFevwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKF671hkqruUO5yxVRJ/QJzImzhN/kEgi2ryDlcrLTn9rE/7OhVmfPqUvYhu84LW1
         EtVnE3QrScKDEgRygXbwwq4kURYOjWKB8wbJNFfGkW0r5Ejj0ybNOAOxyI/P5d1j2E
         y/rUXgMJuzZk+mEIyWmD1PeANC4eG0W1S76+WvGU=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 218EA60388;
        Tue,  9 Oct 2018 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539102260;
        bh=GebfFgA5Jw4id9n0VL+ATVp4DBrrFQQM1cn3khFevwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V79p8rxUCLwbhKkpyhfWBs15QA1QYKazx1OpHqgJUtbUqbHgB0GiD06xsnLeB6RlB
         TeAmpZ9sQzGUdPoJY+7fHkpcJSLnnvwXskpTS6Gv3k69d2uLCLl6mGIL9J2mZmNCYY
         g1qRlq0QwQZmYBNdgQFYYwYMOKT+v1FhcGAZu8z4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 218EA60388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        kyan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 5/5] remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump
Date:   Tue,  9 Oct 2018 21:53:39 +0530
Message-Id: <20181009162339.30522-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009162339.30522-1-sibis@codeaurora.org>
References: <20181009162339.30522-1-sibis@codeaurora.org>
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
 drivers/remoteproc/qcom_q6v5_mss.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 85db95bfd355..bece5dd46bca 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1065,10 +1065,53 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
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
+	unsigned long segment_cnt = 0;
+	int ret;
+	int i;
+
+	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	if (ret < 0) {
+		dev_err(qproc->dev, "unable to load modem.mdt\n");
+		return ret;
+	}
+
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
+							phdr->p_memsz,
+							(void *)segment_cnt,
+							qcom_q6v5_dump_segment);
+		if (ret)
+			break;
+
+		segment_cnt++;
+	}
+
+	qproc->dump_segment_cnt = segment_cnt;
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

