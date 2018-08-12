Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A61C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C6F21A1C
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C6F21A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeHLOAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 10:00:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55036 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeHLOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 10:00:50 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id afd8efab8463d50d; Sun, 12 Aug 2018 13:23:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Ignore turbo active ratio in HWP
Date:   Sun, 12 Aug 2018 13:20:58 +0200
Message-ID: <7876484.jIFljIylbc@aspire.rjw.lan>
In-Reply-To: <20180802002606.42766-1-srinivas.pandruvada@linux.intel.com>
References: <20180802002606.42766-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 2, 2018 2:26:06 AM CEST Srinivas Pandruvada wrote:
> When HWP is active turbo active ratio is not used, so we should allow
> policy max frequency above turbo activation ratio to be set. When HWP is
> not active, then any policy max frequency above turbo activation ratio
> can result upto max one-core turbo frequency.
> 
> This fix helps better thermal control in turbo region when other methods
> like "Running Average Power Limit" is not available to use.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index efb015a5f7ac..32c10e69241e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2020,7 +2020,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>  					 struct cpudata *cpu)
>  {
> -	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
> +	if (!hwp_active &&
> +	    cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
>  	    policy->max < policy->cpuinfo.max_freq &&
>  	    policy->max > cpu->pstate.max_freq) {
>  		pr_debug("policy->max > max non turbo frequency\n");
> 

Applied, thanks!


