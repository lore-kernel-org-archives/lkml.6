Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A2ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0859214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0859214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeITNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:44:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56477 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:44:26 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 80d26960707c0b3e; Thu, 20 Sep 2018 10:02:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/12] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date:   Thu, 20 Sep 2018 09:59:25 +0200
Message-ID: <1645527.R4f0u0jryK@aspire.rjw.lan>
In-Reply-To: <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org> <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 12:20:27 AM CEST Viresh Kumar wrote:
> dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> and will not remove dynamic OPPs automatically. They must be removed
> with a call to dev_pm_opp_remove().
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
> index 31513bd42705..6d33a639f902 100644
> --- a/drivers/cpufreq/mvebu-cpufreq.c
> +++ b/drivers/cpufreq/mvebu-cpufreq.c
> @@ -84,9 +84,10 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
>  		if (ret) {
> +			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
>  			clk_put(clk);
>  			dev_err(cpu_dev, "Failed to register OPPs\n");
> -			goto opp_register_failed;
> +			return ret;
>  		}
>  
>  		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
> @@ -99,11 +100,5 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  
>  	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  	return 0;
> -
> -opp_register_failed:
> -	/* As registering has failed remove all the opp for all cpus */
> -	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
> -
> -	return ret;
>  }
>  device_initcall(armada_xp_pmsu_cpufreq_init);
> 

Please feel free to take this one via OPP.


