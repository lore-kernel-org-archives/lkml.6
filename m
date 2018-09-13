Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE62C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7473120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7473120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeIMS4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:56:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeIMS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:56:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D53D8D19;
        Thu, 13 Sep 2018 13:47:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>
Subject: [PATCH 4.14 087/115] drm/amdgpu: Fix RLC safe mode test in gfx_v9_0_enter_rlc_safe_mode
Date:   Thu, 13 Sep 2018 15:31:47 +0200
Message-Id: <20180913131828.865200923@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 226127a67e31a9518d9516d3e4890759b379d874 upstream.

We were testing the register offset, instead of the value stored in the
register, therefore always timing out the loop.

This reduces suspend time of the system in the bug report below by ~600
ms.

Cc: stable@vger.kernel.org
Bugzilla: https://bugs.freedesktop.org/107277
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3113,7 +3113,7 @@ static void gfx_v9_0_enter_rlc_safe_mode
 
 		/* wait for RLC_SAFE_MODE */
 		for (i = 0; i < adev->usec_timeout; i++) {
-			if (!REG_GET_FIELD(SOC15_REG_OFFSET(GC, 0, mmRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
+			if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, mmRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
 				break;
 			udelay(1);
 		}


