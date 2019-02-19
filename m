Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209F2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBSMiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:38:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:38:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B24828667B;
        Tue, 19 Feb 2019 12:37:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C493610F8;
        Tue, 19 Feb 2019 12:37:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 19 Feb 2019 13:37:59 +0100 (CET)
Date:   Tue, 19 Feb 2019 13:37:57 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20190219123756.GA9210@redhat.com>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20190218193734.GA29983@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218193734.GA29983@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 12:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18, Guenter Roeck wrote:
>
> Unfortunately, this patch causes one of my qemu emulations to crash.
> The crash is not always seen, but at least with every other boot attempt.

Hmm. I can't imagine how this change can cause the null-ptr-deref in
blk_mq_run_hw_queue().

> Reverting the patch fixes the problem. Crash log and bisect results
> are attached below.

Do you mean that you applied the "revert" patch on top of linux-next ?

Or did you rely on git-bisect ?

> [   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
> [   10.681826] Faulting instruction address: 0xc0431480
> [   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
> [   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
> [   10.682387] Modules linked in:
> [   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
> [   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
> [   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
> [   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
> [   10.683236] DEAR: 00000040 ESR: 00000000 
> [   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000 
> [   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000 
> [   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000 
> [   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800 
> [   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
> [   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
> [   10.684602] Call Trace:
> [   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
> [   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
> [   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
> [   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
> [   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
> [   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
> [   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
> [   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
> [   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
> [   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
> [   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
> [   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
> [   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
> [   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
> [   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
> [   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
> [   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114

looks unrelated...

Oleg.

