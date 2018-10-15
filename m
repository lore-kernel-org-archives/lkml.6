Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB502064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB502064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOUc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:32:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:33551 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:32:28 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9FClEhF091008;
        Mon, 15 Oct 2018 21:47:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 15 Oct 2018 21:47:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9FClAgN090934
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 15 Oct 2018 21:47:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20181012112008.GA27955@cmpxchg.org>
 <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
 <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
 <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
 <20181013112238.GA762@cmpxchg.org>
 <b61b2e60-d899-90c6-579a-587815cebff6@i-love.sakura.ne.jp>
 <20181015081934.GD18839@dhcp22.suse.cz>
 <ea637f9a-5dd0-f927-d26d-d0b4fd8ccb6f@i-love.sakura.ne.jp>
 <20181015112427.GI18839@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6c0a57b3-bfd4-d832-b0bd-5dd3bcae460e@i-love.sakura.ne.jp>
Date:   Mon, 15 Oct 2018 21:47:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015112427.GI18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/15 20:24, Michal Hocko wrote:
> On Mon 15-10-18 19:57:35, Tetsuo Handa wrote:
>> On 2018/10/15 17:19, Michal Hocko wrote:
>>> As so many dozens of times before, I will point you to an incremental
>>> nature of changes we really prefer in the mm land. We are also after a
>>> simplicity which your proposal lacks in many aspects. You seem to ignore
>>> that general approach and I have hard time to consider your NAK as a
>>> relevant feedback. Going to an extreme and basing a complex solution on
>>> it is not going to fly. No killable process should be a rare event which
>>> requires a seriously misconfigured memcg to happen so wildly. If you can
>>> trigger it with a normal user privileges then it would be a clear bug to
>>> address rather than work around with printk throttling.
>>>
>>
>> I can trigger 200+ times / 900+ lines / 69KB+ of needless OOM messages
>> with a normal user privileges. This is a lot of needless noise/delay.
> 
> I am pretty sure you have understood the part of my message you have
> chosen to not quote where I have said that the specific rate limitting
> decisions can be changed based on reasonable configurations. There is
> absolutely zero reason to NAK a natural decision to unify the throttling
> and cook a per-memcg way for a very specific path instead.
> 
>> No killable process is not a rare event, even without root privileges.
>>
>> [root@ccsecurity kumaneko]# time ./a.out
>> Killed
>>
>> real    0m2.396s
>> user    0m0.000s
>> sys     0m2.970s
>> [root@ccsecurity ~]# dmesg | grep 'no killable' | wc -l
>> 202
>> [root@ccsecurity ~]# dmesg | wc
>>     942    7335   70716
> 
> OK, so this is 70kB worth of data pushed throug the console. Is this
> really killing any machine?
> 

Nobody can prove that it never kills some machine. This is just one example result of
one example stress tried in my environment. Since I am secure programming man from security
subsystem, I really hate your "Can you trigger it?" resistance. Since this is OOM path
where nobody tests, starting from being prepared for the worst case keeps things simple.
