Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4BA21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBhiiiiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4BA21C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeHIRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:45:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57684 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbeHIRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BquiGe2ZrY5aCQ8zAeCFycoqVTzhPdTfoobhJiBLfeA=; b=HBhiiiiX4/g/Wg1sFFx3hqiJ2A
        +7q380AOmWn+BHSynAnREucUW2ay4hKBoETBL+wHIxu8jYIrz5/mBCCrPqX+pSskz2ce9GFPNsvwm
        m97PT4AujyDWqDNjWSoH9BvyeCsxSD9Bhw1Ao4gZxUci5hwo6ikX5w+oIlSE0pagFmxudZcYqd1kz
        /cf9ubiFoW3yabVbbMuOHhVVuaiqxA9yo3wfABOg/j/ODbPaBycEdxQ+amss4+4wz8W8Q06cnceU+
        0WOk9M53xDjl+E6o/KS6qx7+YvL7uRrFR3sUJyWcEUuoBgJeX0dLNIIQ+WH/wuF6XDVZgPZ8F8DRD
        kONjP43A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnmjf-0004Ca-UK; Thu, 09 Aug 2018 15:20:24 +0000
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
 <20180809083947.2ogkudkpg6d52roc@darkstar>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <87897157-0b49-a0be-f66c-81cc2942b4dd@infradead.org>
Date:   Thu, 9 Aug 2018 08:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809083947.2ogkudkpg6d52roc@darkstar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 01:39 AM, Patrick Bellasi wrote:
> On 06-Aug 09:50, Randy Dunlap wrote:
>> Hi,
> 
> Hi Randy,
> 
>> On 08/06/2018 09:39 AM, Patrick Bellasi wrote:
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index 041f3a022122..1d45a6877d6f 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
>>>  config GENERIC_SCHED_CLOCK
>>>  	bool
>>>  
>>> +menu "Scheduler features"
>>> +
>>> +config UCLAMP_TASK
>>> +	bool "Enable utilization clamping for RT/FAIR tasks"
>>> +	depends on CPU_FREQ_GOV_SCHEDUTIL
>>> +	default false
>>
>> 	default n
>> but just omit the line completely since "n" is already the default.
> 
> 
> Right, will update for next posting!
> Is there a strict rule to omit this line when it's already the
> default?

It's not documented AFAIK, but it's commonly repeated on LKML.

>>> +	help
>>> +	  This feature enables the scheduler to track the clamped utilization
>>> +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
>>> +
>>> +	  When this option is enabled, the user can specify a min and max CPU
>>> +          bandwidth which is allowed for a task.
>>> +	  The max bandwidth allows to clamp the maximum frequency a task can
>>> +	  use, while the min bandwidth allows to define a minimum frequency a
>>> +          task will always use.
>>
>> Please clean up the indentation above to use one tab + 2 spaces on all lines.
> 
> Sure, my bad I did not notice it... although I'm quite sure the patch
> passed a checkpatch... will check better next time.

Thanks.

>>> +
>>> +	  If in doubt, say N.
>>> +
>>> +endmenu


-- 
~Randy
