Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx49ECZLYuNFib3FHXxlDIwZPC5tdP8v6rZBLj4ct/1j+g7yx5O++/+abeuI4vZB/3pXQ8zLK
ARC-Seal: i=1; a=rsa-sha256; t=1523521212; cv=none;
        d=google.com; s=arc-20160816;
        b=bWduU5AE5SYzqOms1KGcIz3M56h4AIRhkQHLNPOr7Pp2JNHEVVG9EAmiGzxTZdSTOZ
         2CwNogg0u6zAXrbkUqWnmicMOSJRKyDbuWuOOoAPrHTXXrlqi//OxSpY/au23ZCOhu+O
         zEIT2qC9DSH2udSVOwz60GVPVqkRKNkl1JW6qmrG+D0olOJjF3PAVwAOYJyPHZUkP7Ci
         sBfXhACOuC1bZkqkl75i2vpQPPBsycYzRxp5sZXSt0B2Acliznlyp9Dxnd21PPlG54Nq
         Efx4MKxpNUKqVnXNbQNrLfNsMyZQ/yml53VyiJZjlW9549/mKyZuo/Qx+tPeYx1yY2EK
         KjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=E7+M0o8kmh96FKvxOW2vb0GAEDAJhTlb6QKU8J/+K9g=;
        b=U7Iq0vwjxZ3GCP0EGfF2/dHhPQ4J3AwCFvwTyq5oc/hkIhDrW+sfHJj352jodAivaq
         oQZ2na5UtTi+ZbQRyEczQh6VieitY0D6qUCJkV16U0qxsMTjzrWt+MJgeJUzGkfnDAxW
         qt70IgN1jQmdtDPcPdau6qIHwY2QbLSnFwlb4b1V8gNgjBcOuxx4is5tyra/dYnXNIS/
         ut5ePFULXqk1cl6Bf0TVBPFkOuz31+IeJvTEC7MX+cYJZA3TX7Z9QHa4X4FR2RPakh4c
         SArOTYWDpJFUvAR15pnCKOq+ShHhPIyxqQmuxku3+knvQLWoPHsFOQLNuqFZaNeRdDbx
         e1RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 1/6] sched/fair: Create util_fits_capacity()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Quentin Perret <quentin.perret@arm.com>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>,
 Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-2-dietmar.eggemann@arm.com>
 <20180412070230.GV7671@vireshk-i7>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0184b049-9333-2b6b-09a0-bdb71f491e25@arm.com>
Date: Thu, 12 Apr 2018 10:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412070230.GV7671@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011678153302942?=
X-GMAIL-MSGID: =?utf-8?q?1597527778601820136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 09:02 AM, Viresh Kumar wrote:
> On 06-04-18, 16:36, Dietmar Eggemann wrote:
>> The functionality that a given utilization fits into a given capacity
>> is factored out into a separate function.
>>
>> Currently it is only used in wake_cap() but will be re-used to figure
>> out if a cpu or a scheduler group is over-utilized.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c58d2f..0a76ad2ef022 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6574,6 +6574,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>>   	return min_t(unsigned long, util, capacity_orig_of(cpu));
>>   }
>>   
>> +static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
>> +{
>> +	return capacity * 1024 > util * capacity_margin;
> 
> This changes the behavior slightly compared to existing code. If that
> wasn't intentional, perhaps you should use >= here.

You're right here ... Already on our v3 list. Thanks!

The 'misfit' patch-set comes with a similar function 
task_fits_capacity() so we have to align on this one with this patch-set 
as well.

[...]
