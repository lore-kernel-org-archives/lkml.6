Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0FC282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A042084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBCBVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:21:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:26983 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfBCBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:21:46 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x131LEju064592;
        Sun, 3 Feb 2019 10:21:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sun, 03 Feb 2019 10:21:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x131L8dA064535
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 3 Feb 2019 10:21:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: linux-next: tracebacks in workqueue.c/__flush_work()
To:     Guenter Roeck <linux@roeck-us.net>,
        Chris Metcalf <chris.d.metcalf@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>
References: <18a30387-6aa5-6123-e67c-57579ecc3f38@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <72e7d782-85f2-b499-8614-9e3498106569@i-love.sakura.ne.jp>
Date:   Sun, 3 Feb 2019 10:21:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <18a30387-6aa5-6123-e67c-57579ecc3f38@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Chris Metcalf and Rusty Russell.)

If NR_CPUS == 1 due to CONFIG_SMP=n, for_each_cpu(cpu, &has_work) loop does not
evaluate "struct cpumask has_work" modified by cpumask_set_cpu(cpu, &has_work) at
previous for_each_online_cpu() loop. Guenter Roeck found a problem among three
commits listed below.

  Commit 5fbc461636c32efd ("mm: make lru_add_drain_all() selective")
  expects that has_work is evaluated by for_each_cpu().

  Commit 2d3854a37e8b767a ("cpumask: introduce new API, without changing anything")
  assumes that for_each_cpu() does not need to evaluate has_work.

  Commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without INIT_WORK().")
  expects that has_work is evaluated by for_each_cpu().

What should we do? Do we explicitly evaluate has_mask if NR_CPUS == 1 ?

 mm/swap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4929bc1..5f07734 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -698,7 +698,8 @@ void lru_add_drain_all(void)
 	}
 
 	for_each_cpu(cpu, &has_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		if (NR_CPUS > 1 || cpumask_test_cpu(cpu, &has_work))
+			flush_work(&per_cpu(lru_add_drain_work, cpu));
 
 	mutex_unlock(&lock);
 }

On 2019/02/03 7:20, Guenter Roeck wrote:
> Commit "workqueue: Try to catch flush_work() without INIT_WORK()" added
> a warning if flush_work() is called without worker function.
> 
> This results in the following tracebacks, typically observed during
> system shutdown.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 101 at kernel/workqueue.c:3018 __flush_work+0x2a4/0x2e0
> Modules linked in:
> CPU: 0 PID: 101 Comm: umount Not tainted 5.0.0-rc4-next-20190201 #1
>        fffffc0007dcbd18 0000000000000000 fffffc00003338a0 fffffc00003517d4
>        fffffc00003517d4 fffffc0000e56c98 fffffc0000e56c98 fffffc0000ebc1d8
>        fffffc0000ec0bd8 ffffffffa8024010 0000000000000bca 0000000000000000
>        fffffc00003d3ea4 fffffc0000e56c98 fffffc0000e56c60 fffffc0000ebc1d8
>        fffffc0000ec0bd8 0000000000000000 0000000000000001 0000000000000000
>        fffffc000782d520 0000000000000000 fffffc000044ef50 fffffc0007c4b540
> Trace:
> [<fffffc00003338a0>] __warn+0x160/0x190
> [<fffffc00003517d4>] __flush_work+0x2a4/0x2e0
> [<fffffc00003517d4>] __flush_work+0x2a4/0x2e0
> [<fffffc00003d3ea4>] lru_add_drain_all+0xe4/0x190
> [<fffffc000044ef50>] shrink_dcache_sb+0x70/0xb0
> [<fffffc0000478dc4>] invalidate_bh_lru+0x44/0x80
> [<fffffc00003a94fc>] on_each_cpu_cond+0x5c/0x90
> [<fffffc0000478d80>] invalidate_bh_lru+0x0/0x80
> [<fffffc000047fe7c>] invalidate_bdev+0x3c/0x70
> [<fffffc0000432ca8>] reconfigure_super+0x178/0x2c0
> [<fffffc000045ee64>] ksys_umount+0x664/0x680
> [<fffffc000045ee9c>] sys_umount+0x1c/0x30
> [<fffffc00003115d4>] entSys+0xa4/0xc0
> [<fffffc00003115d4>] entSys+0xa4/0xc0
> 
> ---[ end trace 613cea34708701f1 ]---
> 
> The problem is seen with several (but not all) architectures. Affected
> architectures/platforms are:
>     alpha
>     arm:versatilepb
>     m68k
>     mips, mips64 (boot from IDE drive or MMC, SMP disabled)
>     parisc (nosmp builds)
>     sparc, sparc64 (nosmp builds)
> 
> There may be others; several of my tests fail with build failures.
> 
> If/when it is seen, the problem is persistent.
> 
> Common denominator seems to be that SMP is disabled. It does appear that
> for_each_cpu() ignores the mask for nosmp builds, but I don't really
> understand why.
> 
> Guenter
> 

