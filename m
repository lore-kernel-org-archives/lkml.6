Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622721924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfBALLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:11:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:46584 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBALLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:11:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 03:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="143358970"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2019 03:11:42 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stefan Mavrodiev <stefan@olimex.com>
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
In-Reply-To: <65d0b3cc-9d6b-737b-ded6-25d4174c16a8@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190131192619.9763-1-sam@ravnborg.org> <20190131200723.GZ114153@art_vandelay> <20190131210312.GA8947@ravnborg.org> <20190131215417.GA13156@mithrandir> <20190201092037.GA9251@ravnborg.org> <CGME20190201102927epcas3p49ed77662feb619ac5977cccbbd98eac8@epcas3p4.samsung.com> <87tvhnyf65.fsf@intel.com> <65d0b3cc-9d6b-737b-ded6-25d4174c16a8@samsung.com>
Date:   Fri, 01 Feb 2019 13:13:18 +0200
Message-ID: <87lg2zyd69.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2019, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 01.02.2019 11:30, Jani Nikula wrote:
>> On Fri, 01 Feb 2019, Sam Ravnborg <sam@ravnborg.org> wrote:
>>> Hi Thierry.
>>>
>>>> I personally like the DRM_DEV_* variants better because of the
>>>> additional information that they provide. That can be useful when
>>>> grepping logs etc.
>>>>
>>>> I'm slightly on the fence about this patch. The unwritten, and
>>>> admittedly fuzzy, rules that I've been using so far are that dev_*() are
>>>> used or messages that have to do with the panel device itself, whereas
>>>> DRM_* variants are used for things that are actually related to DRM. So
>>>> typically this would mean that roughly everything in ->probe() or
>>>> ->remove() would be dev_*(), while the rest would be DRM_DEV_*().
>>> For a rookie like me it is much simpler if one can use the same
>>> logging primitives all over or at least the rules when to use what is simple.
>>> It is simple to say that everything that exists below drivers/gpu/drm/
>>> relates to drm.
>>>
>>> Suggested set of rules to follow:
>>> - If in drm core, use DRM_XXX where XXX represent the core functionality
>>> - If in a driver use DRM_DEV* if a struct device is available
>>> - If in a driver and no struct device, use plain DRM_ERROR/INFO
>> Core and drivers are already pretty conflated:
>>
>> http://patchwork.freedesktop.org/patch/msgid/20181227162310.13023-1-jani.nikula@intel.com
>>
>> ---
>>
>> Side note, I'd like to switch i915 to dev based debugs, but I absolutely
>> hate the idea of changing:
>>
>> 	DRM_DEBUG_KMS("...")
>>
>> to:
>>
>> 	DRM_DEV_DEBUG_KMS(dev_priv->drm.dev, "...")
>>
>> I think the dev based macros are way too long, and would serve *most*
>> (though not all) drivers better by having struct drm_device * rather
>> than struct device * as the first param. In the above, just the
>> boilerplate consumes half the line.
>>
>> Basically I'd like to see drm_ prefixed analogues to all the dev_ based
>> logging functions, e.g. drm_dbg that takes drm_device. But it's so much
>> churn that I'm contemplating just making i915 specific wrappers
>> instead. :(
>
>
> Does it means I am the only one who is not convinced to use all these
> DRM_DEV helpers.
>
> For me classic dev_(err|...) looks fine, if we really want to emphasize
> that logs comes from DRM dev_* allows format modification, sth like this:
>
> #define dev_fmt(fmt) "DRM: %s:%d: " fmt, __func__, __LINE__
>
> but it is still something I do not see very helpful.

dev_dbg has all the fancy dynamic debug stuff, but no way to filter by
category the way drm.debug bitmask allows.

BR,
Jani.


>
>
> In general I think we have too many alternatives/flavours and developers
> do not know what to choose, current usage of all these DRM_* shows it
> clearly.
>
>
> Regards
>
> Andrzej
>
>
>
>>
>> BR,
>> Jani.
>>
>>
>>
>>
>>> If there is a need to distingush before/after one has a drm_device,
>>> the best way would be to have a set of logging primitives that
>>> take a drm_device. So we could extend the rule set:
>>> - If in a driver use DRM_DRM* if a struct drm_device is available
>>>   (This rule would take precedence over a struct device)
>>>
>>> DRM_DRM*, or DRM_DDEV* or ... But you get the idea.
>>>
>>> But this is not where we are today.
>>>
>>> Shall I redo the patch-set so we go back to dev_*() in probe() / remove()?
>>>
>>> 	Sam
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>

-- 
Jani Nikula, Intel Open Source Graphics Center
