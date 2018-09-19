Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA290ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE62214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE62214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeISRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:46:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:62396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeISRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:46:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 05:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91426762"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 05:08:50 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
In-Reply-To: <CAB4CAwdfTZ879LXpXGMiMrYi4kCJJBxggGGTi_REYkuRMvz2PQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com> <20180705144009.GC5565@intel.com> <CAB4CAwfQxrfRF=MaJZqagtRyPfJOdHjcS32GTqyG8cOg5=UgKw@mail.gmail.com> <CAB4CAwdjPFLTj+bL+bAeXw2cwAtk9tWFxPPaATpQ4QbuZsM0ew@mail.gmail.com> <87tvnjlsap.fsf@intel.com> <CAB4CAwdUiFrPVTFsz3iC=x2yTTis0n1V4BzozXPMf7EeD52gvA@mail.gmail.com> <CAB4CAwdfTZ879LXpXGMiMrYi4kCJJBxggGGTi_REYkuRMvz2PQ@mail.gmail.com>
Date:   Wed, 19 Sep 2018 15:08:57 +0300
Message-ID: <87k1nhy9ie.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Chris Chiu <chiu@endlessm.com> wrote:
> I tried to add a slight delay in the hotplug work as follows
>
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -378,6 +378,8 @@ static void do_i915_hotplug_check(struct work_struct *work,
>
>         spin_unlock_irq(&dev_priv->irq_lock);
>
> +       msleep(100);
> +
>         drm_connector_list_iter_begin(dev, &conn_iter);
>         drm_for_each_connector_iter(connector, &conn_iter) {
>                 intel_connector = to_intel_connector(connector);
>
> It does work in most cases, but still fail to update the status if I
> unplug the HDMI
> cable very slow. I basically pull the HDMI cable in loose connected
> state first, and
> hold in that state ~1 second, totally unplug after that. The status in
> sysfs will report
> connected as it used to. There was no problem when I tried the patch
> https://bugs.freedesktop.org/show_bug.cgi?id=107125#c8
>
> I'll try to modify this patch a little bit and send upstream for
> discussion later. Please
> advise if any. Thanks.

Please let's not add excessive msleeps in work functions.

My idea was more along the lines of making the hotplug function run in a
delayed work. After a chat with Ville, below is what I came up with.

Please let me know how it works. Feel free to toy with the
delay. However, 1-2 seconds or more seems too much.

BR,
Jani.



From 72515b3e856171e52e96bb74796774f595a7f418 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 18 Sep 2018 13:12:34 +0300
Subject: [PATCH] drm/i915: delay hotplug scheduling
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Jani Nikula <jani.nikula@intel.com>

On some systems we get the hotplug irq on unplug before the DDC pins
have been disconnected, resulting in connector status remaining
connected. Since previous attempts at using hotplug live status before
DDC have failed, the only viable option is to reduce the window for
mistakes. Delay the hotplug processing.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h      |  2 +-
 drivers/gpu/drm/i915/intel_hotplug.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 7d4daa7412f1..27f579abddae 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -286,7 +286,7 @@ enum hpd_pin {
 #define HPD_STORM_DEFAULT_THRESHOLD 5
 
 struct i915_hotplug {
-	struct work_struct hotplug_work;
+	struct delayed_work hotplug_work;
 
 	struct {
 		unsigned long last_jiffies;
diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index 648a13c6043c..3af64daa5cfc 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -110,6 +110,8 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
 	}
 }
 
+#define HOTPLUG_DELAY_MS		300
+
 #define HPD_STORM_DETECT_PERIOD		1000
 #define HPD_STORM_REENABLE_DELAY	(2 * 60 * 1000)
 
@@ -319,7 +321,8 @@ static void i915_digport_work_func(struct work_struct *work)
 		spin_lock_irq(&dev_priv->irq_lock);
 		dev_priv->hotplug.event_bits |= old_bits;
 		spin_unlock_irq(&dev_priv->irq_lock);
-		schedule_work(&dev_priv->hotplug.hotplug_work);
+		schedule_delayed_work(&dev_priv->hotplug.hotplug_work,
+				      msecs_to_jiffies(HOTPLUG_DELAY_MS));
 	}
 }
 
@@ -329,7 +332,7 @@ static void i915_digport_work_func(struct work_struct *work)
 static void i915_hotplug_work_func(struct work_struct *work)
 {
 	struct drm_i915_private *dev_priv =
-		container_of(work, struct drm_i915_private, hotplug.hotplug_work);
+		container_of(work, struct drm_i915_private, hotplug.hotplug_work.work);
 	struct drm_device *dev = &dev_priv->drm;
 	struct intel_connector *intel_connector;
 	struct intel_encoder *intel_encoder;
@@ -466,7 +469,8 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 	if (queue_dig)
 		queue_work(dev_priv->hotplug.dp_wq, &dev_priv->hotplug.dig_port_work);
 	if (queue_hp)
-		schedule_work(&dev_priv->hotplug.hotplug_work);
+		schedule_delayed_work(&dev_priv->hotplug.hotplug_work,
+				      msecs_to_jiffies(HOTPLUG_DELAY_MS));
 }
 
 /**
@@ -586,7 +590,8 @@ void intel_hpd_poll_init(struct drm_i915_private *dev_priv)
 
 void intel_hpd_init_work(struct drm_i915_private *dev_priv)
 {
-	INIT_WORK(&dev_priv->hotplug.hotplug_work, i915_hotplug_work_func);
+	INIT_DELAYED_WORK(&dev_priv->hotplug.hotplug_work,
+			  i915_hotplug_work_func);
 	INIT_WORK(&dev_priv->hotplug.dig_port_work, i915_digport_work_func);
 	INIT_WORK(&dev_priv->hotplug.poll_init_work, i915_hpd_poll_init_work);
 	INIT_DELAYED_WORK(&dev_priv->hotplug.reenable_work,
@@ -604,7 +609,7 @@ void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
 	spin_unlock_irq(&dev_priv->irq_lock);
 
 	cancel_work_sync(&dev_priv->hotplug.dig_port_work);
-	cancel_work_sync(&dev_priv->hotplug.hotplug_work);
+	cancel_delayed_work_sync(&dev_priv->hotplug.hotplug_work);
 	cancel_work_sync(&dev_priv->hotplug.poll_init_work);
 	cancel_delayed_work_sync(&dev_priv->hotplug.reenable_work);
 }
-- 
2.11.0


-- 
Jani Nikula, Intel Open Source Graphics Center
