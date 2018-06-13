Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 082F5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F0520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dPcSdxJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F0520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeFMGnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:43:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35472 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbeFMGnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:43:04 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180613064302euoutp0105a52b7626546d8a4ec3d0354ffabd33~3pSY61l-g0757907579euoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180613064302euoutp0105a52b7626546d8a4ec3d0354ffabd33~3pSY61l-g0757907579euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528872182;
        bh=o8rM6JMlglZKcv5JAQSa0NGumcPFnZB83Km0pdXo+yA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dPcSdxJckDtjTz13SIvBY3aotO+FAyBVEQSdliN9NnQeGAEP3rzSbVyz0WP0uPfp2
         dD6lSNnweH7gHNjY2et8JBM9e09nII2YSfOzlU/OANZnSyXxJASrSKCZ3aPNze7YxX
         P9uU67D6BEJ1F9N6OmY/5nS1gog5O4x6/9CWCGUI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613064300eucas1p1f0d1539a22fec9b753cc9c0f2e438d60~3pSXgpBH32024620246eucas1p14;
        Wed, 13 Jun 2018 06:43:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.6D.17380.3FCB02B5; Wed, 13
        Jun 2018 07:42:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9~3pSVbThtx0723907239eucas1p2l;
        Wed, 13 Jun 2018 06:42:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180613064257eusmtrp255c81a7808632f34e9a0f25f6b157218~3pSUoXxUe0870908709eusmtrp20;
        Wed, 13 Jun 2018 06:42:57 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-94-5b20bcf34c9e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4F.E6.04178.1FCB02B5; Wed, 13
        Jun 2018 07:42:57 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180613064257eusmtip210eb8f61bab1791951409a85e4670b02~3pSUP050Y2941129411eusmtip2C;
        Wed, 13 Jun 2018 06:42:57 +0000 (GMT)
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 13 Jun 2018 08:42:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29k5O1qT49R8maI2KzRLnQkd0CIhaBRpF6Nwlq48qeSmbGpp
        EILhdKiYYtoyiwUq3pa2lpfRRc3lBU1HoiGkJWqSis1+CF23M8t/z/tcvvd54SMxQScuJFMV
        mYxSIUsTEc5cY//GyH6ryU8aqhsNoNuq9Tid/1hP0Le1Oi5t6aohaGtJH6IXF7zo4aFxnDa3
        nD9CSqYnTITk5YNmnqQkf4WQGN6ruZJSQyOSWNt9JNVqI36KF+ccmcSkpWYzypDDic4pA282
        OBkW0Q31agGWhyq8NciJBCocdLV3eBrkTAqoBgQTxfdxdlhHMPL5iUOxIvhoqOVsRgaaphyu
        egR1P1sdrlUEb3urcJvLjboAed++Iht2pwLANDtqT2BUPQesiyauTSAoMWiWNYQGkSSX2g3W
        PrGN9qDiwWiZsVv4lCsM3JuzYyfqNBQZR+0tMMoXni/XYCz2hA9zDzm294Ea5MHKcLkjnA3V
        hRUYW/sojHUbcRa7wZLZwGOxN/zu3AznI1BXa3nsUIzgWU0HwboioNc8htuaYlQg6LtCWDoK
        5luqeDYaKBeYXHZlC7lAubEKY2k+FBYIWPce0Jpb/619/W4cK0Mi7ZYztVtO0245Tft/7yPE
        bUSeTJZKnsyowhTM9WCVTK7KUiQHX0mXt6O/H2rol3m9A3X9uNyDKBKJtvNnxnylAlyWrcqR
        9yAgMZE7v6zSTyrgJ8lychlleoIyK41R9SAvkivy5F8KuBUnoJJlmcw1hslglJsqh3QS5qGg
        Q9AZNq0s8DYf3KUjLB7CY4YTZzz3rbd9n1vYNlzpsZZozrga7z+yJDXVTTbXzUaF5ap9QBmj
        KQ0UW4s+LdHd9ZJXVQk71u62G0L0ptidL6Jd+spdDujOmWKDpiKt0ZbgaL785iAdfjJi4eJZ
        aAiN6df4P52PFW58abp3vEjEVaXIxHsxpUr2B6kgmdNMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7of9yhEG+zeJGexccZ6VovmxevZ
        LFpmLWKxuLxrDpvF594jjBYvnktbnDl9idXi+NpwBw6PO9f2sHnsn7uG3aO3+R2bx5ar7Swe
        fVtWMXp83iTnMaN9G2sAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexsmjP5kKLitVtL9vY25gnCzTxcjJISFgInFy9U3WLkYuDiGBpYwSi/d/
        ZIFIyEicnNbACmELS/y51sUGUfSWUWLW5YXsIAlhgQiJhk9vGEFsEQENiT0Pz4NNYhZYySTR
        e+QpE0THDiaJze+PMoNUsQkYSnS9BRnFwcErYCdxbXISiMkioCrx+YghSIWoQIzE6o2Xwebz
        CghKnJz5BOwgToFAic5t55lAbGYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwHjcduzn5h2MlzYGH2IU4GBU4uF9
        cFE+Wog1say4MvcQowQHs5II74SpCtFCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MFXkl
        8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhhNzn8UOLa0bvPXzdMr
        Pk1UylE+5fE/zHUb/yJZkXcNAl4Ma2bz/2Ducjwq+XOy2tc9bLfdDurofTnwef/Wa1aSxw+f
        Vjtecq1vFdv0JqFXjQf8JV2eeQWd6V306YeFqGfU+4Nlt/0UNHdHi0zc0nE4Qni5eMQ69V3N
        i+4wvurbPz9rZkfX1rRIJZbijERDLeai4kQAhMOAwt0CAAA=
Message-Id: <20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9~3pSVbThtx0723907239eucas1p2l@eucas1p2.samsung.com>
X-CMS-MailID: 20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
        <10125310.W3e2TP0641@aspire.rjw.lan>
        <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
        <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 2018-06-12 21:43, Ulf Hansson wrote:
> On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
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
>> Let's get back to my IOMMU and codec case, mentioned here:
>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>
>> Now, after applying your patch, when IOMMU creates a link with
>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
> According to your earlier replies, I thought this is what you wanted. No?
>
>> This means that until jpeg driver enables runtime pm for its device and
>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>> resumed.
> What's the problem with that?

Wasted power. IOMMU device is left enabled until first use of JPEG device,
what means that respective power domain is also turned on unnecessarily.

> When does the IOMMU device needs to be
> runtime resumed?

I would like to have IOMMU (supplier) runtime active all the time the JPEG
(consumer) device is runtime active AND all the time between probe() and
remove() if JPEG (consumer) doesn't support runtime PM (if it doesn't
enable runtime PM at all).

>> On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>> creation, the supplier is properly resumed, but then, once the jpeg
>> device probe finishes, the supplier is still in runtime active state
>> until a next runtime suspend/resume cycle of jpeg device.
> Could you elaborate on the what happens in jpeg driver during probe,
> in regards to runtime PM. Perhaps you can also point me to what driver
> it is?

s5p_jpeg_probe() doesn't touch hardware at all and only calls 
pm_runtime_enable(),
see drivers/media/platform/s5p-jpeg/jpeg-core.c

>> If I understand
>> right, the DL_FLAG_RPM_ACTIVE flag should be there from the beginning,
>> but that time it runtime pm part of links worked in a bit different way
>> than now.
> Just to make sure, you also reverted 1e8378619841, before trying
> Rafael's change on top?

Yes

>> Is there any way to keep old behavior?
> I think the old behavior is sub-optimal. I am sure there are users
> that really don't want the driver core to runtime resume the supplier
> unconditionally.
>
> I would rather go and fix the few users of device_link_add(), to use
> DL_FLAG_RPM_ACTIVE, in cases when they need it. Of course I am fine if
> we do these changes in a step by step basis as well.

I also agree that the old behavior is sub-optimal and there are use
cases for the new (corrected) approach. I see no problems to add
DL_FLAG_RPM_ACTIVE to exynos-iommu driver (and probably the 5 other
drivers, which create links with DL_FLAG_PM_RUNTIME flag set to avoid
regressions). The question is what else should be changed/fixed to get
old behavior now.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

