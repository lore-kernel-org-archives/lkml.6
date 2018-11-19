Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F65C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73402148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="py3SNsFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73402148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbeKTDLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeKTDLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:11:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44C9206BA;
        Mon, 19 Nov 2018 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646023;
        bh=vOp8xDvdtez+omukhRXvVZfIDZlhe//wVloqM7X5qbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=py3SNsFfntjS6srN7k0Xa0uIcAVwAVsLKxuWZh7EJr5W3T3vAEvZ0qyLoiCAZyjqy
         01ORiMxOCDnWZzaRB2z4yjU2ZOkvPtCrTDd8m6nDnVncmo08VIDQnTmn1tNlGNkUO2
         qllPZOBMT2StG2ZOOmqNjj/+gI2gRyIk31Cc6Yio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 163/171] drm/i915: Fix error handling for the NV12 fb dimensions check
Date:   Mon, 19 Nov 2018 17:29:19 +0100
Message-Id: <20181119162640.805193973@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit f42f343887016330b321dd40eebc68c7292e4f1b upstream.

Let's not leak obj->framebuffer_references when we decide that
the framebuffer domensions are not suitable for NV12.

Cc: stable@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Vidya Srinivas <vidya.srinivas@intel.com>
Fixes: e44134f2673c ("drm/i915: Add NV12 support to intel_framebuffer_init")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181029140031.11765-1-ville.syrjala@linux.intel.com
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 3b90946fcb6f13b65888c380461793a9dea9d1f4)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -14383,7 +14383,7 @@ static int intel_framebuffer_init(struct
 	     fb->height < SKL_MIN_YUV_420_SRC_H ||
 	     (fb->width % 4) != 0 || (fb->height % 4) != 0)) {
 		DRM_DEBUG_KMS("src dimensions not correct for NV12\n");
-		return -EINVAL;
+		goto err;
 	}
 
 	for (i = 0; i < fb->format->num_planes; i++) {


