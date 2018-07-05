Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D236C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1824137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9VD4fRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B1824137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbeGENMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:12:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36652 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbeGENFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so10733518wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3i8BckNk5AMxsFObk6sMQ2N4Vr3Tdy+vGDFQyGUXeZU=;
        b=G9VD4fRSgCR80eTzzW6fpSDt93wNTPBC3e0s5RsP7jgFooQXq9+g6TfnyaQfGGsh3M
         ++seMqYU6Piy38xXED9y9k9seeSGyRhcNUshc9B7JR2A5LaHq/oXrfgOtj6ycuVGpz9F
         IWejZK5y3eyLwFMMFFmClzAQThiLoyo18JZYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3i8BckNk5AMxsFObk6sMQ2N4Vr3Tdy+vGDFQyGUXeZU=;
        b=K8mdqxhNcHTdB7ktswFAgaDkExqSF3/6zyjlDlm7uSb3lY9IBvn5qqrz4toW2MJcSK
         T0oUE0xU0g2jc0poGk+hheF/SxcYimP4TGORTm79x7n7fAIAs4Q847PU5StRYTbcEAB4
         L3+UL4SeUBk1OIn47qjOhHLOtd6Z+v6D4MZnmhpYzuHSYk51BuCv0RQtUPSpOQd/jfeP
         LcKXjzQ3MFedCHqeZcw/kEmzLFvnoG6ghtYrxrhnavtW0tHJj6Ww5GQ2pmf2+BlY0Z+t
         CGVsPOzKTU865nOL4TCDnZaJ5wOqiIIa28Tv+2Ebw6oFe04/SwUq1pSGlaPVHTZ8FcV+
         hNuA==
X-Gm-Message-State: APt69E2n2ODWKqlyQvQV5/ecuEPZ1q8cNBGDOm8gXbFXUpXnAS1sHBgb
        B8wjclEogeVYLSXEi2R+xHvDPA==
X-Google-Smtp-Source: AAOMgpe0eNYSuGBcTD08aj5xLcHWcYdgCqqUj9HB4M/Tpea1WChzIY45cjkzz1O632riU+/m03mE7Q==
X-Received: by 2002:adf:a49a:: with SMTP id g26-v6mr4681005wrb.91.1530795921265;
        Thu, 05 Jul 2018 06:05:21 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:20 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 13/27] venus: helpers: rename a helper function and use buffer mode from caps
Date:   Thu,  5 Jul 2018 16:03:47 +0300
Message-Id: <20180705130401.24315-14-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename is_reg_unreg_needed() to better name is_dynamic_bufmode() and
use buffer mode from enumerated per codec capabilities.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index c8c4a4be78e3..27c4a4060c4e 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -359,18 +359,16 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	return 0;
 }
 
-static inline int is_reg_unreg_needed(struct venus_inst *inst)
+static bool is_dynamic_bufmode(struct venus_inst *inst)
 {
-	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
-	    inst->core->res->hfi_version == HFI_VERSION_3XX)
-		return 0;
+	struct venus_core *core = inst->core;
+	struct venus_caps *caps;
 
-	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
-	    inst->cap_bufs_mode_dynamic &&
-	    inst->core->res->hfi_version == HFI_VERSION_1XX)
+	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
+	if (!caps)
 		return 0;
 
-	return 1;
+	return caps->cap_bufs_mode_dynamic;
 }
 
 static int session_unregister_bufs(struct venus_inst *inst)
@@ -379,7 +377,7 @@ static int session_unregister_bufs(struct venus_inst *inst)
 	struct hfi_buffer_desc bd;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry_safe(buf, n, &inst->registeredbufs, reg_list) {
@@ -399,7 +397,7 @@ static int session_register_bufs(struct venus_inst *inst)
 	struct venus_buffer *buf;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry(buf, &inst->registeredbufs, reg_list) {
-- 
2.14.1

