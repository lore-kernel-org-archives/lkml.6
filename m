Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C441BECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28B21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="kkUTAoWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A28B21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbeIUIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:00:46 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:46331 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        reply-to:sender:bcc; bh=dH7oG4ngby14vccxwD2Ff1aFPTYbYIwArhLguLPb4Ok=; b=kkUTA
        oWtq2ugWos+lABNxZyxWIPVvbs9IgdXQ25dSsovTtRZLow7Cm8sqJwrRTfsTDBRtUjNOYnqEek7cF
        VfUwliNSyf/JEvDyrjiKMAd14iSwpnz3qbZ6vpyTW8R03Fm18WNzZymROeGdC9tx/+gWN36AQPgfT
        hSIQ9nLwy1fIkUzRWqhPa8kRCPfzPetW7NsEatO/GWM5aGm1/+ZYLUcJZlEV6tNJde8bF6H9qmoP6
        SHlCPdICict1ZTu1Ynr9eW1ACI0YoS4LwNMIQ7RH41VK3xNgogRH4rFQKBD8ng1xVTf33gfoi19Lh
        XCa5mk9xiVbGFeh2nmRDdLIWv5TAA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1g3AxI-000FMz-3o; Fri, 21 Sep 2018 04:14:05 +0200
Received: from asus.site (c-174-62-111-89.hsd1.ca.comcast.net [174.62.111.89])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 6AC45C08FC;
        Fri, 21 Sep 2018 04:13:46 +0200 (CEST)
Subject: Re: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        tj@kernel.org, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537463217.224533.4.camel@acm.org>
 <0e6caed5-33eb-e645-f452-3dfc6c20206d@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4a6c3930-1f90-6a9b-ba25-882b1c9102e2@acm.org>
Date:   Thu, 20 Sep 2018 19:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0e6caed5-33eb-e645-f452-3dfc6c20206d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.36)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sTuB7V85IS95qF7d5aN1VV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO74yoiKRT4T5Dx7UFe3A/4vx+tGGpUzQMWnTzvwoJh8iQmIkfF8rWyvpOu7HcCsBUV+a
 dV8M+2ua0CjnNAfsR5OfvjMAP8kTFjFCgaPMZfm4DMdvte+m2WUhNppJkJhefZY7bpwi2JkCcTIa
 hzqeuZkibCp5zwccy0ekL6xNqWzRY7Bp795h5ZQRK+npnnhq9xDq0oQNgY70en1IeYY8rslLn/nj
 N5eSj526f3kLYY1TzUdYbtFcR7mFayO7rEbq/LRzXEvaO1JRgBz4ducYF6Er1bahvCGcC6OC9ORL
 g916uSDR7Nm87iABJYQ0/KIBhaSsims+DHmi9xgWUrJL4hpHO5hhic6hnF0/HP8dDqVx2usqskBf
 h9gLNBvEVVkgjpFbF4WvUY31/6GgIerkzSEsClaD/aoFN8UC1OIYHGgD7aC6PpHaQzlyXPj/ukmy
 bfrPy73N+NmQZjdI5pedxoffFXb/enftPIg7n76G8OlVGr5eLJxvj0Z/k/Kae70Fd66S7zlIdsPI
 LIC19LhUjcdgHsCbxtlUeZiBgswhNzf2rGZvhQfMnJLxWYh1sZ0BDJLpzg2LW7z+9rwJjso6c/VC
 AwRz7X9u/nNydR8InFFfhqUvgugTwCBLPD4olaNxG93OygpUgTotxFdDVm1SdSl8alisSYg70l72
 b136NlBGEfRvByHw5tDD1k80InEwvRqZR3KVQgqF/fPYYAfEfsgvRvW98ms3QtXhl88VWiqYXaFv
 BC0THXebWbanUR8NBtf+IeobE55lxilFgDI5JUiUyKrK4mS72ohmZ8/dc6ADKJHTMoo8qzTyxdqY
 23W9zKLH2IgPgNMGWY4XS9D6QuwRFZ4oobg8BBg3Jq+ntzj0E9A1RaDAwaeT0VIkM3Ewyyl2KfJk
 pLQOURqR46KU3X/1vykDeQcn+xrIb3Y0YpTriu/76+4tqtUiti9Q0G+binLYM3A6BXfvel8OEFDb
 U53HBYYcJ9vw49aYF0XZBhV5pevLFUHVfIx8rWdu/t9WNs2t5rktjmM64Dyx39EW7vbnShMu2z+Y
 CLdt1O36QJzT0VAVlgUg0ceTnpaCix0bNINM+RH2a8+hOcW7q30pe+BwRJ/eXhAiot4MY812nNgi
 KO20lhzML9eJMR+d8xJLuOgsY8kH9PTOa4mpQXFbeMfbt4RxuX/y2QGQtm1IY1n9
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 6:51 PM, jianchao.wang wrote:
> Hi Bart
> 
> On 09/21/2018 01:06 AM, Bart Van Assche wrote:
>> On Thu, 2018-09-20 at 18:18 +0800, Jianchao Wang wrote:
>>> The current queue freeze depending on percpu_ref_kil/reinit has a limit that
>>> we have drain the requests before unfreeze the queue.
>>>
>>> Let's rework the queue freeze feature as following:
>>> 1. introduce __percpu_ref_get_many.
>>>     It is same with original percpu_ref_get_many, but just need callers to provide
>>>     sched rcu critical section. We will put the __percpu_ref_get_many and our own
>>>     condition checking under rcu_read_lock_sched. With this new helper interface,
>>>     we could save an extra rcu_read_lock_sched.
>>> 2. rework the blk_queue_enter as:
>>>     
>>>     rcu_read_lock_sched()
>>>     if condition check true
>>>       __percpu_ref_get_many(&q->q_usage_counter, 1)
>>>     else
>>>       goto wait
>>>     rcu_read_unlock_sched()
>>> 3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.
>>>
>>> Then we could unfreeze the queue w/o draining requests.
>>> In addition, preempt-only mode code could be simplified.
>> Hello Jianchao,
>>                                                                             =
>> Thanks for having taken a look. However, the approach of this patch series
>> may be more complicated than necessary. Had you considered something like
>> the patch below?
> 
> This patch is just a trying that let our life easier w/o changing anything in percpu-ref code. :)
> In fact, the 1st patch which introduces a new non-functional-changing helper interface in
> percpu-ref code is not necessary.
> 
> This patchset just implement our own condition checking in blk_queue_enter instead of depending on
> __PERCPU_REF_DEAD checking in percpu_ref_tryget_live.
> 
> Then we could do more thing here, like:
>   - unfreeze the queue without draining requests.
>   - check whether q->q_usage_counter is zero
>   - add other gate conditions into blk_queue_enter, such as preempt-only, even any others.
> 
> So why not try it ?

Hello Jianchao,

Some time ago Tejun wrote that he wants to keep the dependency of the 
percpu_ref implementation on rcu-sched inside the percpu_ref 
implementation because he would like to have the freedom to switch to 
regular RCU. Your patch series makes the dependency of percpu_ref 
counters on rcu-sched visible outside the percpu_ref implementation. I 
think that's a disadvantage of your approach. Tejun, please correct me 
if I misunderstood you.

Bart.

