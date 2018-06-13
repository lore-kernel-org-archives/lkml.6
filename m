Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4E5EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5748F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ6lcEmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5748F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934738AbeFMIQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:16:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34385 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:16:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id i205-v6so1534528oib.1;
        Wed, 13 Jun 2018 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gqYN1OU+hdck7ng6AqvCcEnmpERLstIrlx+kX6Y0NSA=;
        b=dZ6lcEmv+TfyhqGzifY3m8xZ5I6Uq//OIND1vyj0fw3USCG9k+JtOnS+KZErEico4P
         faJh21Rto1+rPtqO9Ltb65iNRiLPtsdB9P78Asw97MFDUfyCV6OU1AeWrFpQc9y2htVN
         TK5IdxDw45msWcBp4ig7PP3usED6vE7kN5DH2iu3ik48g1DrWwUvh6q8e62Oc96U6IV4
         MgV7f3SF1I4K95TktYXA5QONMSLlm7yHxUNDb/bOmXr6zbDXDij0i8a6PM/SKM64QQsi
         8qmrMIChDtrEdnBTVsZ2YjLOdFAkPPHwhp/rL/n0hhDvor83sYyJK4rfhkBOHuW/m+2Q
         nlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gqYN1OU+hdck7ng6AqvCcEnmpERLstIrlx+kX6Y0NSA=;
        b=HMaeH6kpquC7VRvLCJOjU+ZVqYbbRKQrDjkSvre4YkQVowJu816wHfdNWjjunJseIv
         UleDvEpiydD6xwUYv1KuQyj0lrtgNsmw8qv8dnkHSwV3+fpl9YwKPBeiE9PvXy1EhNU6
         1K6cCg7jvN6mW9WVYUP02I9n6Kqd9oMrJvd98PeEIxhoyTO/H+vn8W8A1FNbSO2mt3g3
         X00xnRMFhdOVB8Z3KmgituuS8fH/WR41NjxvxedTTLwS5X7tiLs7m9BDF+BNJQcRybhc
         h3FpjxLiGEiYbeXKGFU/eXj9T9+o/LJJKEJgG9Aw27U+00NChayWBmWf2ecbussHaqI6
         2Vuw==
X-Gm-Message-State: APt69E2C5OzxkTIesdgai8I/cNtyQMztCo9bjkn2Nyj9cQeybSKlE6Tc
        bRnDJt9piBfn/j0we4fXrtu+XbeRhAAKv4WxjEk=
X-Google-Smtp-Source: ADUXVKI8Y0L8SA6pfgcZdeS0ASkIs5vekippM2sSP9Ohe1wZB1DsRrPmaVUDTRWOawj/99oYzSSIiI+Wv2dDk3x4KhM=
X-Received: by 2002:aca:6914:: with SMTP id e20-v6mr3703999oic.358.1528877801166;
 Wed, 13 Jun 2018 01:16:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:16:40
 -0700 (PDT)
In-Reply-To: <20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O@eucas1p2.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <1692795.7GA92aXxMT@aspire.rjw.lan> <20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O@eucas1p2.samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 10:16:40 +0200
X-Google-Sender-Auth: P9kEQDCqCHZrrnXIGfzInxXZRRY
Message-ID: <CAJZ5v0gh-Vq=6X9Dn2x-x_REnOwPVAfNj+CTJRUkKNmsAPmsnQ@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:23 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Rafael,

Hi Marek,

> On 2018-06-12 16:24, Rafael J. Wysocki wrote:
>> On Tuesday, June 12, 2018 2:44:23 PM CEST Marek Szyprowski wrote:
>>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> If a device link is added via device_link_add() by the driver of the
>>>> link's consumer device, the supplier's runtime PM usage counter is
>>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>>> driver_probe_device().  However, in that case it is not incremented
>>>> unless the supplier driver is already present and the link is not
>>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>>> the supplier device in a few cases.
>>>>
>>>> To prevent that from happening, bump up the supplier runtime
>>>> PM usage counter in device_link_add() for all links with the
>>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>>> device_link_add() who want the supplier to be resumed by it should
>>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>>
>>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>>> reference counting of device link suppliers at probe) that is going
>>>> to be reverted.
>>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
>> Thanks for testing! :-)
>>
>>> Let's get back to my IOMMU and codec case, mentioned here:
>>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>>
>>> Now, after applying your patch, when IOMMU creates a link with
>>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
>>> This means that until jpeg driver enables runtime pm for its device and
>>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>>> resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>>> creation, the supplier is properly resumed, but then, once the jpeg
>>> device probe finishes, the supplier is still in runtime active state
>>> until a next runtime suspend/resume cycle of jpeg device.
>> That additional suspend-resume cycle should not be necessary in theory
>> unless I'm missing something.
>>
>> The pm_request_idle() call in driver_probe_device() should trigger a
>> suspend of the jpeg device after probe (unless blocked by something)
>> and that should drop the RPM usage counter of the IOMMU.  Next, the
>> pm_runtime_put_suppliers() in there should actually suspend it.
>
> I've also would expect such behavior of PM core, but checks on real
> hardware gives other results.
>
>> It looks like the pm_request_idle() doesn't work as expected.
>
> pm_request_idle() calls rpm_idle(), which returns early with -EAGAIN due to
> (dev->power.runtime_status != RPM_ACTIVE) check. The device runtime_status
> is RPM_SUSPENDED as initially set by pm_runtime_init() on device creation.
> Notice that JPEG driver only calls pm_runtime_enable() and nothing more.

But is the device really suspended during probe?

Note that "suspend" means basically "not accessible to software", but
I guess software needs to access it to set it up, right?  If that is
the case, maybe the driver should set the initial RPM status of the
device to "active" before enabling runtime PM for it?  That at least
would be consistent with passing DL_FLAG_RPM_ACTIVE to
device_link_add().

There are drivers that don't actually touch the hardware in ->probe(),
but it follows from your description that this is not one of them.

>>> If I understand right, the DL_FLAG_RPM_ACTIVE flag should be there from the
>>> beginning, but that time it runtime pm part of links worked in a bit
>>> different way than now.
>> Right, and evidently there are callers depending on the existing behavior.
>>
>>> Is there any way to keep old behavior?
>> Yes, there is, please test the appended v2 of the $subject patch.
>>
>> That said, I'd like to remove the extra supplier resume from there going
>> forward as there may be callers who actually don't want that to happen and
>> DL_FLAG_RPM_ACTIVE is there for a purpose.
>
> Frankly, if the current behavior matches the designed behavior of
> DL_FLAG_RPM_ACTIVE flag,

It doesn't match the DL_FLAG_RPM_ACTIVE exactly as you've already noticed.

DL_FLAG_RPM_ACTIVE assumes that the initial RPM status of the device
will be RPM_ACTIVE and therefore the suppliers need to be resumed at
link creation time.  Therefore device_link_add() causes the suppliers
to remain in the RPM_ACTIVE state with the rpm_active status bit of
the link set, whereas currently they are simply suspended again by the
pm_runtime_put_suppliers() in driver_probe_device() and the link is
not marked as "rpm_active".

> then maybe instead of adding workarounds now, we
> should simply fix all existing callers of device_link_add()? 'git grep'
> shows
> only 6 places where links are created with DL_FLAG_PM_RUNTIME flag, I see no
> problem to add DL_FLAG_RPM_ACTIVE there to keep current behavior after a fix
> in runtime PM core. The description of DL_FLAG_RPM_ACTIVE should also be
> a bit
> updated, because I initially thought that it means that the runtime pm
> counter
> on supplier is increased for the whole lifetime of the device link (it
> is not
> clear when core will call a corresponding pm_runtime_put()).
>
> The other question is what need to be fixed to get proper behavior
> without the
> additional suspend/resume cycle mentioned a few paragraphs above.

As stated already, if the driver passes DL_FLAG_RPM_ACTIVE to
device_link_add() at probe time, then the initial RPM status of the
device being probed is expected to be RPM_ACTIVE.

>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>>
>> If a device link is added via device_link_add() by the driver of the
>> link's consumer device, the supplier's runtime PM usage counter is
>> going to be dropped by the pm_runtime_put_suppliers() call in
>> driver_probe_device().  However, in that case it is not incremented
>> unless the supplier driver is already present and the link is not
>> stateless.  That leads to a runtime PM usage counter imbalance for
>> the supplier device in a few cases.
>>
>> To prevent that from happening, bump up the supplier runtime
>> PM usage counter in device_link_add() for all links with the
>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>> time.  Use pm_runtime_get_noresume() for that as the callers of
>> device_link_add() who want the supplier to be resumed by it are
>> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
>> additionally resume the supplier if the link is added during
>> consumer driver probe to retain the existing behavior for the
>> callers depending on it.
>>
>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I've tested this version of the patch and it keeps the current behavior for
> links created with DL_FLAG_PM_RUNTIME flag. The questions is if we really
> want it?

I think so.

Basically, there are two changes at hand: fixing the behavior for
stateless links (and for stateful ones if the supplier driver is not
present, but that arguably is a corner case) and the behavior change
for stateful links (with supplier drivers present).

Arguably, the former is more important than the latter and I'd like to
be able to push that fix into -stable without dependencies.  The
latter can be done when all of the current callers depending on the
existing behavior have been adjusted.

So, I'm going to add a Tested-by from you to this patch, if you don't
mind, and queue it up.

Thanks,
Rafael
