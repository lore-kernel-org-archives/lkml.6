Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5B8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD2720663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358763;
	bh=ghw2BXaaw+gfwQX+LSsk7j2mGis4tEF0EETk1Vw0z1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6UUSBctQohzR68ablH+k/hcc/1Ay9rSbAAw7W4/gGjdt3LNvliZbAiIagPofl6qf
	 yDu24gHR4++IaqM3FCDUdjv/vKDFXR4DJSXhJRzPk51G/tzY36Q77q7NCjGP9s//Y4
	 MQpM+l2lL/QE7tzR4b8slHDs7RMd4CIzAL2wtXNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfAXTjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733036AbfAXTjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF165218D3;
        Thu, 24 Jan 2019 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358759;
        bh=ghw2BXaaw+gfwQX+LSsk7j2mGis4tEF0EETk1Vw0z1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B80JdAKDuSYg34q9a+HWehcF9otNhlVKLkRtELwbOCdlX7ClpTF4fm0KNyedh/sN2
         D9wCO7Q5IdoIUHZLzDKL2CsHhYJkZikaCF+gW/Xe/mk+z1FFcZShBWi0iu+dBUdwZ/
         lTlk7I8OU8JAvE8+qzYico0uLmFQuByesI9SP/gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 017/127] drm/amd/display: Guard against null stream_state in set_crc_source
Date:   Thu, 24 Jan 2019 20:19:23 +0100
Message-Id: <20190124190212.917076956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

[ Upstream commit f41a895026b8cb6f765190de7d2e7bc3ccbbd183 ]

[Why]

The igt@kms_plane@pixel-format-pipe tests can create a sequence where
stream_state is NULL during amdgpu_dm_crtc_set_crc_source which results
in a null pointer dereference.

[How]

Guard against stream_state being NULL before accessing its fields. This
doesn't fix the root cause of the issue so a DRM_ERROR is generated
to still fail the tests.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: David Francis <David.Francis@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 01fc5717b657..f088ac585978 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -75,6 +75,11 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		return -EINVAL;
 	}
 
+	if (!stream_state) {
+		DRM_ERROR("No stream state for CRTC%d\n", crtc->index);
+		return -EINVAL;
+	}
+
 	/* When enabling CRC, we should also disable dithering. */
 	if (source == AMDGPU_DM_PIPE_CRC_SOURCE_AUTO) {
 		if (dc_stream_configure_crc(stream_state->ctx->dc,
-- 
2.19.1



