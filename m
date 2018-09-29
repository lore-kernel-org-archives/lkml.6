Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA9C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ACA2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PCQdV3Uv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IdKP9Au9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ACA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeI2S3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:29:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeI2S3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:29:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3293160C4F; Sat, 29 Sep 2018 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222462;
        bh=lCfy+UF0ywb1ADOv4ZALgAaUmL0UY/E/F7ZjJErnBks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCQdV3Uv8PtTmqLKGT64kownTwOj6qU6trKJXjWkoVhPUlG/EA3oqxwrhQtxloqFh
         rfKtfABHw6RHLcRrccJQufcV5wXTL+omldqWD0rlJoe2yhDIGIbeiy+48yzeuWTng4
         0Dw7Kz/HfVWVxL3YMIpDkqFHv2VMTlhRQeo8M0ZQ=
Received: from sgorle-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sgorle@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0DC760C4B;
        Sat, 29 Sep 2018 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538222460;
        bh=lCfy+UF0ywb1ADOv4ZALgAaUmL0UY/E/F7ZjJErnBks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdKP9Au9WZ33DZWnJ7KCULSv/KWjMT7O0LmfqlFa/Q1I33hz/FuvOEZ4OvlvnGlhK
         h7m0e6r3YS9+RTkqpSubiB477w8jcqgbAokhO4KKbhF8UosAqnBRdAmd3Y+8vUY6kH
         sfxE2ln6B/gEkJN1MAP0+sWIl+bF/esUHXFmDjBU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0DC760C4B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sgorle@codeaurora.org
From:   Srinu Gorle <sgorle@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sgorle@codeaurora.org
Cc:     acourbot@chromium.org, vgarodia@codeaurora.org
Subject: [PATCH v1 4/5] media: venus: video decoder drop frames handling
Date:   Sat, 29 Sep 2018 17:30:31 +0530
Message-Id: <1538222432-25894-5-git-send-email-sgorle@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- when drop frame flag received from venus h/w, reset buffer
  parameters and update v4l2 buffer flags as error buffer.

Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 0035cf2..311f209 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -991,6 +991,12 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 	if (hfi_flags & HFI_BUFFERFLAG_DATACORRUPT)
 		state = VB2_BUF_STATE_ERROR;
 
+	if (hfi_flags & HFI_BUFFERFLAG_DROP_FRAME) {
+		vb->planes[0].bytesused = 0;
+		vb->timestamp = 0;
+		state = VB2_BUF_STATE_ERROR;
+	}
+
 	v4l2_m2m_buf_done(vbuf, state);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

