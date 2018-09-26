Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8D32152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8D32152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeIZWvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:51:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:43524 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeIZWvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:51:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="77477128"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 26 Sep 2018 09:37:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 26 Sep 2018 19:37:23 +0300
Date:   Wed, 26 Sep 2018 19:37:23 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] DRM: VBLANK: provide valid timestamp for EVENT_FLIP
Message-ID: <20180926163723.GW9144@intel.com>
References: <20180926142535.17997-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926142535.17997-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:25:35PM +0300, Eugeniy Paltsev wrote:
> If driver/HW doesn't support vblank functionality (for example
> UDL driver, ARCPGU driver, ...) we always have vblank->time == 0.
> In result we always provide zero timestamp for
> DRM_EVENT_FLIP_COMPLETE. This breaks userspace apps (for example
> weston) which relies on timestamp value.
> 
> Setup time to provide valid timestamp for DRM_EVENT_FLIP_COMPLETE
> event.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 28cdcf76b6f9..0d19aca48782 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -911,6 +911,15 @@ void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  
>  	if (dev->num_crtcs > 0) {

If those drivers don't support vblank stuff why are they calling
drm_vblank_init() w/ num_crtcs > 0? If they didn't they'd take the
else branch which already does what you want.

>  		seq = drm_vblank_count_and_time(dev, pipe, &now);
> +
> +		/*
> +		 * If driver/HW doesn't support vblank functionality we
> +		 * always have vblank->time == 0. Setup time to provide valid
> +		 * timestamp for DRM_EVENT_FLIP_COMPLETE event.
> +		 */
> +		if (!now && e->event.base.type == DRM_EVENT_FLIP_COMPLETE)
> +			now = ktime_get();
> +
>  	} else {
>  		seq = 0;
>  
> -- 
> 2.14.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
