Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E7620844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfBFO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:58:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32268 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:58:16 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x16Evkl3045080;
        Wed, 6 Feb 2019 23:57:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Wed, 06 Feb 2019 23:57:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x16EviNl045047
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 6 Feb 2019 23:57:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Chris Metcalf <chris.d.metcalf@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
 <87munc306z.fsf@rustcorp.com.au>
 <201902060631.x166V9J8014750@www262.sakura.ne.jp>
 <20190206143625.GA25998@roeck-us.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e4dd7464-a787-c54f-24f9-9caaeb759cfc@i-love.sakura.ne.jp>
Date:   Wed, 6 Feb 2019 23:57:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190206143625.GA25998@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/06 23:36, Guenter Roeck wrote:
> On Wed, Feb 06, 2019 at 03:31:09PM +0900, Tetsuo Handa wrote:
>> (Adding linux-arch ML.)
>>
>> Rusty Russell wrote:
>>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>>>> (Adding Chris Metcalf and Rusty Russell.)
>>>>
>>>> If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
>>>> evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
>>>> previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
>>>> commits listed below.
>>>>
>>>>   Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
>>>>   expects that has_work is evaluated by for_each_cpu().
>>>>
>>>>   Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
>>>>   assumes that for_each_cpu() does not need to evaluate has_work.
>>>>
>>>>   Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
>>>>   expects that has_work is evaluated by for_each_cpu().
>>>>
>>>> What should we do? Do we explicitly evaluate has_work if NR_CPUS == 1 ?
>>>
>>> No, fix the API to be least-surprise.  Fix 2d3854a37e8b767a too.
>>>
>>> Doing anything else would be horrible, IMHO.
>>>
>>
>> Fixing 2d3854a37e8b767a might involve subtle changes. If we do
>>
> 
> Why not fix the macros ?
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> 
> does not really make sense since it does not evaluate mask.
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1 && cpumask_test_cpu((cpu), (mask)); (cpu)++)
> 
> or something similar might do it.

Fixing macros is fine, The problem is that "mask" becomes evaluated
which might be currently undefined or unassigned if CONFIG_SMP=n.
Evaluating "mask" generates expected behavior for lru_add_drain_all()
case. But there might be cases where evaluating "mask" generate
unexpected behavior/results.
