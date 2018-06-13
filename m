Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03FE5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989AB208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3ctR/3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989AB208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933985AbeFMGXY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:23:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58275 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeFMGXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:23:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180613062319euoutp016dc4496c6a24570355ea93b40c1e2792~3pBLR6CGr2873428734euoutp016
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180613062319euoutp016dc4496c6a24570355ea93b40c1e2792~3pBLR6CGr2873428734euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528870999;
        bh=NOBe6JbwRxi7VgANoHolYISXO37FQ4wgNk+EfL1vOxg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X3ctR/3o10OZ+b0V1WdxKbND/ycHT01zz27dirZO5fTCzvOAavnMspPvZ1BZ4aQs3
         ultMoPNkxkgSQl9GOUt7E1vRIK4mleqQNsONcF0Fxk4HysgthCf5jmHQnsjmMgqWMw
         A/8geAd/xG2rB27Cr8c08OSSnhl7dWWOOi5UvDIg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180613062317eucas1p29b90ffb5af766b3402edacbdd9364bc7~3pBKE_AqX1828918289eucas1p2a;
        Wed, 13 Jun 2018 06:23:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F2.3B.17380.558B02B5; Wed, 13
        Jun 2018 07:23:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O;
        Wed, 13 Jun 2018 06:23:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180613062316eusmtrp172da78c07233f3d5c76a218f0cf527b3~3pBI1QfSv2392723927eusmtrp1X;
        Wed, 13 Jun 2018 06:23:16 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-1e-5b20b855ee70
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.15.04178.458B02B5; Wed, 13
        Jun 2018 07:23:16 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180613062316eusmtip1cab267632f5697de520f78f90645b55e~3pBIU7Bis1224612246eusmtip1l;
        Wed, 13 Jun 2018 06:23:16 +0000 (GMT)
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 13 Jun 2018 08:23:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1692795.7GA92aXxMT@aspire.rjw.lan>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7qhOxSiDR63qFpsnLGe1aJ58Xo2
        i5ZZi1gsLu+aw2bxufcIo8WL59IWZ05fYrU4vjbcgcPjzrU9bB77565h9+htfsfmseVqO4tH
        35ZVjB6fN8l5zGjfxhrAHsVlk5Kak1mWWqRvl8CV8W+9eUGXbUXziVWMDYwrDbsYOTkkBEwk
        Nl29y9bFyMUhJLCCUeLXz4PsEM4XRonG9XdYIZzPjBIfTkxmhmm5+fIsM0RiOaPEsuMrwRJC
        Au8ZJab84wGxhQUiJBo+vWEEsUUEtCXm9pwCq2EWWMIkcWRPGYjNJmAo0fW2iw3EZhFQlfh3
        4wKYLSoQI7Ht8gMWEJtXQFDi5MwnYDangIHE8k1LWSDmyEtsfzsHaqa4xK0n85lADpIQOMYu
        sfjDclaI5jKJTTcWskFc7SJx4vl2KFtY4tXxLewQtozE6ck9LBDNzYwS7TNmsUM4PYwSW+fs
        gOqwljh8/CLQVA6gdZoS63fpQ4QdJZ6tnc4OEpYQ4JO48VYQ4iA+iUnbpjNDhHklOtqEIKrV
        JGYdXwe39uCFS8wTGJVmIXlzFpLXZiF5bRbC3gWMLKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1
        kvNzNzECk9Ppf8e/7GDc9SfpEKMAB6MSD++Di/LRQqyJZcWVuYcYJTiYlUR4J0xViBbiTUms
        rEotyo8vKs1JLT7EKM3BoiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpg5DXf3+IyM7eJq2rm
        iraJ3hrF85ZdDPL+1Xi3/Ij0JOO8eTFTuG8fcNzXu6WLpfAFQ5nGvvsXLuQ2nznAVLi0pPFY
        h5GNKecTpsoV09zrrELcP326+sd0/2bD5em/bqeyXf/+vl1Ucuqfb407/tmv2/G+6h3jbZWF
        VX367PsqVnvJv7DJ4P//VomlOCPRUIu5qDgRAJKcFQlKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7ohOxSiDb7NV7bYOGM9q0Xz4vVs
        Fi2zFrFYXN41h83ic+8RRosXz6Utzpy+xGpxfG24A4fHnWt72Dz2z13D7tHb/I7NY8vVdhaP
        vi2rGD0+b5LzmNG+jTWAPUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv499684Iu24rmE6sYGxhXGnYxcnJICJhI3Hx5lrmLkYtDSGApo0RPZxsj
        REJG4uS0BlYIW1jiz7UuNoiit4wSC78sZgZJCAtESDR8egPWICKgLTG35xTYJGaBJUwSZ7ct
        YoHomM4kserUcnaQKjYBQ4mutyCjODl4Bewk9mz+C2azCKhK/LtxAcwWFYiRWL3xMjtEjaDE
        yZlPWEBsTgEDieWbloLZzAJmEvM2P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJ
        ywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBEbnt2M/NOxgvbQw+xCjAwajEw/vgony0
        EGtiWXFl7iFGCQ5mJRHeCVMVooV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gs8kriDU0N
        zS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MHY16T/+lD57jz7D2oMJH6rt
        d04LCd0ad+b/XAvNa9pVXJ/a1SK0mRvCT99xNl1ewr/o/NZZCzlfz+6eUar4MXKtEePznbt8
        p//gt1u7iu0s/6NPN06lPW9u103ba/L3kaFkZ/6ryCPbp2x2vLp1yg3T+MnlR+sF7ns9O5F1
        hP/w/aY3y7d8lwlQYinOSDTUYi4qTgQA4NLf3t4CAAA=
Message-Id: <20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O@eucas1p2.samsung.com>
X-CMS-MailID: 20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018-06-12 16:24, Rafael J. Wysocki wrote:
> On Tuesday, June 12, 2018 2:44:23 PM CEST Marek Szyprowski wrote:
>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
>>> device_link_add() who want the supplier to be resumed by it should
>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>
>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>> reference counting of device link suppliers at probe) that is going
>>> to be reverted.
>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
> Thanks for testing! :-)
>
>> Let's get back to my IOMMU and codec case, mentioned here:
>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>
>> Now, after applying your patch, when IOMMU creates a link with
>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
>> This means that until jpeg driver enables runtime pm for its device and
>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>> resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>> creation, the supplier is properly resumed, but then, once the jpeg
>> device probe finishes, the supplier is still in runtime active state
>> until a next runtime suspend/resume cycle of jpeg device.
> That additional suspend-resume cycle should not be necessary in theory
> unless I'm missing something.
>
> The pm_request_idle() call in driver_probe_device() should trigger a
> suspend of the jpeg device after probe (unless blocked by something)
> and that should drop the RPM usage counter of the IOMMU.  Next, the
> pm_runtime_put_suppliers() in there should actually suspend it.

I've also would expect such behavior of PM core, but checks on real
hardware gives other results.

> It looks like the pm_request_idle() doesn't work as expected.

pm_request_idle() calls rpm_idle(), which returns early with -EAGAIN due to
(dev->power.runtime_status != RPM_ACTIVE) check. The device runtime_status
is RPM_SUSPENDED as initially set by pm_runtime_init() on device creation.
Notice that JPEG driver only calls pm_runtime_enable() and nothing more.

>> If I understand right, the DL_FLAG_RPM_ACTIVE flag should be there from the
>> beginning, but that time it runtime pm part of links worked in a bit
>> different way than now.
> Right, and evidently there are callers depending on the existing behavior.
>   
>> Is there any way to keep old behavior?
> Yes, there is, please test the appended v2 of the $subject patch.
>
> That said, I'd like to remove the extra supplier resume from there going
> forward as there may be callers who actually don't want that to happen and
> DL_FLAG_RPM_ACTIVE is there for a purpose.

Frankly, if the current behavior matches the designed behavior of
DL_FLAG_RPM_ACTIVE flag, then maybe instead of adding workarounds now, we
should simply fix all existing callers of device_link_add()? 'git grep' 
shows
only 6 places where links are created with DL_FLAG_PM_RUNTIME flag, I see no
problem to add DL_FLAG_RPM_ACTIVE there to keep current behavior after a fix
in runtime PM core. The description of DL_FLAG_RPM_ACTIVE should also be 
a bit
updated, because I initially thought that it means that the runtime pm 
counter
on supplier is increased for the whole lifetime of the device link (it 
is not
clear when core will call a corresponding pm_runtime_put()).

The other question is what need to be fixed to get proper behavior 
without the
additional suspend/resume cycle mentioned a few paragraphs above.

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>
> If a device link is added via device_link_add() by the driver of the
> link's consumer device, the supplier's runtime PM usage counter is
> going to be dropped by the pm_runtime_put_suppliers() call in
> driver_probe_device().  However, in that case it is not incremented
> unless the supplier driver is already present and the link is not
> stateless.  That leads to a runtime PM usage counter imbalance for
> the supplier device in a few cases.
>
> To prevent that from happening, bump up the supplier runtime
> PM usage counter in device_link_add() for all links with the
> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
> time.  Use pm_runtime_get_noresume() for that as the callers of
> device_link_add() who want the supplier to be resumed by it are
> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
> additionally resume the supplier if the link is added during
> consumer driver probe to retain the existing behavior for the
> callers depending on it.
>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I've tested this version of the patch and it keeps the current behavior for
links created with DL_FLAG_PM_RUNTIME flag. The questions is if we really
want it?

> ---
>   drivers/base/core.c |   15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
>   			link->rpm_active = true;
>   		}
>   		pm_runtime_new_link(consumer);
> +		/*
> +		 * If the link is being added by the consumer driver at probe
> +		 * time, balance the decrementation of the supplier's runtime PM
> +		 * usage counter after consumer probe in driver_probe_device().
> +		 */
> +		if (consumer->links.status == DL_DEV_PROBING)
> +			pm_runtime_get_noresume(supplier);
>   	}
>   	get_device(supplier);
>   	link->supplier = supplier;
> @@ -235,12 +242,12 @@ struct device_link *device_link_add(stru
>   			switch (consumer->links.status) {
>   			case DL_DEV_PROBING:
>   				/*
> -				 * Balance the decrementation of the supplier's
> -				 * runtime PM usage counter after consumer probe
> -				 * in driver_probe_device().
> +				 * Some callers expect the link creation during
> +				 * consumer driver probe to resume the supplier
> +				 * even without DL_FLAG_RPM_ACTIVE.
>   				 */
>   				if (flags & DL_FLAG_PM_RUNTIME)
> -					pm_runtime_get_sync(supplier);
> +					pm_runtime_resume(supplier);
>   
>   				link->status = DL_STATE_CONSUMER_PROBE;
>   				break;
>
>
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

