Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A12ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F920C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77F920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeGQLD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:03:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:42156 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbeGQLD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:03:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 03:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="57497788"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 17 Jul 2018 03:31:25 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 17 Jul 2018 13:31:24 +0300
Date:   Tue, 17 Jul 2018 13:31:24 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [Nouveau] [PATCH v2 2/3] drm/nouveau: Fix runtime PM leak in
 nv50_disp_atomic_commit()
Message-ID: <20180717103124.GO5565@intel.com>
References: <20180712170256.13018-1-lyude@redhat.com>
 <20180712170256.13018-3-lyude@redhat.com>
 <20180717073352.GA17459@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180717073352.GA17459@wunner.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:33:52AM +0200, Lukas Wunner wrote:
> On Thu, Jul 12, 2018 at 01:02:53PM -0400, Lyude Paul wrote:
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -1878,7 +1878,7 @@ nv50_disp_atomic_commit(struct drm_device *dev,
> >  		nv50_disp_atomic_commit_tail(state);
> >  
> >  	drm_for_each_crtc(crtc, dev) {
> > -		if (crtc->state->enable) {
> > +		if (crtc->state->active) {
> >  			if (!drm->have_disp_power_ref) {
> >  				drm->have_disp_power_ref = true;
> >  				return 0;
> 
> Somewhat tangential comment on this older patch, since you
> continue to dig around in the runtime PM area:
> 
> Whenever a crtc is activated or deactivated in nouveau, we iterate
> over all crtcs and acquire a runtime PM if a crtc is active and
> previously there was no active one, or we drop a ref if none is
> active and previously there was an active one.
> 
> For a while now I've been thinking that it would be more straightforward
> to acquire a ref whenever a crtc is activated and drop one when a crtc
> is deactivated, i.e. hold one ref for every active crtc.  That way the
> have_disp_power_ref variable as well as the iteration logic could be
> removed, leading to a simplification.  Just a suggestion anyway.

The current code looks somewhat busted anyway. First problem is that
it's accessing crtc->state without the appropriate locks held (unless
something always pulls in all crtcs to every commit?). Second issue
is that the rpm_put() is called without waiting for nonblocking commits
to have finished so it looks like you can currentlly remove the power
before the hardware has been properly shut down.

-- 
Ville Syrjälä
Intel
