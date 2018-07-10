Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7C9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7936320881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7936320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGJKsw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:48:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26294 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeGJKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:48:51 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6AAmn4g036359;
        Tue, 10 Jul 2018 19:48:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Tue, 10 Jul 2018 19:48:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6AAmScu036209
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 19:48:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
 <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
 <20180710093046.GE2476@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bdecb526-9f61-bdb9-85f1-a6243b5fac7a@i-love.sakura.ne.jp>
Date:   Tue, 10 Jul 2018 19:48:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180710093046.GE2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/10 18:30, Peter Zijlstra wrote:
>> diff --git a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
>> index e475683..1164965 100644
>> --- a/include/linux/rwsem-spinlock.h
>> +++ b/include/linux/rwsem-spinlock.h
>> @@ -22,7 +22,7 @@
>>   * - if wait_list is not empty, then there are processes waiting for the semaphore
>>   */
>>  struct rw_semaphore {
>> -	__s32			count;
>> +	atomic_long_t		count;
> 
> Uhhh... how does this even build? rwsem-spinlock.c doesn't use
> atomic_long primitives to change count.

Sorry, I forgot to build test rwsem-spinlock.c side.

> 
> And the atomic_long count usage is completely private to rwsem-xadd.c,
> nothing outside of that should use that field, ever.
> 

The reason I made above patch is to make
"[PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up." patch
possible to build on x86_64. Although "nothing outside of that should use
that field", I want to check "struct rw_semaphore"->count for isolating
the problem.

Should I update
"[PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up." side
to use "#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK" ?

