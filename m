Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8942146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543699;
	bh=gv2QnKT0KoR97nO5M8vqZQEAs5RW/cZavRnuV7gk9l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVLDIFmCZIDcMnreOHY4hqe8RlQOVPNhCTFRPa7R8wOXLxRKurmFfQYJ9ZIxnWv3Z
	 ahmgcXbVZjDk1hD05Bmb0YuGhinuyT6d6zd+TSWiQmq9I2tUVwDzKMOhzhSWRuySKW
	 aQ36Z6HfOdkbyUSfky9TrvaHiVv534PM+FCvSzgU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8942146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeLKPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbeLKPyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B5820855;
        Tue, 11 Dec 2018 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543693;
        bh=gv2QnKT0KoR97nO5M8vqZQEAs5RW/cZavRnuV7gk9l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIAi5awx1kWloPlr8DIP0hhlNe1inHC1/fwXi3IFNs14t9K+juEcgWUM2fd6TgNAB
         xLgRfdtJs0kurY1si9sJ8IzKsWk3g1LSeVVabUbpi0smWW2dPnkD0ARkToLk8eKPdq
         l9sjbCpawmvc47glc9iqLo0gT4mJUYe1MSsnrLbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/118] drm/amdgpu: Add amdgpu "max bpc" connector property (v2)
Date:   Tue, 11 Dec 2018 16:40:46 +0100
Message-Id: <20181211151645.333445528@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

[ Upstream commit 69756c6ff0de478c10100481f16c966dde3b5339 ]

[Why]
Many panels support more than 8bpc but some modes are unavailable while
running at greater than 8bpc due to DP/HDMI bandwidth constraints.

Support for more than 8bpc was added recently in the driver but it
defaults to the maximum supported bpc - locking out these modes.

This should be a user configurable option such that the user can select
what bpc configuration they would like.

[How]
This patch introduces the "max bpc" amdgpu driver specific connector
property so the user can limit the maximum bpc. It ranges from 8 to 16.

This doesn't directly set the preferred bpc for the panel since it
follows Intel's existing driver conventions.

This proprety should be removed once common drm support for max bpc
lands.

v2: rebase on upstream (Alex)

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 6748cd7fc129..686a26de50f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -626,6 +626,13 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 					 "dither",
 					 amdgpu_dither_enum_list, sz);
 
+	if (amdgpu_device_has_dc_support(adev)) {
+		adev->mode_info.max_bpc_property =
+			drm_property_create_range(adev->ddev, 0, "max bpc", 8, 16);
+		if (!adev->mode_info.max_bpc_property)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index b9e9e8b02fb7..d1b4d9b6aae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -339,6 +339,8 @@ struct amdgpu_mode_info {
 	struct drm_property *audio_property;
 	/* FMT dithering */
 	struct drm_property *dither_property;
+	/* maximum number of bits per channel for monitor color */
+	struct drm_property *max_bpc_property;
 	/* hardcoded DFP edid from BIOS */
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
-- 
2.19.1



