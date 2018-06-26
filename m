Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FBEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31BB208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31BB208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeFZPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:24:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49296 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeFZPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:24:28 -0400
Received: from 79.184.255.183.ipv4.supernova.orange.pl (79.184.255.183) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id aeb47dd5528fa76a; Tue, 26 Jun 2018 17:24:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yisheng Xie <xieyisheng1@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 10/21] cpufreq: intel_pstate: use match_string() helper
Date:   Tue, 26 Jun 2018 17:23:10 +0200
Message-ID: <1633797.WhvbXNE1Nx@aspire.rjw.lan>
In-Reply-To: <1527765086-19873-11-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-11-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 31, 2018 1:11:15 PM CEST Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - add Reviewed-by tag.
> 
>  drivers/cpufreq/intel_pstate.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 17e566af..d701e26 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -645,21 +645,18 @@ static ssize_t store_energy_performance_preference(
>  {
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
>  	char str_preference[21];
> -	int ret, i = 0;
> +	int ret;
>  
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	while (energy_perf_strings[i] != NULL) {
> -		if (!strcmp(str_preference, energy_perf_strings[i])) {
> -			intel_pstate_set_energy_pref_index(cpu_data, i);
> -			return count;
> -		}
> -		++i;
> -	}
> +	ret = match_string(energy_perf_strings, -1, str_preference);
> +	if (ret < 0)
> +		return ret;
>  
> -	return -EINVAL;
> +	intel_pstate_set_energy_pref_index(cpu_data, ret);
> +	return count;
>  }
>  
>  static ssize_t show_energy_performance_preference(
> 

Srinivas, any concerns?

