Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeDIJDs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:03:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37191 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:03:47 -0400
X-Google-Smtp-Source: AIpwx4/eMLN1hZawC1tPWO2Ue7x8nphMDBawt2rlDrszyywVzikTP6KgP4SpbiHNozdbhfJSt6ZfgG1UYbA1lTb4Tfk=
MIME-Version: 1.0
In-Reply-To: <201804080124.GHG87587.SVFOOQFLOHMJtF@I-love.SAKURA.ne.jp>
References: <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
 <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
 <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
 <20180407153937.GR4082@hirez.programming.kicks-ass.net> <CACT4Y+Z6_P9mj2TEE3mtCez1je7dbviftM0rPcgsmQ-yFYYmBg@mail.gmail.com>
 <201804080124.GHG87587.SVFOOQFLOHMJtF@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 11:03:26 +0200
Message-ID: <CACT4Y+ZA_zYGxxj9oN8m5ApSbKSSS-mf2DXpHT3Ab3MdiEKKgQ@mail.gmail.com>
Subject: Re: [PATCH v2] locking/hung_task: Show all hung tasks before panic
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mandeep Singh Baines <msb@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 7, 2018 at 6:24 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Dmitry Vyukov wrote:
>> On Sat, Apr 7, 2018 at 5:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Sat, Apr 07, 2018 at 09:31:19PM +0900, Tetsuo Handa wrote:
>> >> are for replacing debug_show_all_locks() in check_hung_task() for cases like
>> >> https://syzkaller.appspot.com/bug?id=26aa22915f5e3b7ca2cfca76a939f12c25d624db
>> >> because we are interested in only threads holding locks.
>> >>
>> >> SysRq-t is too much but SysRq-w is useless for killable/interruptible threads...
>> >
>> > Or use a script to process the sysrq-t output? I mean, we can add all
>> > sorts, but where does it end?
>
> Maybe allow khungtaskd to call call_usermode_helper() to run arbitrary operations
> instead of just calling panic()?

This would probably work for syzbot too.

>> Good question.
>> We are talking about few dozen more stacks, right?
>>
>> Not all kernel bugs are well reproducible, so it's not always possible
>> to go back and hit sysrq-t. And this come up in the context of syzbot,
>> which is an automated system. It reported a bunch of hangs and most of
>> them are real bugs, but not all of them are easily actionable.
>> Can it be a config or a command line argument, which will make syzbot
>> capture more useful context for each such hang?
>>
>
> It will be nice if syzbot testing is done with kdump configured, and the
> result of automated scripting on vmcore (such as "foreach bt -s -l") is
> available.

kdump's popped up several times already
(https://github.com/google/syzkaller/issues/491). But this will
require some non-trivial amount of work to pipe it through the whole
system (starting from investigation/testing, second kernel to storing
them and exposing).
