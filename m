Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E2520989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E2520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeKUUuc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:50:32 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:61200 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbeKUUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:50:32 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14579409-1500050 
        for multiple; Wed, 21 Nov 2018 10:16:31 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     David Airlie <airlied@linux.ie>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20181121095423.20760-1-hans.ml.holmberg@owltronix.com>
Message-ID: <154279538801.11623.10312467957931830687@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: avoid rebuilding i915_gpu_error.o on version string
 updates
Date:   Wed, 21 Nov 2018 10:16:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hans Holmberg (2018-11-21 09:54:23)
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> There is no need to rebuild i915_gpu_error.o when the version string
> changes as the version is available in init_utsname()->release.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
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
>         if (*error->error_msg)
>                 err_printf(m, "%s\n", error->error_msg);
> -       err_printf(m, "Kernel: " UTS_RELEASE "\n");
> +       err_printf(m, "Kernel: %s\n", init_utsname()->release);

Should we take some more info from init_utsname, plagiarising
dump_stack,

	err_printf(m, :Kernel: %s %.*s\n",
		   init_utsname()->release,
		   (int)strcspn(init_utsname()->version, " "),
		   init_utsname()->version);

-Chris
