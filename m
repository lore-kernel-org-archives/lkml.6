Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757669AbeDXMyu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:54:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37416 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757813AbeDXMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:45:15 -0400
X-Google-Smtp-Source: AIpwx4/VW0QBFccGLsb+ZWNd2Mm+5zpJa2UgV6dDc/OJe3Mt+UfFI1UdK3DwBImu83eWBis66NTcRg==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 06/28] venus: hfi: handle buffer output2 type as well
Date: Tue, 24 Apr 2018 15:44:14 +0300
Message-Id: <20180424124436.26955-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
References: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds handling of buffers of type OUTPUT2 which is needed to
support Venus 4xx version.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
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
index 5970e9b1716b..023802e62833 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -825,7 +825,8 @@ static void hfi_session_ftb_done(struct venus_core *core,
 		error = HFI_ERR_SESSION_INVALID_PARAMETER;
 	}
 
-	if (buffer_type != HFI_BUFFER_OUTPUT)
+	if (buffer_type != HFI_BUFFER_OUTPUT &&
+	    buffer_type != HFI_BUFFER_OUTPUT2)
 		goto done;
 
 	if (hfi_flags & HFI_BUFFERFLAG_EOS)
-- 
2.14.1
