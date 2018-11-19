Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878EC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0CDhOHQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878EC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeKTCyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbeKTCyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00CD20870;
        Mon, 19 Nov 2018 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645044;
        bh=gx+lCOMQzcYnK8MM7gPw6GEdOkCfn8Git+1hggTzjI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CDhOHQR1obE2cAKyw0i41MEYhkYIJWfQVaoIOeWl49AfpHSrbxmrs3aO5k4OGN4U
         iBOU+mmu4bJ1OeoYlyoyMYewFUVGBUwcwDYbZiQTHt2vSB60SqjH6zY4cXHFkw6Zow
         /MDAPEcSfpt+7yRZ1FycpdnHg1PTslXSyogVC8KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/205] drm/msm/gpu: fix parameters in function msm_gpu_crashstate_capture
Date:   Mon, 19 Nov 2018 17:25:22 +0100
Message-Id: <20181119162619.928821741@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -367,8 +367,8 @@ static void msm_gpu_crashstate_capture(s
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


