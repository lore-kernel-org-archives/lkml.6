Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A582184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130569;
	bh=f9t5fgbgrMndqF0xmKDrSOFgaLsSfEcMgQJUj+B3hXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfBXxt91/VQk55nYaPZdZM9PSEpE8llPUV3ymdmHL7txfYy/wKOHzMm3of5+0PY/O
	 SBj9sdAqxgJfXeCgNvfCNF/q/DThzyF1WwIruYmZqS4vEdRe00Vo41mxyUQLzhf8tI
	 wyvAZ6a5pplCXBY3CTiASVEPENOD1Hc+ekE7N5cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfBYVgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733091AbfBYVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4E7217F5;
        Mon, 25 Feb 2019 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130561;
        bh=f9t5fgbgrMndqF0xmKDrSOFgaLsSfEcMgQJUj+B3hXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm3A+F1bwbQpmIrYyTbC7rMLpSwmTzCI37YbMkYbpRTd+aGU0GokazgE0eAd0TuzW
         UFJXNkbOLGXVEysu/hKj+ImfngJozd94bPEZRw70A/TXC3NwVXPPRa3YiBSHgdY/If
         vuKBmqJ4M7hQGzfWk0rc1OhFnVQXI3pGjA3VWX1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 160/183] drm/amd/display: Fix MST reboot/poweroff sequence
Date:   Mon, 25 Feb 2019 22:12:13 +0100
Message-Id: <20190225195121.970429942@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo (Hanghong) Ma <hanghong.ma@amd.com>

commit d2f0b53bda3193874f3905bc839888f895d1c0cf upstream.

[Why]

drm_dp_mst_topology_mgr_suspend() is added into the new reboot
sequence, which disables the UP request at the beginning.
Therefore sideband messages are blocked.

[How]

Finish MST sideband message transaction before UP request is
suppressed.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -704,12 +704,13 @@ static int dm_suspend(void *handle)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	int ret = 0;
 
+	WARN_ON(adev->dm.cached_state);
+	adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
+
 	s3_handle_mst(adev->ddev, true);
 
 	amdgpu_dm_irq_suspend(adev);
 
-	WARN_ON(adev->dm.cached_state);
-	adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 


