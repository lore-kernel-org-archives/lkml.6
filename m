Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A728206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAPW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:57:00 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48065 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfAPW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:56:59 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id fdacdc8b9883e575; Wed, 16 Jan 2019 23:56:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 01/10] cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date:   Wed, 16 Jan 2019 23:56:05 +0100
Message-ID: <1718046.8NPD0iV1Wv@aspire.rjw.lan>
In-Reply-To: <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 14, 2019 5:34:53 PM CET Amit Kucheria wrote:
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
> 
> We can then auto-register the cpufreq driver as a thermal cooling device
> from cpufreq core code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  include/linux/cpufreq.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..7d0cf54125fa 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -95,6 +95,11 @@ struct cpufreq_policy {
>  	struct cpufreq_frequency_table	*freq_table;
>  	enum cpufreq_table_sorting freq_table_sorted;
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cooldev;
> +#endif
> +

Why here and not at the end of the struct?

>  	struct list_head        policy_list;
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;
> 

Also, I would suggest combining this one with patch [02/10].

