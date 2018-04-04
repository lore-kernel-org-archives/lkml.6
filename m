Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDDOhk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:37:40 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40555 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDDOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:37:38 -0400
X-Google-Smtp-Source: AIpwx4/Y9oTfN0L6NlDUjHc8cEJCzqOqE+mlyeVEJyt6q62AZ1v4f63Nz4Mko70BE51NJ8517Bohgw==
From: Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date: Wed, 4 Apr 2018 16:37:35 +0200
To: Ferenc =?iso-8859-1?Q?W=E1gner?= <wferi@niif.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the priority of the idle task?
Message-ID: <20180404143735.GA23925@aton>
Mail-Followup-To: Ferenc =?iso-8859-1?Q?W=E1gner?= <wferi@niif.hu>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muykk2p2.fsf@lant.ki.iif.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018, Ferenc Wágner wrote:
> As explained by several (if somewhat old) articles [2,3,4], the Linux
> idle task (PID=0, one per CPU) is run when there are no other tasks to
> run. To get the scheduler do this, the idle task must have the lowest
> priority reserved for it. That old Documentation/ftrace.txt in the
> linked LWN article explicitly says that
> 
> > The prio "140" is reserved for the idle task which is the lowest
> > priority thread (pid 0).
> 
> This makes sense, but under Linux 4.9
> 
> # perf record -e sched:sched_switch sleep 1
> # perf script
>    sleep  6526 [000] 362661.310842: sched:sched_switch: sleep:6526 [120] S ==> swapper/0:0 [120]
> 
> reports a priority of 120 for swapper/0 (in the closing bracket),
> contradicting the above.
> 
> How does the Linux scheduler handle the idle task nowadays? The commits
> removing the quoted text from ftrace.txt (87d80de28, 294ae4011) didn't
> help.

The idle task has its own scheduling class that only handles the idle threads per CPU
core. This scheduling class has the lowest priority of the scheduling classes
available in the kernel. This means that it is the last one in the list of scheduling
classes that are asked at a task switch whether they have a task to schedule on the
CPU. Hence, the idle task is not managed by CFS and accordingly doesn't have any nice
value or priority (or at least it is not important nowadays). Interesting files in
the kernel source that might contain more information are kernel/sched/idle_task.c,
kernel/sched/sched.h and kernel/sched/core.c.

Regards
Till
