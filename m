Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2503EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB620835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBB620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJLV5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51950 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbeJLV5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99747ED1;
        Fri, 12 Oct 2018 07:25:09 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E143F5BC;
        Fri, 12 Oct 2018 07:25:06 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:25:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181012142503.GF3401@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
> Use cpu hotplug callback mechanism to attach/dettach the cpu in
> the cpu power domain. During cpu hotplug callback registration,
> the starting callback is invoked on all online cpus. So there is
> no need to attach from device probe.
> 
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  drivers/soc/qcom/cpu_pd.c  | 33 +++++++++++++++++++++++++--------
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
> index 242eced..bf2d95d 100644
> --- a/drivers/soc/qcom/cpu_pd.c
> +++ b/drivers/soc/qcom/cpu_pd.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/cpuhotplug.h>
>  #include <linux/ktime.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_domain.h>
> @@ -85,12 +86,26 @@ static int cpu_pd_power_off(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int cpu_pd_starting(unsigned int cpu)
> +{
> +	if (!suspend && of_genpd_attach_cpu(cpu))
> +		pr_err("%s: genpd_attach_cpu fail\n", __func__);

If it's that serious, return proper error code and drop the message which
could be annoying if you are running some hotplug test loop.

--
Regards,
Sudeep
