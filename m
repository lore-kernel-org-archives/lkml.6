Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103CC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFE52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFE52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJLUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:30:42 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23055 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:30:42 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9CCwJfq003805;
        Fri, 12 Oct 2018 21:58:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Fri, 12 Oct 2018 21:58:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9CCwJra003790
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 12 Oct 2018 21:58:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org> <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
Date:   Fri, 12 Oct 2018 21:58:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012124137.GA29330@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling printk() people. ;-)

On 2018/10/12 21:41, Johannes Weiner wrote:
> On Fri, Oct 12, 2018 at 09:10:40PM +0900, Tetsuo Handa wrote:
>> On 2018/10/12 21:08, Michal Hocko wrote:
>>>> So not more than 10 dumps in each 5s interval. That looks reasonable
>>>> to me. By the time it starts dropping data you have more than enough
>>>> information to go on already.
>>>
>>> Yeah. Unless we have a storm coming from many different cgroups in
>>> parallel. But even then we have the allocation context for each OOM so
>>> we are not losing everything. Should we ever tune this, it can be done
>>> later with some explicit examples.
>>>
>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> Thanks! I will post the patch to Andrew early next week.
>>>
>>
>> How do you handle environments where one dump takes e.g. 3 seconds?
>> Counting delay between first message in previous dump and first message
>> in next dump is not safe. Unless we count delay between last message
>> in previous dump and first message in next dump, we cannot guarantee
>> that the system won't lockup due to printk() flooding.
> 
> How is that different from any other printk ratelimiting? If a dump
> takes 3 seconds you need to fix your console. It doesn't make sense to
> design KERN_INFO messages for the slowest serial consoles out there.

You can't fix the console. It is a hardware limitation.

> 
> That's what we did, btw. We used to patch out the OOM header because
> our serial console was so bad, but obviously that's not a generic
> upstream solution. We've since changed the loglevel on the serial and
> use netconsole[1] for the chattier loglevels.
> 
> [1] https://github.com/facebook/fbkutils/tree/master/netconsd
> 
