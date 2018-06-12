Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56488C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FC120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFLJXV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:23:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:15984 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932639AbeFLJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:23:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 02:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="63355266"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2018 02:23:14 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drm/i915/guc: fix GEM_BUG_ON check
In-Reply-To: <20180612091016.yi4lbmdgcltmcen3@mwanda>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180611164653.13691-1-colin.king@canonical.com> <20180612091016.yi4lbmdgcltmcen3@mwanda>
Date:   Tue, 12 Jun 2018 12:23:07 +0300
Message-ID: <87d0ww2was.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jun 11, 2018 at 05:46:53PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>> 
>> The check for level being less than zero always false because flags
>> is currently unsigned and can never be negative. Fix this by making
>> flags a s32.
>> 
>> Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")
>> 
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> 
>> ---
>> V2: Make flags s32 rather than remove the GEM_BUG_ON check, thanks to
>> Ville Syrjälä for spotting the mistake in my first attempt.
>> ---
>>  drivers/gpu/drm/i915/intel_guc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
>> index 116f4ccf1bbd..fb31f5004bcf 100644
>> --- a/drivers/gpu/drm/i915/intel_guc.c
>> +++ b/drivers/gpu/drm/i915/intel_guc.c
>> @@ -206,7 +206,7 @@ void intel_guc_fini(struct intel_guc *guc)
>>  static u32 get_log_control_flags(void)
>>  {
>>  	u32 level = i915_modparams.guc_log_level;
>> -	u32 flags = 0;
>> +	s32 flags = 0;
>>  
>>  	GEM_BUG_ON(level < 0);
>
> Only insane people use "s32" when it's not part of the hardware spec and
> you changed the wrong variable...

Yeah, int level.

Also,

Fixes: cb5d64e9f13e ("drm/i915/guc: Allow user to control default GuC logging")

BR,
Jani.


>
> regards,
> dan carpenter
>

-- 
Jani Nikula, Intel Open Source Graphics Center
