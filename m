Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98D7FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbgkykdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF0420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbeFMPNq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:13:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38317 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936045AbeFMPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so3154239wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8FeGnPaIV5EPC/U6dJ9bqO8cVCrprWFMS2h0FyRklic=;
        b=DbgkykdIAU/q2oI+KqvMKILbWsND/5N+3ERdIHtdnXuD6XzymIAn7sUKImayk8I4Da
         jYrLROPWZw48ReRmNPemXqgtyParf4wx3aUPXokZpeGGRYuYwgVeoZxBGrXB3aHMR1R4
         FcWabV65slqNUB8i1qjFKl09JBvhDLZiLm1bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8FeGnPaIV5EPC/U6dJ9bqO8cVCrprWFMS2h0FyRklic=;
        b=aK5nSj6oZAC119It6YyLDFtVBO4/3RjerOB6da+304tY52++Io8T4ZLjx6OVpYcvgY
         pWaCsHxSpdBIB+GcVKbwYaw0K9WV7aMbaHzQdA/AWnFNxJaeyOlc/kuRroLYEEVfIyBc
         Cpa0lBkw9LVHk0r8TBXC8lMnmyk0cWhik6ezUyREevQJhOclfad6oD/oiCc8VU4igrhj
         RkfFjzMxVBCQsLZ6RtUou0/VeT7o4EgdXUaFkt5QLjGK8GwTmSvFlnW0ftHuupTlb9+H
         H1twpT/MSKnQxsnQtFJrn1Wv9U7apB5CfMuMwoKgKuWF1aWPOWje7+CPNDuoR3GPWibP
         /oXQ==
X-Gm-Message-State: APt69E23cOOLi2OENXFgtHe43VFBX3+fSt0kNr5ykP668xoIwmaZzkwF
        IADqzsSfeV4k5Tx2eZ5EQItHvA==
X-Google-Smtp-Source: ADUXVKLkX20GBpAzYIki4TRCBHHeQuDOFjjbs4wfKTyTzJsh56JVzo+FTOxYut9DDs8GJeByvu+2hg==
X-Received: by 2002:adf:965a:: with SMTP id c26-v6mr4525172wra.197.1528902571177;
        Wed, 13 Jun 2018 08:09:31 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:30 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 16/27] venus: core: delete not used buffer mode flags
Date:   Wed, 13 Jun 2018 18:07:50 +0300
Message-Id: <20180613150801.11702-17-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete not used flag for capture buffer allocation mode and
no longer used cap_bufs_mode_dynamic from instance structure.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h       | 4 ----
 drivers/media/platform/qcom/venus/hfi_parser.c | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

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
index e8e41811db80..c4ad50f992b0 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -73,13 +73,9 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
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
-- 
2.14.1

