Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeCFUpm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:45:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCFUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:45:41 -0500
Date: Tue, 6 Mar 2018 12:45:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: mingo@kernel.org, adobriyan@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 0/4 v2] Define killable version for
 access_remote_vm() and use it in fs/proc
Message-Id: <20180306124540.d8b5f6da97ab69a49566f950@linux-foundation.org>
In-Reply-To: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 08:25:47 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> 
> Background:
> When running vm-scalability with large memory (> 300GB), the below hung
> task issue happens occasionally.
> 
> INFO: task ps:14018 blocked for more than 120 seconds.
>        Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  ps              D    0 14018      1 0x00000004
>   ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>   ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>   00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>  Call Trace:
>   [<ffffffff817154d0>] ? __schedule+0x250/0x730
>   [<ffffffff817159e6>] schedule+0x36/0x80
>   [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>   [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>   [<ffffffff81717db0>] down_read+0x20/0x40
>   [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>   [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>   [<ffffffff81241d87>] __vfs_read+0x37/0x150
>   [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>   [<ffffffff81242266>] vfs_read+0x96/0x130
>   [<ffffffff812437b5>] SyS_read+0x55/0xc0
>   [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
> 
> When manipulating a large mapping, the process may hold the mmap_sem for
> long time, so reading /proc/<pid>/cmdline may be blocked in
> uninterruptible state for long time.
> We already have killable version APIs for semaphore, here use down_read_killable()
> to improve the responsiveness.
> 

Maybe I'm missing something, but I don't see how this solves the
problem.  Yes, the read of /proc/pid/cmdline will be abandoned if
someone interrupts that process.  But if nobody does that, the read
will still just sit there for 2 minutes and the watchdog warning will
still come out?

Where the heck are we holding mmap_sem for so long?  Can that be fixed?
