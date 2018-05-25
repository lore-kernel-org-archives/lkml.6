Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966805AbeEYPvE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:51:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Felix Kuehling <Felix.Kuehling@amd.com>,
        Andres Rodriguez <andresx7@gmail.com>,
        Kent Russell <kent.russell@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm/amdgpu: fix 32-bit build warning
Date: Fri, 25 May 2018 17:50:09 +0200
Message-Id: <20180525155030.3667352-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tLTWrYXK1XmFzZLwisy/MzqQOimKFZ/gBKSKdg92DpoZEKoM3d6
 taKR1iy1GFRGryEPMWpUBJeb65etS2e2S5yQ7BkZTsOj8GUYkNfPVlaoMmngou1h3FM9e3X
 Vug1UAWFHUD8h//gmV9DvaI5zH6u4Mc4TNcSVbicSNsntGJKNzWStqD9Q5pqfJzWF4cB4u2
 jPcLUOMUphxjvEKM0ACjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uC9nKQETneQ=:yV19KX2xB6NE4AtlRCzm8g
 B4vAN/r11tARlk2OlpuPKLyQgIsLQb2AasLCDmVmAM84vZ7GIy8uliv+tB2npf/YSOF3LFirf
 3J/g6VXdIQyBaF4TLnzJxhIJJp7ekGVqheOKeCyTFa6d1KTogNAsCxxZSUyL/u7psjOkjm6yI
 qfAXZYzNAExlyTxbG5YG6nR/wTqKbSgAabtDM3mZcsmRzia9UlCcy+PEwq6AWKYEX6l+KgXNT
 YJcXvK6/Lk7OBPWcQ3RiTpgEnIhpuvS8f2JpAoNGSbuPFmGa9UMYfd8Nu0B5xS2u9lMcncRxT
 VogqBMjU05BTdVS2tqyxvb/W/+GPbcS5vZ44p+g7I4nO6ns6lBEZbYVX5fo9Naj94cVcRR/QL
 Bf3ob/z32LeNfR4DkexaEgP40yf7ECNMgHyvQnStkX199h6BjV+04L9aU+JubwSIZQ6Ru+rIl
 EKJx21LW0DXwqEdPbVj3vzDaVV9LPWHaA/pFN9TS4Mf1VjK/hN9mJp99MVKQCVovf8air9DNw
 1ivB8qG2wca+UpAEsqAVxABCWM4OaxirS0y174kLDC/h485ZY2Rd4DTFa6aV2KIHEFDFMbZfQ
 YvySz8pcmyxRIKLr/sA+O7Ne/7I5RG8f4CbC65v8w2MHS0w5UFS0eitZJTP6nMdIZObps0QT0
 PFWM57j/3n3SEUXyM6kv/eES4Le+uTBy1YzkWWBqI29Gg11v34CXXiltwADRnbuiK+V8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting a pointer to a 64-bit type causes a warning on 32-bit targets:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
          lower_32_bits((uint64_t)wptr));
                        ^
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1701:53: note: in definition of macro 'WREG32'
 #define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
                                                     ^
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:10: note: in expansion of macro 'lower_32_bits'
          lower_32_bits((uint64_t)wptr));
          ^~~~~~~~~~~~~

The correct method is to cast to 'uintptr_t'.

Fixes: d5a114a6c5f7 ("drm/amdgpu: Add GFXv9 kfd2kgd interface functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 8f37991df61b..f0c0d3953f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -470,9 +470,9 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uint64_t)wptr));
+		       lower_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-		       upper_32_bits((uint64_t)wptr));
+		       upper_32_bits((uintptr_t)wptr));
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
 		       get_queue_mask(adev, pipe_id, queue_id));
 	}
-- 
2.9.0
