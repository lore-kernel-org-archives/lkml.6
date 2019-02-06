Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B18C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22BA206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfBFKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:33:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45676 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBFKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:33:23 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 70cda8ed52eeddda; Wed, 6 Feb 2019 11:33:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] cpufreq: Add flag to auto-register as cooling device
Date:   Wed, 06 Feb 2019 11:32:09 +0100
Message-ID: <2181391.oHn0C2QMFc@aspire.rjw.lan>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 29, 2019 5:55:06 AM CET Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Changes since v4:
>  - Added IS_ENABLED guards in cpufreq.c
>  - Changed flag name to CPUFREQ_IS_COOLING_DEV
>  - Collected various review tags
> 
> Changes since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c
> 
> Changes since v2:
>  - Get rid of #ifdef'ery and let the pointer exist in all cases
>  - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
>    Kconfig
> 
> Changes since v1:
> - Fix compilation failures with allmodconfig
> - Get rid of #ifdef in cpufreq.c
> - Removed miscellaneous patches and sent them separately
> - Merged patches 1 and 2 from v1
> 
> Amit Kucheria (9):
>   thermal: cpu_cooling: Require thermal core to be compiled in
>   cpufreq: Auto-register the driver as a thermal cooling device if asked
>   cpufreq: qcom-hw: Register as a cpufreq cooling device
>   cpufreq: imx6q: Use auto-registration of thermal cooling device
>   cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
>   cpufreq: mediatek: Use auto-registration of thermal cooling device
>   cpufreq: qoriq: Use auto-registration of thermal cooling device
>   cpufreq: scmi: Use auto-registration of thermal cooling device
>   cpufreq: scpi: Use auto-registration of thermal cooling device
> 
>  drivers/cpufreq/Kconfig            |  3 ---
>  drivers/cpufreq/Kconfig.arm        |  5 -----
>  drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
>  drivers/cpufreq/cpufreq.c          | 13 +++++++++++++
>  drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
>  drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
>  drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
>  drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
>  drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
>  drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
>  drivers/thermal/Kconfig            |  1 +
>  include/linux/cpufreq.h            |  9 +++++++++
>  12 files changed, 37 insertions(+), 92 deletions(-)
> 
> 

I've applied the series, thanks!


