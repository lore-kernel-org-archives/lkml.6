Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316DB22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQADcyQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316DB22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeKMT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:28:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38556 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbeKMT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:28:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so5417179pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPwmqQYNP9eqvMbepbeCIftdcUUAvxdfCAU5vJtMY5o=;
        b=DQADcyQ05kkYk3zKhC3GDamjEQ0RgANb13f0NLbfkyTvNUqjY7zqcloMCeS99N2+D5
         gHIQUn1cJZPNIe00G4o3cuTrB4yPHuEcMGD6e0ZdUWzX1r5Hd2s9w3Rd9kWYHuHlxLKS
         tPwFT6wN1rsd6I8b3G9+oydcRADN8ZQNuqOIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPwmqQYNP9eqvMbepbeCIftdcUUAvxdfCAU5vJtMY5o=;
        b=t22ZxIgwAIjVJbPNSycizoL8fG0blQV05Ou/WzRHDGcqo2AGMbiZAmHuLUlhc3CHWU
         Sn4SivZPg1Y367YPe93WPU/MbBB+MOxyNTCmT65yyEx8pxzz6tN5PkIQ6sG7AftbAupD
         xwOgFTLAbePffYHYzRI8YOtuCD1M0rDyWoSZRXYOYrzgKvDho0fiok8rCnii+whIULLA
         9KbpnbBGy0PW/LTpLble+YKAKUqHMvCJR6Usi0LN0zKiz4mxMhEnVB7sQLAM2eS7Byb2
         RVo+qx48yQrJx30G8AzAGiOmzwW7EVaLdRJDzQTT9urRJdHxDxoolxQjWvKiS5p4o2d+
         FYOw==
X-Gm-Message-State: AGRZ1gL3tG7vp5pgfEL2feaxEMDAP/Fg01gZhzyQv/nl02M1+crCMQLB
        jpC/qxlLcxIKcLyiwJbuLAhiOQ==
X-Google-Smtp-Source: AJdET5d6jKYZ4+U6+0cr5wnHFmdGdqPz7mowjQUhS4NMd1trt+pQvmF/QGwdEiEAxFgfnwtDjPqQuw==
X-Received: by 2002:a63:8043:: with SMTP id j64mr4109676pgd.405.1542101454407;
        Tue, 13 Nov 2018 01:30:54 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id k14sm20613216pgs.52.2018.11.13.01.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 01:30:53 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: venus: fix reported size of 0-length buffers
Date:   Tue, 13 Nov 2018 18:30:48 +0900
Message-Id: <20181113093048.236201-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last buffer is often signaled by an empty buffer with the
V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
bytesused field set to the full size of the OPB, which leads
user-space to believe that the buffer actually contains useful data. Fix
this by passing the number of bytes reported used by the firmware.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 189ec975c6bb..282de21cf2e1 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -885,10 +885,8 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 	vbuf->field = V4L2_FIELD_NONE;
 
 	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-		unsigned int opb_sz = venus_helper_get_opb_size(inst);
-
 		vb = &vbuf->vb2_buf;
-		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
+		vb2_set_plane_payload(vb, 0, bytesused);
 		vb->planes[0].data_offset = data_offset;
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
-- 
2.19.1.930.g4563a0d9d0-goog

