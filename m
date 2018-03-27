Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeC0SBY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:01:24 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:16262 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeC0SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:01:21 -0400
Subject: Re: [ANNOUNCE] v4.14.29-rt25
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
Date: Tue, 27 Mar 2018 13:01:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 03/25/2018 05:12 AM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.14.29-rt25 patch set.
> 
> Changes since v4.14.29-rt24:
> 
>    - There are checks for disabled interrupts in the target code which do
>      not work on RT. Reported by Arnaldo Carvalho de Melo.
> 
> Known issues
>       - A warning triggered in "rcu_note_context_switch" originated from
>         SyS_timer_gettime(). The issue was always there, it is now
>         visible. Reported by Grygorii Strashko and Daniel Wagner.
> 
> The delta patch against v4.14.29-rt24 is appended below and can be found here:
>   
>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.29-rt24-rt25.patch.xz
> 
> You can get this release via the git tree at:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.29-rt25
> 
> The RT patch against v4.14.29 can be found here:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.29-rt25.patch.xz
> 
> The split quilt queue is available at:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.29-rt25.tar.xz
> 
> Sebastian
> 

I've took this RT version and applied "[RT] kernel/time/posix-timer: avoid schedule()
while holding the RCU lock" [1] on top. Then I run below tests:

##  stress-ng --class os --all 0 -t 5m
- and -
## stress-ng --class cpu --all 0 -t 5m &   stress-ng --class memory --all 0 --vm-bytes 90% -t 5m

no stall or crashes were observed, but I've caught two "rcu_note_context_switch()" warnings

[1] https://patchwork.kernel.org/patch/10305015/

==== WARN1 ====
[  104.967174] ------------[ cut here ]------------
[  104.967191] WARNING: CPU: 0 PID: 1676 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x2e0/0x5f4
stress-ng: error: [913] stress-ng-fifo: read timeout!
stress-ng: error: [924] stress-ng-fifo: read timeout!
[  104.967194] Modules linked in:
[  104.967206] CPU: 0 PID: 1676 Comm: stress-ng-fstat Not tainted 4.14.29-rt25-01568-g2ba67d4-dirty #269
stress-ng: error: [926] stress-ng-fifo: read timeout!
stress-ng: error: [920] stress-ng-fifo: read timeout!
[  104.967210] Hardware name: Generic DRA74X (Flattened Device Tree)
[  104.967227] [<c011143c>] (unwind_backtrace) from [<c010cb40>] (show_stack+0x10/0x14)
[  104.967239] [<c010cb40>] (show_stack) from [<c0828c10>] (dump_stack+0x98/0xc4)
[  104.967251] [<c0828c10>] (dump_stack) from [<c012eee0>] (__warn+0xe8/0x100)
[  104.967261] [<c012eee0>] (__warn) from [<c012efa8>] (warn_slowpath_null+0x20/0x28)
[  104.967271] [<c012efa8>] (warn_slowpath_null) from [<c01aa470>] (rcu_note_context_switch+0x2e0/0x5f4)
stress-ng: fail:  [828] stress-ng-af-alg: socket failed, errno=9[  104.967285] [<c01aa470>] (rcu_note_context_switch) from [<c083e2fc>] (__schedule+0xdc/0x814)
7 (Address family not supported by protocol)
[  104.967294] [<c083e2fc>] (__schedule) from [<c083ea8c>] (schedule+0x58/0xf0)
[  104.967302] [<c083ea8c>] (schedule) from [<c0840604>] (rt_spin_lock_slowlock_locked+0xbc/0x2f4)
stress-ng: fail:  [1484] stress-ng-quota: quotactl command Q_GETQUOTA failed: errno=38 (Function not implemented)
stress-ng: fail:  [1484] stress-ng-quota: quotactl command Q_GETFMT failed: errno=38 (Function not implemented)
stress-ng: fail:  [1484] stress-ng-quota: quotactl command Q_GETINFO failed: errno=38 (Function not implemented)
stress-ng: fail:  [1484] stress-ng-quota: quotactl command Q_SYNC failed: errno=38 (Function not implemented)
stress-ng: error: [1484] stress-ng-quota: quotactl() failed, not available on this kernel
[  104.967311] [<c0840604>] (rt_spin_lock_slowlock_locked) from [<c08412b4>] (__read_rt_lock+0x84/0xc0)
[  104.967320] [<c08412b4>] (__read_rt_lock) from [<c0130918>] (pin_current_cpu+0x40/0x11c)
[  104.967329] [<c0130918>] (pin_current_cpu) from [<c015a5d8>] (migrate_disable+0x78/0x1e4)
[  104.967339] [<c015a5d8>] (migrate_disable) from [<c0842338>] (rt_spin_lock+0x18/0x60)
[  104.967349] [<c0842338>] (rt_spin_lock) from [<c0440994>] (lockref_get_not_dead+0xc/0x34)
[  104.967360] [<c0440994>] (lockref_get_not_dead) from [<c0273fb8>] (legitimize_path+0x2c/0x64)
[  104.967368] [<c0273fb8>] (legitimize_path) from [<c02740e4>] (unlazy_walk+0x3c/0x18c)
[  104.967376] [<c02740e4>] (unlazy_walk) from [<c0274258>] (complete_walk+0x24/0x78)
[  104.967384] [<c0274258>] (complete_walk) from [<c02768b8>] (path_lookupat+0xbc/0x1ec)
[  104.967393] [<c02768b8>] (path_lookupat) from [<c0278f98>] (filename_lookup+0x8c/0xe8)
[  104.967404] [<c0278f98>] (filename_lookup) from [<c026e1ac>] (vfs_statx+0x5c/0xb8)
[  104.967414] [<c026e1ac>] (vfs_statx) from [<c026e8ec>] (SyS_stat64+0x28/0x44)
[  104.967424] [<c026e8ec>] (SyS_stat64) from [<c0108480>] (ret_fast_syscall+0x0/0x28)
[  104.967429] ---[ end trace 0000000000000002 ]---


=== WARN2 ====
[  196.437276] ------------[ cut here ]------------
[  196.437293] WARNING: CPU: 0 PID: 1521 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x2e0/0x5f4
[  196.437296] Modules linked in:
[  196.437307] CPU: 0 PID: 1521 Comm: stress-ng-opcod Not tainted 4.14.29-rt25-01568-g2ba67d4-dirty #269
[  196.437311] Hardware name: Generic DRA74X (Flattened Device Tree)
[  196.437326] [<c011143c>] (unwind_backtrace) from [<c010cb40>] (show_stack+0x10/0x14)
[  196.437338] [<c010cb40>] (show_stack) from [<c0828c10>] (dump_stack+0x98/0xc4)
[  196.437349] [<c0828c10>] (dump_stack) from [<c012eee0>] (__warn+0xe8/0x100)
[  196.437359] [<c012eee0>] (__warn) from [<c012efa8>] (warn_slowpath_null+0x20/0x28)
[  196.437369] [<c012efa8>] (warn_slowpath_null) from [<c01aa470>] (rcu_note_context_switch+0x2e0/0x5f4)
[  196.437381] [<c01aa470>] (rcu_note_context_switch) from [<c083e2fc>] (__schedule+0xdc/0x814)
[  196.437390] [<c083e2fc>] (__schedule) from [<c083ea8c>] (schedule+0x58/0xf0)
[  196.437398] [<c083ea8c>] (schedule) from [<c0840604>] (rt_spin_lock_slowlock_locked+0xbc/0x2f4)
[  196.437407] [<c0840604>] (rt_spin_lock_slowlock_locked) from [<c08412b4>] (__read_rt_lock+0x84/0xc0)
[  196.437416] [<c08412b4>] (__read_rt_lock) from [<c0130918>] (pin_current_cpu+0x40/0x11c)
[  196.437424] [<c0130918>] (pin_current_cpu) from [<c015a5d8>] (migrate_disable+0x78/0x1e4)
[  196.437433] [<c015a5d8>] (migrate_disable) from [<c011a3a4>] (kmap_atomic+0x34/0x174)
[  196.437443] [<c011a3a4>] (kmap_atomic) from [<c0236484>] (alloc_set_pte+0x288/0x320)
[  196.437453] [<c0236484>] (alloc_set_pte) from [<c01ffcb8>] (filemap_map_pages+0x2b0/0x4c8)
[  196.437461] [<c01ffcb8>] (filemap_map_pages) from [<c0236c4c>] (handle_mm_fault+0x690/0xc78)
[  196.437468] [<c0236c4c>] (handle_mm_fault) from [<c0115bd8>] (do_page_fault+0x2bc/0x398)
[  196.437476] [<c0115bd8>] (do_page_fault) from [<c0101474>] (do_PrefetchAbort+0x38/0xa0)
[  196.437484] [<c0101474>] (do_PrefetchAbort) from [<c010decc>] (ret_from_exception+0x0/0x14)
[  196.437488] Exception stack(0xe9943fb0 to 0xe9943ff8)
[  196.437494] 3fa0:                                     00000000 00000000 00000000 00000000
[  196.437502] 3fc0: b6f6e468 bee42888 b6f6e400 bee42898 b6f6e8c0 00000000 000003af 000003af
[  196.437508] 3fe0: 00000078 bee42888 b6d9ac91 b6d9ac90 200b0030 ffffffff
[  196.437513] ---[ end trace 0000000000000002 ]---


-- 
regards,
-grygorii
