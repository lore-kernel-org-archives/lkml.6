Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AD220835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o2k91CjD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VuKB8p0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AD220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCSSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:18:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:18:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0670F607BD; Wed,  3 Oct 2018 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566238;
        bh=kcINhkcUfuzC1LCmMOCUFvDVNU6dzcolKIXuKvfbxi8=;
        h=From:To:Cc:Subject:Date:From;
        b=o2k91CjD0ojgejpAsuacmNCmPDZV/Mp/OHzs3UeqlsX3S4Gp8yxnKcHTBL3CsXDRa
         kcFXcR5WXaGgqQNKlIUWK26RqH0drLpmEG6vSjstSFSN0QFGDX2Ie9fTKGq1nC/vjQ
         4FlsalgRNQidtusuWX9FIshLkKgFQnknHCnQY0i8=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A627460B26;
        Wed,  3 Oct 2018 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566237;
        bh=kcINhkcUfuzC1LCmMOCUFvDVNU6dzcolKIXuKvfbxi8=;
        h=From:To:Cc:Subject:Date:From;
        b=VuKB8p0CEu7WZjpdEYYkDV7k80Ych0pKouFycCyU3UFlaXDPcWKkhIlhzwpNdr35X
         +mQKTQBYPao8ZZNRZduLAY4jQACAqpjiLiU3Sq2kByHqxmd4APNHLC4jv6e/rqcKb+
         HMaWMzxCtG6g5dUGUppX32CKARWgTTEiOu2vpc9A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A627460B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH] venus: vdec: fix decoded data size
Date:   Wed,  3 Oct 2018 17:00:21 +0530
Message-Id: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exisiting code returns the max of the decoded size and buffer size.
It turns out that buffer size is always greater due to hardware
alignment requirement. As a result, payload size given to client
is incorrect. This change ensures that the bytesused is assigned
to actual payload size, when available.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 991e158..189ec97 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -888,8 +888,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 		unsigned int opb_sz = venus_helper_get_opb_size(inst);
 
 		vb = &vbuf->vb2_buf;
-		vb->planes[0].bytesused =
-			max_t(unsigned int, opb_sz, bytesused);
+		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
 		vb->planes[0].data_offset = data_offset;
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

