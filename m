Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B75CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2395A20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tSUEsRzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2395A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935175AbeFMKXI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:23:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42654 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934978AbeFMKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:23:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180613102303euoutp02e70d554ef5d5e08b09b119758ab12b90~3sSf7GHIz0068400684euoutp02a
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180613102303euoutp02e70d554ef5d5e08b09b119758ab12b90~3sSf7GHIz0068400684euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528885383;
        bh=flygiTKnPIMeJ+h/bBWsO5G/HkKu1WD4wnMLMIJ+7XU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tSUEsRzYjTyo0BWfReRGtw4rWoY9qNiocldfFNxazSgE/JusVQUCKEiFkE+vmY/U/
         Ca8BJaHOHf1qfIysw/E4cXL5hVk3YqW21pBGj0cG6IGA2Nx93cZPaEJkX5gWf0OJij
         HxD7Kflj50jYzp2ZeUVfdQUQZd3HjEjnX1pJPthY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613102302eucas1p13169b2f85ce1bf88da6e0ef15f692041~3sSejeLG22237822378eucas1p1D;
        Wed, 13 Jun 2018 10:23:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.C9.05700.580F02B5; Wed, 13
        Jun 2018 11:23:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180613102301eucas1p26feaa6ac1ceba2216bd9f2b696c89f86~3sSdhwfI42411224112eucas1p2y;
        Wed, 13 Jun 2018 10:23:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180613102301eusmtrp1ae239242938ac04183b1f049aaa8a51d~3sSdgg78N3156731567eusmtrp1e;
        Wed, 13 Jun 2018 10:23:01 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-74-5b20f0856510
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.C4.04183.580F02B5; Wed, 13
        Jun 2018 11:23:01 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180613102300eusmtip29880f0f2f06544289af06aa0da8dafd0~3sSdBsTU-2103021030eusmtip2G;
        Wed, 13 Jun 2018 10:23:00 +0000 (GMT)
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 13 Jun 2018 12:23:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gh-Vq=6X9Dn2x-x_REnOwPVAfNj+CTJRUkKNmsAPmsnQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87qtHxSiDbb9srbYOGM9q0Xz4vVs
        Fi2zFrFYXN41h83ic+8RRosXz6Ut5n6Zymxx5vQlVovja8MdOD02repk87hzbQ+bx/65a9g9
        epvfsXlsudrO4tG3ZRWjx+dNch4z2rexBnBEcdmkpOZklqUW6dslcGWsmXWUpeC4T8XLvRfZ
        GxjP2nUxcnJICJhI9D46xtjFyMUhJLCCUWLV1dmsEM4XRomf59pYIJzPjBLP7zWxwrScObsX
        qmo5o8TCH01QVe8ZJa59vMMMUiUsECHR8OkNI4gtIqAtsWTRVWaQImaBs0wSlzr+s4Ak2AQM
        JbredrGB2CwCqhKL2naDxUUFYiS2XX4AZvMKCEqcnPkEzOYUCJS48+gP2FBmAXmJ5q2zmSFs
        cYlbT+YzgSyQELjELvFpyWN2iOYyien3vkLd7SJxbM8TdghbWOLV8S1QtozE6ck9LBDNzYwS
        7TNmsUM4PYwSW+fsYIOospY4fPwi0CQOoHWaEut36UOEHSWerZ3ODhKWEOCTuPFWEOIgPolJ
        26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiF5cxaS12YheW0Wwt4FjCyrGMVTS4tz01OL
        DfNSy/WKE3OLS/PS9ZLzczcxAtPW6X/HP+1g/Hop6RCjAAejEg/vg4vy0UKsiWXFlbmHGCU4
        mJVEeP1eKEQL8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2CyTJxcEo1
        MO6SVZxhoDrt9d+GmQkevibnlLd5T9hit8XwqdhrMQXmN84yxw7kT/8lzzvLyK1qYnVfg9C5
        2dV5Kh9S1oQLH9l1Ief1CftLNtx/G0JeFHOJ7EuzecC45mlC33/llXfuBsu02qSHWmowr9tx
        Zvr9eg3Zbys1J75Y8yzobMfyVPnpy1+WTGcou6zEUpyRaKjFXFScCABrKuKoVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7qtHxSiDf5c4bDYOGM9q0Xz4vVs
        Fi2zFrFYXN41h83ic+8RRosXz6Ut5n6Zymxx5vQlVovja8MdOD02repk87hzbQ+bx/65a9g9
        epvfsXlsudrO4tG3ZRWjx+dNch4z2rexBnBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjq
        GRqbx1oZmSrp29mkpOZklqUW6dsl6GWsmXWUpeC4T8XLvRfZGxjP2nUxcnJICJhInDm7l7WL
        kYtDSGApo8Tz049ZIBIyEienNbBC2MISf651sYHYQgJvGSXeL5ABsYUFIiQaPr1hBLFFBLQl
        liy6ygwyiFngPJPEu7+b2SCmnmaWuPVgOdhUNgFDia63EJN4Bewkzu6ezgxiswioSixq2w1W
        IyoQI7F642V2iBpBiZMzn4DFOQUCJe48+gO2jVnATGLe5ofMELa8RPPW2VC2uMStJ/OZJjAK
        zULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGKXbjv3csoOx613w
        IUYBDkYlHt4HF+WjhVgTy4orcw8xSnAwK4nw+r1QiBbiTUmsrEotyo8vKs1JLT7EaAr03ERm
        KdHkfGACySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwJhzydl6
        1n/ubDPlBzFqHF1dl11zKpde5zrqxap3v/qb6Otm1ZVb3W7PUt7xUZGPL7j2rE95ad+PnBf7
        ruRabFRkMJtyODXN0P2rAa+aUlxx/Y0QtR3fcmedbvt8MzbVaQ2jmsEaK+1LxwS6DoZNPRej
        IZis+yrqmCmb5Smv10mPkwzbLNz6lViKMxINtZiLihMBF44Bw+gCAAA=
Message-Id: <20180613102301eucas1p26feaa6ac1ceba2216bd9f2b696c89f86~3sSdhwfI42411224112eucas1p2y@eucas1p2.samsung.com>
X-CMS-MailID: 20180613102301eucas1p26feaa6ac1ceba2216bd9f2b696c89f86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
        <10125310.W3e2TP0641@aspire.rjw.lan>
        <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
        <1692795.7GA92aXxMT@aspire.rjw.lan>
        <20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O@eucas1p2.samsung.com>
        <CAJZ5v0gh-Vq=6X9Dn2x-x_REnOwPVAfNj+CTJRUkKNmsAPmsnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018-06-13 10:16, Rafael J. Wysocki wrote:
> On Wed, Jun 13, 2018 at 8:23 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> On 2018-06-12 16:24, Rafael J. Wysocki wrote:
>>> On Tuesday, June 12, 2018 2:44:23 PM CEST Marek Szyprowski wrote:
>>>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> If a device link is added via device_link_add() by the driver of the
>>>>> link's consumer device, the supplier's runtime PM usage counter is
>>>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>>>> driver_probe_device().  However, in that case it is not incremented
>>>>> unless the supplier driver is already present and the link is not
>>>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>>>> the supplier device in a few cases.
>>>>>
>>>>> To prevent that from happening, bump up the supplier runtime
>>>>> PM usage counter in device_link_add() for all links with the
>>>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>>>> device_link_add() who want the supplier to be resumed by it should
>>>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>>>
>>>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>>>> reference counting of device link suppliers at probe) that is going
>>>>> to be reverted.
>>>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
>>> Thanks for testing! :-)
>>>
>>>> Let's get back to my IOMMU and codec case, mentioned here:
>>>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>>>
>>>> Now, after applying your patch, when IOMMU creates a link with
>>>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>>>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>>>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
>>>> This means that until jpeg driver enables runtime pm for its device and
>>>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>>>> resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>>>> creation, the supplier is properly resumed, but then, once the jpeg
>>>> device probe finishes, the supplier is still in runtime active state
>>>> until a next runtime suspend/resume cycle of jpeg device.
>>> That additional suspend-resume cycle should not be necessary in theory
>>> unless I'm missing something.
>>>
>>> The pm_request_idle() call in driver_probe_device() should trigger a
>>> suspend of the jpeg device after probe (unless blocked by something)
>>> and that should drop the RPM usage counter of the IOMMU.  Next, the
>>> pm_runtime_put_suppliers() in there should actually suspend it.
>> I've also would expect such behavior of PM core, but checks on real
>> hardware gives other results.
>>
>>> It looks like the pm_request_idle() doesn't work as expected.
>> pm_request_idle() calls rpm_idle(), which returns early with -EAGAIN due to
>> (dev->power.runtime_status != RPM_ACTIVE) check. The device runtime_status
>> is RPM_SUSPENDED as initially set by pm_runtime_init() on device creation.
>> Notice that JPEG driver only calls pm_runtime_enable() and nothing more.
> But is the device really suspended during probe?

This is a runtime pm state of the newly created platform device when driver
core calls ->probe() from its driver. At that time it is not yet known if
the driver supports runtime pm or not and typically drivers do some hardware
access there. Platform device is created from device tree.

> Note that "suspend" means basically "not accessible to software", but
> I guess software needs to access it to set it up, right?  If that is
> the case, maybe the driver should set the initial RPM status of the
> device to "active" before enabling runtime PM for it?  That at least
> would be consistent with passing DL_FLAG_RPM_ACTIVE to
> device_link_add().
>
> There are drivers that don't actually touch the hardware in ->probe(),
> but it follows from your description that this is not one of them.

The JPEG driver was just an example, and it actually doesn't touch hw in
probe. However I would like to have the typical cases working:

1. runtime pm enabled, no hw access
2. runtime pm enabled, some hw access (guarded by either
    pm_runtime_get_sync or pm_runtime_get_noresume+pm_runtime_set_active)
3. runtime pm disabled (no runtime pm calls at all), some hw access.

For the last type it is important to enable IOMMU during the probe().

>>>> If I understand right, the DL_FLAG_RPM_ACTIVE flag should be there from the
>>>> beginning, but that time it runtime pm part of links worked in a bit
>>>> different way than now.
>>> Right, and evidently there are callers depending on the existing behavior.
>>>
>>>> Is there any way to keep old behavior?
>>> Yes, there is, please test the appended v2 of the $subject patch.
>>>
>>> That said, I'd like to remove the extra supplier resume from there going
>>> forward as there may be callers who actually don't want that to happen and
>>> DL_FLAG_RPM_ACTIVE is there for a purpose.
>> Frankly, if the current behavior matches the designed behavior of
>> DL_FLAG_RPM_ACTIVE flag,
> It doesn't match the DL_FLAG_RPM_ACTIVE exactly as you've already noticed.
>
> DL_FLAG_RPM_ACTIVE assumes that the initial RPM status of the device
> will be RPM_ACTIVE and therefore the suppliers need to be resumed at
> link creation time.  Therefore device_link_add() causes the suppliers
> to remain in the RPM_ACTIVE state with the rpm_active status bit of
> the link set, whereas currently they are simply suspended again by the
> pm_runtime_put_suppliers() in driver_probe_device() and the link is
> not marked as "rpm_active".
>
>> then maybe instead of adding workarounds now, we
>> should simply fix all existing callers of device_link_add()? 'git grep'
>> shows
>> only 6 places where links are created with DL_FLAG_PM_RUNTIME flag, I see no
>> problem to add DL_FLAG_RPM_ACTIVE there to keep current behavior after a fix
>> in runtime PM core. The description of DL_FLAG_RPM_ACTIVE should also be
>> a bit
>> updated, because I initially thought that it means that the runtime pm
>> counter
>> on supplier is increased for the whole lifetime of the device link (it
>> is not
>> clear when core will call a corresponding pm_runtime_put()).
>>
>> The other question is what need to be fixed to get proper behavior
>> without the
>> additional suspend/resume cycle mentioned a few paragraphs above.
> As stated already, if the driver passes DL_FLAG_RPM_ACTIVE to
> device_link_add() at probe time, then the initial RPM status of the
> device being probed is expected to be RPM_ACTIVE.

Okay, then this doesn't match the case of Exynos IOMMU and JPEG (and other
Exynos multimedia drivers), because the links are created from the 
add_device
platform bus notifier, which is executed just before ->probe() callback of
the newly created jpeg/multimedia device. That time of course 
jpeg/multimedia
driver is not able to enable runtime PM of the handled device yet...

>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>>>
>>> If a device link is added via device_link_add() by the driver of the
>>> link's consumer device, the supplier's runtime PM usage counter is
>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>> driver_probe_device().  However, in that case it is not incremented
>>> unless the supplier driver is already present and the link is not
>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>> the supplier device in a few cases.
>>>
>>> To prevent that from happening, bump up the supplier runtime
>>> PM usage counter in device_link_add() for all links with the
>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>> device_link_add() who want the supplier to be resumed by it are
>>> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
>>> additionally resume the supplier if the link is added during
>>> consumer driver probe to retain the existing behavior for the
>>> callers depending on it.
>>>
>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> I've tested this version of the patch and it keeps the current behavior for
>> links created with DL_FLAG_PM_RUNTIME flag. The questions is if we really
>> want it?
> I think so.
>
> Basically, there are two changes at hand: fixing the behavior for
> stateless links (and for stateful ones if the supplier driver is not
> present, but that arguably is a corner case) and the behavior change
> for stateful links (with supplier drivers present).
>
> Arguably, the former is more important than the latter and I'd like to
> be able to push that fix into -stable without dependencies.  The
> latter can be done when all of the current callers depending on the
> existing behavior have been adjusted.
>
> So, I'm going to add a Tested-by from you to this patch, if you don't
> mind, and queue it up.

Okay, fine for me.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

