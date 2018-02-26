Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeBZJtx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:49:53 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:37659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeBZJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:49:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: fix building without debugfs
Date: Mon, 26 Feb 2018 10:49:26 +0100
Message-Id: <20180226094941.2783405-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:kkfEgG/0yDhC6Ll1DSQYMwQSd2hVPBgQve1rK8+WNb9L2bn036O
 7ZaWW+T5I7J/1JnhrnWYaVOc8dcaF/yb4+NYIosfZyEqK5AP8oJq3Rxh13GKGDiUuczkCmJ
 irXH5FkOhDrtaR3TzI+Sa5JuWiWSiAsJsfaTIwkcuBuNHxIq0i49aDLdBo7hXexdbThklCk
 OLEEutuxGBR0a4EArrueg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IgcO1iWzomg=:dWle4ckDBmPdeSy2QqCW3i
 kLzfIHc5I/B4mu85XQi4pydmfwv5VPb+XlCFQsgGrQJN7Vk1FlpMSx5pPZ/wITKF6wwzTf4dQ
 hvwJANmI6zVpVSsgld5RXr0iyf/GQXpkOaFunfcCaWh9W6dmW9rHze3K4lWzpqiKXF3dc+Kw+
 Si9hRI0P6ini8EP1VeVegnKJFUCCc2Kjv3cbPUfR0C+HXdHMFhN5cGnSG4FLt59qEjfKvTUpa
 rKIPrh8Z2pAHJ0qbGyKp+uyjTrXZmHdGfqrjbEbfCnctElsHHHl1oRVYo5Na1/pImYmTv/mJR
 5WpMq3BFSOGg94BLqRJSV2yoA2ZJQa1TB38TaG9VhUoQyMkLbPQevZfgmMBEEC5Gi0uO/WOal
 kH4Q3i88SlnEPwmAcTTJ08bANrhJdJwd//nuFBTt/zmmknE4RvH/qRxJyCwAnDoVRsGUoSkLJ
 TAs2U5rFM1afsie9pscpAlaXT0ApCSikoGhcjK6x3uL3MM9qFM7mJjCAySXDbSiw1w/qPhmdv
 7hcnbcpaW0K1Ab5JKNLBawalXAKkTySBUOJtm2ChRj09aFjwQaFVeXoP+OMrhBz9IB6mPmh9R
 kSzSbuVCFFtgbrEHj+SSjvwX+8V+kJtLNurRCWuiKH2yIEUnq+NRIygajLigIJ4sUnwp0igF2
 vED7mUmluR3MOf+Dj7/OqYzVDepTzjuUOj8clmJvXkZ27ehmUFb3CNY2qEdNM8esU8vPzDfpk
 19hW5QApHRluSB/pktfN9fcIth3H50qTFgfumg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adreno driver stopped building when CONFIG_DEBUGFS is disabled:

drivers/gpu/drm/msm/adreno/adreno_device.c: In function 'adreno_load_gpu':
drivers/gpu/drm/msm/adreno/adreno_device.c:153:16: error: 'const struct msm_gpu_funcs' has no member named 'debugfs_init'
  if (gpu->funcs->debugfs_init) {
                ^~
drivers/gpu/drm/msm/adreno/adreno_device.c:154:13: error: 'const struct msm_gpu_funcs' has no member named 'debugfs_init'
   gpu->funcs->debugfs_init(gpu, dev->primary);
             ^~

This adds an #ifdef around the code that references the hidden
pointer.

Fixes: 331dc0bc195b ("drm/msm: add a5xx specific debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f07d3ec7d77b..8e0cb161754b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -164,11 +164,13 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 		return NULL;
 	}
 
+#ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
 		gpu->funcs->debugfs_init(gpu, dev->primary);
 		gpu->funcs->debugfs_init(gpu, dev->render);
 		gpu->funcs->debugfs_init(gpu, dev->control);
 	}
+#endif
 
 	return gpu;
 }
-- 
2.9.0
