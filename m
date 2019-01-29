Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C2FC282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B95820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfA2TUU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:20:20 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:54763 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727056AbfA2TUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:20:20 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15394971-1500050 
        for multiple; Tue, 29 Jan 2019 19:20:14 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190129191001.442-2-lyude@redhat.com>
Cc:     Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190129191001.442-1-lyude@redhat.com>
 <20190129191001.442-2-lyude@redhat.com>
Message-ID: <154878961170.21797.2796600824480189142@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v3 1/3] drm/i915: Block fbdev HPD processing during suspend
Date:   Tue, 29 Jan 2019 19:20:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lyude Paul (2019-01-29 19:09:59)
> When resuming, we check whether or not any previously connected
> MST topologies are still present and if so, attempt to resume them. If
> this fails, we disable said MST topologies and fire off a hotplug event
> so that userspace knows to reprobe.
> 
> However, sending a hotplug event involves calling
> drm_fb_helper_hotplug_event(), which in turn results in fbcon doing a
> connector reprobe in the caller's thread - something we can't do at the
> point in which i915 calls drm_dp_mst_topology_mgr_resume() since
> hotplugging hasn't been fully initialized yet.
> 
> This currently causes some rather subtle but fatal issues. For example,
> on my T480s the laptop dock connected to it usually disappears during a
> suspend cycle, and comes back up a short while after the system has been
> resumed. This guarantees pretty much every suspend and resume cycle,
> drm_dp_mst_topology_mgr_set_mst(mgr, false); will be caused and in turn,
> a connector hotplug will occur. Now it's Rute Goldberg time: when the
> connector hotplug occurs, i915 reprobes /all/ of the connectors,
> including eDP. However, eDP probing requires that we power on the panel
> VDD which in turn, grabs a wakeref to the appropriate power domain on
> the GPU (on my T480s, this is the PORT_DDI_A_IO domain). This is where
> things start breaking, since this all happens before
> intel_power_domains_enable() is called we end up leaking the wakeref
> that was acquired and never releasing it later. Come next suspend/resume
> cycle, this causes us to fail to shut down the GPU properly, which
> causes it not to resume properly and die a horrible complicated death.
> 
> (as a note: this only happens when there's both an eDP panel and MST
> topology connected which is removed mid-suspend. One or the other seems
> to always be OK).
> 
> We could try to fix the VDD wakeref leak, but this doesn't seem like
> it's worth it at all since we aren't able to handle hotplug detection
> while resuming anyway. So, let's go with a more robust solution inspired
> by nouveau: block fbdev from handling hotplug events until we resume
> fbdev. This allows us to still send sysfs hotplug events to be handled
> later by user space while we're resuming, while also preventing us from
> actually processing any hotplug events we receive until it's safe.
> 
> This fixes the wakeref leak observed on the T480s and as such, also
> fixes suspend/resume with MST topologies connected on this machine.
> 
> Changes since v2:
> * Don't call drm_fb_helper_hotplug_event() under lock, do it after lock
>   (Chris Wilson)
> * Don't call drm_fb_helper_hotplug_event() in
>   intel_fbdev_output_poll_changed() under lock (Chris Wilson)
> * Always set ifbdev->hpd_waiting (Chris Wilson)
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 0e32b39ceed6 ("drm/i915: add DP 1.2 MST support (v0.7)")
> Cc: Todd Previte <tprevite@gmail.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.17+

I suspect the locking is overkill, but certainly easier to reason than
trying to remember all the ins and outs of fbdev with its dubious async
initialisation.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
