Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDILuY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:50:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40650 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeDILuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:50:22 -0400
X-Google-Smtp-Source: AIpwx49wgLDWWHnBS4fzXuumbkUuUM1OBGIwOLfb+H3xhCWGoU6HrarQn62Il5RcxLI5NgiGVCBhU0I9jhRDyvQc3ZE=
MIME-Version: 1.0
In-Reply-To: <201804092013.IIF48452.FMOLFHVStOFJQO@I-love.SAKURA.ne.jp>
References: <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
 <20180407153937.GR4082@hirez.programming.kicks-ass.net> <CACT4Y+Z6_P9mj2TEE3mtCez1je7dbviftM0rPcgsmQ-yFYYmBg@mail.gmail.com>
 <201804080124.GHG87587.SVFOOQFLOHMJtF@I-love.SAKURA.ne.jp>
 <CACT4Y+ZA_zYGxxj9oN8m5ApSbKSSS-mf2DXpHT3Ab3MdiEKKgQ@mail.gmail.com> <201804092013.IIF48452.FMOLFHVStOFJQO@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 13:50:01 +0200
Message-ID: <CACT4Y+ZX-QtOzCXaDhGnk4FzpSUk3rNw=5_o34O9=je2jSQkxw@mail.gmail.com>
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

On Mon, Apr 9, 2018 at 1:13 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>> > It will be nice if syzbot testing is done with kdump configured, and the
>> > result of automated scripting on vmcore (such as "foreach bt -s -l") is
>> > available.
>>
>> kdump's popped up several times already
>> (https://github.com/google/syzkaller/issues/491). But this will
>> require some non-trivial amount of work to pipe it through the whole
>> system (starting from investigation/testing, second kernel to storing
>> them and exposing).
>>
>
> We can use different kernels for testing and kdump, can't we? Then,
> I think it is not difficult to load kernel for kdump from local disk.
> And kdump (kexec-tools) already supports dumping via ssh. Then, is there
> still non-trivial amount of work? Just a remote server for temporarily
> holding kernel for testing and run scripted analyzing commands ?

It's just that usually fully automating something is much larger
amount of work than doing it manually as a one-off thing. I also need
to figure out how much time and space it takes to reboot into kdump
kernel and extract the dump. I don't think that it's feasible to
persistently store all kdumps, because we are getting ~1 crash/sec.
Then, the web server that serves syzbot UI and sends emails is an
Appengine web app which does not have direct access to test machines
and/or git, but it seems that only it can decide when we need to store
dumps persistently. In the current architecture test machines are
disposable and are long gone by the time crash it uploaded to
dashboard. So machines needs to be preserved until after dashboard
says if we need dump or not. Or maybe extract dumps always and store
them locally temporary until we know if we need to persist it or not.
I don't know yet what will work better. This also needs to be
carefully treated through crash reproduction process which has
different logic from main testing loop. And at the end interfaces
between multiple systems need to be extended, database format needs to
be extended, lots of testing done, and we need to figure out what is a
good config for kdump kernel and image build process needs to be
extended to package kdump kernel, configs of multiple systems need to
be extended and probably a bunch of other small things here and there.
Then we also need vmlinux to make dumps actionable, right? And vmlinux
is nice in itself because it allows to do objdump -d. So it probably
makes sense to separate vmlinux uploading and persistance from dumps,
because vmlinux'es probably better be uploaded once per kernel build
(which is like once per day). So that will be separate paths through
the system.
Also probably makes sense to consider if
https://github.com/google/syzkaller/issues/466 can be bundled with
this work (at least data paths, what exactly is captured can of course
be extended later).
We also need to figure out if at least part of all this can be
unit-tested and write tests.
So, yes, nothing extraordinary. But I feel this is not doable within a
day and will preferably require several uninterrupted days with
nothing else urgent, but I am having troubles with such days lately...
