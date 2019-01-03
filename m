Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3D208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfACReW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:34:22 -0500
Received: from gateway30.websitewelcome.com ([192.185.150.24]:29654 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730267AbfACReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:34:22 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 1836C6635E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jan 2019 11:34:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id f6svgCcem90onf6svghmAy; Thu, 03 Jan 2019 11:34:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=36770 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gf6su-000Jye-7D; Thu, 03 Jan 2019 11:34:20 -0600
Date:   Thu, 3 Jan 2019 11:34:18 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu_vm: fix boolean expressions
Message-ID: <20190103173418.GA18739@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gf6su-000Jye-7D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:36770
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix boolean expressions by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: c8c5e569c5b0 ("drm/amdgpu: Consolidate visible vs. real vram check v2.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e73d152659a2..4cc0d1079935 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3006,7 +3006,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
-	WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
+	WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 	vm->last_update = NULL;
 
@@ -3136,7 +3136,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, uns
 	vm->pte_support_ats = pte_support_ats;
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
-	WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
+	WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 
 	if (vm->pasid) {
-- 
2.20.1

