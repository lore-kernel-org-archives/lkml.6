Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4062083F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkdE1Qsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4062083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeF0PdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:33:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34146 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934844AbeF0P2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so2487273wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpg/OEO6kmuXcfyGgT7M54n6/6j/1UYfIVpGWyjDnSc=;
        b=MkdE1QsjTmOmf+d/s1S21lCHKClpD/AcqM70krJNgJddYgavMPkqFNgHJfKBeEG7o8
         faAElo9RcrU6hHjp/6tkNjw3ntrw+S/Um2o1l4fxuSGfWD9SuHl7B5SjRlFnQmbLGJDO
         WSQcvR8B1tvL+lFFyuZuORzci9Y74y/PYTeYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpg/OEO6kmuXcfyGgT7M54n6/6j/1UYfIVpGWyjDnSc=;
        b=InA8IcOeJqBDX6K5P4FI6iQlx/s6jUtJQifW19JlCvCf++Chf2C4jtWIvT9ekExPYv
         vo89av3cVDC4UZ4tPxRFUihkQQAfn3N3Dka38qa9UGZHs5YiCU627VuHbbouCx8tmXHw
         J9DoU9OWrEcFDK0QM+O/ZVPCMRo0snCA9VE++dveR/ApS67BNw8BmUfnrePH9SYgMf4U
         araIOm+QWQGz1Tg56OOSBSI7EYY7QA66UGLqNTt5WwUnFvDllhKGVONh7R6CD32YCpgo
         jtNcVonqUQsvlgFlOrmOXMDbuhNcgZzIIEYhOb7cll5sZXvXpzOHfIhHps2FXruImZ/0
         ICxQ==
X-Gm-Message-State: APt69E0KdRmdJtV86HScELxArQZ+zUKAdUy1KlkhElnlNJJfQB3uUetL
        cVATYD4eyMEqR446sJWdME12bg==
X-Google-Smtp-Source: AAOMgpc71JneHdQ5N70WrU1Bsi/DyRxiwoea1r7cHVT6xiA8xDuUkmsWPjYCOMl5roRBdY2RKzZemA==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr3463885wrb.193.1530113293515;
        Wed, 27 Jun 2018 08:28:13 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:12 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 13/27] venus: helpers: rename a helper function and use buffer mode from caps
Date:   Wed, 27 Jun 2018 18:27:11 +0300
Message-Id: <20180627152725.9783-14-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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
index 228084e72fb7..03121dbb4175 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -354,18 +354,16 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
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
@@ -374,7 +372,7 @@ static int session_unregister_bufs(struct venus_inst *inst)
 	struct hfi_buffer_desc bd;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry_safe(buf, n, &inst->registeredbufs, reg_list) {
@@ -394,7 +392,7 @@ static int session_register_bufs(struct venus_inst *inst)
 	struct venus_buffer *buf;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry(buf, &inst->registeredbufs, reg_list) {
-- 
2.14.1

