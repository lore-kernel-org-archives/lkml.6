Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C1124137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBVRGtF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C1124137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeGENJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53192 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeGENFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so10969739wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQvgz0he50LgDF6W19hQpoXcaRIIqvIGjdBolqGqtak=;
        b=aBVRGtF7chvAjFUuH4DJM+9T9BSUp4mwafrIU3ALbgzmIAB6H3ZT9YsZ8yIWXVsJZc
         U4NdSrXUnq5lW0n4IWk4N474qVIYcU6eqwr4YrlfRFt4HE+jCfs6ozAeeFQQ8rvry7lK
         Mb9D2izWO8I2T3p6qXC/rAF00jFgAfh6x9Jgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQvgz0he50LgDF6W19hQpoXcaRIIqvIGjdBolqGqtak=;
        b=IOzoerkjVwVfO1CffGbjmPpObp529m9rVDCbbefNj8/7Wjp8zarGR0hiJrasnzUfLx
         u1aaCThbZGEQQdeIDeA9RUhhrjC/ogM+dZboTdWhCrnmhQ9DYpT5OBvpsk2UBPVgTQPU
         4wkBNZKVtiXUvqd2KyUSQ6vxFC3glY9630xfU3LaRS63XtIS1rqVso8H1b0ZBVe8YlZI
         I9tbflo9o08+ip4Q3hrcodQmNrTjYFPUQgY4yH75sFj2kMq8cOeXrtiC5JsLJxMyqiRn
         C2lv8efHmvY5h4/Qpfw+62f5c1MRbv3KRMh8rR6la/5W1Rg3S8WKhha17GNVV+FD3J+m
         bMHQ==
X-Gm-Message-State: APt69E2xviihEvvA+nde5hOLbOF2XGu7wBPbptCMsw+EK/UhD4UGH0RA
        SHxjoBmKRMR2IIYyMCdj/s/TOw==
X-Google-Smtp-Source: AAOMgpfmd1voAABLCW3meOU5njU4bQuO2HrUGLcMBsQslbFsG+WY/cvqDCBwxzDPGT4/KaP/5Cxh1Q==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr4118435wmh.112.1530795924608;
        Thu, 05 Jul 2018 06:05:24 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:24 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 16/27] venus: core: delete not used buffer mode flags
Date:   Thu,  5 Jul 2018 16:03:50 +0300
Message-Id: <20180705130401.24315-17-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete not used flag for capture buffer allocation mode and
no longer used cap_bufs_mode_dynamic from instance structure.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h       |  4 ----
 drivers/media/platform/qcom/venus/hfi_parser.c | 11 +++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index b995d1601c87..1d1a59a5d343 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -255,8 +255,6 @@ struct venus_buffer {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
- * @cap_bufs_mode_static:	buffers allocation mode capability
- * @cap_bufs_mode_dynamic:	buffers allocation mode capability
  */
 struct venus_inst {
 	struct list_head list;
@@ -305,8 +303,6 @@ struct venus_inst {
 	const struct hfi_inst_ops *ops;
 	u32 session_type;
 	union hfi_get_property hprop;
-	bool cap_bufs_mode_static;
-	bool cap_bufs_mode_dynamic;
 };
 
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index afc0db3b5dc3..2293d936e49c 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -60,8 +60,7 @@ fill_buf_mode(struct venus_caps *cap, const void *data, unsigned int num)
 }
 
 static void
-parse_alloc_mode(struct venus_core *core, struct venus_inst *inst, u32 codecs,
-		 u32 domain, void *data)
+parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
 	u32 num_entries = mode->num_entries;
@@ -74,13 +73,9 @@ parse_alloc_mode(struct venus_core *core, struct venus_inst *inst, u32 codecs,
 
 	while (num_entries--) {
 		if (mode->buffer_type == HFI_BUFFER_OUTPUT ||
-		    mode->buffer_type == HFI_BUFFER_OUTPUT2) {
-			if (*type == HFI_BUFFER_MODE_DYNAMIC && inst)
-				inst->cap_bufs_mode_dynamic = true;
-
+		    mode->buffer_type == HFI_BUFFER_OUTPUT2)
 			for_each_codec(core->caps, ARRAY_SIZE(core->caps),
 				       codecs, domain, fill_buf_mode, type, 1);
-		}
 
 		type++;
 	}
@@ -267,7 +262,7 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 			parse_profile_level(core, codecs, domain, data);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, inst, codecs, domain, data);
+			parse_alloc_mode(core, codecs, domain, data);
 			break;
 		default:
 			break;
-- 
2.14.1

