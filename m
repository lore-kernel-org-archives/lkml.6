Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7932098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7932098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbeIXUGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:06:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41645 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbeIXUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:06:24 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8OE44SE017096;
        Mon, 24 Sep 2018 23:04:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Mon, 24 Sep 2018 23:04:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8OE3whJ017080
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 24 Sep 2018 23:04:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
To:     Dmitry Vyukov <dvyukov@google.com>, Jiri Kosina <jikos@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <0000000000006364200575dfc280@google.com>
 <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
 <CAOQ4uxhmFsvy6y6NgcFPs4NF1Lg7J0h2VoWgiL8WfXdDz+Z0FQ@mail.gmail.com>
 <nycvar.YFH.7.76.1809241511500.15880@cbobk.fhfr.pm>
 <CACT4Y+bNOch9EC2MyFjPgM_pvzidbRxeStV3w5w1TN1NOUhPJQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b8747ec0-296e-aa16-dfa2-afe4d40488c0@i-love.sakura.ne.jp>
Date:   Mon, 24 Sep 2018 23:03:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bNOch9EC2MyFjPgM_pvzidbRxeStV3w5w1TN1NOUhPJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/24 22:31, Dmitry Vyukov wrote:
> On Mon, Sep 24, 2018 at 3:19 PM, Jiri Kosina <jikos@kernel.org> wrote:
>> On Sun, 16 Sep 2018, Amir Goldstein wrote:
>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
>>>>>
>>>>
>>>> Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.
>>>>
>>>> [  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
>>>> [  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
>>>>
>>>> Since the reproducer is simple, this might be lockup due to continuous printk().
>>>> If syzbot can reliably reproduce this problem using the reproducer, try
>>>> ratelimiting printk().
>>>
>>> Right.. and I was able to reproduce after setting CONFIG_HID_GENERIC=y
>>> but unless I am missing something, the core problem doesn't seem related to
>>> fsnotify and $SUBJECT, so CCing HID maintainer.
>>
>> Alright, so you're basically triggering a never-ending flow of kmsgs being
>> printed out from HID parser due to doing crazy things with the parser, and
>> that causes the issues for the kworker trying to flush them out.
>>
>> I guess the patch below fixes it, however the kworker should not really be
>> blocked by this I think ... adding a few more printk folks to double-check
>> why the kworker would get stuck due to massive printk() flood.
> 
> 
> The task hanged in synchronize_rcu(). I think any infinite loop
> (whether it prints or not) can cause this.

This problem is occurring on CONFIG_PREEMPT=y CONFIG_PREEMPT_RCU=y kernel.
I think that any insane printk() stress can delay waiters long enough to
fire khungtaskd watchdog. Though syzbot might be unable to reliably test
this problem (because syzbot has succeeded to trigger this problem for only
two times), why not to let syzbot try the patch anyway?
