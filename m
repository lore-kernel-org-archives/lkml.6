Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C22EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44459213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzHQfGn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44459213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJDPEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:04:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41758 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeJDPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:04:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so8838409wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKbF7sLZ24PYFv/OaLEbM4W+RIB/jNs+v2KAvaUklf8=;
        b=HzHQfGn96CU2buT4oWH4iLvD4D7rIZGsYgysSM2n9Zwg+YHjmYW6iGb5AxNqxPd13h
         Q60tQHOarDEKag6qp7HZt/ew1TRFsvCt6Ma/rExKXMbK9oikXsiRR1VWkWe4SOMvRwNQ
         6Hf9HFOOjCHPXep3/7DDu+6Mx7pFln7EvQt7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKbF7sLZ24PYFv/OaLEbM4W+RIB/jNs+v2KAvaUklf8=;
        b=tMKYPcvp3FNt08zsOaD88WfyZrLgkEnGPf+TfVSo5QMDZgFtUUjSQr+g9PMwjOizR3
         eYcyb4gjgYcwpgSOslifCJMJbzZwtNRMudxQemxol+zMHwyfctTKyLFXuLitXZ6yA+yZ
         Wt/79PhUnfsgFOhFwPIcLv29Bxsds+rSxJC4QZxT6x0JUE7T8B1nibbJ6PYkhBu/kg9y
         MeQ7QvuAsSPszWnQyFat4trrMFQfevkcjfdeyX3zda3H/KMYuDKD4qSSbkeU7O08yDbG
         BOBSLoKvMUQ4HVVBujzpG1gPvH9NPj1CHEdL/Y6OisnRxyVp6jJEcNGfxcGXOIo1IlEn
         +2nQ==
X-Gm-Message-State: ABuFfoj11uaq7t14mmxK1pk5hYk6NlyeukLAtMIskXifluEf9wDfs+WT
        oNsIRtU3k/4DnWlomUTCzUhfTJeqoog=
X-Google-Smtp-Source: ACcGV61VHb70aA3P1xwU/0Xg4T4Xne3dJpSJlTnsc0oBQKtA1MER2/bFMRbi+MEOrLvtcRFU9EEAvw==
X-Received: by 2002:a5d:548e:: with SMTP id h14-v6mr3876291wrv.316.1538640767292;
        Thu, 04 Oct 2018 01:12:47 -0700 (PDT)
Received: from [192.168.0.40] (225.182.88.92.rev.sfr.net. [92.88.182.225])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm5258647wmd.46.2018.10.04.01.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:12:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <20181004075703.GG19272@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e4cf9124-2dbb-45cb-6b45-f0b92a6ac88e@linaro.org>
Date:   Thu, 4 Oct 2018 10:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004075703.GG19272@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

On 04/10/2018 09:57, Peter Zijlstra wrote:
> On Thu, Oct 04, 2018 at 09:42:07AM +0200, Daniel Lezcano wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b88a145..5605f03 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
>>  
>>  	return sum;
>>  }
>> -/*
>> - * Consumers of these two interfaces, like for example the cpufreq menu
>> - * governor are using nonsensical data. Boosting frequency for a CPU that has
>> - * IO-wait which might not even end up running the task when it does become
>> - * runnable.
>> - */
>>  
>>  unsigned long nr_iowait_cpu(int cpu)
>  
> +static

The function is exported in include/linux/sched/stat.h and used by
drivers/cpuidle/governors/menu.c

Do you want to declare it static inline in the stat.h file ?

>>  {
>>  	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>>  }
>>  
>> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
>> -{
>> -	struct rq *rq = this_rq();
>> -	*nr_waiters = atomic_read(&rq->nr_iowait);
>> -	*load = rq->load.weight;
>> -}
>> -
>>  /*
>>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>>   *
> 
> I'm obviously all for this :-)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

