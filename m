Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F85C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C07B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C07B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeIMTQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbeIMTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 588DCD36;
        Thu, 13 Sep 2018 14:06:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 188/197] drm/amdgpu: Warn and update pin_size values when destroying a pinned BO
Date:   Thu, 13 Sep 2018 15:32:17 +0200
Message-Id: <20180913131849.079965041@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 15e6b76880e65be24250e30986084b5569b7a06f upstream.

This shouldn't happen, but if it does, we'll get a backtrace of the
caller, and update the pin_size values as needed.

v2:
* Check bo->pin_count instead of placement flags (Christian König)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   32 ++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -50,11 +50,35 @@ static bool amdgpu_need_backup(struct am
 	return true;
 }
 
+/**
+ * amdgpu_bo_subtract_pin_size - Remove BO from pin_size accounting
+ *
+ * @bo: &amdgpu_bo buffer object
+ *
+ * This function is called when a BO stops being pinned, and updates the
+ * &amdgpu_device pin_size values accordingly.
+ */
+static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	if (bo->tbo.mem.mem_type == TTM_PL_VRAM) {
+		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
+		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
+			     &adev->visible_pin_size);
+	} else if (bo->tbo.mem.mem_type == TTM_PL_TT) {
+		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
+	}
+}
+
 static void amdgpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 
+	if (WARN_ON_ONCE(bo->pin_count > 0))
+		amdgpu_bo_subtract_pin_size(bo);
+
 	if (bo->kfd_bo)
 		amdgpu_amdkfd_unreserve_system_memory_limit(bo);
 
@@ -791,13 +815,7 @@ int amdgpu_bo_unpin(struct amdgpu_bo *bo
 	if (bo->pin_count)
 		return 0;
 
-	if (bo->tbo.mem.mem_type == TTM_PL_VRAM) {
-		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
-		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
-			     &adev->visible_pin_size);
-	} else if (bo->tbo.mem.mem_type == TTM_PL_TT) {
-		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
-	}
+	amdgpu_bo_subtract_pin_size(bo);
 
 	for (i = 0; i < bo->placement.num_placement; i++) {
 		bo->placements[i].lpfn = 0;


