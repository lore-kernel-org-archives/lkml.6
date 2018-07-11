Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E440C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016DD20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016DD20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403753AbeGKXb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:31:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:57387 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389441AbeGKXb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:31:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 79080C009; Thu, 12 Jul 2018 01:25:16 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2] i915/intel_tv_get_modes: fix strncpy truncation warning
Date:   Thu, 12 Jul 2018 01:24:46 +0200
Message-Id: <1531351486-5932-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change it to use strlcpy instead

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

 drivers/gpu/drm/i915/intel_tv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
index b55b5c157e38..25fee7dba7e2 100644
--- a/drivers/gpu/drm/i915/intel_tv.c
+++ b/drivers/gpu/drm/i915/intel_tv.c
@@ -1355,8 +1355,7 @@ intel_tv_get_modes(struct drm_connector *connector)
 		mode_ptr = drm_mode_create(connector->dev);
 		if (!mode_ptr)
 			continue;
-		strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
-		mode_ptr->name[DRM_DISPLAY_MODE_LEN - 1] = '\0';
+		strlcpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
 
 		mode_ptr->hdisplay = hactive_s;
 		mode_ptr->hsync_start = hactive_s + 1;
-- 
2.17.1

