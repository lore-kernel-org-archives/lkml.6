Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeBUT50 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:57:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34722 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:57:24 -0500
X-Google-Smtp-Source: AH8x226xCyn0ddi5Xgvfc6/iVmvktX6UV+Hacr1figdNsBcM8mF/PzQ3P+lnr5g2iW3GvFOC1KndwA==
Date: Wed, 21 Feb 2018 22:57:20 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: use down_read_killable in
 proc_pid_cmdline_read()
Message-ID: <20180221195720.GA639@avx2>
References: <1519156169-11883-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180220223825.GA6705@avx2>
 <fa1e9b6b-efaf-79c5-00ea-1f58d5078c2d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1e9b6b-efaf-79c5-00ea-1f58d5078c2d@linux.alibaba.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 03:38:24PM -0800, Yang Shi wrote:
> 
> 
> On 2/20/18 2:38 PM, Alexey Dobriyan wrote:
> > On Wed, Feb 21, 2018 at 03:49:29AM +0800, Yang Shi wrote:
> >> When running vm-scalability with large memory (> 300GB), the below hung
> >> task issue happens occasionally.
> >>
> >> INFO: task ps:14018 blocked for more than 120 seconds.
> >>         Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
> >>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>   ps              D    0 14018      1 0x00000004
> >>    ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
> >>    ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
> >>    00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
> >>   Call Trace:
> >>    [<ffffffff817154d0>] ? __schedule+0x250/0x730
> >>    [<ffffffff817159e6>] schedule+0x36/0x80
> >>    [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
> >>    [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
> >>    [<ffffffff81717db0>] down_read+0x20/0x40
> >>    [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
> >>    [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
> >>    [<ffffffff81241d87>] __vfs_read+0x37/0x150
> >>    [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
> >>    [<ffffffff81242266>] vfs_read+0x96/0x130
> >>    [<ffffffff812437b5>] SyS_read+0x55/0xc0
> >>    [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
> >>
> >> When manipulating a large mapping, the process may hold the mmap_sem for
> >> long time, so reading /proc/<pid>/cmdline may be blocked in
> >> uninterruptible state for long time.
> >>
> >> down_read_trylock() sounds too aggressive, and we already have killable
> >> version APIs for semaphore, here use down_read_killable() to improve the
> >> responsiveness.
> >> -	down_read(&mm->mmap_sem);
> >> +	rv = down_read_killable(&mm->mmap_sem);
> >> +	if (rv)
> >> +		goto out_mmput;
> >>   	arg_start = mm->arg_start;
> >>   	arg_end = mm->arg_end;
> >>   	env_start = mm->env_start;
> > Fix is incomplete
> 
> Yes, it is. Since I just ran into the above splat, so I just did the 
> minimum change.
> 
> > 1) /proc/*/cmdline only wants to read 4 values atomically,
> >     those 4 values are basically random values and aren't
> >     related to VM part at all (after C/R went in, they are
> >     settable to arbitrary values)
> 
> Sorry, I don't get your point here. Could you please elaborate?

I hoped there is some random spinlock those 4 values could be moved to
but no.

> > 2) access_remote_vm() et al will do the same ->mmap_sem, and
> 
> Yes, it does. But, __access_remote_vm() is called by access_process_vm() 
> too, which is used by much more places, i.e. ptrace, so I was not sure 
> if it is preferred to convert to killable version. So, I leave it untouched.

Yeah, but ->mmap_sem is taken 3 times per /proc/*/cmdline read
and your scalability tests should trigger next backtrace right away.

> > 3) /proc/*/environ and get_cmdline() do the same.
> 
> They look suitable to use killable version.
> 
> BTW, I just realized the code should go to out_free_page instead of 
> out_mmput. Will rectify in newer version once we decide the extra places 
> to use killable version.
