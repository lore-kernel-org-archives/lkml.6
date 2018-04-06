Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeDFPBx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:01:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46713 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755205AbeDFPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:01:50 -0400
X-Google-Smtp-Source: AIpwx48ATDl9wNWztPjtxTIAaFHFrT3xkEL9StbmvAG+TL9z7OFuLsyWGYClkhGT18fes7jr6gtORw==
Subject: Re: WARNING: lock held when returning to user space!
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Omar Sandoval <osandov@osandov.com>
References: <00000000000082922905692da9e1@google.com>
 <0e998b77-14f0-aee0-8d32-bc1dd96fcc4c@kernel.dk>
 <CACT4Y+Y0TVJLDA5-0RGq-a-A6KKLKHZtA4pwUH2rtvR0hkiZQQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <63121c85-f417-cde8-510d-f275dbe81c4d@kernel.dk>
Date: Fri, 6 Apr 2018 09:01:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y0TVJLDA5-0RGq-a-A6KKLKHZtA4pwUH2rtvR0hkiZQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/18 8:57 AM, Dmitry Vyukov wrote:
> On Fri, Apr 6, 2018 at 4:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> On 4/6/18 7:02 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
>>> Merge tag 'armsoc-drivers' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>>> syzbot dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=31e8daa8b3fc129e75f2
>>>
>>> So far this crash happened 9 times on upstream.
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6407930337296384
>>> syzkaller reproducer:
>>> https://syzkaller.appspot.com/x/repro.syz?id=4942413340606464
>>> Raw console output:
>>> https://syzkaller.appspot.com/x/log.txt?id=4764483918495744
>>> Kernel config:
>>> https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
>>> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com
>>> It will help syzbot understand when the bug is fixed. See footer for
>>> details.
>>> If you forward the report, please keep this part and the footer.
>>>
>>>
>>> ================================================
>>> WARNING: lock held when returning to user space!
>>> 4.16.0+ #3 Not tainted
>>> ------------------------------------------------
>>> syzkaller433111/4462 is leaving the kernel with locks still held!
>>> 1 lock held by syzkaller433111/4462:
>>>   #0: 0000000003a06fae (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x1ec0
>>> drivers/block/loop.c:1363
>>
>> Is this a new regression? Omar did just fiddle with the locking a bit,
>> seems suspicious.
> 
> Looking at:
> https://syzkaller.appspot.com/bug?extid=31e8daa8b3fc129e75f2
> It first happened 4 hours ago and 9 times since then, so probably a
> just introduced regression.

After writing that, I saw the discussion in another
thread ("INFO: task hung in lo_ioctl"), so I think we can definitely say
that it's a recently introduced regression in loop due to the killable
lock changes.

-- 
Jens Axboe
