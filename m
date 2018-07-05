Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555A424135
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sxjl44Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555A424135
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeGENFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeGENFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so1137324wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=Sxjl44ChUU1xaGXSh8Zizx2qkhpkRjvpO2dUOD8sZkgIzziO8yyJWCtA0t0+W+sY+G
         9pj+GSf3MHPK4+mHXAbo1BbgfXg+6zX61J6+iDgXmNEK6Lt3NAvvSFNtpvPbxsdhLp5q
         9RXkA8w1oaXus0qQ9ebprLlzb6lHUQu5avSsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=g/iwRCCGPFhJQD5vVtYy/JDkljYhC9TvCgFtkAhUAG3XrvtJcQp7NMDQtEZklcRSx/
         AVgsh00MPxf6gvIf1z2GLiI8QzrpzDaTkK7up7q/z1jezp2+m+2ArjVrvFM7/0207ZCC
         qBynEB/xfjPKap0zOe83Uap4VoQ3h51lN3bqlAhz6mcO/49buOWfivktGriXLjGSYQmM
         wzrzTdzY5wGBZiRKYP5mY2SmRDPa9nzC5UCKTPkTnDhlwKTfWxOHtiX+TKhKhYhfo49Q
         Cq6BxCJb92vSC+Wx+Nlw/4z1kWNtFxwXUIjbySxJ8tue6JXTyQcIuYdDOj8Ko4/HP5BM
         PjKw==
X-Gm-Message-State: APt69E3Y1vpMqXQJO85PoKKk8ZnEEK89xmwblxOmsXp8jiSZlwTMlJJj
        mmmRtbixe9ZyPo6vB7dA6mvVZg==
X-Google-Smtp-Source: AAOMgpcNLu+g4lUDrjQlkR3cCJzCQUAzc74+X6eZXAyOBco0VrN7Z/6jBm/GdRy36rQ7rMqZjRdECg==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr4308779wrn.14.1530795913157;
        Thu, 05 Jul 2018 06:05:13 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:12 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 06/27] venus: hfi: handle buffer output2 type as well
Date:   Thu,  5 Jul 2018 16:03:40 +0300
Message-Id: <20180705130401.24315-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds handling of buffers of type OUTPUT2 which is needed to
support Venus 4xx version.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi.c      | 3 ++-
 drivers/media/platform/qcom/venus/hfi_msgs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index cbc6fad05e47..a570fdad0de0 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -473,7 +473,8 @@ int hfi_session_process_buf(struct venus_inst *inst, struct hfi_frame_data *fd)
 
 	if (fd->buffer_type == HFI_BUFFER_INPUT)
 		return ops->session_etb(inst, fd);
-	else if (fd->buffer_type == HFI_BUFFER_OUTPUT)
+	else if (fd->buffer_type == HFI_BUFFER_OUTPUT ||
+		 fd->buffer_type == HFI_BUFFER_OUTPUT2)
 		return ops->session_ftb(inst, fd);
 
 	return -EINVAL;
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 54cd41e5837c..c0f3bef8299f 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -823,7 +823,8 @@ static void hfi_session_ftb_done(struct venus_core *core,
 		error = HFI_ERR_SESSION_INVALID_PARAMETER;
 	}
 
-	if (buffer_type != HFI_BUFFER_OUTPUT)
+	if (buffer_type != HFI_BUFFER_OUTPUT &&
+	    buffer_type != HFI_BUFFER_OUTPUT2)
 		goto done;
 
 	if (hfi_flags & HFI_BUFFERFLAG_EOS)
-- 
2.14.1

