Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADEC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AA20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0AA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeFUIDa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:03:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:61093 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeFUID0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:03:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 01:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,251,1526367600"; 
   d="scan'208";a="65996855"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2018 01:03:24 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: mark expected switch fall-through
In-Reply-To: <26740470-d7b7-0a58-0aae-fc628bd4f416@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180620133100.GA608@embeddedor.com> <20180620190628.GC8258@intel.com> <26740470-d7b7-0a58-0aae-fc628bd4f416@embeddedor.com>
Date:   Thu, 21 Jun 2018 11:03:14 +0300
Message-ID: <87r2l0va65.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> On 06/20/2018 02:06 PM, Rodrigo Vivi wrote:
>> On Wed, Jun 20, 2018 at 08:31:00AM -0500, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>>> where we are expecting to fall through.
>>>
>>> Addresses-Coverity-ID: 1470102 ("Missing break in switch")
>> 
>> Any other advantage besides coverity?
>> Can't we address it by marking as "Intentional" on the tool?
>> 
>
> Yes. The advantage of this is that it will eventually allows to enable 
> -Wimplicit-fallthrough, hence, enabling the compiler to trigger a 
> warning, which will force us to double check if we are actually missing 
> a break before committing the code.

I applaud the efforts. Since you're doing the comment changes, do you
have an idea what -Wimplicit-fallthrough=N level is being considered for
kernel?

>> I'm afraid there will be so many more places to add fallthrough
>> marks....
>> 
>
> Oh yeah, there are around 1000 similar places in the whole codebase. 
> There is an ongoing effort to review each case. Months ago, it used to 
> be around 1500 of these cases.

We use our own MISSING_CASE() to indicate stuff that's not supposed to
happen, or to be implemented, etc. and in many cases the fallthrough is
normal. I wonder if we could embed __attribute__ ((fallthrough)) in
there to tackle all of these without a comment.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
