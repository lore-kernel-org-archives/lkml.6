Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA214C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8566C215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8566C215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeHOP5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:57:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:9047 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbeHOP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:57:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 06:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,243,1531810800"; 
   d="scan'208";a="81558092"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2018 06:05:35 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Add drm.edid_quirk_param module parameter
In-Reply-To: <20180809061123.1734-1-keithp@keithp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180809061123.1734-1-keithp@keithp.com>
Date:   Wed, 15 Aug 2018 16:05:28 +0300
Message-ID: <874lfv93vr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2018, Keith Packard <keithp@keithp.com> wrote:
> This parameter allows the set of EDID quirks to be changed at
> runtime. The syntax is
>
> 	vendor/product/quirks,vendor/product/quirks,...
>
> where vendor is the three-letter EDID vendor value, product is the
> EDID product id which may be prefixed with 0x to for hex instead of
> decimal values and quirks is the replacement quirks value from the
> list in drm_edid.c.

Why?

I guess if we want to manage quirks from userspace, we should work to
provide an interface udev can use.

BR,
Jani.

>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 5dc742b27ca0..63b4587faddd 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -98,6 +98,12 @@ struct detailed_mode_closure {
>  #define LEVEL_GTF2	2
>  #define LEVEL_CVT	3
>  
> +#define EDID_QUIRK_PARAM_LEN	256
> +static char edid_quirk_param[EDID_QUIRK_PARAM_LEN];
> +module_param_string(edid_quirk_param, edid_quirk_param, sizeof(edid_quirk_param), 0644);
> +MODULE_PARM_DESC(edid_quirk_param, "Extra EDID quirks, "
> +		 "format is 'vendor/product/quirks;...' ");
> +
>  static const struct edid_quirk {
>  	char vendor[4];
>  	int product_id;
> @@ -1774,8 +1780,24 @@ static bool edid_vendor(const struct edid *edid, const char *vendor)
>  static u32 edid_get_quirks(const struct edid *edid)
>  {
>  	const struct edid_quirk *quirk;
> +	const char *q;
>  	int i;
>  
> +	for (q = edid_quirk_param; q && *q; q = strchr(q, ',')) {
> +		char 	vendor[4];
> +		int	product_id;
> +		int	quirks;
> +
> +		while (*q == ',')
> +			q++;
> +
> +		if (sscanf(q, "%3s/%i/%i", vendor, &product_id, &quirks) == 3) {
> +			if (edid_vendor(edid, vendor) &&
> +			    (EDID_PRODUCT_ID(edid) == product_id))
> +				return quirks;
> +		}
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(edid_quirk_list); i++) {
>  		quirk = &edid_quirk_list[i];

-- 
Jani Nikula, Intel Open Source Graphics Center
