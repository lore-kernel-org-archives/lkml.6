Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCLNq3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:46:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751695AbeCLNq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:46:27 -0400
Date: Mon, 12 Mar 2018 13:46:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: kernel test robot <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infraded.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>,
        lkp@01.org
Subject: Re: 94d3a25408: kernel_BUG_at_kernel/fork.c
Message-ID: <20180312134621.xao4map7gw3ts6nv@lakrids.cambridge.arm.com>
References: <20180228121458.2230-1-mark.rutland@arm.com>
 <20180309211139.24vegrzjmiptdqp5@inn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309211139.24vegrzjmiptdqp5@inn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 05:11:39AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 94d3a254089a7cd4f11b7071b4323afd98eea0a6 ("Detect early free of a live mm")
> url: https://github.com/0day-ci/linux/commits/Mark-Rutland/Detect-early-free-of-a-live-mm/20180303-144149

> [   47.208935] kernel BUG at kernel/fork.c:599!
> [   47.210365] invalid opcode: 0000 [#1] SMP PTI
> [   47.211336] Modules linked in:
> [   47.212145] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc3-00001-g94d3a25 #1
> [   47.213966] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   47.215869] RIP: 0010:__mmdrop+0x136/0x170
> [   47.216866] RSP: 0018:ffffffff82803dd8 EFLAGS: 00010293
> [   47.218160] RAX: ffffffff82818500 RBX: ffff880115770000 RCX: ffffffff810ae876
> [   47.219758] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff880115770000
> [   47.221306] RBP: ffffffff82803e00 R08: 0000000000000001 R09: 0000000000000000
> [   47.223268] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82818500
> [   47.224961] R13: ffffffff82a8ce20 R14: ffff88013ff534c0 R15: 00000000000003e7
> [   47.226716] FS:  0000000000000000(0000) GS:ffff88013b200000(0000) knlGS:0000000000000000
> [   47.228550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   47.229884] CR2: 00007fbfc2cc0190 CR3: 0000000002812000 CR4: 00000000000006f0
> [   47.231580] Call Trace:
> [   47.232144]  idle_task_exit+0x53/0x60

Luckily this is a spurious warning. In idle_task_exit(), we switch to
the init_mm, but leave active_mm stale before calling mmdrop().

In addition to the WARN_ON[_ONCE] changes, I'll drop the following in:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7c535eee0a6..0ef844abc2da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5506,6 +5506,7 @@ void idle_task_exit(void)
 
        if (mm != &init_mm) {
                switch_mm(mm, &init_mm, current);
+               current->active_mm = &init_mm;
                finish_arch_post_lock_switch();
        }
        mmdrop(mm);

Thanks,
Mark.
