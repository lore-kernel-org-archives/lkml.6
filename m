Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4256FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF62726461
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF62726461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeF0JbO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:31:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:50080 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbeF0JbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:31:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 02:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="67688398"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 02:31:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: mark expected switch fall-through
In-Reply-To: <357b53aa-d8ce-c9db-0b81-2e8e1aa821bb@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180620133100.GA608@embeddedor.com> <20180620190628.GC8258@intel.com> <26740470-d7b7-0a58-0aae-fc628bd4f416@embeddedor.com> <87r2l0va65.fsf@intel.com> <357b53aa-d8ce-c9db-0b81-2e8e1aa821bb@embeddedor.com>
Date:   Wed, 27 Jun 2018 12:30:49 +0300
Message-ID: <87tvpotw3a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> Hi Jani,
>
> On 06/21/2018 03:03 AM, Jani Nikula wrote:
>> On Wed, 20 Jun 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>> On 06/20/2018 02:06 PM, Rodrigo Vivi wrote:
>>>> On Wed, Jun 20, 2018 at 08:31:00AM -0500, Gustavo A. R. Silva wrote:
>>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>>>> where we are expecting to fall through.
>>>>>
>>>>> Addresses-Coverity-ID: 1470102 ("Missing break in switch")
>>>>
>>>> Any other advantage besides coverity?
>>>> Can't we address it by marking as "Intentional" on the tool?
>>>>
>>>
>>> Yes. The advantage of this is that it will eventually allows to enable 
>>> -Wimplicit-fallthrough, hence, enabling the compiler to trigger a 
>>> warning, which will force us to double check if we are actually missing 
>>> a break before committing the code.
>> 
>> I applaud the efforts. Since you're doing the comment changes, do you
>> have an idea what -Wimplicit-fallthrough=N level is being considered for
>> kernel?
>> 
>
> Currently, we are trying level 2.
>
>>>> I'm afraid there will be so many more places to add fallthrough
>>>> marks....
>>>>
>>>
>>> Oh yeah, there are around 1000 similar places in the whole codebase. 
>>> There is an ongoing effort to review each case. Months ago, it used to 
>>> be around 1500 of these cases.
>> 
>> We use our own MISSING_CASE() to indicate stuff that's not supposed to
>> happen, or to be implemented, etc. and in many cases the fallthrough is
>> normal. I wonder if we could embed __attribute__ ((fallthrough)) in
>> there to tackle all of these without a comment.
>> 
>
> I've tried this:
>
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index 00165ad..829572c 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -40,8 +40,10 @@
>  #undef WARN_ON_ONCE
>  #define WARN_ON_ONCE(x) WARN_ONCE((x), "%s", "WARN_ON_ONCE(" __stringify(x) ")")
>
> -#define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
> -                            __stringify(x), (long)(x))
> +#define MISSING_CASE(x) ({ \
> +       WARN(1, "Missing case (%s == %ld)\n", __stringify(x), (long)(x)); \
> +       __attribute__ ((fallthrough)); \
> +})
>
>  #if GCC_VERSION >= 70000
>  #define add_overflows(A, B) \
>
> and I get the following warnings as a consequence:

Right. That's because we've used MISSING_CASE() also in if-ladders in
addition to the switch default case. From our POV the usage is similar.

*shrug*

I guess I like /* fall through */ annotations next to MISSING_CASE()
better than having two different macros depending on where they're being
used.

Thanks for trying it out anyway.

BR,
Jani.


>
> drivers/gpu/drm/i915/intel_pm.c: In function ‘intel_init_clock_gating_hooks’:
> drivers/gpu/drm/i915/i915_utils.h:48:2: error: invalid use of attribute ‘fallthrough’
>   __attribute__ ((fallthrough)); \
>   ^
> drivers/gpu/drm/i915/intel_pm.c:9240:3: note: in expansion of macro ‘MISSING_CASE’
>    MISSING_CASE(INTEL_DEVID(dev_priv));
>    ^~~~~~~~~~~~
> drivers/gpu/drm/i915/intel_pm.c: In function ‘intel_read_wm_latency’:
> drivers/gpu/drm/i915/i915_utils.h:48:2: error: invalid use of attribute ‘fallthrough’
>   __attribute__ ((fallthrough)); \
>   ^
> drivers/gpu/drm/i915/intel_pm.c:2902:3: note: in expansion of macro ‘MISSING_CASE’
>    MISSING_CASE(INTEL_DEVID(dev_priv));
>    ^~~~~~~~~~~~
>
> Thanks
> --
> Gustavo

-- 
Jani Nikula, Intel Open Source Graphics Center
