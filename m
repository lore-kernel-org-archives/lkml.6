Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E820652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131321;
	bh=TUj7dWf8HD90/aLE6DeGVJF5AuMukAIWLaMiZ4yFu10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqyqK6olA/OxTaUJ62ObGC6XWYnrpRRm775gBVcEq+6OUWmTKcJkD5hdZLlQ4MiT6
	 OkB3inTN014dS3fhVmWEJ3QfS85nOFooC8tZ80jcF81PIsg9RyhvPNrFN923Hd3MS7
	 rC4DiPIlhUNTP1SW94fW3MxuVoxHTuKFQoxqeZb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfBYVsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfBYV00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF906213A2;
        Mon, 25 Feb 2019 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129985;
        bh=TUj7dWf8HD90/aLE6DeGVJF5AuMukAIWLaMiZ4yFu10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUFalvoQpmqYfMFH7INyCPl5s6yNFNN3+Sg/C+Ar2C6RSaT8+fDT9YX9TvwHRyOUz
         0NH9ojV3xRHZe1VvB5hssS2XSS+txRO6DOUrcuYl7CBUzAAmM9c93dyIFDWjHfUj6p
         A/XX6zydDiadEtcmKK2n8/bfUTZYdArqholEKRjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 129/152] drm/amd/display: Fix MST reboot/poweroff sequence
Date:   Mon, 25 Feb 2019 22:12:01 +0100
Message-Id: <20190225195052.238353652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -624,12 +624,13 @@ static int dm_suspend(void *handle)
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
 


