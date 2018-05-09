Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934115AbeEIJqZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:46:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34073 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbeEIJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:46:23 -0400
X-Google-Smtp-Source: AB8JxZpSg9Aj4jqh0Sypl7PNdZvAgJJ9hYGIbkCD4b+J+tCWjA22QpSwD4FTNduPjLgEVYGbavYs5w==
Date: Wed, 9 May 2018 15:16:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, claudio@evidence.eu.com,
        patrick.bellasi@arm.com, juri.lelli@redhat.com, joelaf@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Avoid using invalid next_freq
Message-ID: <20180509094620.zblddmbxe6vxsc5h@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <2276196.ev9rMjHTR0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2276196.ev9rMjHTR0@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-18, 11:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the next_freq field of struct sugov_policy is set to UINT_MAX,
> it shouldn't be used for updating the CPU frequency (this is a
> special "invalid" value), but after commit b7eaf1aab9f8 (cpufreq:
> schedutil: Avoid reducing frequency of busy CPUs prematurely) it
> may be passed as the new frequency to sugov_update_commit() in
> sugov_update_single().
> 
> Fix that by adding an extra check for the special UINT_MAX value
> of next_freq to sugov_update_single().
> 
> Fixes: b7eaf1aab9f8 (cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely)
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -305,7 +305,8 @@ static void sugov_update_single(struct u
>  	 * Do not reduce the frequency if the CPU has not been idle
>  	 * recently, as the reduction is likely to be premature then.
>  	 */
> -	if (busy && next_f < sg_policy->next_freq) {
> +	if (busy && next_f < sg_policy->next_freq &&
> +	    sg_policy->next_freq != UINT_MAX) {
>  		next_f = sg_policy->next_freq;
>  
>  		/* Reset cached freq as next_freq has changed */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
