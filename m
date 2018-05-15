Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeEOJur (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:50:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:50458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeEOJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41053530"
Subject: Re: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
To: Ayan Halder <ayan.halder@arm.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nd@arm.com
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
 <1524593567-5559-6-git-send-email-ayan.halder@arm.com>
 <20180425071722.GN25142@phenom.ffwll.local>
 <20180425112604.GP14661@e110455-lin.cambridge.arm.com>
 <CAKMK7uGeptRT+oeTQQQ4U6LgAVQg2SOofTrqDo9MfFwRkKhj4A@mail.gmail.com>
 <20180514100126.GA24437@arm.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <4e3c2f27-dbb3-cc95-0564-5f785ae1d805@intel.com>
Date: Tue, 15 May 2018 11:50:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514100126.GA24437@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2018 12:01 PM, Ayan Halder wrote:
> On Wed, Apr 25, 2018 at 01:49:35PM +0200, Daniel Vetter wrote:
> Hi Daniel,
>> On Wed, Apr 25, 2018 at 1:26 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
>>> On Wed, Apr 25, 2018 at 09:17:22AM +0200, Daniel Vetter wrote:
>>>> On Tue, Apr 24, 2018 at 07:12:47PM +0100, Ayan Kumar Halder wrote:
>>>>> malidp_pm_suspend_late checks if the runtime status is not suspended
>>>>> and if so, invokes malidp_runtime_pm_suspend which disables the
>>>>> display engine/core interrupts and the clocks. It sets the runtime status
>>>>> as suspended.
>>>>>
>>>>> The difference between suspend() and suspend_late() is as follows:-
>>>>> 1. suspend() makes the device quiescent. In our case, we invoke the DRM
>>>>> helper which disables the CRTC. This would have invoked runtime pm
>>>>> suspend but the system suspend process disables runtime pm.
>>>>> 2. suspend_late() It continues the suspend operations of the drm device
>>>>> which was started by suspend(). In our case, it performs the same functionality
>>>>> as runtime_suspend().
>>>>>
>>>>> The complimentary functions are resume() and resume_early(). In the case of
>>>>> resume_early(), we invoke malidp_runtime_pm_resume() which enables the clocks
>>>>> and the interrupts. It sets the runtime status as active. If the device was
>>>>> in runtime suspend mode before system suspend was called, pm_runtime_work()
>>>>> will put the device back in runtime suspended mode( after the complete system
>>>>> has been resumed).
>>>>>
>>>>> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>>>>>
>>>> Afaiui we still haven't bottomed out on the discussion on v1. Did you get
>>>> hold of Rafael?
>>> No, there was no reply from him. Lets try again:
>>>
>>> Rafael, we are debating on what the proper approach is for handling the
>>> suspend/resume callbacks for a DRM driver that is likely to not be
>>> runtime suspended when the power-down happens (because we are driving
>>> the display output). We are using in this patch the LATE_SYSTEM_SLEEP_PM_OPS
>>> in order to do the work that we also do during runtime suspend, which is
>>> turning off the output and the clocks driving it. The reason for doing
>>> that is because the PM core takes a runtime reference during system
>>> suspend for all devices that are not already runtime suspended, so our
>>> runtime_pm_suspend() hook is never called.
>>>
>>> Daniel's argument is that we should not be doing this from LATE hooks,
>>> but from the normal suspend hooks, however kernel doc seems to suggest
>>> otherwise.
>> For more context: I thought the reason behind the recommendation to
>> stuff the rpm callbacks into the late/early hooks was to solve
>> cross-device ordering issues. That way everyone shuts down the device
>> functionality in the normal hooks, but only powers them off in the
>> late hook (to allow other drivers to keep using the clock/i2c
>> master/whatever). But we now have device_link to solve that since a
>> while, so I'm not sure the recommendation to stuff the rpm hooks into
>> late/early callbacks is still correct.
>> -Daniel
>>
> It has been more than two weeks and we have not got any response from
> Rafael. Can you ping him personally or suggest any way by which ask
> him to respond?

It is in my queue though, sorry for the delay.

It would help if you resent the series with a CC to 
linux-pm@vger.kernel.org as it would be easier for me to review it then.

Thanks,
Rafael
