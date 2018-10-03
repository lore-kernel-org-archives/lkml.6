Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6B20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kyzoIEUx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kyzoIEUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD6B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJCS0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:26:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeJCS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:26:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9742860C64; Wed,  3 Oct 2018 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566713;
        bh=8c9+qWAyiMYN0k8HfwddS62SwsXVqGMuh8Smfy3ceoM=;
        h=From:To:Cc:Subject:Date:From;
        b=kyzoIEUx1DQ6Up2bpwHG4iZS2d0GLEQITZ30xZV13YTPhpA/MGic8piiRx1UKX8+J
         zHnhRXNVZ/HYZAAL7RjoDO/P0AC2VRQdgWVnVZn7tPFRnVAKyhSZNMs4Fp7QVdVmxn
         Rd0mJxjDgqdE1LWmhhZSEh/740XB/7iizpJVRk94=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BACD607BD;
        Wed,  3 Oct 2018 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566713;
        bh=8c9+qWAyiMYN0k8HfwddS62SwsXVqGMuh8Smfy3ceoM=;
        h=From:To:Cc:Subject:Date:From;
        b=kyzoIEUx1DQ6Up2bpwHG4iZS2d0GLEQITZ30xZV13YTPhpA/MGic8piiRx1UKX8+J
         zHnhRXNVZ/HYZAAL7RjoDO/P0AC2VRQdgWVnVZn7tPFRnVAKyhSZNMs4Fp7QVdVmxn
         Rd0mJxjDgqdE1LWmhhZSEh/740XB/7iizpJVRk94=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BACD607BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH] rpmsg: glink: smem: Support rx peak for size less than 4 bytes
Date:   Wed,  3 Oct 2018 17:08:20 +0530
Message-Id: <1538566700-29469-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rx peak function fails to read the data if size is
less than 4bytes.

Use memcpy_fromio to support data reads of size less than 4 bytes.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_smem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 2b5cf27..7b65443 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -89,15 +89,11 @@ static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
 		tail -= pipe->native.length;
 
 	len = min_t(size_t, count, pipe->native.length - tail);
-	if (len) {
-		__ioread32_copy(data, pipe->fifo + tail,
-				len / sizeof(u32));
-	}
+	if (len)
+		memcpy_fromio(data, pipe->fifo + tail, len);
 
-	if (len != count) {
-		__ioread32_copy(data + len, pipe->fifo,
-				(count - len) / sizeof(u32));
-	}
+	if (len != count)
+		memcpy_fromio(data + len, pipe->fifo, (count - len));
 }
 
 static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

