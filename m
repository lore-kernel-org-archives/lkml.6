Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9908AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F09821902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfBSHEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:04:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:32796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSHEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:04:42 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB1E3C87250DE5053D19;
        Tue, 19 Feb 2019 15:04:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 15:04:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sumit.garg@linaro.org>, <jens.wiklander@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tee: optee: Fix unsigned comparison with less than zero
Date:   Tue, 19 Feb 2019 15:04:28 +0800
Message-ID: <20190219070428.15480-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to tee_client_invoke_func can be a
negative error code however this is being assigned to an
unsigned variable 'ret' hence the check is always false.
Fix this by making 'ret' an int.

Detected by Coccinelle ("Unsigned expression compared with zero:
ret < 0")

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 5e4938b..1f22376 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -34,7 +34,7 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 static int get_devices(struct tee_context *ctx, u32 session,
 		       struct tee_shm *device_shm, u32 *shm_size)
 {
-	u32 ret = 0;
+	int ret = 0;
 	struct tee_ioctl_invoke_arg inv_arg = {0};
 	struct tee_param param[4] = {0};
 
-- 
2.7.0


