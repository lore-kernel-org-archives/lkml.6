Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A347C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DE522B66
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE522B66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933856AbeGFUaU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:30:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:43101 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932328AbeGFUaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:30:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 13:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,317,1526367600"; 
   d="scan'208";a="69282814"
Received: from qifengwu-mobl.amr.corp.intel.com (HELO intel.com) ([10.254.87.22])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2018 13:30:16 -0700
Date:   Fri, 6 Jul 2018 13:30:15 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Make the "Reducing compressed framebufer size" message
 be DRM_INFO_ONCE()
Message-ID: <20180706203015.GC23473@intel.com>
References: <20180706190424.29194-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706190424.29194-1-pjones@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:04:24PM -0400, Peter Jones wrote:
> This was sort of annoying me:
> 
> random:~$ dmesg | tail -1
> [523884.039227] [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.
> random:~$ dmesg | grep -c "Reducing the compressed"
> 47
> 
> This patch makes it DRM_INFO_ONCE() just like the similar message
> farther down in that function is pr_info_once().
> 
> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_fbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_fbc.c b/drivers/gpu/drm/i915/intel_fbc.c
> index b431b6733cc..88b013758da 100644
> --- a/drivers/gpu/drm/i915/intel_fbc.c
> +++ b/drivers/gpu/drm/i915/intel_fbc.c
> @@ -585,7 +585,7 @@ static int intel_fbc_alloc_cfb(struct intel_crtc *crtc)
>  	if (!ret)
>  		goto err_llb;
>  	else if (ret > 1) {
> -		DRM_INFO("Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.\n");
> +		DRM_INFO_ONCE("Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.\n");

I know the feeling of seeing a message over and over again when you are already aware of that.
Specially something that tells you to change BIOS configuration...
for this reason I think it makes sense, so:

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

I will just wait for CI and give a couple days to someone else to challenge.
If I end up forgetting to push it please ping me...

>  
>  	}
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
