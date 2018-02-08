Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBHOpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:45:21 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44046 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeBHOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:45:17 -0500
X-Google-Smtp-Source: AH8x226PWb6JejtWDujtYs7l4xoY6GUexS2IRrz8y8s4z45VTjOGWNrNJkHGIzJ7jTBk7pj5qpMJrw==
Date: Thu, 8 Feb 2018 20:15:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in
 dev_pm_opp_init_cpufreq_table
Message-ID: <20180208144513.GW28462@vireshk-i7>
References: <1516956529-32264-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516956529-32264-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-18, 16:48, Jia-Ju Bai wrote:
> After checking all possible call chains to 
> dev_pm_opp_init_cpufreq_table() here,
> my tool finds that this function is never called in atomic context, 
> namely never in an interrupt handler or holding a spinlock.
> And dev_pm_opp_init_cpufreq_table() calls dev_pm_opp_get_opp_count(), 
> which calls mutex_lock that can sleep.
> It indicates that atmtcp_v_send() can call functions which may sleep.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/opp/cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
> index 2d87bc1..0c09107 100644
> --- a/drivers/opp/cpu.c
> +++ b/drivers/opp/cpu.c
> @@ -55,7 +55,7 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>  	if (max_opps <= 0)
>  		return max_opps ? max_opps : -ENODATA;
>  
> -	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_ATOMIC);
> +	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
>  	if (!freq_table)
>  		return -ENOMEM;

Applied thanks.

-- 
viresh
