Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29484ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2E320673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2E320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeGRIOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:14:07 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:53515 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeGRIOG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 18 Jul 2018 04:14:06 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 09:37:34 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 08:37:14 +0100
Date:   Tue, 17 Jul 2018 22:13:23 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Message-ID: <20180717201323.6rwb4yklq46cmtom@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5423012.ZZnfdYddaT@aspire.rjw.lan>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The firmware interface used by the pcc-cpufreq driver is
> fundamentally not scalable and using it for dynamic CPU performance
> scaling on systems with many CPUs leads to degraded performance.
> 
> For this reason, disable dynamic CPU performance scaling on systems
> with pcc-cpufreq where the number of CPUs present at the driver init
> time is greater than 4.  Also make the driver print corresponding
> complaints to the kernel log.
> 
> Reported-by: Andreas Herrmann <aherrmann@suse.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Rework the messages printed in the problematic case.

I've tested this patch. Effect is as expected: driver loads but use of
ondemand governor is not allowed. Sample output:

[   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
[   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
[   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings
[   40.972327] pcc_cpufreq_init: and complain to the system vendor
[   41.025620] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
...
[   41.187928] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor

Last message is shown for each online CPU in the system  (ie. 120x).

Looks good to me.


Andreas

> ---
>  drivers/cpufreq/pcc-cpufreq.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
> +++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
> @@ -589,6 +589,15 @@ static int __init pcc_cpufreq_init(void)
>  		return ret;
>  	}
>  
> +	if (num_present_cpus() > 4) {
> +		pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
> +		pr_err("%s: Too many CPUs, dynamic performance scaling disabled\n",
> +		       __func__);
> +		pr_err("%s: Try to enable a different scaling driver through BIOS settings\n",
> +		       __func__);
> +		pr_err("%s: and complain to the system vendor\n", __func__);
> +	}
> +
>  	ret = cpufreq_register_driver(&pcc_cpufreq_driver);
>  
>  	return ret;
> 
> 
