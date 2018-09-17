Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4309ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE2B214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2B214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIQXYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:24:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:59422 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQXYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:24:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 10:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="90853308"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 17 Sep 2018 10:55:46 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 17 Sep 2018 20:55:45 +0300
Date:   Mon, 17 Sep 2018 20:55:45 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/probe_helper: Don't bother probing when connectors
 are forced off
Message-ID: <20180917175545.GP5565@intel.com>
References: <20180917174344.22011-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917174344.22011-1-lyude@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 01:43:44PM -0400, Lyude Paul wrote:
> Userspace asked them to be forced off, so why would we care about what a
> probe tells us?

I believe there should be force checks in the callers already.
Or are we missing some?

> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index a1bb157bfdfa..56d2b5dd1f58 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -269,7 +269,9 @@ drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
>  retry:
>  	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &ctx);
>  	if (!ret) {
> -		if (funcs->detect_ctx)
> +		if (connector->force == DRM_FORCE_OFF)
> +			ret = connector_status_disconnected;

connector->force is protected by mode_config.mutex IIRC.

> +		else if (funcs->detect_ctx)
>  			ret = funcs->detect_ctx(connector, &ctx, force);
>  		else if (connector->funcs->detect)
>  			ret = connector->funcs->detect(connector, force);
> @@ -317,6 +319,9 @@ drm_helper_probe_detect(struct drm_connector *connector,
>  	if (ret)
>  		return ret;
>  
> +	if (connector->force == DRM_FORCE_OFF)
> +		return connector_status_disconnected;
> +
>  	if (funcs->detect_ctx)
>  		return funcs->detect_ctx(connector, ctx, force);
>  	else if (connector->funcs->detect)
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
