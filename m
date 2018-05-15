Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbeEOIJl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:09:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51595 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeEOH7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:59:38 -0400
X-Google-Smtp-Source: AB8JxZpl+UsgTc2DVvEskmLqJT2o9zF1xF25o0AEE4HZ3m6ET5DXtdM7T1VgyBwLXhqKm2EQSMLwfQ==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 10/29] venus: hfi_venus: add suspend functionality for Venus 4xx
Date: Tue, 15 May 2018 10:58:40 +0300
Message-Id: <20180515075859.17217-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds suspend (power collapse) functionality by reusing
the suspend function for Venus 3xx and also enables idle indicator
property for Venus 4xx (where it is disabled by default).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 284da69eb81b..109116e1545d 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -878,6 +878,14 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
+	/*
+	 * Idle indicator is disabled by default on some 4xx firmware versions,
+	 * enable it explicitly in order to make suspend functional by checking
+	 * WFI (wait-for-interrupt) bit.
+	 */
+	if (IS_V4(hdev->core))
+		venus_sys_idle_indicator = true;
+
 	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
 	if (ret)
 		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
@@ -1525,7 +1533,8 @@ static int venus_suspend_3xx(struct venus_core *core)
 
 static int venus_suspend(struct venus_core *core)
 {
-	if (core->res->hfi_version == HFI_VERSION_3XX)
+	if (core->res->hfi_version == HFI_VERSION_3XX ||
+	    core->res->hfi_version == HFI_VERSION_4XX)
 		return venus_suspend_3xx(core);
 
 	return venus_suspend_1xx(core);
-- 
2.14.1
