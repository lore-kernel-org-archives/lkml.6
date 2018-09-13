Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0A220652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0A220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeIMTNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:13:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeIMTNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:13:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AB47D32;
        Thu, 13 Sep 2018 14:03:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Mikita Lipski <Mikita.Lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 167/197] drm/amd/display: Use requested HDMI aspect ratio
Date:   Thu, 13 Sep 2018 15:31:56 +0200
Message-Id: <20180913131848.237358083@linuxfoundation.org>
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

From: Leo (Sunpeng) Li <sunpeng.li@amd.com>

commit e11d41472a50742c16d53c968e143fb498fa482f upstream.

[Why]
The DRM mode's HDMI picture aspect ratio field was never saved in
dc_stream's timing struct. This causes us to mistake a new stream to
have the same timings as the old, even though the user has requested a
different aspect ratio.

[How]
Save DRM's aspect ratio field within dc_stream's timing struct.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=107153
Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2124,13 +2124,8 @@ convert_color_depth_from_display_info(co
 static enum dc_aspect_ratio
 get_aspect_ratio(const struct drm_display_mode *mode_in)
 {
-	int32_t width = mode_in->crtc_hdisplay * 9;
-	int32_t height = mode_in->crtc_vdisplay * 16;
-
-	if ((width - height) < 10 && (width - height) > -10)
-		return ASPECT_RATIO_16_9;
-	else
-		return ASPECT_RATIO_4_3;
+	/* 1-1 mapping, since both enums follow the HDMI spec. */
+	return (enum dc_aspect_ratio) mode_in->picture_aspect_ratio;
 }
 
 static enum dc_color_space


