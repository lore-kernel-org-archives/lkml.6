Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706152145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706152145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeKULJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeKULJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 740E83082A2F;
        Wed, 21 Nov 2018 00:37:41 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66F0E18978;
        Wed, 21 Nov 2018 00:37:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Synchronize hpd work in i915_hpd_storm_ctl_show()
Date:   Tue, 20 Nov 2018 19:37:17 -0500
Message-Id: <20181121003718.17704-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 21 Nov 2018 00:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add a chamelium test for short HPD IRQs, I ran into
issues where a hotplug storm would be triggered, but the point at which
it would be reported by the kernel would be after igt actually finished
checking i915_hpd_storm_ctl's status. So, fix this by simply
synchronizing our IRQ work, dig_port_work, and hotplug_work before
printing out the HPD storm status in i915_hpd_storm_ctl_show().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 69447c68b9af..af4268a6d2d9 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4592,6 +4592,13 @@ static int i915_hpd_storm_ctl_show(struct seq_file *m, void *data)
 	struct drm_i915_private *dev_priv = m->private;
 	struct i915_hotplug *hotplug = &dev_priv->hotplug;
 
+	/* Synchronize with everything first in case there's been an HPD
+	 * storm, but we haven't finished handling it in the kernel yet
+	 */
+	synchronize_irq(dev_priv->drm.irq);
+	flush_work(&dev_priv->hotplug.dig_port_work);
+	flush_work(&dev_priv->hotplug.hotplug_work);
+
 	seq_printf(m, "Threshold: %d\n", hotplug->hpd_storm_threshold);
 	seq_printf(m, "Detected: %s\n",
 		   yesno(delayed_work_pending(&hotplug->reenable_work)));
-- 
2.19.1

