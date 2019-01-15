Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09240C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD8A20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570548;
	bh=pega+TEvVe1F4Vbdb5BfF7Wd8SiLMsjZPeUedBy7ZFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HSkiYqRUfD1FeX0zCgsebSpNQR4SzQLMfvbf1DfPqOqzBwlXF8KxzzdGGxrQtsKyu
	 8O5DIhJOkJFRZQpT5HmEe/nUH19tZeXhwXM16e/j1jv9RXNIhB1a08t9NFBAYCp7Al
	 jXI3CMZDe3wqPCjOZwskGv3wszPiGGqmwSyT8ENY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfAOQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732947AbfAOQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613E320645;
        Tue, 15 Jan 2019 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570542;
        bh=pega+TEvVe1F4Vbdb5BfF7Wd8SiLMsjZPeUedBy7ZFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDcn9VeRt/Pm9c49H+fHoBtQl4nUugNtVnI5boahOWCUCHyEmgy++UNQdJNyoRh24
         I1iTOeqtwnQAapAPwleOYhsYQrlXqTRiENiZK0xIdJcOnwPn8OwE8gIE58dS1HY9f5
         MxFbVOxvkJ8YDmZ7sjW7uhjmLlVmXQsJj0HYhhwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH 4.19 31/50] drm/amd/display: Fix MST dp_blank REG_WAIT timeout
Date:   Tue, 15 Jan 2019 17:36:07 +0100
Message-Id: <20190115154911.714709573@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

From: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>

commit 8c9d90eebd23b6d40ddf4ce5df5ca2b932336a06 upstream.

Need to blank stream before deallocate MST payload.

[drm:generic_reg_wait [amdgpu]] *ERROR* REG_WAIT timeout 10us * 3000 tries - dce110_stream_encoder_dp_blank line:944
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2201 at /var/lib/dkms/amdgpu/18.50-690240/build/amd/amdgpu/../display/dc/dc_helper.c:249 generic_reg_wait+0xe7/0x160 [amdgpu]
Call Trace:
 dce110_stream_encoder_dp_blank+0x11c/0x180 [amdgpu]
 core_link_disable_stream+0x40/0x230 [amdgpu]
 ? generic_reg_update_ex+0xdb/0x130 [amdgpu]
 dce110_reset_hw_ctx_wrap+0xb7/0x1f0 [amdgpu]
 dce110_apply_ctx_to_hw+0x30/0x430 [amdgpu]
 ? dce110_apply_ctx_for_surface+0x206/0x260 [amdgpu]
 dc_commit_state+0x2ba/0x4d0 [amdgpu]
 amdgpu_dm_atomic_commit_tail+0x297/0xd70 [amdgpu]
 ? amdgpu_bo_pin_restricted+0x58/0x260 [amdgpu]
 ? wait_for_completion_timeout+0x1f/0x120
 ? wait_for_completion_interruptible+0x1c/0x160
 commit_tail+0x3d/0x60 [drm_kms_helper]
 drm_atomic_helper_commit+0xf6/0x100 [drm_kms_helper]
 drm_atomic_connector_commit_dpms+0xe5/0xf0 [drm]
 drm_mode_obj_set_property_ioctl+0x14f/0x250 [drm]
 drm_mode_connector_property_set_ioctl+0x2e/0x40 [drm]
 drm_ioctl+0x1e0/0x430 [drm]
 ? drm_mode_connector_set_obj_prop+0x70/0x70 [drm]
 ? ep_read_events_proc+0xb0/0xb0
 ? ep_scan_ready_list.constprop.18+0x1e6/0x1f0
 ? timerqueue_add+0x52/0x80
 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
 do_vfs_ioctl+0x90/0x5f0
 SyS_ioctl+0x74/0x80
 do_syscall_64+0x74/0x140
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
---[ end trace 3ed7b77a97d60f72 ]---

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2457,11 +2457,11 @@ void core_link_disable_stream(struct pip
 {
 	struct dc  *core_dc = pipe_ctx->stream->ctx->dc;
 
+	core_dc->hwss.blank_stream(pipe_ctx);
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
 
-	core_dc->hwss.blank_stream(pipe_ctx);
-
 	core_dc->hwss.disable_stream(pipe_ctx, option);
 
 	disable_link(pipe_ctx->stream->sink->link, pipe_ctx->stream->signal);


