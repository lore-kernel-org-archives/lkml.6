Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31761ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95A920877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95A920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeISU6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:58:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54426 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbeISU6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:58:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 932BC206EE; Wed, 19 Sep 2018 17:20:25 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64333206EE;
        Wed, 19 Sep 2018 17:20:15 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     niklas.cassel@linaro.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
References: <cover.1536736872.git.viresh.kumar@linaro.org>
        <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
Date:   Wed, 19 Sep 2018 17:20:16 +0200
In-Reply-To: <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Wed, 12 Sep 2018 13:58:46 +0530")
Message-ID: <87o9ctjyz3.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,
 
 On mer., sept. 12 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> and will not remove dynamic OPPs automatically. They must be removed
> with a call to dev_pm_opp_remove().

So now that mean when adding more than 2 OPPs, we should have the list
of them available in the driver to be able to remove them, right?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory

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
> -- 
> 2.18.0.rc1.242.g61856ae69a2c
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
