Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70345C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C2220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C2220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeLIW0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:26:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34854 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002pp-1W; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Oc-LK; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "N. W." <nw9165-3201@yahoo.com>,
        "Tom Yan" <tom.ty89@gmail.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Paulo Zanoni" <paulo.r.zanoni@intel.com>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>,
        "=?UTF-8?Q?Micha=C5=82=20?= =?UTF-8?Q?Kope=C4=87?=" 
        <mkopec12@gmail.com>,
        "Nicholas Stommel" <nicholas.stommel@gmail.com>,
        "Jani Nikula" <jani.nikula@intel.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.87507979@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 141/328] drm/i915: set DP Main Stream Attribute for
 color range on DDI platforms
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180814060001.18224-1-jani.nikula@intel.com
(cherry picked from commit dc5977da99ea28094b8fa4e9bacbd29bedc41de5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[bwh: Backported to 3.16:
 - s/crtc_state->/intel_crtc->config./
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/i915_reg.h  | 1 +
 drivers/gpu/drm/i915/intel_ddi.c | 4 ++++
 2 files changed, 5 insertions(+)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -5918,6 +5918,7 @@ enum punit_power_well {
 #define  TRANS_MSA_10_BPC		(2<<5)
 #define  TRANS_MSA_12_BPC		(3<<5)
 #define  TRANS_MSA_16_BPC		(4<<5)
+#define  TRANS_MSA_CEA_RANGE		(1 << 3)
 
 /* LCPLL Control */
 #define LCPLL_CTL			0x130040
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -929,6 +929,10 @@ void intel_ddi_set_pipe_settings(struct
 	if (type == INTEL_OUTPUT_DISPLAYPORT || type == INTEL_OUTPUT_EDP) {
 
 		temp = TRANS_MSA_SYNC_CLK;
+
+		if (intel_crtc->config.limited_color_range)
+			temp |= TRANS_MSA_CEA_RANGE;
+
 		switch (intel_crtc->config.pipe_bpp) {
 		case 18:
 			temp |= TRANS_MSA_6_BPC;

