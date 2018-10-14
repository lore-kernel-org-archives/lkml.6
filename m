Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D6C20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D6C20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeJNXMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36230 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cm-Av; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000YI-MU; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Pavel Petrovic" <ppetrovic@acm.org>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>,
        "=?UTF-8?Q?S=C3=A9rgio=20?=M. Basto" <sergio@serjux.com>,
        "Florent Flament" <contact@florentflament.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.380085542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 271/366] drm/i915: Fix drm:intel_enable_lvds ERROR
 message in kernel log
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florent Flament <contact@florentflament.com>

commit e8f48f96db7e482995743f461b3e8a5c1a102533 upstream.

Fix `[drm:intel_enable_lvds] *ERROR* timed out waiting for panel to
power on` in kernel log at boot time.

Toshiba Satellite Z930 laptops needs between 1 and 2 seconds to power
on its screen during Intel i915 DRM initialization. This currently
results in a `[drm:intel_enable_lvds] *ERROR* timed out waiting for
panel to power on` message appearing in the kernel log during boot
time and when stopping the machine.

This change increases the timeout of the `intel_enable_lvds` function
from 1 to 5 seconds, letting enough time for the Satellite 930 LCD
screen to power on, and suppressing the error message from the kernel
log.

This patch has been successfully tested on Linux 4.14 running on a
Toshiba Satellite Z930.

[vsyrjala: bump the timeout from 2 to 5 seconds to match the DP
 code and properly cover the max hw timeout of ~4 seconds, and
 drop the comment about the specific machine since this is not
 a particulary surprising issue, nor specific to that one machine]

Signed-off-by: Florent Flament <contact@florentflament.com>
Cc: Pavel Petrovic <ppetrovic@acm.org>
Cc: Sérgio M. Basto <sergio@serjux.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103414
References: https://bugzilla.kernel.org/show_bug.cgi?id=57591
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180419160700.19828-1-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 280b54ade5914d3b4abe4f0ebe083ddbd4603246)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_lvds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -219,7 +219,8 @@ static void intel_enable_lvds(struct int
 
 	I915_WRITE(ctl_reg, I915_READ(ctl_reg) | POWER_TARGET_ON);
 	POSTING_READ(lvds_encoder->reg);
-	if (wait_for((I915_READ(stat_reg) & PP_ON) != 0, 1000))
+
+	if (wait_for((I915_READ(stat_reg) & PP_ON) != 0, 5000))
 		DRM_ERROR("timed out waiting for panel to power on\n");
 
 	intel_panel_enable_backlight(intel_connector);

