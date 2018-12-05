Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD259C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B14920878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B14920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbeLEPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:08:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:18831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeLEPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:08:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 07:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="96339107"
Received: from jinbaowa-mobl1.ccr.corp.intel.com ([10.249.170.100])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2018 07:08:13 -0800
Message-ID: <1544022486.2841.42.camel@intel.com>
Subject: Re: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
From:   Zhang Rui <rui.zhang@intel.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org
Date:   Wed, 05 Dec 2018 23:08:06 +0800
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
         <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new flag and mechanism in thermal trip points
> in
> DT.  The old implementation in thermal zone in DT sets the same
> configuration for all internal trip points. It does not work for all
> HW.  There are SoCs which support IRQs for some trip points (i.e.
> Exynos 4 has 4 trip points with IRQs). For additional one defined
> inside the thermal zone there is a need of 'polling'. When developer
> adds polling mode settings inside the thermal zone, all the trip
> points will be registered for polling, even those supporting IRQs,
> which does not make sense.

we have two timers, one for polling, and one for passive cooling.
I think we are talking about passive cooling timer only, right?
And the real problem is that we have multiple passive trip points and
only part of them support irq_mode, and we don't want to start the
passive polling timer for all of the passive trip points.

thanks,
rui

>  Thus, developers create workarounds, which
> are confusing for some other developers.  To workaround, 
> people declare some trip points as 'active' (those with IRQ support).
> It allows to bypass polling mode in thermal framework applied for 
> all thermal zone's trip points.
> 
> Thermal framework defines 4 types of trip points. The 'passive' means
> passive cooling using DVFS, 'active' is designed for fan and other
> devices actively changing the outside conditions. Therefore, a
> workaround
> mentioned earlier is confusing when someone does not know about the
> framework limitations.
> 
> This patch set tries to solve the issue by adding one flag inside the
> trip point: 'irq-mode;'.  The trip point 'passive' declared in DT
> with
> explicit flag 'irq-mode;' will not register itself as polling mode.
> Thermal framework will skip it during scheduling next read out work.
> The old global-polling-mode-configuration-inside-thermal-zone is
> still
> valid.  Patch set does not break existing design for trip points
> which
> do not have 'irq-mode' flag - they will use polling.
> 
> As an example please check patch #10 for Exynos4 SoC family, where
> there
> is 4 HW supported trip points and there is a need of 6. The rest 2
> are
> declared as 'passive' without 'irq-mode;' flag, which means polling
> mode needed for them.
> 
> Patch #1 is a small cleanup in thermal framework.
> 
> Change log:
> v2
> - changed description in cover letter
> - change commit messages according to Krzysztof comments
> - rebase on top of current mainline (v4.20-rc1)
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (11):
>   thermal: remove unused function parameter
>   thermal: add irq-mode configuration for trip point
>   thermal: add new sysfs file for irq-mode
>   Doc: thermal: new irq-mode for trip point
>   Doc: DT: thermal: new irq-mode for trip point
>   arm64: dts: exynos5433: add support for thermal trip irq-mode
>   arm64: dts: exynos7: add support for thermal trip irq-mode
>   arm: dts: exynos4: add support for thermal trip irq-mode
>   arm: dts: exynos5420: add support for thermal trip irq-mode
>   arm: dts: exynos5422: add support for thermal trip irq-mode
>   arm: dts: exynos5410: add support for thermal trip irq-mode
> 
>  .../devicetree/bindings/thermal/thermal.txt        |   7 ++
>  Documentation/thermal/sysfs-api.txt                |   9 ++
>  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105
> ++++++++++++++-------
>  .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
>  drivers/thermal/of-thermal.c                       |  17 ++++
>  drivers/thermal/thermal_core.c                     |  16 ++--
>  drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
>  include/linux/thermal.h                            |   5 +
>  12 files changed, 226 insertions(+), 64 deletions(-)
> 
