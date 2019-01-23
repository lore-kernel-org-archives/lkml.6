Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA895C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17E621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iYzInfyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfAWI0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:26:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51926 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfAWI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:26:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190123082651euoutp01ad08e1a7ddb145a598d83399ce1fb6f6~8bM-PyiSJ0646706467euoutp01j
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:26:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190123082651euoutp01ad08e1a7ddb145a598d83399ce1fb6f6~8bM-PyiSJ0646706467euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548232011;
        bh=meVMRgsTYcqgFAT9IVIUB3oG3QcDW4crpl9UWZTS9Q8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iYzInfyxUMYZYikgQ5bswFrA2Ul0y3HHS4GqNeZ1pNebQ7iygI+7qrbi4IiwoXEG+
         Ho78FavUxL7o7euStj5xgfpfwe9//BGcbINXnpdwwkfDlyjR6RyMP91j/1W0dL6xeX
         cz8IdsP7PrS/KFBluJR9k+otuVL8QXR/1QD4SOA8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190123082651eucas1p246d5b28a7e2c92145588f8254105f555~8bM_9FbGM1835718357eucas1p2P;
        Wed, 23 Jan 2019 08:26:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.78.04806.B45284C5; Wed, 23
        Jan 2019 08:26:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280~8bM9zCFET1834918349eucas1p2N;
        Wed, 23 Jan 2019 08:26:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190123082649eusmtrp2420e7092af5722c0e26899adb162acb3~8bM9keoC62287322873eusmtrp2J;
        Wed, 23 Jan 2019 08:26:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-eb-5c48254b4a56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.C2.04128.945284C5; Wed, 23
        Jan 2019 08:26:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190123082649eusmtip1244f2cda0f9e9080aedfd3f46821b3e4~8bM8zvwQT2571425714eusmtip1C;
        Wed, 23 Jan 2019 08:26:49 +0000 (GMT)
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <47b23e55-11b7-3d44-d611-8d6120139d5c@samsung.com>
Date:   Wed, 23 Jan 2019 09:26:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7reqh4xBu+ucVhMffiEzeLZrb1M
        Fi2zFrFYfH/UwGRxedccNoutL98xWTR+vMlu0fllFpsDh8emVZ1sHocOdzB6PNrq79Hb/I7N
        4/MmuQDWKC6blNSczLLUIn27BK6M5u15BV+FKu68PM/YwLiAv4uRg0NCwETiy8/ALkZODiGB
        FYwSM1uLuhi5gOwvjBInbjxlg3A+M0qcm7OMBaQKpOH/6kuMEInljBLXl75hh3DeM0pMWvaG
        CaRKWCBT4tD/iWC2iECQxIYFW8A6mAUmMEm86m9hA0mwCRhKdL3tArN5Bewkuv/fYQS5iUVA
        VaK/JQzEFBWIkWi9zAVRIShxcuYTsCM4BQIlLnzZxQ5iMwvIS2x/O4cZwhaXuPVkPhPIKgmB
        bewSRzseMENc7SJx+/xyRghbWOLV8S3sELaMxP+dMA3NjBLtM2axQzg9jBJb5+xgg6iyljh8
        /CIryEXMApoS63fpQ4QdJT5fXsEECUc+iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsP
        XrjEPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzAN
        nf53/OsOxn1/kg4xCnAwKvHw/jBzjxFiTSwrrsw9xCjBwawkwut60S1GiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+NJJ639NfZCD2SNPh+7knWaj+Ej
        p5uFlFbBlOO/k582XM1rOylnorTq7dkCRemcggu+da5pphd0NuVKm9UFbi+eY/JeYNM1deMT
        P90Nrq9w2shgE5Bmn9PrnWLuFv08anHl0VD2c9aulmt2cKoxhnJsMzLa2n5mFXvCJX9xoZV/
        HrzUTGFcosRSnJFoqMVcVJwIAIioyOc/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7qeqh4xBl9+mlpMffiEzeLZrb1M
        Fi2zFrFYfH/UwGRxedccNoutL98xWTR+vMlu0fllFpsDh8emVZ1sHocOdzB6PNrq79Hb/I7N
        4/MmuQDWKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2M5u15BV+FKu68PM/YwLiAv4uRk0NCwETi/+pLjF2MXBxCAksZJRr+7mSCSMhInJzWwAph
        C0v8udbFBlH0llHi2O1XbCAJYYFMiUP/J4I1iAgESTz4e5IVpIhZYBKTxOG906E6WhglbjZu
        ZwSpYhMwlOh62wXWzStgJ9H9/w5QnIODRUBVor8lDCQsKhAjMetJHztEiaDEyZlPWEBsToFA
        iQtfdoHFmQXUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJL
        i3PTc4uN9IoTc4tL89L1kvNzNzECo2/bsZ9bdjB2vQs+xCjAwajEw/vDzD1GiDWxrLgy9xCj
        BAezkgiv60W3GCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3OByaGvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjKdPlryYs191cVfmy6ffblTFrbyxlvnyvOzJ
        2zYc+f3aOL//iSfXcqN9i7sbLkSYfjd3+BLFev5MmlTrinsBu4963dgt/+uLsgq/q/fJCiHW
        pndWunOmcmr/sHnCm7ZX5MK0CgbpWSmLZvPqzrWQzCyN9TB7z6jAHRxQ6X/i9WcfH/Gq7veH
        bJVYijMSDbWYi4oTAeNO1G/UAgAA
X-CMS-MailID: 20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
        <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
        <CGME20190123082650eucas1p243ce21346a00e9b3e9eed2863cd3d280@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

On 2019-01-22 10:36, Geert Uytterhoeven wrote:
> On Mon, Jan 14, 2019 at 4:36 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>> I have noticed that system suspend has started failing consistently on a
>> couple Tegra boards over the last few days with the linux-next branch.
>> The following error is seen on on entering suspend ...
>>
>> [   58.222033] spi_master spi1: could not stop message queue
>> [   58.222038] spi_master spi1: queue stop failed
>> [   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
>> [   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
>> [   58.222057] PM: Some devices failed to suspend, or early wake event detected
>>
>> Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
>> waking pump thread from spi_sync instead run teardown delayed") and
>> reverting this on top of -next fixes the problem. I have not had chance
>> to dig any further but wanted to report this issue to see if you have
>> any thoughts.
> I can confirm this on r8a7791/koelsch:
>
>     PM: suspend entry (deep)
>     PM: Syncing filesystems ... done.
>     Freezing user space processes ... (elapsed 0.010 seconds) done.
>     OOM killer disabled.
>     Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
>     spi_master spi0: could not stop message queue
>     spi_master spi0: queue stop failed
>     dpm_run_callback(): rspi_suspend+0x0/0xc returns -16
>     PM: Device e6b10000.spi failed to suspend: error -16
>     PM: Some devices failed to suspend, or early wake event detected

With recent linux-next I've got a similar issue on Samsung Exynos based
Chromebooks: Peach-Pit and Peach-Pi, both using SPI for communicating
with regulators via chrome EC bridge:

PM: suspend entry (deep)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
printk: Suspending console(s) (use no_console_suspend to debug)
...
spi_master spi2: could not stop message queue
spi_master spi2: queue stop failed
dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
PM: Device 12d40000.spi failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

