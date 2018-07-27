Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5662208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G5RWflH9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G5RWflH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5662208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbeG0QoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:44:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbeG0Qn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:43:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE9C960B83; Fri, 27 Jul 2018 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704896;
        bh=z9AXPBQQWRivJrxXKe2Idv9ECGtSqlnLhLGztoHwNPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5RWflH9xmmaDlBRnTVq6WB3jGpj09x1KILCdplBRH1BEgfvNsfgxuycIx/Opnwg9
         ILyTAw1FrH9XBS1JPAriFJr8AV6eXcOxGhDwK9VhSRCygJGB+MyqlF+Lr5mDW23xd4
         bVvhMzEkxo0FRQAzwae2X5cROlDADZ65b5cwklB4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE09E60B11;
        Fri, 27 Jul 2018 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532704896;
        bh=z9AXPBQQWRivJrxXKe2Idv9ECGtSqlnLhLGztoHwNPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5RWflH9xmmaDlBRnTVq6WB3jGpj09x1KILCdplBRH1BEgfvNsfgxuycIx/Opnwg9
         ILyTAw1FrH9XBS1JPAriFJr8AV6eXcOxGhDwK9VhSRCygJGB+MyqlF+Lr5mDW23xd4
         bVvhMzEkxo0FRQAzwae2X5cROlDADZ65b5cwklB4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE09E60B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 6/6] remoteproc: qcom: q6v5-pil: Assign the relocated address
Date:   Fri, 27 Jul 2018 20:50:03 +0530
Message-Id: <20180727152003.11663-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180727152003.11663-1-sibis@codeaurora.org>
References: <20180727152003.11663-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the relocated base of the modem image, as the offsets
from the virtual memory might not be based on the physical
address.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 22bb049c3e7f..b1296d614b8b 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -862,6 +862,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
+	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &phdrs[i];
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

