Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4EC20666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NitFmy3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4EC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIZUi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:38:58 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:44060 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeIZUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:38:58 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CFC1F24E238D;
        Wed, 26 Sep 2018 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537971945; bh=ReVafM3t9npTlHFTc12wOnkxcS9D2M+4a44nR9nLSDM=;
        h=From:To:Cc:Subject:Date:From;
        b=NitFmy3jAZua4yQnmew77fgKsWhWUPq/JJBMjRELx/dRPAulu43+UqfHEmWmEGTvD
         /gI4LpxyAlq+nIQnLY3AmOQbn7nGZPDsaMt+eQs1UgmR16FJG6tD27o7J0vPwndhNj
         qamcmd0widoWSUVs978U+sCqqrxczxqhBUHzlBkK6oHa291UQJ9PL75y6HOj68Aq3V
         uN9L7CY/R7gWZkRyOJkyJIdfcJkgk9LfVGbo5+raQfnFFf/pT5nIiBuITtez69obDc
         NqdM2/XNx4JGqrAlsZSk6BI5MoZ1tJ0dqHXVE1mHH9MD7EmT+3PRgFEdzJ1RGfTgAB
         rvDIKT3i1Oa9A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8155E5CD0;
        Wed, 26 Sep 2018 07:25:38 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] DRM: VBLANK: provide valid timestamp for EVENT_FLIP
Date:   Wed, 26 Sep 2018 17:25:35 +0300
Message-Id: <20180926142535.17997-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver/HW doesn't support vblank functionality (for example
UDL driver, ARCPGU driver, ...) we always have vblank->time == 0.
In result we always provide zero timestamp for
DRM_EVENT_FLIP_COMPLETE. This breaks userspace apps (for example
weston) which relies on timestamp value.

Setup time to provide valid timestamp for DRM_EVENT_FLIP_COMPLETE
event.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/drm_vblank.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 28cdcf76b6f9..0d19aca48782 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -911,6 +911,15 @@ void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 
 	if (dev->num_crtcs > 0) {
 		seq = drm_vblank_count_and_time(dev, pipe, &now);
+
+		/*
+		 * If driver/HW doesn't support vblank functionality we
+		 * always have vblank->time == 0. Setup time to provide valid
+		 * timestamp for DRM_EVENT_FLIP_COMPLETE event.
+		 */
+		if (!now && e->event.base.type == DRM_EVENT_FLIP_COMPLETE)
+			now = ktime_get();
+
 	} else {
 		seq = 0;
 
-- 
2.14.4

