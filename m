Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4936FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E121480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8E121480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeIXQwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:52:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeIXQwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A1180D;
        Mon, 24 Sep 2018 03:51:12 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 739C83F5B3;
        Mon, 24 Sep 2018 03:51:12 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 742B41AE3117; Mon, 24 Sep 2018 11:51:33 +0100 (BST)
Date:   Mon, 24 Sep 2018 11:51:33 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Traceback in ww_mutex test (test_cycle_work) on arm64/x86_64
Message-ID: <20180924105133.GA12461@arm.com>
References: <20180923195706.GA1538@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923195706.GA1538@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sun, Sep 23, 2018 at 12:57:06PM -0700, Guenter Roeck wrote:
> when enabling CONFIG_WW_MUTEX_SELFTEST on arm64 or x86_64,
> I get the following traceback.
> 
> [    3.111852] ------------[ cut here ]------------
> [    3.112100] DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
> [    3.112753] WARNING: CPU: 1 PID: 771 at kernel/locking/mutex.c:1211 __mutex_unlock_slowpath+0x1a8/0x2e0
> [    3.113238] Modules linked in:
> [    3.113774] CPU: 1 PID: 771 Comm: kworker/u16:8 Not tainted 4.19.0-rc5-dirty #1
> [    3.114025] Hardware name: linux,dummy-virt (DT)
> [    3.114587] Workqueue: test-ww_mutex test_cycle_work
> [    3.114950] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    3.115144] pc : __mutex_unlock_slowpath+0x1a8/0x2e0
> [    3.115327] lr : __mutex_unlock_slowpath+0x1a8/0x2e0
> [    3.115500] sp : ffff00000b7cbc40
> [    3.115647] x29: ffff00000b7cbc40 x28: 0000000000000000 
> [    3.115921] x27: ffff00000942f000 x26: ffff00000a204da0 
> [    3.116155] x25: ffff00000a1c93d0 x24: ffff000009103cd8 
> [    3.116376] x23: ffff00000a1c9000 x22: ffff00000942f000 
> [    3.116596] x21: ffff00000b7cbca8 x20: ffff80001c05f8c8 
> [    3.116817] x19: 0000000000000000 x18: ffffffffffffffff 
> [    3.117036] x17: 0000000000000000 x16: 0000000000000000 
> [    3.117256] x15: ffff00000942f808 x14: ffff00008a1c8bb7 
> [    3.117476] x13: ffff00000a1c8bc5 x12: ffff00000944f000 
> [    3.117695] x11: 0000000005f5e0ff x10: ffff0000094b3000 
> [    3.117947] x9 : 0000000000000000 x8 : ffff00000942f808 
> [    3.118172] x7 : ffff00000816153c x6 : 0000000000000000 
> [    3.118392] x5 : 0000000000000000 x4 : ffff00000b7cc000 
> [    3.118612] x3 : 6172e063a21fe200 x2 : ffff00000944fd80 
> [    3.118830] x1 : 6172e063a21fe200 x0 : 0000000000000000 
> [    3.119169] Call trace:
> [    3.119348]  __mutex_unlock_slowpath+0x1a8/0x2e0
> [    3.119540]  ww_mutex_unlock+0x48/0xa0
> [    3.119709]  test_cycle_work+0x10c/0x220
> [    3.119864]  process_one_work+0x29c/0x708
> [    3.120016]  worker_thread+0x40/0x458
> [    3.120179]  kthread+0x12c/0x130
> [    3.120317]  ret_from_fork+0x10/0x18

Fun: I can reproduce this all the way back to 4.11, when the selftests
were merged!

> Debugging shows that the traceback occurs in the following code
> in test_cycle_work().
> 
> +       err = ww_mutex_lock(cycle->b_mutex, &ctx);
> +       if (err == -EDEADLK) {
> 				# true
> +               ww_mutex_unlock(&cycle->a_mutex);
> +               ww_mutex_lock_slow(cycle->b_mutex, &ctx);
> +               err = ww_mutex_lock(&cycle->a_mutex, &ctx);
> 				# returns with err == -EDEADLK
> +       }
> +
> +       if (!err)
> +               ww_mutex_unlock(cycle->b_mutex);
> +       ww_mutex_unlock(&cycle->a_mutex);
> 				# traceback seen here:
> 				# unlocks a_mutex even though it was not
> 				# acquired by this thread
> 
> Details don't really matter as long as the number of CPUs is at least 8
> (I have not seen the problem with 1, 2, 4, or 6 CPUs). My test system
> has 8 CPU cores (times 2 for hyperthreading), so that may be related.
> 
> The test case above is clearly wrong if both calls to ww_mutex_lock()
> fail with -EDEADLK. Unfortunately I don't know the expected behavior
> in this case, so I'll have to pass this on without a proposed fix.

Yeah, I think the test code isn't robust in the face of
CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which can spuriously return -EDEADLK
from mutex_lock(). It looks like it's assuming that err will always be
reset to 0 when it takes a_mutex the second time. Chris?

Will
