Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29150C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E4E20700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gnqOttu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E4E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbeKFB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:56:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34194 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:56:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181105163600euoutp02338f9e198eb98294ca0f0a6e7567e70a~kR6gppdiO0762707627euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 16:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181105163600euoutp02338f9e198eb98294ca0f0a6e7567e70a~kR6gppdiO0762707627euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541435760;
        bh=H0/PBL2NbtjRtladzOXaXnMEvJHQ3q7TKIWl3omDj70=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gnqOttu6iviqbJYCm/Sn5OYfQVy1394jf8foktKFhljtVquiugYc+grs8xbQ7c+vF
         ZCOhhTgP/3efptfEaVm8YQs+OXWbvs72G2n0xmHtqKJIdtZS4q8UhD5oWXmL31FCG5
         iuSDC3WstwpL32S5CfBj5H+O9vzXjFVmcxQsPtZA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181105163558eucas1p216334856de567ec5f6324f8a9f67b1e6~kR6foTCef2469224692eucas1p2-;
        Mon,  5 Nov 2018 16:35:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.30.04441.E6170EB5; Mon,  5
        Nov 2018 16:35:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181105163557eucas1p160168ea4ccd52bd8cea53fb843ff06e7~kR6eqjkTH2968229682eucas1p1e;
        Mon,  5 Nov 2018 16:35:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181105163557eusmtrp12d5662bdd88910a1a8a50d853eb99493~kR6eZUnFp2213022130eusmtrp1b;
        Mon,  5 Nov 2018 16:35:57 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-8b-5be0716e377b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.DE.04128.D6170EB5; Mon,  5
        Nov 2018 16:35:57 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181105163556eusmtip19ec32e31c84c52c72bdba74d5afe498f~kR6drg-960720907209eusmtip1N;
        Mon,  5 Nov 2018 16:35:56 +0000 (GMT)
Subject: Re: [PATCH v2 00/17] thermal: enable+check sensor after its setup
 is finished
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ba5bc790-6809-e0e3-58fb-757c8c617181@samsung.com>
Date:   Mon, 5 Nov 2018 17:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1541387097.2124.9.camel@intel.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj27Tl79mwcvl2ZXvdpNUxmSAbzuUwYzTgzxmXMNC4xWnVmNWrL
        HrmOEdVilYSx2lzLKpES6SKjiW27ukWzg2zSCCHZXGoM2s42/Hve93me733edz6WUn+Rj2Ij
        9VsFg14bpWG86FtVPQ+n6Le0hE67ccePJMRnychblx2RvBQbTc49bZKTin2NiPxp7ZCT2uL9
        MpJoyaTJxbbXCtJYdpohrpT7iJz+/EJB2l4fYci7mz6kMMfBkJ6yszS588qFFqj4/Z1VDG9x
        NjB8qaVZwRc9n8lnlb+X8YW5hxj+ZVM5w6ckfGb44qazFF9t/kHzdkexjHcVjlsxZK3XvAgh
        KnKbYAgICvPaVJcdEJs5f8dv4wEmHl0OMCElC3gGGMu+KEzIi1XjHATltl5GKroRPLtw3cO4
        ENSkOWQDFseF2x5VNoKSU7/6CTXuRNBmCXLj4Xg15Oc8kbuxN54AmQ+KkNtA4UYaehPMtJtg
        8BxIO5CL3JjDQeBMze430NgP3iQ/6uuz7Ii+h1LrJ0kSFdSkt/VblXganMiw9lspPB4SijIo
        KVw6C2fy9BIOhu7aBrmEh8MH+02FhMdA3fFk2p0HsBnBx16rp8hHcLW+yrPmXLhnfyx3h6Cw
        P+SXeQ62EE52dNPuNuCh4PikkjIMhWO3zJTU5uCgUS2pJ0LBpQJmYKyp9LInJg+Jx5NkR5Gv
        5b/NLP9tY/k39zyicpGPECdG6wQxUC9snypqo8U4vW5qeEx0Ier7h3W/7V9L0LcnGysRZpFm
        CAcrnaFquXabuDO6EgFLabw5DdMSquYitDt3CYaYDYa4KEGsRKNZWuPD7R7UR2GddquwWRBi
        BcMAK2OVo+LREshxqsfsqeh44P9s9uCH4ancdNDdV3TFLVq85Lsxd1VSe6t1fbtLNegaygyu
        VrZ2UsvafySFWJfPuh65dI1x/nMU1UKxG+76nmiOfNn8s8u1eKQmecfe1HUmfMk8lvjFbj9c
        wx6KPc9V2F44gyNmWBPD0nquZIWEz7MNW7XSFKKhxU3awMmUQdT+BXTwAfCDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7q5hQ+iDbZMVbFobljMZPHs83FG
        i7W9R1ks5l+5xmpxoPEyo8X/R69ZLU5tb2KyaJm1iMViyZOH7BaXd81hs/jce4TRYs672+wW
        Tx72sVm82CJusWnFDTaLn7vmsVjsvfeZ0UHQo+n9MTaPWffPsnnsnHWX3WPrLVOPxXteMnls
        WtXJ5nHn2h42j97md2we26/NY/Y4Mf07i8fxG9uZPD5vkgvgidKzKcovLUlVyMgvLrFVija0
        MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOL1cv2CRfcW/tna2BsaV+l2MnBwS
        AiYSNxbuZuti5OIQEljKKHH09j0ghwMoISNxfH0ZRI2wxJ9rXVA1bxkltmw+yQSSEBaIkJg1
        8zcriC0ioCyx6NxWRoiig4wSjStfMIE4zAJXWSSarv1hBqliE7CSmNi+ihHE5hWwk7jfvxys
        m0VAReJxzwWwuCjQ1FsPO1ggagQlTs58AmZzChhITJm9FKyGWUBd4s+8S8wQtrxE89bZzBMY
        BWchaZmFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN927GfW3Ywdr0LPsQo
        wMGoxMPLUfAgWog1say4MvcQowQHs5IIrxIbUIg3JbGyKrUoP76oNCe1+BCjKdATE5mlRJPz
        gWkoryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo8jMFWoP2c7m
        h80SiGzdobhiY2jA38N7Io0tNBlmPvfl/eylLHRYJ3kGH5Mw50ROV/6z/44GnxcPKXxT9oGj
        5Ve0sMBR5vqFJdMmXj0UXtTMW3hlg7SIyvFLqp5n1kzdIissq/L0YNd0devcJIObkv6cQlVa
        1S65k0UnM889WR/9rHMzU22fEktxRqKhFnNRcSIATOA/nwsDAAA=
X-CMS-MailID: 20181105163557eucas1p160168ea4ccd52bd8cea53fb843ff06e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6
References: <CGME20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6@epcas2p4.samsung.com>
        <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <1541387097.2124.9.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/05/2018 04:04 AM, Zhang Rui wrote:
> Hi, Bartlomiej,

Hi Rui,

> Interesting, I'm about to bring this issue to Linux Plumber Conference
> this year for discussion, and I'm also proposing a solution to fix the
> issues, but only with thermal core part finished yet.
> can you please take a look at it?
> https://patchwork.kernel.org/project/linux-pm/list/?series=38181

Thank you for the patches but they seem to be far from being
a complete solution for issues fixed by my patchset. Even
thermal core part is not finished yet as it doesn't provide
a way to register disabled sensors for DT thermal drivers (only
for platform ones)..

Why not simply apply my patchset now and incrementally work
on top of it to implement fixes for issues your patchset is
addressing?

My patchset may not be a perfect solution but IMO it is good
enough and it has been practically ready since v1 posted in
April (v2 fixes all issues requested by Eduardo's review from
September)..

> thanks,
> rui
> 
> On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> [devm]_thermal_zone_of_sensor_register() is used to register
>> thermal sensor by thermal drivers using DeviceTree. Besides
>> registering sensor this function also immediately:
>>
>> - enables it:
>>
>>   tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
>>   (->set_mode is set to of_thermal_set_mode() in of-thermal.c)
>>
>> - checks it (indirectly by using of_thermal_set_mode()):
>>
>>   thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>   (which in turn ends up using ->get_temp method).
>>
>> For many DT thermal drivers this causes a problem because:
>>
>> - [devm]_thermal_zone_of_sensor_register() need to be called in
>>   order to obtain data about thermal trips which are then used to
>>   finish hardware sensor setup (only after which ->get_temp can
>>   be used)
>>
>> There is also related issue for DT thermal drivers that support
>> IRQ (i.e. exynos and rockchip ones):
>>
>> - sensor hardware should be enabled only after IRQ handler is
>>   requested (because otherwise we might get IRQs that we can't
>>   handle)
>>
>> - IRQ handler needs tzd structure which is obtained from
>>   [devm_]thermal_zone_of_sensor_register()
>>
>> - after [devm_]thermal_zone_of_sensor_register() call core
>>   thermal code assumes that sensor is enabled and ready to use
>>   (i.e. that IRQ handler has been requested and sensor hardware
>>   has been enabled)
>>
>> In order to fix all abovementioned issues sensor registration,
>> enable and check operations are separated in the core DT thermal
>> code and corresponding DT thermal drivers are modified to do sensor
>> setup correctly.
>>
>> Changes since v1:
>> - rebased on the current -next kernel (next-20181015)
>> - enhanced patch descriptions and cover letter
>> - renamed thermal_zone_device_toggler() to thermal_zone_set_mode()
>> - converted thermal_zone_set_mode() to use enum thermal_device_mode
>> - added CONFIG_THERMAL=n stubs for thermal_zone_set_mode() and
>>   thermal_zone_device_check()
>> - fixed uses of [devm]_thermal_zone_of_sensor_register() outside of
>>   drivers/thermal/
>> - changed ordering between patch #2 and #3 in order to add all
>>   needed core helpers first before fixing sensor setup code
>> - changed ordering between patch #3 and #4 in order to simplify them
>> - renamed patch #3 to "thermal: separate sensor enable and check
>>   operations"
>> - renamed patch #4 to "thermal: separate sensor registration and
>>   enable+check operations"
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>> Bartlomiej Zolnierkiewicz (17):
>>   thermal: add thermal_zone_set_mode() helper
>>   thermal: add thermal_zone_device_check() helper
>>   thermal: separate sensor enable and check operations
>>   thermal: separate sensor registration and enable+check operations
>>   thermal: bcm2835: enable+check sensor after its setup is finished
>>   thermal: brcmstb: enable+check sensor after its setup is finished
>>   thermal: hisi_thermal: enable+check sensor after its setup is
>> finished
>>   thermal: qcom: tsens: enable+check sensor after its setup is
>> finished
>>   thermal: qoriq: enable+check sensor after its setup is finished
>>   thermal: rcar_gen3_thermal: enable+check sensor after its setup is
>>     finished
>>   thermal: rockchip_thermal: enable+check sensor after its setup is
>>     finished
>>   thermal: exynos: enable+check sensor after its setup is finished
>>   thermal: tegra: enable+check sensor after its setup is finished
>>   thermal: ti-soc-thermal: enable+check sensor after its setup is
>>     finished
>>   thermal: uniphier: enable+check sensor after its setup is finished
>>   thermal: zx2967: enable+check sensor after its setup is finished
>>   thermal: warn on attempts to read temperature on disabled sensors
>>
>>  drivers/acpi/thermal.c                             |  5 +--
>>  drivers/ata/ahci_imx.c                             | 10 ++++--
>>  drivers/hwmon/hwmon.c                              |  5 +++
>>  drivers/hwmon/ntc_thermistor.c                     |  4 +++
>>  drivers/hwmon/scpi-hwmon.c                         |  4 +++
>>  drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +++
>>  drivers/input/touchscreen/sun4i-ts.c               |  8 ++++-
>>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>>  drivers/regulator/max8973-regulator.c              |  6 ++--
>>  drivers/thermal/armada_thermal.c                   |  3 ++
>>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>>  drivers/thermal/da9062-thermal.c                   |  7 ++--
>>  drivers/thermal/db8500_thermal.c                   |  5 ++-
>>  drivers/thermal/hisi_thermal.c                     | 22 ++++------
>> ---
>>  drivers/thermal/imx_thermal.c                      |  3 +-
>>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>>  drivers/thermal/mtk_thermal.c                      |  3 ++
>>  drivers/thermal/of-thermal.c                       |  6 ++--
>>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 ++-
>>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>>  drivers/thermal/rcar_gen3_thermal.c                |  7 ++--
>>  drivers/thermal/rcar_thermal.c                     |  7 ++--
>>  drivers/thermal/rockchip_thermal.c                 | 38 +++++++++++-
>> ----------
>>  drivers/thermal/samsung/exynos_tmu.c               |  7 +++-
>>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>>  drivers/thermal/tango_thermal.c                    |  5 +++
>>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>>  drivers/thermal/thermal_core.c                     | 14 ++++----
>>  drivers/thermal/thermal_helpers.c                  | 32
>> ++++++++++++++++++
>>  drivers/thermal/thermal_sysfs.c                    | 17 ++++++----
>>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 +++-
>>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>>  include/linux/thermal.h                            | 11 +++++++
>>  44 files changed, 220 insertions(+), 87 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
