Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8704C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764F920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896015;
	bh=ySuW65yNFpjmthIV/poQhuVBsPREjGq+uFEYHCwUp10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YYmQCtBnS7bWvFlGvlk/jHsg6dZDYYiUvSPRX9HXEVTEcCG7FWYVTOIcX9tJcZlJt
	 BOZ3SY12m30uOwsXJUj/uIQ9frzx3QjaIfoa58RZ4Z8ZYk0ancJTqnqGNxrXCvliUl
	 VF9ANWRrexB9/Dedxkb7SjXlkCmynh//NUB+PzWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfBKOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732022AbfBKOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBDA320700;
        Mon, 11 Feb 2019 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896010;
        bh=ySuW65yNFpjmthIV/poQhuVBsPREjGq+uFEYHCwUp10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bei8qra0Fnrt5w24rp8Oek8Kwh1IGlu1E7dhUOwsitw4VFpIC34VZxRz4vnTZpNQf
         upefMlrA/F/N9Pdy0FNCE7dEMeInVklzCSq60zupWQ108CDjpBpqrPZZ/DgPoTX+/d
         DDoq9O/i30AlxLnWvV8B7+T8pKAJAO4ZIBxAcXFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murton Liu <murton.liu@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/313] drm/amd/display: fix gamma not being applied correctly
Date:   Mon, 11 Feb 2019 15:15:23 +0100
Message-Id: <20190211141856.452174173@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index cfcc54f2ce65..33a9d0c58966 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1190,7 +1190,8 @@ static bool dcn10_set_input_transfer_func(struct pipe_ctx *pipe_ctx,
 		tf = plane_state->in_transfer_func;
 
 	if (plane_state->gamma_correction &&
-		!plane_state->gamma_correction->is_identity
+		!dpp_base->ctx->dc->debug.always_use_regamma
+		&& !plane_state->gamma_correction->is_identity
 			&& dce_use_lut(plane_state->format))
 		dpp_base->funcs->dpp_program_input_lut(dpp_base, plane_state->gamma_correction);
 
-- 
2.19.1



