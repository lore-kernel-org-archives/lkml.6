Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5F214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C5F214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeIQXpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:45:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:32650 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIQXpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:45:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 11:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="73961672"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 17 Sep 2018 11:16:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 17 Sep 2018 21:16:41 +0300
Date:   Mon, 17 Sep 2018 21:16:41 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
Message-ID: <20180917181641.GQ5565@intel.com>
References: <20180917174344.22011-1-lyude@redhat.com>
 <20180917175545.GP5565@intel.com>
 <54c01a13f382aacd7cd4d75a642630053f54b8f1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c01a13f382aacd7cd4d75a642630053f54b8f1.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:10:02PM -0400, Lyude Paul wrote:
> On Mon, 2018-09-17 at 20:55 +0300, Ville Syrjälä wrote:
> > On Mon, Sep 17, 2018 at 01:43:44PM -0400, Lyude Paul wrote:
> > > Userspace asked them to be forced off, so why would we care about what a
> > > probe tells us?
> > 
> > I believe there should be force checks in the callers already.
> > Or are we missing some?
> 
> JFYI, what triggered me to send this patch are these error messages that come
> from nouveau when a hotplug happens on a port that we've forced off:
> 
> [ 1903.918104] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-2
> [ 1903.918123] [drm:drm_helper_hpd_irq_event [drm_kms_helper]] [CONNECTOR:61:DP-2] status updated from disconnected to disconnected
> 
> That being said; I'm sure there are probably some checks missing, but I don't
> really see the purpose in calling the driver's probe functions at all if they're
> just supposed to return the status we forced.

Digging through my cobweb ridden local git repository I found this:

commit bbd17813a7c7d0210c619365707044d0fb29e3f0
Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
Date:   Mon Jun 10 15:28:55 2013 +0300

    drm: Ignore forced connectors in drm_helper_hpd_irq_event()
    
    drm_helper_hpd_irq_event() calls the connector's .detect() function
    even for forced connectors. If the returned status doesn't match the
    forced status, we will send the hotplug event, causing userspace to
    re-probe all the connectors. Eventually we should end up back where
    we started when drm_helper_probe_single_connector_modes() overwrites
    the connector status with the forced status.
    
    We can avoid all that pointles work if we just skip forced connectors
    in drm_helper_hpd_irq_event().
    
    Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index ed1334e27c33..4fc2ad76c107 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -1086,6 +1086,10 @@ void drm_helper_hpd_irq_event(struct drm_device *dev)
 	mutex_lock(&dev->mode_config.mutex);
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 
+		/* Ignore forced connectors. */
+		if (connector->force)
+			continue;
+
 		/* Only handle HPD capable connectors. */
 		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
 			continue;


I guess I never sent it out.

-- 
Ville Syrjälä
Intel
