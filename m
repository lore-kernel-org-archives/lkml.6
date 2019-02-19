Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8025621773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfBSRbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:31:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSRbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:31:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C488BEBD;
        Tue, 19 Feb 2019 09:31:14 -0800 (PST)
Received: from [10.37.8.220] (unknown [10.37.8.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69C13F720;
        Tue, 19 Feb 2019 09:31:12 -0800 (PST)
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave P Martin <dave.martin@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Subject: xen/evtchn and forced threaded irq
Message-ID: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
Date:   Tue, 19 Feb 2019 17:31:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been looking at using Linux RT in Dom0. Once the guest is started,
the console is ending to have a lot of warning (see trace below).

After some investigation, this is because the irq handler will now be threaded.
I can reproduce the same error with the vanilla Linux when passing the option
'threadirqs' on the command line (the trace below is from 5.0.0-rc7 that has
not RT support).

FWIW, the interrupt for port 6 is used to for the guest to communicate with
xenstore.

From my understanding, this is happening because the interrupt handler is now
run in a thread. So we can have the following happening.

   Interrupt context            |     Interrupt thread
                                |  
   receive interrupt port 6     |
   clear the evtchn port        |
   set IRQF_RUNTHREAD	        |
   kick interrupt thread        |
                                |    clear IRQF_RUNTHREAD
                                |    call evtchn_interrupt
   receive interrupt port 6     |
   clear the evtchn port        |
   set IRQF_RUNTHREAD           |
   kick interrupt thread        |
                                |    disable interrupt port 6
                                |    evtchn->enabled = false
                                |    [....]
                                |
                                |    *** Handling the second interrupt ***
                                |    clear IRQF_RUNTHREAD
                                |    call evtchn_interrupt
                                |    WARN(...)

I am not entirely sure how to fix this. I have two solutions in mind:

1) Prevent the interrupt handler to be threaded. We would also need to
switch from spin_lock to raw_spin_lock as the former may sleep on RT-Linux.

2) Remove the warning

None of them are ideals. Do you have an opionion/better suggestion?

[  127.192087] Interrupt for port 6, but apparently not enabled; per-user 0000000078d39c7f
[  127.200333] WARNING: CPU: 0 PID: 2553 at drivers/xen/evtchn.c:167 evtchn_interrupt+0xfc/0x120
[  127.208799] Modules linked in:
[  127.211939] CPU: 0 PID: 2553 Comm: irq/52-evtchn:x Tainted: G        W
  5.0.0-rc7-00023-g2a3d41623699 #1257
[  127.222374] Hardware name: ARM Juno development board (r2) (DT)
[  127.228381] pstate: 40000005 (nZcv daif -PAN -UAO)
[  127.233256] pc : evtchn_interrupt+0xfc/0x120
[  127.237607] lr : evtchn_interrupt+0xfc/0x120
[  127.241952] sp : ffff000012d2bd60
[  127.245347] x29: ffff000012d2bd60 x28: ffff00001015d608
[  127.250741] x27: ffff8008b39de400 x26: ffff00001015d330
[  127.256137] x25: ffff00001015d2d4 x24: 0000000000000001
[  127.261532] x23: ffff00001015d570 x22: 0000000000000034
[  127.266926] x21: 0000000000000000 x20: ffff8008b7f02400
[  127.272322] x19: ffff8008b3aba000 x18: 0000000000000037
[  127.277717] x17: 0000000000000000 x16: 0000000000000000
[  127.283112] x15: 00000000fffffff0 x14: 0000000000000000
[  127.288507] x13: 3030303030207265 x12: 000000000000000c
[  127.293902] x11: ffff000010ea0a88 x10: 0000000000000000
[  127.299297] x9 : 00000000fffb9fff x8 : 0000000000000000
[  127.304701] x7 : 0000000000000001 x6 : ffff8008bac5c240
[  127.310087] x5 : ffff8008bac5c240 x4 : 0000000000000000
[  127.315483] x3 : ffff8008bac64708 x2 : ffff8008b39de400
[  127.320877] x1 : 893ac9b38837b800 x0 : 0000000000000000
[  127.326272] Call trace:
[  127.328802]  evtchn_interrupt+0xfc/0x120
[  127.332804]  irq_forced_thread_fn+0x38/0x98
[  127.337066]  irq_thread+0x190/0x238
[  127.340636]  kthread+0x134/0x138
[  127.343942]  ret_from_fork+0x10/0x1c
[  127.347593] ---[ end trace 1d3fa385877cc18b ]---


Cheers,

-- 
Julien Grall
