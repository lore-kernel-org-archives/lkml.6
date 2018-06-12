Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8902EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F882089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F882089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeFLMIw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:08:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:41804 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754250AbeFLMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:08:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 05:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="46505056"
Received: from irvmail001.ir.intel.com ([163.33.26.43])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2018 05:08:48 -0700
Received: from mwajdecz-mobl1.ger.corp.intel.com (mwajdecz-mobl1.ger.corp.intel.com [172.28.174.165])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id w5CC8l1M028135;
        Tue, 12 Jun 2018 13:08:47 +0100
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Colin King" <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH][V3] drm/i915/guc: fix GEM_BUG_ON check
References: <20180612093804.11341-1-colin.king@canonical.com>
Date:   Tue, 12 Jun 2018 14:08:43 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Michal Wajdeczko" <michal.wajdeczko@intel.com>
Message-ID: <op.zkhv0tz5xaggs7@mwajdecz-mobl1.ger.corp.intel.com>
In-Reply-To: <20180612093804.11341-1-colin.king@canonical.com>
User-Agent: Opera Mail/1.0 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:38:04 +0200, Colin King <colin.king@canonical.com>  
wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The check for level being less than zero always false because flags
> is currently unsigned and can never be negative. Fix this by making
> level a s32.
>
> Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")
>
> Fixes: cb5d64e9f13e ("drm/i915/guc: Allow user to control default GuC  
> logging")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> ---
> V3: Make level s32 and add the missing Fixes: tag, thanks to Dan  
> Carpenter and
> Jani Nikula for correcting my mistakes
>
> ---
>  drivers/gpu/drm/i915/intel_guc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_guc.c  
> b/drivers/gpu/drm/i915/intel_guc.c
> index 116f4ccf1bbd..bdb1fab322bf 100644
> --- a/drivers/gpu/drm/i915/intel_guc.c
> +++ b/drivers/gpu/drm/i915/intel_guc.c
> @@ -205,7 +205,7 @@ void intel_guc_fini(struct intel_guc *guc)
> static u32 get_log_control_flags(void)
>  {
> -	u32 level = i915_modparams.guc_log_level;
> +	s32 level = i915_modparams.guc_log_level;

s/s32 level/int level

to match modparam type as already suggested by others

>  	u32 flags = 0;
> 	GEM_BUG_ON(level < 0);

please note that this BUG_ON will go away with pending [1] so maybe
we can just merge series [2] instead ?

Thanks,
Michal

[1] https://patchwork.freedesktop.org/patch/227365/
[2] https://patchwork.freedesktop.org/series/44201/
