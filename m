Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA2F218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeLaMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:32:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:60374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbeLaMcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:32:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 04:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; 
   d="scan'208";a="122970627"
Received: from unknown (HELO [10.252.3.166]) ([10.252.3.166])
  by orsmga001.jf.intel.com with ESMTP; 31 Dec 2018 04:32:27 -0800
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime
 interface
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Intel graphics driver community testing & development 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
 <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
Date:   Mon, 31 Dec 2018 12:32:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/12/2018 13:26, Vincent Guittot wrote:
> On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> Hi,
>>
>> On 21/12/2018 10:33, Vincent Guittot wrote:
>>> Use the new pm runtime interface to get the accounted suspended time:
>>> pm_runtime_suspended_time().
>>> This new interface helps to simplify and cleanup the code that computes
>>> __I915_SAMPLE_RC6_ESTIMATED and to remove direct access to internals of
>>> PM runtime.
>>>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
>>>    drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>>>    2 files changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
>>> index d6c8f8f..3f76f60 100644
>>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>>> @@ -5,6 +5,7 @@
>>>     */
>>>
>>>    #include <linux/irq.h>
>>> +#include <linux/pm_runtime.h>
>>>    #include "i915_pmu.h"
>>>    #include "intel_ringbuffer.h"
>>>    #include "i915_drv.h"
>>> @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>>>                 * counter value.
>>>                 */
>>>                spin_lock_irqsave(&i915->pmu.lock, flags);
>>> -             spin_lock(&kdev->power.lock);
>>>
>>>                /*
>>>                 * After the above branch intel_runtime_pm_get_if_in_use failed
>>> @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
>>>                 * suspended and if not we cannot do better than report the last
>>>                 * known RC6 value.
>>>                 */
>>> -             if (kdev->power.runtime_status == RPM_SUSPENDED) {
>>> -                     if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
>>> -                             i915->pmu.suspended_jiffies_last =
>>> -                                               kdev->power.suspended_jiffies;
>>> +             if (pm_runtime_status_suspended(kdev)) {
>>> +                     val = pm_runtime_suspended_time(kdev);
>>
>> There is a race condition between the status check and timestamp access
>> which the existing code solves by holding the power.lock over it. But I
>> don't exactly remember how this issue was manifesting. Is
>> kdev->power.suspended_jiffies perhaps reset on exit from runtime
>> suspend, which was then underflowing the val, not sure.
>>
>> Anyways, is the new way of doing this safe with regards to this race? In
> 
> AFAICT it is safe.
> The current version does:
> 1-take lock,
> 2-test if dev is suspended
> 3-read some internals field to computed an up-to-date suspended time
> 4-update __I915_SAMPLE_RC6_ESTIMATED
> 5-release lock
> 
> The new version does:
> 1-test if dev is suspended
> 2-get an up-to-date  suspended time with pm_runtime_suspended_time.
> This is atomic and monotonic
> 3-update __I915_SAMPLE_RC6_ESTIMATED
> 
> A change from suspended to another states that happens just before
> step 1 is ok for both as we will run the else if
> No change of the state can happen after step 1 in current code and the
> estimated suspended time will be the time up to step2. In parallel,
> Any state change will have to wait step5 to continue
> If a change from suspended to another state happens after step 1 in
> new code, the suspended time return by PM core will be the time up to
> this change. So I would say you don't delay state transition and you
> get a more accurate estimated suspended time (even if the difference
> should be small).
> If a change from suspended to another state happens after step 2 in
> new code, the suspended time return by PM core will be the time up to
> step 2 so there is no changes
> 
> 
>> other words is the value pm_runtime_suspended_time always monotonic,
>> even when not suspended? If not we have to handle the race somehow.
> 
> Yes pm_runtime_suspended_time is monotonic and stays unchanged when
> not suspended
> 
>>
>> If it is always monotonic, then worst case we report one wrong sample,
>> which I guess is still not ideal since someone could be querying the PMU
>> with quite low frequency.
>>
>> There are tests which probably can hit this, but to run them
>> automatically your patches would need to be rebased on drm-tip and maybe
>> sent to our trybot. I can do that after the holiday break if you are
>> okay with having the series waiting until then.
> 
> yes looks good to me

Looks good to me as well. And our CI agrees with it. So:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I assume you will take the patch through some power related tree and we 
will eventually pull it back to drm-tip.

Regards,

Tvrtko
