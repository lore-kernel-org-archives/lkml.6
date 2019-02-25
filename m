Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39362173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129299;
	bh=25rw6pliNjvkmYourVvciM/OpDffsdDTj4NjgDrSJMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4zGCRbz5vV1jrNfJcSjA/KKKEdDvNMLL4UVNVaKojJhDxWNXb2re2wie2cjpN9zR
	 SC6J9jjh2ey6hLDugesTPtWHK5esa3HY1B1vU5UxdFcRVhjWr1O5qMPRTGUJKxww8E
	 dp27TM59nHuTYaSb2nrK5M1bUWdp9lTz+p3U3qaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfBYVO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfBYVO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80D52173C;
        Mon, 25 Feb 2019 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129296;
        bh=25rw6pliNjvkmYourVvciM/OpDffsdDTj4NjgDrSJMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kr+AJsXgkshbMW1lvke3vppGtdyFRS35qO2m8MegBW/PJdGnrEma7VZQuTD+Ju21i
         21IaYmrGOJlS27qD/uhRNSewTRm/1w9wmFo45Fx5MmJwJYNn0eCrV49VHy7EoiyVVH
         H/dRBYblObE4THIaBpksj1q3t3cS5qE/wzXBlq8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 48/63] drm/i915: Fix enum pipe vs. enum transcoder for the PCH transcoder
Date:   Mon, 25 Feb 2019 22:11:48 +0100
Message-Id: <20190225195039.502691959@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ville Syrjälä" <ville.syrjala@linux.intel.com>

commit 41c32e5da3ff3922490341a988b2a3ae46d0b6a8 upstream.

Use enum pipe for PCH transcoders also in the FIFO underrun code.

Fixes the following new sparse warnings:
intel_fifo_underrun.c:340:49: warning: mixing different enum types
intel_fifo_underrun.c:340:49:     int enum pipe  versus
intel_fifo_underrun.c:340:49:     int enum transcoder
intel_fifo_underrun.c:344:49: warning: mixing different enum types
intel_fifo_underrun.c:344:49:     int enum pipe  versus
intel_fifo_underrun.c:344:49:     int enum transcoder
intel_fifo_underrun.c:397:57: warning: mixing different enum types
intel_fifo_underrun.c:397:57:     int enum pipe  versus
intel_fifo_underrun.c:397:57:     int enum transcoder
intel_fifo_underrun.c:398:17: warning: mixing different enum types
intel_fifo_underrun.c:398:17:     int enum pipe  versus
intel_fifo_underrun.c:398:17:     int enum transcoder

Cc: Matthias Kaehlcke <mka@chromium.org>
Fixes: a21960339c8c ("drm/i915: Consistently use enum pipe for PCH transcoders")
Signed-off-by: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20170901143123.7590-3-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
[nc: Backport to 4.9, drop unneeded hunks]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/intel_fifo_underrun.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/intel_fifo_underrun.c
+++ b/drivers/gpu/drm/i915/intel_fifo_underrun.c
@@ -185,11 +185,11 @@ static void broadwell_set_fifo_underrun_
 }
 
 static void ibx_set_fifo_underrun_reporting(struct drm_device *dev,
-					    enum transcoder pch_transcoder,
+					    enum pipe pch_transcoder,
 					    bool enable)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
-	uint32_t bit = (pch_transcoder == TRANSCODER_A) ?
+	uint32_t bit = (pch_transcoder == PIPE_A) ?
 		       SDE_TRANSA_FIFO_UNDER : SDE_TRANSB_FIFO_UNDER;
 
 	if (enable)
@@ -201,7 +201,7 @@ static void ibx_set_fifo_underrun_report
 static void cpt_check_pch_fifo_underruns(struct intel_crtc *crtc)
 {
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
-	enum transcoder pch_transcoder = (enum transcoder) crtc->pipe;
+	enum pipe pch_transcoder = crtc->pipe;
 	uint32_t serr_int = I915_READ(SERR_INT);
 
 	assert_spin_locked(&dev_priv->irq_lock);
@@ -212,12 +212,12 @@ static void cpt_check_pch_fifo_underruns
 	I915_WRITE(SERR_INT, SERR_INT_TRANS_FIFO_UNDERRUN(pch_transcoder));
 	POSTING_READ(SERR_INT);
 
-	DRM_ERROR("pch fifo underrun on pch transcoder %s\n",
-		  transcoder_name(pch_transcoder));
+	DRM_ERROR("pch fifo underrun on pch transcoder %c\n",
+		  pipe_name(pch_transcoder));
 }
 
 static void cpt_set_fifo_underrun_reporting(struct drm_device *dev,
-					    enum transcoder pch_transcoder,
+					    enum pipe pch_transcoder,
 					    bool enable, bool old)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
@@ -235,8 +235,8 @@ static void cpt_set_fifo_underrun_report
 
 		if (old && I915_READ(SERR_INT) &
 		    SERR_INT_TRANS_FIFO_UNDERRUN(pch_transcoder)) {
-			DRM_ERROR("uncleared pch fifo underrun on pch transcoder %s\n",
-				  transcoder_name(pch_transcoder));
+			DRM_ERROR("uncleared pch fifo underrun on pch transcoder %c\n",
+				  pipe_name(pch_transcoder));
 		}
 	}
 }
@@ -388,8 +388,8 @@ void intel_pch_fifo_underrun_irq_handler
 {
 	if (intel_set_pch_fifo_underrun_reporting(dev_priv, pch_transcoder,
 						  false))
-		DRM_ERROR("PCH transcoder %s FIFO underrun\n",
-			  transcoder_name(pch_transcoder));
+		DRM_ERROR("PCH transcoder %c FIFO underrun\n",
+			  pipe_name(pch_transcoder));
 }
 
 /**


