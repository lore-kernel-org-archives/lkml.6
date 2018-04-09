Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx499V6xp4MAoJEbg4pig/krtMLXp3Cyn+F0uqCU2zHSKJQTure8T8thpBwa8+KowbkJFWO3d
ARC-Seal: i=1; a=rsa-sha256; t=1523267585; cv=none;
        d=google.com; s=arc-20160816;
        b=cjKWwX9Xliisygux4PdeCsodJIP2Utct78mKw5ngPlAw4GANFm46U2M3LDiF595L22
         BbIMbkA6M3NzWUMUUNWMfxWfFFyLKMp7tuWBVONslIrnl2h/EMbchmFc/PhFJoJWU1QE
         c0vMQTm5O0l6byn6gD7skV7jKX3CwyKQM0ZYGiEyq6aM31tN6PPtuRLVc1BzetSDLgjV
         jh8mrOJWtFGf0MzZ/f1cVDzxuE2dVGS5y2Aa0wa7Jf7w/5E4hFFX2lA0H86GJ+jp+2El
         U7G8qT4LbGmWhgxtAuBNiov3VeDSTdWlT97BdbQ19QG3J1KgvfdzC6Uwr7e3VsF5zflT
         HfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4D+RgcpfZhKSmvhObqOJE3FBxhHjFtqoiffkI7QWk2k=;
        b=1BZnZxvoRugBkXm7M9Xhcb6sNm/sf2JSMFQljB/Behu5Eb26RNvtyeerUWKOc1yP7w
         sfY8TM/vA+9Lgk4/wPvYW3Q0T1d4pY1WFQkjdk5HdtHquYQZzPKPamvHEwRjvYB5gg7V
         nKcmwGxq1vc3mQi7v6UMavSbJMhJFRdfJYvzgaRt4bPXd0wUYHxvoy9iAFGw+7Tf2YQq
         7y9Mc2BM+hEV9AnciMKSTVdk/x6mq7DI5DNt5hv5QkMWDkHzw9J+MVm4zGBvK3hrE6Mt
         5GZBEPUK7gRzPfrlX/FoNpgxpRY9yTuIDRDw/BGdU/+EoZ+heGlMQyelBwcJEF6Q8xm+
         tNJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
 <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
Date: Mon, 9 Apr 2018 11:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449336588138126?=
X-GMAIL-MSGID: =?utf-8?q?1597261832190079903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 11:40 AM, Peter Zijlstra wrote:
> 
> (I know there is a new version out; but I was reading through this to
> catch up with the discussion)
> 
> On Tue, Mar 20, 2018 at 09:43:09AM +0000, Dietmar Eggemann wrote:
>> +static inline int sd_overutilized(struct sched_domain *sd)
>> +{
>> +	return READ_ONCE(sd->shared->overutilized);
>> +}
>> +
>> +static inline void update_overutilized_status(struct rq *rq)
>> +{
>> +	struct sched_domain *sd;
>> +
>> +	rcu_read_lock();
>> +	sd = rcu_dereference(rq->sd);
>> +	if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
>> +		WRITE_ONCE(sd->shared->overutilized, 1);
>> +	rcu_read_unlock();
>> +}
>> +#else
> 
> I think you ought to go have a look at the end of
> kernel/sched/topology.c:sd_init(), where it says:
> 
> 	/*
> 	 * For all levels sharing cache; connect a sched_domain_shared
> 	 * instance.
> 	 */
> 	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> 		atomic_inc(&sd->shared->ref);
> 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> 	}
> 
> Because if I read all this correctly, your code assumes sd->shared
> exists unconditionally, while the quoted bit only ensures it does so <=
> LLC.
> 

But the patch changes this part further down.

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564f5255..c8b7c7665ab2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1184,15 +1184,11 @@ sd_init(struct sched_domain_topology_level *tl,
  		sd->idle_idx = 1;
  	}

-	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
-	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+
+	if (sd->flags & SD_SHARE_PKG_RESOURCES)
  		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
