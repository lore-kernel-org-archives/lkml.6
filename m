Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403762175F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403762175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeHMNhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:37:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:44882 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbeHMNhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:37:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 03:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,233,1531810800"; 
   d="scan'208";a="62741949"
Received: from sorvi.fi.intel.com ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2018 03:55:47 -0700
Message-ID: <1534157747.30780.19.camel@intel.com>
Subject: Re: [Intel-gfx] [v3] drm/i915: Add detection of changing of edid on
 between suspend and resume
From:   Mika Kahola <mika.kahola@intel.com>
Reply-To: mika.kahola@intel.com
To:     "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>,
        "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Date:   Mon, 13 Aug 2018 13:55:47 +0300
In-Reply-To: <919efd746382923946f9f443909cec65590ffc37.camel@intel.com>
References: <20180803163453.7760-1-gwan-gyeong.mun@intel.com>
         <20180809111330.5113-1-gwan-gyeong.mun@intel.com>
         <919efd746382923946f9f443909cec65590ffc37.camel@intel.com>
Organization: Intel OTC
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 13:02 +0000, Lisovskiy, Stanislav wrote:
> On Thu, 2018-08-09 at 14:13 +0300, Gwan-gyeong Mun wrote:
> > 
> > The hotplug detection routine of i915 uses
> > drm_helper_hpd_irq_event(). This
> > helper can detect changing of status of connector, but it can not
> > detect
> > changing of edid.
> > 
> > Following scenario requires detection of changing of edid.
> > 
> >  1) plug display device to a connector
> >  2) system suspend
> >  3) unplug 1)'s display device and plug the other display device to
> > a
> > connector
> >  4) system resume
> > 
> > It adds edid check routine when a connector status still remains as
> > "connector_status_connected".
> > 
> > v2: Add NULL check before comparing of EDIDs.
> > 
> > Testcase: igt/kms_chamelium/hdmi-edid-change-during-hibernate
> > Testcase: igt/kms_chamelium/hdmi-edid-change-during-suspend
> > Testcase: igt/kms_chamelium/dp-edid-change-during-hibernate
> > Testcase: igt/kms_chamelium/dp-edid-change-during-suspend
> > 
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > ---
> >  drivers/gpu/drm/i915/intel_hotplug.c | 84
> > +++++++++++++++++++++++++++-
> >  1 file changed, 83 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_hotplug.c
> > b/drivers/gpu/drm/i915/intel_hotplug.c
> > index 648a13c6043c..965f2d771fc0 100644
> > --- a/drivers/gpu/drm/i915/intel_hotplug.c
> > +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> > @@ -507,6 +507,88 @@ void intel_hpd_init(struct drm_i915_private
> > *dev_priv)
> >  	}
> >  }
> >  
> > +/**
> > + * intel_hpd_irq_event - hotplug processing
> > + * @dev: drm_device
> > + *
> > + * Drivers can use this function to run a detect cycle on all
> > connectors which
> > + * have the DRM_CONNECTOR_POLL_HPD flag set in their &polled
> > member.
> > All other
> > + * connectors are ignored, which is useful to avoid reprobing
> > fixed
> > panels.
> > + *
> > + * This function is useful for drivers which can't or don't track
> > hotplug interrupts
> > + * for each connector. This function is based on
> > drm_helper_hpd_irq_event() helper
> > + * function and besides it adds edid check routine when a
> > connector
> > status still
> > + * remains as "connector_status_connected".
> > + *
> > + * Following scenario requires detection of changing of edid.
> > + *  1) plug display device to a connector
> > + *  2) system suspend
> > + *  3) unplug 1)'s display device and plug the other display
> > device
> > to a connector
> > + *  4) system resume
> > +
> > + * This function must be called from process context with no mode
> > + * setting locks held.
> > + *
> > + * Note that a connector can be both polled and probed from the
> > hotplug handler,
> > + * in case the hotplug interrupt is known to be unreliable.
> > + */
> > +static bool intel_hpd_irq_event(struct drm_device *dev)
> > +{
> > +	struct drm_connector *connector;
> > +	struct drm_connector_list_iter conn_iter;
> > +	enum drm_connector_status old_status, cur_status;
> > +	struct edid *old_edid;
> > +	bool changed = false;
> > +
> > +	if (!dev->mode_config.poll_enabled)
> > +		return false;
> > +
> > +	mutex_lock(&dev->mode_config.mutex);
> > +	drm_connector_list_iter_begin(dev, &conn_iter);
> > +	drm_for_each_connector_iter(connector, &conn_iter) {
> > +		/* Only handle HPD capable connectors. */
> > +		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
> > +			continue;
> > +
> > +		old_status = connector->status;
> > +		old_edid = to_intel_connector(connector)-
> > > 
> > > detect_edid;
> > +
> > +		cur_status = drm_helper_probe_detect(connector,
> > NULL, false);
> > +		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] status updated
> > from
> > %s to %s\n",
> > +			      connector->base.id, connector->name,
> > +			      drm_get_connector_status_name(old_st
> > at
> > us),
> > +			      drm_get_connector_status_name(cur_st
> > at
> > us));
> > +
> > +		if (old_status != cur_status)
> > +			changed = true;
> > +
> > +		/* Check changing of edid when a connector status
> > still remains
> > +		 * as "connector_status_connected".
> > +		 */
> > +		if (old_status == cur_status &&
> > +		    cur_status == connector_status_connected) {
> > +			struct edid *cur_edid =
> > to_intel_connector(connector)->detect_edid;
> > +
> > +			if (!old_edid || !cur_edid)
> > +				continue;
> > +
> > +			if (memcmp(old_edid, cur_edid,
> > sizeof(*cur_edid))) {
> > +				changed = true;
> > +				DRM_DEBUG_KMS("[CONNECTOR:%d:%s]
> > edid updated\n",
> > +					      connector->base.id,
> > +					      connector->name);
> > +			}
> > +		}
> > +	}
> > +	drm_connector_list_iter_end(&conn_iter);
> > +	mutex_unlock(&dev->mode_config.mutex);
> > +
> > +	if (changed)
> > +		drm_kms_helper_hotplug_event(dev);
> > +
> > +	return changed;
> > +}
> > +
> >  static void i915_hpd_poll_init_work(struct work_struct *work)
> >  {
> >  	struct drm_i915_private *dev_priv =
> > @@ -552,7 +634,7 @@ static void i915_hpd_poll_init_work(struct
> > work_struct *work)
> >  	 * in the middle of disabling polling
> >  	 */
> >  	if (!enabled)
> > -		drm_helper_hpd_irq_event(dev);
> > +		intel_hpd_irq_event(dev);
> >  }
> Just wondering, as I saw previously drm_helper_hpd_irq_event function
> was used, which basically does the same thing, except doing memcmp
> for detecting the edid change. Is it only Intel specific change? As
> we
> could just add this modification to existing helper function or add
> another helper function to the drm (drm_probe_helper.c), so that it
> is
> also usable elsewhere..
I second Stanislav's proposal to add this feature as part of drm. This
edid check could be part of existing drm_helper_hpd_irq_event()
function. Other drivers might find this change useful.

> 
> > 
> >  
> >  /**
> -- 
> Best Regards,
> 
> Lisovskiy Stanislav
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
-- 
Mika Kahola - Intel OTC

