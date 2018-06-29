Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C7D27C03
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e47vWq+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C7D27C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeF2SsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:48:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33201 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753843AbeF2SsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:48:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so4872853plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/bVSRf1pFV9mW0ojgQHvp3NBSea7vZWfijbAIaCa6m4=;
        b=e47vWq+SJusXcfNa0kXS+OB1p1BmirpoXvxYHcXoFvuHfehrILm6GvptHeqLyelOu6
         DS+p8xfG+H2YjfomZJSK0LKFFgvUiNX/Anj5DFu3+QVPN5Z7/lh28GVA34GjPWWS8hw5
         nRoNTuK0XLenXZEgl8Xe5kYRMPi/V1UkbrlVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/bVSRf1pFV9mW0ojgQHvp3NBSea7vZWfijbAIaCa6m4=;
        b=L1Dc9BQrpY5Ve0toqaavAI8L7uuB+f4zkQWTqsTrjijsdivxeFbM9ZeVT8EK0iwg6u
         VwQ6Bqzo9pL8iRL/nQlhSDzbN2qFS4FqrvSjqE+gQZ8hN76N6CVWU3clqhpNtThKl/3B
         icPJL23N2KFAngyfqLTDFYnAyY6GBdhC9gADdv+xqUChdZ1rGs96c7QXpahF2CgYslZb
         o0U+HScfcoicpwu6Sacy2pdCiyw+KiGVCoUAs7FFJNzjV7Un053uSZ6KR1sm47PJXLBN
         Q5Mo70XXVOdOSP9pHDxy/vR+RyDiNoICv1OJeQ3c7FKLT/v7PaIGg/UoDaWxhXdyYqkw
         UktA==
X-Gm-Message-State: APt69E1nEhF0X53RBbdCfbHvhyWd0By9DRvPzxEl9QENuSsbT7psvxSw
        bfExY1anK7TyfFhqeoPL0QwrWA==
X-Google-Smtp-Source: ADUXVKKi2K5+QorKWSLLV27W9lljztkTay4P4QICdPgdp8225lxEEhKByGuLThVHanN2TddaSyLTQA==
X-Received: by 2002:a17:902:89:: with SMTP id a9-v6mr15702910pla.326.1530298100265;
        Fri, 29 Jun 2018 11:48:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m5-v6sm1067720pfm.27.2018.06.29.11.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:48:19 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:48:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/adreno: Remove VLA usage
Message-ID: <20180629184818.GA37439@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a kasprintf()ed buffer. Return paths are updated
to free the allocation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 28 +++++++++++++++++--------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d39400e5bc42..f5f76f8151f9 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/qcom_scm.h>
@@ -19,6 +20,7 @@
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/pm_opp.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/slab.h>
 #include "msm_gem.h"
 #include "msm_mmu.h"
 #include "a5xx_gpu.h"
@@ -91,12 +93,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
 		ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
 				mem_region, mem_phys, mem_size, NULL);
 	} else {
-		char newname[strlen("qcom/") + strlen(fwname) + 1];
+		char *newname;
 
-		sprintf(newname, "qcom/%s", fwname);
+		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
 
 		ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
 				mem_region, mem_phys, mem_size, NULL);
+		kfree(newname);
 	}
 	if (ret)
 		goto out;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index bcbf9f2a29f9..bfaafdfc7eb2 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -17,7 +17,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/kernel.h>
 #include <linux/pm_opp.h>
+#include <linux/slab.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
@@ -70,10 +72,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 {
 	struct drm_device *drm = adreno_gpu->base.dev;
 	const struct firmware *fw = NULL;
-	char newname[strlen("qcom/") + strlen(fwname) + 1];
+	char *newname;
 	int ret;
 
-	sprintf(newname, "qcom/%s", fwname);
+	newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
+	if (!newname)
+		return ERR_PTR(-ENOMEM);
 
 	/*
 	 * Try first to load from qcom/$fwfile using a direct load (to avoid
@@ -87,11 +91,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			dev_info(drm->dev, "loaded %s from new location\n",
 				newname);
 			adreno_gpu->fwloc = FW_LOCATION_NEW;
-			return fw;
+			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
 			dev_err(drm->dev, "failed to load %s: %d\n",
 				newname, ret);
-			return ERR_PTR(ret);
+			fw = ERR_PTR(ret);
+			goto out;
 		}
 	}
 
@@ -106,11 +111,12 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			dev_info(drm->dev, "loaded %s from legacy location\n",
 				newname);
 			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
-			return fw;
+			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
 			dev_err(drm->dev, "failed to load %s: %d\n",
 				fwname, ret);
-			return ERR_PTR(ret);
+			fw = ERR_PTR(ret);
+			goto out;
 		}
 	}
 
@@ -126,16 +132,20 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			dev_info(drm->dev, "loaded %s with helper\n",
 				newname);
 			adreno_gpu->fwloc = FW_LOCATION_HELPER;
-			return fw;
+			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
 			dev_err(drm->dev, "failed to load %s: %d\n",
 				newname, ret);
-			return ERR_PTR(ret);
+			fw = ERR_PTR(ret);
+			goto out;
 		}
 	}
 
 	dev_err(drm->dev, "failed to load %s\n", fwname);
-	return ERR_PTR(-ENOENT);
+	fw = ERR_PTR(-ENOENT);
+out:
+	kfree(newname);
+	return fw;
 }
 
 static int adreno_load_fw(struct adreno_gpu *adreno_gpu)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
