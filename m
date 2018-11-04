Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51DBC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AF20866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb9xpIvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2AF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbeKDXHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbeKDXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568EF20869;
        Sun,  4 Nov 2018 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339529;
        bh=zy620Y7x/m+A0bjHOCjHlZZoZhZimtRe0uUNebKIqOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xb9xpIvA7orA5AOzid7WcKVl2c0ADFl29NU4ZQLt3j7OzXT4wGqTgpFk9yAOUIHD1
         rj3xmQMa6Mej6ptB324xwXtG5VKfIhNsNKfdGLanzzOV2WPyXFg8gGQPElbgJmTVPL
         5Fu6nt4cl4WtAmO4kC+fDAMcWs8wkzmDbsSKEKQ0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 24/57] drm/msm/gpu: fix parameters in function msm_gpu_crashstate_capture
Date:   Sun,  4 Nov 2018 08:51:11 -0500
Message-Id: <20181104135144.88324-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 6969019f65b43afb6da6a26f1d9e55bbdfeebcd5 ]

When CONFIG_DEV_COREDUMP isn't defined msm_gpu_crashstate_capture
doesn't pass the correct parameters.
drivers/gpu/drm/msm/msm_gpu.c: In function ‘recover_worker’:
drivers/gpu/drm/msm/msm_gpu.c:479:34: error: passing argument 2 of ‘msm_gpu_crashstate_capture’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
                                  ^~~~~~
drivers/gpu/drm/msm/msm_gpu.c:388:13: note: expected ‘char *’ but argument is of type ‘struct msm_gem_submit *’
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_gpu.c:479:2: error: too many arguments to function ‘msm_gpu_crashstate_capture’
  msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_gpu.c:388:13: note: declared here
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,

In current code the function msm_gpu_crashstate_capture parameters.

Fixes: cdb95931dea3 ("drm/msm/gpu: Add the buffer objects from the submit to the crash dump")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-By: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 5e808cfec345..46e6b82f7b66 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -367,8 +367,8 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		msm_gpu_devcoredump_read, msm_gpu_devcoredump_free);
 }
 #else
-static void msm_gpu_crashstate_capture(struct msm_gpu *gpu, char *comm,
-		char *cmd)
+static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
+		struct msm_gem_submit *submit, char *comm, char *cmd)
 {
 }
 #endif
-- 
2.17.1

