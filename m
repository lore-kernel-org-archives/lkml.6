Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D8C64E96
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828662087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U0D5ccPg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U0D5ccPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828662087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeI2S3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:29:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeI2S3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:29:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E722760B7F; Sat, 29 Sep 2018 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222457;
        bh=F1MtYhnXdGfQ6iKMBLdLmFe2T2EZmwMzIVbji0LHeX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0D5ccPgao1aPF2DXyOB175RnLporFlG+/5jAFf6E13JqxsZ8zXmkXXkUD+coHeGs
         mxNmvLDML2pmUrhPD1MnHugSZO5jaa/ZZnSSdriKB/dr1hesBlgq/JTwvc6uxXmYdO
         OvELIJWx/iZ51FA2YYyTqEgFA2SrpBw6fKIsf0FI=
Received: from sgorle-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sgorle@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D21460C4F;
        Sat, 29 Sep 2018 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222457;
        bh=F1MtYhnXdGfQ6iKMBLdLmFe2T2EZmwMzIVbji0LHeX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0D5ccPgao1aPF2DXyOB175RnLporFlG+/5jAFf6E13JqxsZ8zXmkXXkUD+coHeGs
         mxNmvLDML2pmUrhPD1MnHugSZO5jaa/ZZnSSdriKB/dr1hesBlgq/JTwvc6uxXmYdO
         OvELIJWx/iZ51FA2YYyTqEgFA2SrpBw6fKIsf0FI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D21460C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgorle@codeaurora.org
From:   Srinu Gorle <sgorle@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sgorle@codeaurora.org
Cc:     acourbot@chromium.org, vgarodia@codeaurora.org
Subject: [PATCH v1 3/5] media: venus: do not destroy video session during queue setup
Date:   Sat, 29 Sep 2018 17:30:30 +0530
Message-Id: <1538222432-25894-4-git-send-email-sgorle@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- open and close video sessions for plane properties is incorrect.
- add check to ensure, same instance persist from driver open to close.

Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
---
 drivers/media/platform/qcom/venus/hfi.c  | 3 +++
 drivers/media/platform/qcom/venus/vdec.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 36a4784..59c34ba 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -207,6 +207,9 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
 	const struct hfi_ops *ops = core->ops;
 	int ret;
 
+	if (inst->state >= INST_INIT && inst->state < INST_STOP)
+		return 0;
+
 	inst->hfi_codec = to_codec_type(pixfmt);
 	reinit_completion(&inst->done);
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index afe3b36..0035cf2 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -700,6 +700,8 @@ static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
 
 	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
 
+	return 0;
+
 deinit:
 	hfi_session_deinit(inst);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

