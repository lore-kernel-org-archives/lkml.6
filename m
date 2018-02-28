Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeB1KXm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:23:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:51092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbeB1KXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:23:38 -0500
Date: Wed, 28 Feb 2018 11:23:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: kernel test robot <shun.hao@intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [printk]  c162d5b433: BUG:KASAN:use-after-scope_in_c
Message-ID: <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224053405.ksymb5yurtpwmfs6@shao2-debian>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-02-24 13:34:05, kernel test robot wrote:
> TO: Petr Mladek <pmladek@suse.com>
> CC: Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt (VMware) <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org, lkp@01.org
> 
> 
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: c162d5b4338d72deed61aa65ed0f2f4ba2bbc8ab ("printk: Hide console waiter logic into helpers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 1G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------+------------+------------+
> |                                | dbdda842fe | c162d5b433 |
> +--------------------------------+------------+------------+
> | boot_successes                 | 0          | 0          |
> | boot_failures                  | 18         | 16         |
> | BUG:KASAN:use-after-scope_in_p | 18         |            |
> | BUG:KASAN:use-after-scope_in_c | 0          | 16         |
> +--------------------------------+------------+------------+
> 
> 
> 
> [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
> [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960

Is there any change to get disassembly of console_unlock() from the
problematic build?

I have troubles to reproduce this myself. Also I was not able to find any
bug just by looking into the code yet. The disassembly might help
a lot here.


Interesting symptoms (for myself and other debuggers):

The lines are duplicated. Therefore it happened when real
console was registered and before the early console was unregistered.
See also the full dmesg for these actions. The related printk messages
are right after the KASAN report.

I wonder if it is unsafe to pass the console_lock via
console_trylock_spinnning() from console_unlock() called
in register_console(). I do not see any problem but I might
be blind.

Another interesting thing is that the entire KASAN report is
duplicated. I wonder if it is a two level duplication or
if the BUG() was really triggered twice.

> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email

Also the job-script was not attached. Is it because the problem
happened already during the boot?

Thanks for the report.

Best Regards,
Petr
