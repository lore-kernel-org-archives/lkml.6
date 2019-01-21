Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6DC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C519520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CU1pgPwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfAUKGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:06:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41688 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAUKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:06:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so22522717wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ywAKA7XPaADxrBcsFMk+tbkoWLax4ZTEel24lBBuNN4=;
        b=CU1pgPwdJuBHiqIkLzqPe3O5BRFdhqNL8zM5PR0fDMSAOkMednRyPq5b/5Amwrhp36
         Iqe5iuZo6CAn77BXugWM0s5p2Y9tSZQkKVc1ZRQgxL0T93Puxwf3XPkYJ3bHbNa/DBDE
         oEotYZRM4hs6LvE56qEz3YWK0QqqswLR1+wYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ywAKA7XPaADxrBcsFMk+tbkoWLax4ZTEel24lBBuNN4=;
        b=GjsQcFWYY3Yti2B8vzTqbzOVNEk2o1dAAmdH/H6XGmstkkG4XGGAml6+g498cMTOua
         h1x8OMfEdRpGunp5x/pe2q8ACxqPUMw5XYaaPdzPEjSobnTbpveD/okdxJ9/EJ92Wq8d
         GCdbA5OF9bcAbWbG18/Y1AW225olAQO92iwIs7Kupt7ch0oOD+Wy8CKKS5hcKtI5onqY
         hVus4/dOXQkGMweFCSDQzxI+BEebi8bgDK6Tx14zfaFygZvRIGTh2D0UMOdch0jJKchs
         F0D/IgQw1NCsliCQ2aNfBMXWGxX2VpE3pYY2en1I5n+9uP8SS/Z4DxnLHWHPzznVzXkD
         qA2Q==
X-Gm-Message-State: AJcUukc4e8rcHn7Fa2znP/ZCimwd9R2w28DNB/DZQo3ChfGACCCKKH40
        z6fjbN6TaYNO5uEZ1CqKo7Z9Mm8850Ct6w==
X-Google-Smtp-Source: ALg8bN4T35PTJmcoWBiZz43SdGIQsaQWsyH81wjzgvRlM2FU6AmVs9duzGMsQsXUR8oVF8GpbavgMw==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr29375533wrw.50.1548065181082;
        Mon, 21 Jan 2019 02:06:21 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:789e:cc70:7004:686b])
        by smtp.gmail.com with ESMTPSA id f22sm4541857wmj.26.2019.01.21.02.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 02:06:20 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH] drm: disable WC optimization for cache coherent devices on non-x86
Date:   Mon, 21 Jan 2019 11:06:17 +0100
Message-Id: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DRM code assumes that PCI devices are always cache
coherent for DMA, and that this can be selectively overridden for
some buffers using non-cached mappings on the CPU side and PCIe
NoSnoop transactions on the bus side.

Whether the NoSnoop part is implemented correctly is highly platform
specific. Whether it /matters/ if NoSnoop is implemented correctly or
not is architecture specific: on x86, such transactions are coherent
with the CPU whether the NoSnoop attribute is honored or not. On other
architectures, it depends on whether such transactions may allocate in
caches that are non-coherent with the CPU's uncached mappings.

Bottom line is that we should not rely on this optimization to work
correctly for cache coherent devices in the general case. On the
other hand, disabling this optimization for non-coherent devices
is likely to cause breakage as well, since the driver will assume
cache coherent PCIe if this optimization is turned off.

So rename drm_arch_can_wc_memory() to drm_device_can_wc_memory(), and
pass the drm_device pointer into it so we can base the return value
on whether the device is cache coherent or not if not running on
X86.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: David Zhou <David1.Zhou@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: Michel Daenzer <michel.daenzer@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
This is a followup to '[RFC PATCH] drm/ttm: force cached mappings for system
RAM on ARM'

https://lore.kernel.org/linux-arm-kernel/20190110072841.3283-1-ard.biesheuvel@linaro.org/

Without t
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  2 +-
 drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
 include/drm/drm_cache.h                    | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 728e15e5d68a..777fa251838f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -480,7 +480,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	/* For architectures that don't support WC memory,
 	 * mask out the WC flag from the BO
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!drm_device_can_wc_memory(adev->ddev))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 #endif
 
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 833e909706a9..610889bf6ab5 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -249,7 +249,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	/* For architectures that don't support WC memory,
 	 * mask out the WC flag from the BO
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!drm_device_can_wc_memory(rdev->ddev))
 		bo->flags &= ~RADEON_GEM_GTT_WC;
 #endif
 
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..ced63b1207a3 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -33,6 +33,8 @@
 #ifndef _DRM_CACHE_H_
 #define _DRM_CACHE_H_
 
+#include <drm/drm_device.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/scatterlist.h>
 
 void drm_clflush_pages(struct page *pages[], unsigned long num_pages);
@@ -41,15 +43,16 @@ void drm_clflush_virt_range(void *addr, unsigned long length);
 u64 drm_get_max_iomem(void);
 
 
-static inline bool drm_arch_can_wc_memory(void)
+static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
 {
-#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	return false;
-#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
-	return false;
-#else
-	return true;
-#endif
+	if (IS_ENABLED(CONFIG_PPC))
+		return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
+	else if (IS_ENABLED(CONFIG_MIPS))
+		return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
+	else if (IS_ENABLED(CONFIG_X86))
+		return true;
+
+	return !dev_is_dma_coherent(ddev->dev);
 }
 
 #endif
-- 
2.17.1

