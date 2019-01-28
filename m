Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C0EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AD521741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690339;
	bh=R/tgEZAfbGwJhjaefn86eutFsyBFRhyC6ueHvS8uFuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ed5OSP3GGNd6SIOrNCl1fyXBhQ7Izxb45ctj7/YPpU4L+xEEMTyioYDgP/J0yqEv4
	 KwHvujnLQ2yf4NGZriuhiga2TmHIIJJQVMfhAXunvC/u/caoG6JsqtbIucnucn4hlF
	 n5oU2txrApdoYoMzv401WunamCjaD3EXV4hJr/1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfA1Pph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfA1Ppf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D38821741;
        Mon, 28 Jan 2019 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690335;
        bh=R/tgEZAfbGwJhjaefn86eutFsyBFRhyC6ueHvS8uFuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MdFyCimOzu+881Rx6kElc3T794zF0lexqodT81Z8iRlsZJzEJkYZljd5kkEp5+NK
         dD7k1PyqezSSJ2U/AnsapR43ix1RWS8UKwT9/63/gERamWzsiXM03HwYv29Gf4ni/X
         lV//lt++1YnhW+1FKmgnny+0ECyD6EGDzG2wzcBk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Murton Liu <murton.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 055/304] drm/amd/display: fix gamma not being applied correctly
Date:   Mon, 28 Jan 2019 10:39:32 -0500
Message-Id: <20190128154341.47195-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murton Liu <murton.liu@amd.com>

[ Upstream commit 8ce504b9389be846bcdf512ed5be8f661b3bf097 ]

[why]
Gamma was always being set as identity on SDR monitor,
leading to no changes in gamma. This caused nightlight to
not apply correctly.

[how]
Added a default gamma structure to compare against
in the sdr case.

Signed-off-by: Murton Liu <murton.liu@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 193184affefb..32e4c653b1b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1226,7 +1226,8 @@ static bool dcn10_set_input_transfer_func(struct pipe_ctx *pipe_ctx,
 		tf = plane_state->in_transfer_func;
 
 	if (plane_state->gamma_correction &&
-		!plane_state->gamma_correction->is_identity
+		!dpp_base->ctx->dc->debug.always_use_regamma
+		&& !plane_state->gamma_correction->is_identity
 			&& dce_use_lut(plane_state->format))
 		dpp_base->funcs->dpp_program_input_lut(dpp_base, plane_state->gamma_correction);
 
-- 
2.19.1

