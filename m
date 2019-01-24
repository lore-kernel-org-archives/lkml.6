Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9015C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE1D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVHv9eio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfAXMHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:07:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54857 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAXMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:07:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2851453wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsPSU83pbk1uWSobF359Hmb25tSiPCSXYSiAdhiX2K0=;
        b=MVHv9eioSsA83BVb2J9fi21oGdNAhe8L5mYX67nd+XBNW59IxbYWyPCjLtaUXXFxQx
         C8eDCimc2jtV5LiHYUHkJKhoQYN40/4u2K6EOoUunE10yy3C+J6aGY9JX5gh7mgstcNp
         Dvdm9CHYXs35/N3s4bzP1fUHVnLbpVKVammw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsPSU83pbk1uWSobF359Hmb25tSiPCSXYSiAdhiX2K0=;
        b=JhSOfm2087Yah04xighE+lUF1akID+OL/3dzE0tmEY8rP86dMwQN65r9R7miB/9GqI
         pO7wAqqkkQKk2mbjvEb3c7EqMzZr57+Xu+AVO4HfSGsZdw87cmA5EXQbGczbz0OIFo71
         3ZZHW/aQ2quocrd0bq9LyZSK0zG6s4JXym0vNe0zO0u0b2CexF9WQkv2J/qMmEUDJfyy
         GdMPEJEw987JWQrxnBcssCAjf2p4hqPsilJYLl/FzeDjRuDAbMfi/JJDosCjKPwd7ePy
         Yaoz5Beq6CHqFLQD0zbLJ4TwvfXMBRROiydP2dY6dT5Wc8whAwxno6xmMtVNZF9bIYpg
         ZXQQ==
X-Gm-Message-State: AJcUukftf5v1qFSfyjrjgymjK57U54fSvf6rJ8F41KVB01J/AygJaCIx
        gnMTXlPmuFTty3Auk4SY/psJmIw6oRrPkw==
X-Google-Smtp-Source: ALg8bN55gm82WRKfoWS5g8dy3rATbR8W4MaKwupN1EALKBkI9t9KdMSE60V2HSnI4wy7yU44++cGoA==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr2530824wmf.69.1548331626262;
        Thu, 24 Jan 2019 04:07:06 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id t12sm98842348wrr.65.2019.01.24.04.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 04:07:05 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
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
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>
Subject: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date:   Thu, 24 Jan 2019 13:06:58 +0100
Message-Id: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM driver stack is designed to work with cache coherent devices
only, but permits an optimization to be enabled in some cases, where
for some buffers, both the CPU and the GPU use uncached mappings,
removing the need for DMA snooping and allocation in the CPU caches.

The use of uncached GPU mappings relies on the correct implementation
of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
will use cached mappings nonetheless. On x86 platforms, this does not
seem to matter, as uncached CPU mappings will snoop the caches in any
case. However, on ARM and arm64, enabling this optimization on a
platform where NoSnoop is ignored results in loss of coherency, which
breaks correct operation of the device. Since we have no way of
detecting whether NoSnoop works or not, just disable this
optimization entirely for ARM and arm64.

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
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/drm/drm_cache.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..97fc498dc767 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -47,6 +47,24 @@ static inline bool drm_arch_can_wc_memory(void)
 	return false;
 #elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
 	return false;
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	/*
+	 * The DRM driver stack is designed to work with cache coherent devices
+	 * only, but permits an optimization to be enabled in some cases, where
+	 * for some buffers, both the CPU and the GPU use uncached mappings,
+	 * removing the need for DMA snooping and allocation in the CPU caches.
+	 *
+	 * The use of uncached GPU mappings relies on the correct implementation
+	 * of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
+	 * will use cached mappings nonetheless. On x86 platforms, this does not
+	 * seem to matter, as uncached CPU mappings will snoop the caches in any
+	 * case. However, on ARM and arm64, enabling this optimization on a
+	 * platform where NoSnoop is ignored results in loss of coherency, which
+	 * breaks correct operation of the device. Since we have no way of
+	 * detecting whether NoSnoop works or not, just disable this
+	 * optimization entirely for ARM and arm64.
+	 */
+	return false;
 #else
 	return true;
 #endif
-- 
2.20.1

