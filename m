Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1985C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F22086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfASNBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:01:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:28791 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbfASNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:01:07 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0JD16xb030725;
        Sat, 19 Jan 2019 22:01:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Sat, 19 Jan 2019 22:01:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0JD0r7r030274
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 19 Jan 2019 22:01:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>
References: <00000000000010b2fc057fcdfaba@google.com>
 <CACT4Y+ZSK4DDhsz5gCAUnW49mCJPGcKECqC8yAn=PAA0Tx8D3w@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1737a5e1-f93a-e7ea-80d0-c244b22d0b61@I-love.SAKURA.ne.jp>
Date:   Sat, 19 Jan 2019 22:00:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZSK4DDhsz5gCAUnW49mCJPGcKECqC8yAn=PAA0Tx8D3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/19 20:41, Dmitry Vyukov wrote:
> On Sat, Jan 19, 2019 at 12:32 PM syzbot
> <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    2339e91d0e66 Merge tag 'media/v5.0-1' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=175f2638c00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=abc3dc9b7a900258
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1505c80c74256c6118a5
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4dc28c00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15df4108c00000
> 
> Looking at the reproducer it looks like something with scheduler as it
> involves perf_event_open and sched_setattr. So +Peter and Mingo.
> Is it the same root cause as the other stalls involving sched_setattr?

Yes. I think sched_setattr() involves this problem.

Reproducers from "BUG: workqueue lockup (4)" at
https://syzkaller.appspot.com/text?tag=ReproC&x=13ec31a5400000
involves sched_setattr(SCHED_DEADLINE) and
https://syzkaller.appspot.com/text?tag=ReproC&x=104da690c00000
also involves sched_setattr().

