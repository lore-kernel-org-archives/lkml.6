Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD0CC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2D1206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2D1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbeKGG5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeKGG5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:57:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FD2B394D5C;
        Tue,  6 Nov 2018 21:30:33 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2A9600C7;
        Tue,  6 Nov 2018 21:30:31 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] drm/i915: Clarify flow for disabling IRQs on storms
Date:   Tue,  6 Nov 2018 16:30:15 -0500
Message-Id: <20181106213017.14563-5-lyude@redhat.com>
In-Reply-To: <20181106213017.14563-1-lyude@redhat.com>
References: <20181106213017.14563-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 06 Nov 2018 21:30:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is rather confusing to look at as-is:
dev_priv->display.hpd_irq_setup(dev_priv); in intel_hpd_irq_handler()
handles disabling the actual HPD IRQ, while
intel_hpd_irq_storm_disable() handles moving the HPD pin state over from
MARK_DISABLED to DISABLED along with enabling polling for it.

Changes since v3:
- Rename i915_hpd_irq_storm_disable() to
  i915_hpd_irq_storm_switch_to_polling() - Rodrigo Vivi

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/i915/intel_hotplug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index c11d73de16f2..d642c0795452 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -161,7 +161,8 @@ static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
 	return storm;
 }
 
-static void intel_hpd_irq_storm_disable(struct drm_i915_private *dev_priv)
+static void
+intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
 {
 	struct drm_device *dev = &dev_priv->drm;
 	struct intel_connector *intel_connector;
@@ -351,8 +352,8 @@ static void i915_hotplug_work_func(struct work_struct *work)
 	hpd_event_bits = dev_priv->hotplug.event_bits;
 	dev_priv->hotplug.event_bits = 0;
 
-	/* Disable hotplug on connectors that hit an irq storm. */
-	intel_hpd_irq_storm_disable(dev_priv);
+	/* Enable polling for connectors which had HPD IRQ storms */
+	intel_hpd_irq_storm_switch_to_polling(dev_priv);
 
 	spin_unlock_irq(&dev_priv->irq_lock);
 
@@ -458,6 +459,10 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 		}
 	}
 
+	/*
+	 * Disable any IRQs that storms were detected on. Polling enablement
+	 * happens later in our hotplug work.
+	 */
 	if (storm_detected && dev_priv->display_irqs_enabled)
 		dev_priv->display.hpd_irq_setup(dev_priv);
 	spin_unlock(&dev_priv->irq_lock);
-- 
2.19.1

