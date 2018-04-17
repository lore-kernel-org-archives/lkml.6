Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx4+Po9Zgrt0OqfsZ4qTbvY5upX3fezb/IC3FUH38eQC6ZJ1osdMjAi6kyI9mRvrLvab5HNo8
ARC-Seal: i=1; a=rsa-sha256; t=1523986769; cv=none;
        d=google.com; s=arc-20160816;
        b=xUWsTQIHYh85Q39USC0G/lNzygXFbepW+WfGhtYcWYom8I0oo81pSBGbayDmXatjcC
         DZByGat05Qsb63y+7FRiU9TnBxIGogyMtgU+mWure2ikQb1PH+RVakU5ZtG5EyD8LQrU
         2j1ODFphEfEJZlzz9rijhKy3YFHPKfZUd2650J1CAq9hCYE0/Y+S+Tgtnp53sxDwqAAB
         /Tvl7xipFcEr9Y1h2n6y7ooNcy8CG9F4YKE5NGmeMvu1wL0C3YfMjYMWXPbGoyK9kX8R
         XRdMsRGBSSkS7qygCQoN86toPpTR37yC0M3/X1hlkI8uXzZdWBhbHqoLOz2bexWchezo
         Rc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=P2EQyuzIXnqTssSruv7trWZIZ4RZrFC7NsLcj9oQzv0=;
        b=UCayIbH9i7XP11OlM2sH4BD+RzYkzNyT0mYqmARo87npeZwnl/cTCr11WO/Jo+FNPt
         avIx3V/SwNMSaHTktuXCofIFXY9UrgwBGR3sRj5O0FALCwIfU5Nx9qbZWZ5npQrywiSe
         QT5gf34ljUJqNR4aocsFBE5ctN7u7dc74OmezDV7kLkXBf53S0IAKM1mCxsjSAQw9MUL
         6f2oZyf4U4q8rSOuhnb29vEWHGwmcdd0l87Pn96JJwdGNLRCjM5agyBUa/40duIFYuch
         DLZybAUSi8BH6boj3CF1cpxebaMQIko78vkAFaWR7RMnxMPqFcaYMVXRh7ORaWcZT8Em
         M33w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Quentin Perret <quentin.perret@arm.com>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>,
 Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <20180417142440.GB18509@leoy-ThinkPad-X240s>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
Date: Tue, 17 Apr 2018 19:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417142440.GB18509@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1598015950495567560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 04:25 PM, Leo Yan wrote:

>> @@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   		update_cfs_group(se);
>>   	}
>>   
>> -	if (!se)
>> +	if (!se) {
>>   		add_nr_running(rq, 1);
>> +		update_overutilized_status(rq);
>> +	}
> 
> Maybe this isn't a good question, why only update overutilized flag
> for enqueue flow but not for dequeue flow?

[...]

>> @@ -9955,6 +10009,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>   
>>   	if (static_branch_unlikely(&sched_numa_balancing))
>>   		task_tick_numa(rq, curr);
>> +
>> +	update_overutilized_status(rq);
> 
> Can sched tick clear overutilized flag if under tipping point?

No, only the load balancer for this particular sched domain level is 
able to clear the flag. We want to use the existing iteration over all 
cpus of the sched domain span to reset the flag.
