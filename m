Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A16C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2406A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRKhZf4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfAQQVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:21:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52214 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfAQQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:21:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1699510wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MkbOUFHDsrDG1TGvqhepL8zE+1a5aus1syCufXPfhww=;
        b=WRKhZf4RUsxe3qwNVAqkut2X4sPhjyKbKboB/6lzkNvpEPB690MAHkE9otoCgA3iCa
         sEDi+1WICELvvqYkxsUIfeEexgdDrAxRPeJ/eF/uJ05JRhnj4kyyrIouRwEqMwAe11Go
         Iv9bcBTxbyPc2omRNkdybZCKrY7uq19n5v19g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MkbOUFHDsrDG1TGvqhepL8zE+1a5aus1syCufXPfhww=;
        b=tIkROK809nudcrWoXk24D+4+6T/bQ3rfKnv+e2ZERroihJDRDI5SmMZmeP8xEUbo9g
         1nxZEhelMQhi3JDIfmvG6XFILKtIqMc8ZMyLdPpzS8pNBXIFqCxHq2BcprufkzQerzUu
         b/E+GFHW6LgjaUvgOH3RB/RAPrZm6eyAMoNcYcfUmAL2RUWfRM9CnkLR6hB4zU6LhaNq
         +7s8IQ+ZmLc9DakY5bXbYNJVRZ/SBfAuJNzRMZKfKCZzc0/2xxI6yFB+fephDN2Iy6ZM
         MxJ7Wp/TDM3EbMrbX1L7qKYr3wF1d17DQorQCEWHWAhJT9lO0OdeWWUugCt+IIZR+VWm
         i5eg==
X-Gm-Message-State: AJcUukddp1ArnzMr1dmQVls/MtemkGahPTXpe+6o+e4VuRW0M/NYaWmv
        RgnFtFsYDl2n36AigCtKr4xFrw==
X-Google-Smtp-Source: ALg8bN5NqvzrDlG3B/jNNGzGdg1LJu7EDyDaSjTmT2y5zFFt2yGnY2HJWVfZtcbgY+YxrF94NnCeLw==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr12654932wme.16.1547742068013;
        Thu, 17 Jan 2019 08:21:08 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id v133sm31124734wmf.19.2019.01.17.08.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:21:07 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 06/10] venus: hfi: return an error if session_init is already called
Date:   Thu, 17 Jan 2019 18:20:04 +0200
Message-Id: <20190117162008.25217-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes hfi_session_init to return an error when it is
already called without a call to hfi_session_deinit.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index eaa82af9ec09..5374655eda39 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -207,6 +207,9 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
 	const struct hfi_ops *ops = core->ops;
 	int ret;
 
+	if (inst->state != INST_UNINIT)
+		return -EINVAL;
+
 	inst->hfi_codec = to_codec_type(pixfmt);
 	reinit_completion(&inst->done);
 
-- 
2.17.1

