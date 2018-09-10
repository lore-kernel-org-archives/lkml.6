Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5E32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFozTeRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5E32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeIJWcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:32:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46311 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:32:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so10803727pga.13;
        Mon, 10 Sep 2018 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wagdiQetN/Iu6/tFPaSkBGalyN/sKqtafqZlGQJhCak=;
        b=UFozTeRP19I2Y48nr7UVZa65B/ii8cl2fFVV0A0yYhxE/5T/Fc4RzygDYmVVkbTUkV
         Y2lOOA5SkNlZ8g+17LkFiqwUlwihaYjUGm1qYyVU5fJ4z+aUlIWiEuz0fZ0r0+ZXXmPF
         grqPfpD1i0LF6A/xfjxyLHXsFPxU5c2KdpE52KAygPQoCrTTSELHWTkXxsd1ac0iu9+Y
         nwegvt9qkmoE3I8tjsp7zMGvxrHM1PlY0WZhPyuG6cDZLCO99hW/6lkXQhNSl2L+25uT
         Lz8KiLaZmvRPUtYVHvCNc1RaNOwZ5BA6yDf1DNAZsC57PSRgffr8bG1Djerp8BMUCftd
         TAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wagdiQetN/Iu6/tFPaSkBGalyN/sKqtafqZlGQJhCak=;
        b=qDjOq3zS5AveYAbtO5QvuJBKnOtMiEHBD8ohrrqMpPO34gSiukfdtJ2oTVT8OoX7g3
         wGutjM8INy0WRyNO2W96OPBW6kaCAsRnfOSV1onWTp6lyY2wpRNHnefnNVZy74ZzmMWb
         +EHB4y1t2hkwwCwKz4nBOP+RFd2k63tdzTQEkx4Zr34ViJjx7GFJVqjjgS0CM+RYyc0L
         HAdfpKFlLYJBXhT4Dr2cXlG0B99EA0pz51kByR4w40P6V80gNDiwHdPs0L+L53uSRrEf
         8W/JXk9GKwFRbrgl1vN9O6+RFA/D+/kWtQ0BX2yc7nbdCuNayzGHFNqJqpH+H75ghgle
         aJAQ==
X-Gm-Message-State: APzg51C+GkJbpunviChtz4vnsVCij5CCoxoxesnePGP2vqaCcFLkERgw
        6PebwsRe383z8E1qukU4tQg=
X-Google-Smtp-Source: ANB0VdY+uiyGHh2x2mENNj4dqgHdYUl7pA9oWMltMGwgy1gPxq/borLBZrVfR8bMVAJAo4C5rzeH7g==
X-Received: by 2002:a63:66c7:: with SMTP id a190-v6mr24298443pgc.411.1536601028912;
        Mon, 10 Sep 2018 10:37:08 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id f184-v6sm36046747pfc.88.2018.09.10.10.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:37:08 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:37:01 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
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
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
Message-ID: <20180910173659.GB4196@localhost.localdomain>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
 <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:41:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> [devm]_thermal_zone_of_sensor_register() is used to register
> thermal sensor by thermal drivers using DeviceTree. Besides
> registering sensor this function also immediately enables it
> (using ->set_mode method) and then checks it with a update call
> to the thermal core (which ends up using ->get_temp method).

Yeah, pretty much the driver needs to be ready to answer to callbacks
once it calls thermal_*_register() method.

> For many DT thermal drivers this causes a problem because

Can you be more specific? Are you seeing this problem in samsung driver
or in other drivers too?

> [devm]_thermal_zone_of_sensor_register() need to be called in
> order to obtain data about thermal trips which are then used to
> finish hardware sensor setup (only after which ->get_temp can
> be used). The issue has been observed when using Samsung Exynos

Oh I see, this is because trip info is read by the of thermal thermal
then, correct?

> thermal driver and fixed internally in the driver in commit
> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
> only when TMU is turned on"). However after this commit there
> are now following warnings from the thermal core visible:
> 
> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
> 
> This patchset attempts to directly address the thermal core
> problem with [devm]_thermal_zone_of_sensor_register() and
> affected DT thermal drivers. In order to achieve this sensor
> registration, enable and check operations are separated and
> corresponding drivers are modified to use the new helpers to
> enable and check sensor explicitly.
> 

Ok. Up to this point I followed that this is a samsung driver issue, not
we need to change the core to fix adapt to it?

And adapting the core should be fine to fit a new use/fix something,
as long the issue is well described..

> Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
> warnings from the thermal core are now gone).
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (17):
>   thermal: add thermal_zone_device_toggle() helper
>   thermal: separate sensor registration and enable
>   thermal: add thermal_zone_device_check() helper
>   thermal: do sensor checking explicitly in drivers
>   thermal: bcm2835: enable/check sensor after its setup is finished
>   thermal: brcmstb: enable/check sensor after its setup is finished
>   thermal: hisi_thermal: enable/check sensor after its setup is finished
>   thermal: qcom: tsens: enable/check sensor after its setup is finished
>   thermal: qoriq: enable/check sensor after its setup is finished
>   thermal: rcar_gen3_thermal: enable/check sensor after its setup is
>     finished
>   thermal: rockchip_thermal: enable/check sensor after its setup is
>     finished
>   thermal: exynos: enable/check sensor after its setup is finished
>   thermal: tegra: enable/check sensor after its setup is finished
>   thermal: ti-soc-thermal: enable/check sensor after its setup is
>     finished
>   thermal: uniphier: enable/check sensor after its setup is
>     finished
>   thermal: zx2967: enable/check sensor after its setup is finished
>   thermal: warn on attempts to read temperature on disabled sensors
> 
>  drivers/acpi/thermal.c                             |  5 ++--
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>  drivers/regulator/max8973-regulator.c              |  3 +-
>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>  drivers/thermal/da9062-thermal.c                   |  7 ++---
>  drivers/thermal/db8500_thermal.c                   |  5 +++-
>  drivers/thermal/hisi_thermal.c                     | 22 ++++----------
>  drivers/thermal/imx_thermal.c                      |  3 +-
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>  drivers/thermal/mtk_thermal.c                      |  3 ++
>  drivers/thermal/of-thermal.c                       |  6 ++--
>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>  drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
>  drivers/thermal/rcar_thermal.c                     |  8 +++--
>  drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
>  drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>  drivers/thermal/tango_thermal.c                    |  5 ++++
>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>  drivers/thermal/thermal_core.c                     | 14 ++++-----
>  drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>  include/linux/thermal.h                            |  5 ++++
>  37 files changed, 173 insertions(+), 84 deletions(-)
> 
> -- 
> 1.9.1
