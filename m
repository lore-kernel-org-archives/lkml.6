Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0CE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0CE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeIMTRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:17:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbeIMTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A836BD06;
        Thu, 13 Sep 2018 14:07:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <mkopec12@gmail.com>,
        "N. W." <nw9165-3201@yahoo.com>,
        Nicholas Stommel <nicholas.stommel@gmail.com>,
        Tom Yan <tom.ty89@gmail.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.18 184/197] drm/i915: set DP Main Stream Attribute for color range on DDI platforms
Date:   Thu, 13 Sep 2018 15:32:13 +0200
Message-Id: <20180913131848.922339925@linuxfoundation.org>
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

From: Jani Nikula <jani.nikula@intel.com>

commit 6209c285e7a5e68dbcdf8fd2456c6dd68433806b upstream.

Since Haswell we have no color range indication either in the pipe or
port registers for DP. Instead, there's a separate register for setting
the DP Main Stream Attributes (MSA) directly. The MSA register
definition makes no references to colorimetry, just a vague reference to
the DP spec. The connection to the color range was lost.

Apparently we've failed to set the proper MSA bit for limited, or CEA,
range ever since the first DDI platforms. We've started setting other
MSA parameters since commit dae847991a43 ("drm/i915: add
intel_ddi_set_pipe_settings").

Without the crucial bit of information, the DP sink has no way of
knowing the source is actually transmitting limited range RGB, leading
to "washed out" colors. With the colorimetry information, compliant
sinks should be able to handle the limited range properly. Native
(i.e. non-LSPCON) HDMI was not affected because we do pass the color
range via AVI infoframes.

Though not the root cause, the problem was made worse for DDI platforms
with commit 55bc60db5988 ("drm/i915: Add "Automatic" mode for the
"Broadcast RGB" property"), which selects limited range RGB
automatically based on the mode, as per the DP, HDMI and CEA specs.

After all these years, the fix boils down to flipping one bit.

[Per testing reports, this fixes DP sinks, but not the LSPCON. My
 educated guess is that the LSPCON fails to turn the CEA range MSA into
 AVI infoframes for HDMI.]

Reported-by: Michał Kopeć <mkopec12@gmail.com>
Reported-by: N. W. <nw9165-3201@yahoo.com>
Reported-by: Nicholas Stommel <nicholas.stommel@gmail.com>
Reported-by: Tom Yan <tom.ty89@gmail.com>
Tested-by: Nicholas Stommel <nicholas.stommel@gmail.com>
References: https://bugs.freedesktop.org/show_bug.cgi?id=100023
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107476
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=94921
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180814060001.18224-1-jani.nikula@intel.com
(cherry picked from commit dc5977da99ea28094b8fa4e9bacbd29bedc41de5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h  |    1 +
 drivers/gpu/drm/i915/intel_ddi.c |    4 ++++
 2 files changed, 5 insertions(+)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -8825,6 +8825,7 @@ enum skl_power_gate {
 #define  TRANS_MSA_10_BPC		(2<<5)
 #define  TRANS_MSA_12_BPC		(3<<5)
 #define  TRANS_MSA_16_BPC		(4<<5)
+#define  TRANS_MSA_CEA_RANGE		(1<<3)
 
 /* LCPLL Control */
 #define LCPLL_CTL			_MMIO(0x130040)
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -1659,6 +1659,10 @@ void intel_ddi_set_pipe_settings(const s
 	WARN_ON(transcoder_is_dsi(cpu_transcoder));
 
 	temp = TRANS_MSA_SYNC_CLK;
+
+	if (crtc_state->limited_color_range)
+		temp |= TRANS_MSA_CEA_RANGE;
+
 	switch (crtc_state->pipe_bpp) {
 	case 18:
 		temp |= TRANS_MSA_6_BPC;


