Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B095CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7937020684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7937020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeKUUiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:38:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:24890 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeKUUiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:38:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="109960345"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2018 02:04:34 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        David Airlie <airlied@linux.ie>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] drm/i915: avoid rebuilding i915_gpu_error.o on version string updates
In-Reply-To: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com>
Date:   Wed, 21 Nov 2018 12:05:05 +0200
Message-ID: <87va4qeofi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>
> There is no need to rebuild i915_gpu_error.o when the version string
> changes as the version is available in init_utsname()->release.
>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

Nice!

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index 8762d17b6659..958e1484a3dd 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -27,7 +27,7 @@
>   *
>   */
>  
> -#include <generated/utsrelease.h>
> +#include <linux/utsname.h>
>  #include <linux/stop_machine.h>
>  #include <linux/zlib.h>
>  #include <drm/drm_print.h>
> @@ -650,7 +650,7 @@ int i915_error_state_to_str(struct drm_i915_error_state_buf *m,
>  
>  	if (*error->error_msg)
>  		err_printf(m, "%s\n", error->error_msg);
> -	err_printf(m, "Kernel: " UTS_RELEASE "\n");
> +	err_printf(m, "Kernel: %s\n", init_utsname()->release);
>  	ts = ktime_to_timespec64(error->time);
>  	err_printf(m, "Time: %lld s %ld us\n",
>  		   (s64)ts.tv_sec, ts.tv_nsec / NSEC_PER_USEC);

-- 
Jani Nikula, Intel Open Source Graphics Center
