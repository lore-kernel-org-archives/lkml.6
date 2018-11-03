Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D1EC65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638272081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638272081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeKCJ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeKCJ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F12AE3082B6F;
        Sat,  3 Nov 2018 00:19:20 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD205D9CD;
        Sat,  3 Nov 2018 00:19:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] drm/i915: Fix threshold check in intel_hpd_irq_storm_detect()
Date:   Fri,  2 Nov 2018 20:19:06 -0400
Message-Id: <20181103001909.23645-4-lyude@redhat.com>
In-Reply-To: <20181103001909.23645-1-lyude@redhat.com>
References: <20181103001909.23645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 03 Nov 2018 00:19:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in intel_hpd_irq_storm_detect() when we detect that the last
recorded hotplug wasn't within the period defined by
HPD_STORM_DETECT_DELAY, we make the mistake of resetting the HPD count
to 0 without incrementing it. This results in us only enabling storm
detection when we go +2 above the threshold, e.g. an HPD threshold of 5
would not trigger a storm until we reach a total of 7 hotplugs.

So: rework the code a bit so we reset the HPD count when
HPD_STORM_DETECT_DELAY has passed, then increment the count afterwards.
Also, clean things up a bit to make it easier to undertand.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/intel_hotplug.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index 8326900a311e..c11d73de16f2 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -135,24 +135,27 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
 static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
 				       enum hpd_pin pin)
 {
-	unsigned long start = dev_priv->hotplug.stats[pin].last_jiffies;
+	struct i915_hotplug *hpd = &dev_priv->hotplug;
+	unsigned long start = hpd->stats[pin].last_jiffies;
 	unsigned long end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
-	const int threshold = dev_priv->hotplug.hpd_storm_threshold;
+	const int threshold = hpd->hpd_storm_threshold;
 	bool storm = false;
 
+	if (!threshold)
+		return false;
+
 	if (!time_in_range(jiffies, start, end)) {
-		dev_priv->hotplug.stats[pin].last_jiffies = jiffies;
-		dev_priv->hotplug.stats[pin].count = 0;
-		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: 0\n", pin);
-	} else if (dev_priv->hotplug.stats[pin].count > threshold &&
-		   threshold) {
-		dev_priv->hotplug.stats[pin].state = HPD_MARK_DISABLED;
+		hpd->stats[pin].last_jiffies = jiffies;
+		hpd->stats[pin].count = 0;
+	}
+
+	if (++hpd->stats[pin].count > threshold) {
+		hpd->stats[pin].state = HPD_MARK_DISABLED;
 		DRM_DEBUG_KMS("HPD interrupt storm detected on PIN %d\n", pin);
 		storm = true;
 	} else {
-		dev_priv->hotplug.stats[pin].count++;
 		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: %d\n", pin,
-			      dev_priv->hotplug.stats[pin].count);
+			      hpd->stats[pin].count);
 	}
 
 	return storm;
-- 
2.19.1

