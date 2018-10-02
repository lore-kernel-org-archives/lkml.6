Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85D22083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85D22083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeJBU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:58:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:08 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0F1D4BF0;
        Tue,  2 Oct 2018 13:26:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 026/228] drm/amd/display: fix use of uninitialized memory
Date:   Tue,  2 Oct 2018 06:22:03 -0700
Message-Id: <20181002132500.847926910@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[ Upstream commit f3e077d95ca0a016fdf3d6b1e97a9910dfdaff17 ]

DML does not calculate chroma values for RQ when surface is not YUV, but DC
will unconditionally use the uninitialized values for HW programming.
This does not cause visual corruption since HW will ignore garbage chroma
values when surface is not YUV, but causes presubmission tests to fail
golden value comparison.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -239,6 +239,8 @@ void dml1_extract_rq_regs(
 	extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_l), rq_param.sizing.rq_l);
 	if (rq_param.yuv420)
 		extract_rq_sizing_regs(mode_lib, &(rq_regs->rq_regs_c), rq_param.sizing.rq_c);
+	else
+		memset(&(rq_regs->rq_regs_c), 0, sizeof(rq_regs->rq_regs_c));
 
 	rq_regs->rq_regs_l.swath_height = dml_log2(rq_param.dlg.rq_l.swath_height);
 	rq_regs->rq_regs_c.swath_height = dml_log2(rq_param.dlg.rq_c.swath_height);


