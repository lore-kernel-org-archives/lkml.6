Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58058C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5825C18
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5825C18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965573AbeFZN3A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:29:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:15175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965544AbeFZN26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 06:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="52363440"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 26 Jun 2018 06:28:55 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:28:54 +0300
Date:   Tue, 26 Jun 2018 16:28:54 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/gma500: Fix potential NULL pointer dereference
Message-ID: <20180626132854.GZ20518@intel.com>
References: <20180625121844.GA12466@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625121844.GA12466@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 07:18:44AM -0500, Gustavo A. R. Silva wrote:
> fb is being dereferenced before it is null checked, hence there
> is a potential null pointer dereference.
> 
> Fix this by moving the pointer dereference after fb has been
> properly null checked at line 74: if (!fb)

I don't remember if set_base w/ fb==NULL is even legal. But as long as
the check is there this seems sane. Pushed to drm-misc-next. Thanks for
the patch.

> 
> Addresses-Coverity-ID: 1470169 ("Dereference before null check")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/gma500/gma_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index c8f071c..f767579 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -60,7 +60,7 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  	struct drm_psb_private *dev_priv = dev->dev_private;
>  	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
>  	struct drm_framebuffer *fb = crtc->primary->fb;
> -	struct gtt_range *gtt = to_gtt_range(fb->obj[0]);
> +	struct gtt_range *gtt;
>  	int pipe = gma_crtc->pipe;
>  	const struct psb_offset *map = &dev_priv->regmap[pipe];
>  	unsigned long start, offset;
> @@ -76,6 +76,8 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  		goto gma_pipe_cleaner;
>  	}
>  
> +	gtt = to_gtt_range(fb->obj[0]);
> +
>  	/* We are displaying this buffer, make sure it is actually loaded
>  	   into the GTT */
>  	ret = psb_gtt_pin(gtt);
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
