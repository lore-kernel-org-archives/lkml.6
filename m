Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A4C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA62174E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA62174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGGOJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:09:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62277 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeGGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:09:13 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w67E9B2h045938;
        Sat, 7 Jul 2018 23:09:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 07 Jul 2018 23:09:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w67E9B6r045935
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 7 Jul 2018 23:09:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] locking/lockdep: Dump state of percpu_rwsem upon hung up.
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <465c2661-4207-8c92-f190-4271c9845afb@i-love.sakura.ne.jp>
Date:   Sat, 7 Jul 2018 23:09:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <201807071750.mmO8ZiJo%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thanks for doing build test, but I don't understand what is wrong.
As far as I can see, "struct percpu_rw_semaphore" contains "struct rw_semaphore"
and "struct rw_semaphore" contains "atomic_long_t count".
Then, why trying to read using atomic_long_read(&sem->rw_sem.count) causes

  note: expected 'const atomic_long_t * {aka const struct <anonymous> *}' but argument is of type '__s32 * {aka int *}'

warning? Is mips using different type?

struct percpu_rw_semaphore {
        struct rcu_sync         rss;
        unsigned int __percpu   *read_count;
        struct rw_semaphore     rw_sem; /* slowpath */
        struct rcuwait          writer; /* blocked writer */
        int                     readers_block;
};

/* All arch specific implementations share the same struct */
struct rw_semaphore {
        atomic_long_t count;
        struct list_head wait_list;
        raw_spinlock_t wait_lock;
#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
        struct optimistic_spin_queue osq; /* spinner MCS lock */
        /*
         * Write owner. Used as a speculative check to see
         * if the owner is running on the cpu.
         */
        struct task_struct *owner;
#endif
#ifdef CONFIG_DEBUG_LOCK_ALLOC
        struct lockdep_map      dep_map;
#endif
};

On 2018/07/07 20:31, kbuild test robot wrote:
> Hi Tetsuo,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20180706]
> [also build test ERROR on v4.18-rc3]
> [cannot apply to tip/auto-latest tip/sched/core linus/master v4.18-rc3 v4.18-rc2 v4.18-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tetsuo-Handa/locking-lockdep-Dump-state-of-percpu_rwsem-upon-hung-up/20180707-143406
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:14:0,
>                     from include/asm-generic/bug.h:18,
>                     from arch/mips/include/asm/bug.h:42,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:9,
>                     from kernel/hung_task.c:8:
>    kernel/hung_task.c: In function 'dump_percpu_rwsem_state':
>>> kernel/hung_task.c:95:20: error: passing argument 1 of 'atomic_long_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
>       atomic_long_read(&sem->rw_sem.count));
>                        ^
>    include/linux/printk.h:311:34: note: in definition of macro 'pr_info'
>      printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>                                      ^~~~~~~~~~~
>    In file included from include/linux/atomic.h:1309:0,
>                     from arch/mips/include/asm/processor.h:14,
>                     from arch/mips/include/asm/thread_info.h:16,
>                     from include/linux/thread_info.h:38,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/mips/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:81,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from kernel/hung_task.c:8:
>    include/asm-generic/atomic-long.h:41:20: note: expected 'const atomic_long_t * {aka const struct <anonymous> *}' but argument is of type '__s32 * {aka int *}'
>     static inline long atomic_long_read##mo(const atomic_long_t *l)  \
>                        ^
>>> include/asm-generic/atomic-long.h:47:1: note: in expansion of macro 'ATOMIC_LONG_READ_OP'
>     ATOMIC_LONG_READ_OP()
>     ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

