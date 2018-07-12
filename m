Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3944C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A81208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A81208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbeGLMxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:53:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:11769 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeGLMxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:53:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 05:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,342,1526367600"; 
   d="scan'208";a="56344047"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 12 Jul 2018 05:44:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Jul 2018 15:44:01 +0300
Date:   Thu, 12 Jul 2018 15:44:01 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] i915/intel_tv_get_modes: fix strncpy
 truncation warning
Message-ID: <20180712124401.GZ5565@intel.com>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:46:15AM +0200, Dominique Martinet wrote:
> This is effectively no-op as the next line writes a nul at the final

What is "This". Please write self contained commit messages.

> byte of the buffer, so copying one letter less does not change the
> behaviour.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> gcc 8 gives the following warning, which I am not sure why is treated
> as error for this file, thus making me fix it:
> drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
> drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals destination size [-Werror=stringop-truncation]
>    strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

That warning should be in the actual commit message.

> 
> 
> Also, as a side note, while checking if this was already sent I stumbled
> uppon this: https://lists.freedesktop.org/archives/intel-gfx/2018-July/170638.html
> ([Intel-gfx] [PATCH i-g-t 6/7] Fix truncate string in the strncpy)
> which replaces strncpy(dest, src, sizeof(dest)) by strncpy(dest, src,
> strlen(dest))... This isn't for linux but this looks like a pretty bad
> idea to me... (I'm not on the list to reply there, sorry)
> 
>  drivers/gpu/drm/i915/intel_tv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
> index b55b5c157e38..f5614d07b10d 100644
> --- a/drivers/gpu/drm/i915/intel_tv.c
> +++ b/drivers/gpu/drm/i915/intel_tv.c
> @@ -1355,7 +1355,7 @@ intel_tv_get_modes(struct drm_connector *connector)
>  		mode_ptr = drm_mode_create(connector->dev);
>  		if (!mode_ptr)
>  			continue;
> -		strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
> +		strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN - 1);
>  		mode_ptr->name[DRM_DISPLAY_MODE_LEN - 1] = '\0';

This same pattern is used all over drm. Can you go and fix them all up?
One might even consider writing a cocci patch for it ;)

>  
>  		mode_ptr->hdisplay = hactive_s;
> -- 
> 2.17.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
