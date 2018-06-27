Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1246126024
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUd+yvxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1246126024
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeF0P22 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45605 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934910AbeF0P2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so2463809wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tdgb7i3pHOc18juXBnV581NGwky8g4nU20Ecgz01uNo=;
        b=UUd+yvxrHZiApNI8YeMHvQQ41nVuNqkHvB0A4Y6e1V+tQyvkhJIqVVsyAljazzNfB3
         knxl7Oe1VPRhS7YENKeDyYABWggiBOqOa8n7bKQ7fv996cDQmB+62vEmM1gFK2c/Aweg
         upHmp3DwZvgCCFC3I7ns+j6ZgnmEPT1nM2apE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tdgb7i3pHOc18juXBnV581NGwky8g4nU20Ecgz01uNo=;
        b=qPnlfeQqBqxWG/iSd5Of+450Hk2LVM7KOO03Ycb7qp8FQkk8Zf5vDc+niDjttPTd0g
         6NCCqA3xozNXlpY67ehrTMg5fsjrebuHmc6KbhfAikjdlvaPOH7uA2luKPMsqyfr6CpG
         lm10mP1n/8QB8wE2KpmLEJ+/95rR0SAdHBki/fau7h4BWtot0g5jMKr2vP415AlDlNjZ
         H8/sqD7wQFd0nD1jcCfWzp+SQGM+jm3W1CxTu7Z85ArgEt5EpjTL4DVXROCF32w1SXMV
         g8VZxmDmFP2AsDcyJehLbdnv5Hu4crJIbhGzwBQfbJz9JFuKZNK0FlifCY0tGlF3OMJW
         hsiA==
X-Gm-Message-State: APt69E38Dkwep67HGmdjzQfKTbAXYFSlsB0HV2TRj/O01RPzbKeZ6wQ9
        o9pmGjYZUJq4OEn5FX4GW+0LFQ==
X-Google-Smtp-Source: AAOMgpcbA5kbTv9ulIZQ6RCEWFFHn+DlRyu9AXYYSBkRo+aO1H0KsGFWwVwgVg45yA+TNDddcfvNdw==
X-Received: by 2002:adf:9226:: with SMTP id 35-v6mr2359316wrj.44.1530113295028;
        Wed, 27 Jun 2018 08:28:15 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:14 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 14/27] venus: helpers: add a helper function to set dynamic buffer mode
Date:   Wed, 27 Jun 2018 18:27:12 +0300
Message-Id: <20180627152725.9783-15-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new helper function to set dynamic buffer mode if it is
supported by current HFI version. The dynamic buffer mode is
set unconditionally for both decoder outputs.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c    | 15 +++------------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 03121dbb4175..e3dc2772946f 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -519,6 +519,28 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
 
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
+{
+	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
+	struct hfi_buffer_alloc_mode mode;
+	int ret;
+
+	if (!is_dynamic_bufmode(inst))
+		return 0;
+
+	mode.type = HFI_BUFFER_OUTPUT;
+	mode.mode = HFI_BUFFER_MODE_DYNAMIC;
+
+	ret = hfi_session_set_property(inst, ptype, &mode);
+	if (ret)
+		return ret;
+
+	mode.type = HFI_BUFFER_OUTPUT2;
+
+	return hfi_session_set_property(inst, ptype, &mode);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 0e64aa95624a..52b961ed491e 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -40,6 +40,7 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 31a240ab142b..92669a358a90 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -557,18 +557,9 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
-	if (core->res->hfi_version == HFI_VERSION_3XX ||
-	    inst->cap_bufs_mode_dynamic) {
-		struct hfi_buffer_alloc_mode mode;
-
-		ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
-		mode.type = HFI_BUFFER_OUTPUT;
-		mode.mode = HFI_BUFFER_MODE_DYNAMIC;
-
-		ret = hfi_session_set_property(inst, ptype, &mode);
-		if (ret)
-			return ret;
-	}
+	ret = venus_helper_set_dyn_bufmode(inst);
+	if (ret)
+		return ret;
 
 	if (ctr->post_loop_deb_mode) {
 		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
-- 
2.14.1

