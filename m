Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCOKsa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:48:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45786 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeCOKs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:48:28 -0400
Subject: Re: [PATCH] percpu: Allow to kill tasks doing pcpu_alloc() and
 waiting for pcpu_balance_workfn()
To: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180314220909.GE2943022@devbig577.frc2.facebook.com>
 <20180314152203.c06fce436d221d34d3e4cf4a@linux-foundation.org>
 <c5c1c98b-9e0c-ec09-36c6-4266ad239ef1@virtuozzo.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5a4a1aae-8c61-de28-d3cd-2f8f4355f050@i-love.sakura.ne.jp>
Date: Thu, 15 Mar 2018 19:48:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5c1c98b-9e0c-ec09-36c6-4266ad239ef1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/03/15 17:58, Kirill Tkhai wrote:
> On 15.03.2018 01:22, Andrew Morton wrote:
>> On Wed, 14 Mar 2018 15:09:09 -0700 Tejun Heo <tj@kernel.org> wrote:
>>
>>> Hello, Andrew.
>>>
>>> On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
>>>> It would benefit from a comment explaining why we're doing this (it's
>>>> for the oom-killer).
>>>
>>> Will add.
>>>
>>>> My memory is weak and our documentation is awful.  What does
>>>> mutex_lock_killable() actually do and how does it differ from
>>>> mutex_lock_interruptible()?  Userspace tasks can run pcpu_alloc() and I
>>>
>>> IIRC, killable listens only to SIGKILL.

I think that killable listens to any signal which results in termination of
that process. For example, if a process is configured to terminate upon SIGINT,
fatal_signal_pending() becomes true upon SIGINT.

>>>
>>>> wonder if there's any way in which a userspace-delivered signal can
>>>> disrupt another userspace task's memory allocation attempt?
>>>
>>> Hmm... maybe.  Just honoring SIGKILL *should* be fine but the alloc
>>> failure paths might be broken, so there are some risks.  Given that
>>> the cases where userspace tasks end up allocation percpu memory is
>>> pretty limited and/or priviledged (like mount, bpf), I don't think the
>>> risks are high tho.
>>
>> hm.  spose so.  Maybe.  Are there other ways?  I assume the time is
>> being spent in pcpu_create_chunk()?  We could drop the mutex while
>> running that stuff and take the appropriate did-we-race-with-someone
>> testing after retaking it.  Or similar.
>
> The balance work spends its time in pcpu_populate_chunk(). There are
> two stacks of this problem:

Will you show me more contexts? Unless CONFIG_MMU=n kernels, the OOM reaper
reclaims memory from the OOM victim. Therefore, "If tasks doing pcpu_alloc()
are choosen by OOM killer, they can't exit, because they are waiting for the
mutex." should not cause problems. Of course, giving up upon SIGKILL is nice
regardless.

>
> [  106.313267] kworker/2:2     D13832   936      2 0x80000000
> [  106.313740] Workqueue: events pcpu_balance_workfn
> [  106.314109] Call Trace:
> [  106.314293]  ? __schedule+0x267/0x750
> [  106.314570]  schedule+0x2d/0x90
> [  106.314803]  schedule_timeout+0x17f/0x390
> [  106.315106]  ? __next_timer_interrupt+0xc0/0xc0
> [  106.315429]  __alloc_pages_slowpath+0xb73/0xd90
> [  106.315792]  __alloc_pages_nodemask+0x16a/0x210
> [  106.316148]  pcpu_populate_chunk+0xce/0x300
> [  106.316479]  pcpu_balance_workfn+0x3f3/0x580
> [  106.316853]  ? _raw_spin_unlock_irq+0xe/0x30
> [  106.317227]  ? finish_task_switch+0x8d/0x250
> [  106.317632]  process_one_work+0x1b7/0x410
> [  106.317970]  worker_thread+0x26/0x3d0
> [  106.318304]  ? process_one_work+0x410/0x410
> [  106.318649]  kthread+0x10e/0x130
> [  106.318916]  ? __kthread_create_worker+0x120/0x120
> [  106.319360]  ret_from_fork+0x35/0x40
>
> [  106.453375] a.out           D13400  3670      1 0x00100004
> [  106.453880] Call Trace:
> [  106.454114]  ? __schedule+0x267/0x750
> [  106.454427]  schedule+0x2d/0x90
> [  106.454829]  schedule_preempt_disabled+0xf/0x20
> [  106.455422]  __mutex_lock.isra.2+0x181/0x4d0
> [  106.455988]  ? pcpu_alloc+0x3c4/0x670
> [  106.456465]  pcpu_alloc+0x3c4/0x670
> [  106.456973]  ? preempt_count_add+0x63/0x90
> [  106.457401]  ? __local_bh_enable_ip+0x2e/0x60
> [  106.457882]  ipv6_add_dev+0x121/0x490
> [  106.458330]  addrconf_notify+0x27b/0x9a0
> [  106.458823]  ? inetdev_init+0xd7/0x150
> [  106.459270]  ? inetdev_event+0x339/0x4b0
> [  106.459738]  ? preempt_count_add+0x63/0x90
> [  106.460243]  ? _raw_spin_lock_irq+0xf/0x30
> [  106.460747]  ? notifier_call_chain+0x42/0x60
> [  106.461271]  notifier_call_chain+0x42/0x60
> [  106.461819]  register_netdevice+0x415/0x530
> [  106.462364]  register_netdev+0x11/0x20
> [  106.462849]  loopback_net_init+0x43/0x90
> [  106.463216]  ops_init+0x3b/0x100
> [  106.463516]  setup_net+0x7d/0x150
> [  106.463831]  copy_net_ns+0x14b/0x180
> [  106.464134]  create_new_namespaces+0x117/0x1b0
> [  106.464481]  unshare_nsproxy_namespaces+0x5b/0x90
> [  106.464864]  SyS_unshare+0x1b0/0x300
>
> [  106.536845] Kernel panic - not syncing: Out of memory and no killable processes...

These two stacks of this problem are not blocked at mutex_lock().

Why all OOM-killable threads were killed? There were only few?
Does pcpu_alloc() allocate so much enough to deplete memory reserves?
