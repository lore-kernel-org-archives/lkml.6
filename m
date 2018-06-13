Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1A1EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AFB208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPGRaIpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AFB208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936066AbeFMPNP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:13:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41195 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936048AbeFMPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so3123865wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87ORcY69pnhjHzwy3ZGqBtyUOPwoa/Ckei7U+5Elc6I=;
        b=OPGRaIpf+/sYt2380waJ5LQ41bf3I1BZm5nsCVakxqQZJjQE4xFvTTTIa0DLdp+Wwa
         jZcsXJYP4ym6QvbiO5xqeXiJSV/zYMPAIfrNvSzavIORxbl4VIxCcQgsBfVRS0Mcu0O5
         vhgMVbtB0DrIF9b8uafC748X+ZZmBHvi1x13E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87ORcY69pnhjHzwy3ZGqBtyUOPwoa/Ckei7U+5Elc6I=;
        b=q336qdjjH/qo9Q4ypuvHPKetAXLl7yfl4orpVH6ywcLC+mxaD4E7BJwmJBXnbA+Zpb
         EuCrBj2JlHAM2fv137jLNt3UIlMEafmOU6vdoQAOFmJIf09bOZkRKKxa64Gx7ZwYr7eo
         0603+M8EeqGZXBKTpWIxNvWeGSMNcKHys0lZeCnPmrzUix5jAm1qOPcGDl/vHde0odDF
         fw2rWVhvU/OI2boquhy/IfwiCjpO2ZW0WSOORDQd5wDv3cBVxOVidP9P6SiqfX8PmCmg
         ESzFrjPOg+Ozu+9dlu69vpB3kvKtiS+89E8xSHa8eJlBnVLKyCpHC0n40kGqgGmxgx1/
         /Vsg==
X-Gm-Message-State: APt69E3yLdwKPIVf3XPViSm7jaA/FqRL84Zkjyt+h6U0u93OwkWr+ut4
        6c6Sijo7bZi/Hvr+jVeuUn3rWQ==
X-Google-Smtp-Source: ADUXVKLx7cXSmnciTwyXQ9ijMgs2oEfxNMTD2gS03dGe2V3B5/qUua8ZOl6ijg9XbccsXWfMwkhakQ==
X-Received: by 2002:adf:a645:: with SMTP id k63-v6mr4762953wrc.231.1528902572269;
        Wed, 13 Jun 2018 08:09:32 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:31 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 17/27] venus: helpers: add buffer type argument to a helper
Date:   Wed, 13 Jun 2018 18:07:51 +0300
Message-Id: <20180613150801.11702-18-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds one more function argument to pass buffer type to
set_output_resolution() helper function. That is a preparation
to support secondary decoder output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 5 +++--
 drivers/media/platform/qcom/venus/helpers.h | 3 ++-
 drivers/media/platform/qcom/venus/venc.c    | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 0cce664f093d..2eeb243e4dbe 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -453,12 +453,13 @@ int venus_helper_set_input_resolution(struct venus_inst *inst,
 EXPORT_SYMBOL_GPL(venus_helper_set_input_resolution);
 
 int venus_helper_set_output_resolution(struct venus_inst *inst,
-				       unsigned int width, unsigned int height)
+				       unsigned int width, unsigned int height,
+				       u32 buftype)
 {
 	u32 ptype = HFI_PROPERTY_PARAM_FRAME_SIZE;
 	struct hfi_framesize fs;
 
-	fs.buffer_type = HFI_BUFFER_OUTPUT;
+	fs.buffer_type = buftype;
 	fs.width = width;
 	fs.height = height;
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index cd306bd8978f..0de9989adcdb 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -36,7 +36,8 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 int venus_helper_set_input_resolution(struct venus_inst *inst,
 				      unsigned int width, unsigned int height);
 int venus_helper_set_output_resolution(struct venus_inst *inst,
-				       unsigned int width, unsigned int height);
+				       unsigned int width, unsigned int height,
+				       u32 buftype);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index aa6b0026d79d..1d7f87e0f5b3 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -795,7 +795,8 @@ static int venc_init_session(struct venus_inst *inst)
 		goto deinit;
 
 	ret = venus_helper_set_output_resolution(inst, inst->width,
-						 inst->height);
+						 inst->height,
+						 HFI_BUFFER_OUTPUT);
 	if (ret)
 		goto deinit;
 
-- 
2.14.1

