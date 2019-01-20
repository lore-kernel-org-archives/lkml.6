Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A530C61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F62084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfATChN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:37:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:15799 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfATChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:37:12 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0K2Ztlo012616;
        Sun, 20 Jan 2019 11:35:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Sun, 20 Jan 2019 11:35:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0K2ZrYw012598
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 20 Jan 2019 11:35:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in lo_ioctl
To:     Dmitry Vyukov <dvyukov@google.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@fb.com>,
        syzbot 
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>, shli@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, knikanth@suse.de
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
 <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
 <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
 <20180406121411.GJ4082@hirez.programming.kicks-ass.net>
 <201804062255.HEJ82361.FJOFHVtSLOMOQF@I-love.SAKURA.ne.jp>
 <20180406154343.GK4082@hirez.programming.kicks-ass.net>
 <20180406155905.GA11697@vader>
 <CACT4Y+ZaL=zPbb-r7PKvOsY8aBRiMEEHMc+-HVGm+dRTax+DfA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <faf9772a-f865-1475-ea0b-f9efb04ea974@i-love.sakura.ne.jp>
Date:   Sun, 20 Jan 2019 11:35:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZaL=zPbb-r7PKvOsY8aBRiMEEHMc+-HVGm+dRTax+DfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/20 3:56, Dmitry Vyukov wrote:
>> Seems easy enough to fix without resorting to __mutex_owner() (untested):
>>
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 264abaaff662..cee258d12a1e 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1300,12 +1300,13 @@ loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
>>  static int
>>  loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
>>         struct loop_info64 info64;
>> -       int err = 0;
>> +       int err;
>>
>> -       if (!arg)
>> -               err = -EINVAL;
>> -       if (!err)
>> -               err = loop_get_status(lo, &info64);
>> +       if (!arg) {
>> +               mutex_unlock(&lo->lo_ctl_mutex);
>> +               return -EINVAL;
>> +       }
>> +       err = loop_get_status(lo, &info64);
>>         if (!err && copy_to_user(arg, &info64, sizeof(info64)))
>>                 err = -EFAULT;
>>
>>
>> I'll test it and send it up when I get into the office.
> 
> 
> Was this ever submitted? Or some other fix for this?
> 
> The bug is still open, but last happened 289 days ago:
> https://syzkaller.appspot.com/bug?id=608144371e7fc2cb6285b9ed871fb1eb817a61ce
> 
> But it also has 10 duplicates, some of which happened much more recently.
> If a fix was submitted, but Reported-by tag wasn't added this open bug
> can now mask lots of other new bugs.
> 

The commit for this specific patch is bdac616db9bbadb9 ("loop: fix LOOP_GET_STATUS
lock imbalance"). But the root cause of these hung tasks would be fixed by a series
containing commit 1dded9acf6dc9a34 ("Avoid circular locking dependency between
loop_ctl_mutex and bd_mutex") or commit 04906b2f542c2362 ("blockdev: Fix livelocks
on loop device"). We were not aware of these bugs when you marked these reports as
duplicates on 2017/12/12. You can undup them and fix them if you want.
