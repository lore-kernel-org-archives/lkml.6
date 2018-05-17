Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeEQHAc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:00:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40153 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:00:30 -0400
X-Google-Smtp-Source: AB8JxZor5phaO0gIqQGhPXj0V2RWADfG3gYTAwK5i2LbPet9a2Yhq3Snrh0HshhIuXS6Hw6EY6ai/A==
Date: Thu, 17 May 2018 09:00:26 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180517070026.GA22493@localhost.localdomain>
References: <20180516224518.109891-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516224518.109891-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 16/05/18 15:45, Joel Fernandes (Google) wrote:

[...]

> @@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  static void sugov_work(struct kthread_work *work)
>  {
>  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> +	unsigned int freq;
> +	unsigned long flags;
> +
> +	/*
> +	 * Hold sg_policy->update_lock shortly to handle the case where:
> +	 * incase sg_policy->next_freq is read here, and then updated by
> +	 * sugov_update_shared just before work_in_progress is set to false
> +	 * here, we may miss queueing the new update.
> +	 */
> +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> +	freq = sg_policy->next_freq;
> +	sg_policy->work_in_progress = false;
> +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);

OK, we queue the new request up, but still we need to let this kthread
activation complete and then wake it up again to service the request
already queued, right? Wasn't what Claudio proposed (service back to
back requests all in the same kthread activation) better from an
overhead pow?

Also, I assume that there's no problem kicking the irq_work thing while
the kthread that it's going to be woken up it's already running?

>  
>  	mutex_lock(&sg_policy->work_lock);
> -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> +	__cpufreq_driver_target(sg_policy->policy, freq,
>  				CPUFREQ_RELATION_L);
>  	mutex_unlock(&sg_policy->work_lock);
> -
> -	sg_policy->work_in_progress = false;
>  }

Best,

- Juri
