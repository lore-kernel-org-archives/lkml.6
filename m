Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23609C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8992086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIhG7H/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeK2E45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbeK2E45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so19268870wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8xMCk4+ab81E1Ehso04+OwMObLxe7I7gMMe8OyYUruk=;
        b=EIhG7H/b8SRtALhIPoAB2wtED+h9CBzgyIpEbYHG/NWKBpDilhcZlfuAccOQ+oY/TI
         UIx7OUUlhSq4IL+Zf3S73jnxNEMNnrUtH9XLdj1s+Kr4nGRqx+ZajlD+aBAvX4hFMmfd
         pUTMvUFpohldMHOcHAo42G1xsxmv5XJSTXcbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xMCk4+ab81E1Ehso04+OwMObLxe7I7gMMe8OyYUruk=;
        b=StXDc13I3jrYsNBe9pNMhUggA5BdnIkXyaTA4gNeel1xvk8ugvQ8ZBr8/FcrkWJXuZ
         JHyD2BRQUb4QZccOF1SWEmmBshdbxsxLra+Fy4bcn548T0eU+9M1Ge1hiZKzQjRTgSMa
         e/0YMj2ZvI3LnKhqvEthSvvwkHuleYYJW8r3gK99F3FKVG5GH4SoyFIPQdCjNl6epHXQ
         kcVYA3PtyBjoy+kSQ2Fpe1nbesF441T7IOVoy/ZANF1ffFb3+F4LW4EtiVzl5+iYV9yu
         NkudX81oTKUC/9OfhBfFDgAZ+iaoKlOfZcXkll1hNzqDPMey9KvNgRVFjtp0lAZH7plP
         cDWg==
X-Gm-Message-State: AA+aEWaMw+8K0aDTNJisNF3Lpq2J4E12BEJS3yq++ZZ4B+kkg/Wu40as
        3gZVQkfeAB3Jug/BaRSkhuUegnnzu5s=
X-Google-Smtp-Source: AFSGD/WmJ9VZFZHvC+EAyEsr6eW/RBpmRkYc2ONQ2O5/+mrRuzBjlJLLLOLp+qX5Atzn0VpcHFoY8Q==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr31370002wrq.11.1543427668533;
        Wed, 28 Nov 2018 09:54:28 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 14sm4714565wmv.36.2018.11.28.09.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:54:27 -0800 (PST)
Subject: Re: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <20181128114454.GC4271@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <17ecb59a-7647-ce56-0715-bfe8d520dd18@linaro.org>
Date:   Wed, 28 Nov 2018 18:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128114454.GC4271@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 12:44, Juri Lelli wrote:
> Hi Daniel,
> 
> On 27/11/18 14:24, Daniel Lezcano wrote:
>> The mutex protects a per_cpu variable access. The potential race can
>> happen only when the cpufreq governor module is loaded and at the same
>> time the cpu capacity is changed in the sysfs.
>>
>> There is no real interest of using a mutex to protect a variable
>> assignation when there is no situation where a task can take the lock
>> and block.
>>
>> Replace the mutex by READ_ONCE / WRITE_ONCE.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/base/arch_topology.c  | 7 +------
>>  include/linux/arch_topology.h | 2 +-
>>  2 files changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index edfcf8d..fd5325b 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -31,12 +31,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>>  		per_cpu(freq_scale, i) = scale;
>>  }
>>  
>> -static DEFINE_MUTEX(cpu_scale_mutex);
>>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>>  
>>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>>  {
>> -	per_cpu(cpu_scale, cpu) = capacity;
>> +	WRITE_ONCE(per_cpu(cpu_scale, cpu), capacity);
>>  }
>>  
>>  static ssize_t cpu_capacity_show(struct device *dev,
>> @@ -71,10 +70,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
>>  	if (new_capacity > SCHED_CAPACITY_SCALE)
>>  		return -EINVAL;
>>  
>> -	mutex_lock(&cpu_scale_mutex);
>>  	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
>>  		topology_set_cpu_scale(i, new_capacity);
>> -	mutex_unlock(&cpu_scale_mutex);
> 
> IIRC this was meant to ensure atomic updates of all siblings with the new
> capacity value. I actually now wonder if readers should not grab the
> mutex as well (cpu_capacity_show()). Can't we get into a situation where
> a reader might see siblings with intermediate values (while the loop
> above is performing an update)?

With or without this patch, it is the case:

                task1                      task2
                  |                          |
  read("/sys/.../cpu1/cpu_capacity)          |
                  |                  write("/sys/.../cpu1/cpu_capacity")
  read("/sys/.../cpu2/cpu_capacity)          |


There is no guarantee userspace can have a consistent view of the
capacity. As soon as it reads a capacity, it can be changed in its back.


> BTW, please update my email address. :-)

Sure.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

