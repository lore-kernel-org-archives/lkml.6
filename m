Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C70C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4850A208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4850A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeJBUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbeJBUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:33 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A40BB4B;
        Tue,  2 Oct 2018 13:37:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 91/94] drm/amdgpu: Update power state at the end of smu hw_init.
Date:   Tue,  2 Oct 2018 06:25:45 -0700
Message-Id: <20181002132506.846924153@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rex Zhu <Rex.Zhu@amd.com>

[ Upstream commit 2ab4d0e74256fc49b7b270f63c1d1e47c2455abc ]

For SI/Kv, the power state is managed by function
amdgpu_pm_compute_clocks.

when dpm enabled, we should call amdgpu_pm_compute_clocks
to update current power state instand of set boot state.

this change can fix the oops when kfd driver was enabled on Kv.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c |    4 +---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c |    3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -1350,8 +1350,6 @@ static int kv_dpm_enable(struct amdgpu_d
 		return ret;
 	}
 
-	kv_update_current_ps(adev, adev->pm.dpm.boot_ps);
-
 	if (adev->irq.installed &&
 	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
@@ -3086,7 +3084,7 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	mutex_unlock(&adev->pm.mutex);
-
+	amdgpu_pm_compute_clocks(adev);
 	return ret;
 }
 
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6959,7 +6959,6 @@ static int si_dpm_enable(struct amdgpu_d
 
 	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
 	si_thermal_start_thermal_controller(adev);
-	ni_update_current_ps(adev, boot_ps);
 
 	return 0;
 }
@@ -7836,7 +7835,7 @@ static int si_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	mutex_unlock(&adev->pm.mutex);
-
+	amdgpu_pm_compute_clocks(adev);
 	return ret;
 }
 


