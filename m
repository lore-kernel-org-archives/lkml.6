Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964890AbeE3Euk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:50:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37090 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeE3Eui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:50:38 -0400
X-Google-Smtp-Source: ADUXVKKzu/3gIX9E80Ovga6dnYRSwL7HawVKDVmCLMW5wu/EdRpJC6Em+9jpZcpIOcyxb2TeNCNleA==
Date: Wed, 30 May 2018 10:20:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] cpufreq: Use static SRCU initializer
Message-ID: <20180530045034.xlxnjq42gkm6dbrs@vireshk-i7>
References: <20180525101958.13277-1-bigeasy@linutronix.de>
 <20180525101958.13277-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525101958.13277-3-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 12:19, Sebastian Andrzej Siewior wrote:
> Use the static SRCU initializer for `cpufreq_transition_notifier_list'.
> This avoids the init_cpufreq_transition_notifier_list() initcall. Its
> only purpose is to initialize the SRCU notifier once during boot and set
> another variable which is used as an indicator whether the init was
> perfromed before cpufreq_register_notifier() was used.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 075d18f6ba7a..3f7b502cfb1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -89,16 +89,7 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy);
>   * The mutex locks both lists.
>   */
>  static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
> -static struct srcu_notifier_head cpufreq_transition_notifier_list;
> -
> -static bool init_cpufreq_transition_notifier_list_called;
> -static int __init init_cpufreq_transition_notifier_list(void)
> -{
> -	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
> -	init_cpufreq_transition_notifier_list_called = true;
> -	return 0;
> -}
> -pure_initcall(init_cpufreq_transition_notifier_list);
> +SRCU_NOTIFIER_HEAD_STATIC(cpufreq_transition_notifier_list);
>  
>  static int off __read_mostly;
>  static int cpufreq_disabled(void)
> @@ -1764,8 +1755,6 @@ int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
>  	if (cpufreq_disabled())
>  		return -EINVAL;
>  
> -	WARN_ON(!init_cpufreq_transition_notifier_list_called);
> -
>  	switch (list) {
>  	case CPUFREQ_TRANSITION_NOTIFIER:
>  		mutex_lock(&cpufreq_fast_switch_lock);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
