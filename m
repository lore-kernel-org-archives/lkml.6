Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B983C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F59F24993
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F59F24993
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeGBUNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:13:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeGBUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:13:46 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fa5Cg-0002IF-VR; Mon, 02 Jul 2018 22:13:43 +0200
Date:   Mon, 2 Jul 2018 22:13:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     gengdongjiu <gengdongjiu@huawei.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, anna-maria@linutronix.de,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
Subject: Re: hrtimer become inaccurate with RT patch
In-Reply-To: <CALAqxLVK=EghPr=GVTKzX511XMO2NM4Ehh3pVP9QumpKRBP+rA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807022209210.1590@nanos.tec.linutronix.de>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com> <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com> <CALAqxLVK=EghPr=GVTKzX511XMO2NM4Ehh3pVP9QumpKRBP+rA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, John Stultz wrote:
> On Mon, Jul 2, 2018 at 2:34 AM, gengdongjiu <gengdongjiu@huawei.com> wrote:
> > Hi Thomas/Anna/John,
> >
> >   Recently I found that the hrtimer become inaccurate when there is a RT
> > process runs on the same cpu core, and the kernel has applied preempt_rt
> > patch.
> >   The Linux kernel version is v4.1.46, and the preempt_rt patch is
> > patch-4.1.46-rt52.patch.
> >   I know that in the preempt_rt environment the interrupt handlers no
> > longer run in interrupt context but in process context, so that RT
> > process will not be interrupt. But if the hrtimer is also runs in
> > process context the timer is useless when it's inaccurate. so I want to
> > consult you whether this is expected behavior? whether is reasonable to
> > move the timer IRQ handling to a thread?
> 
> I've not looked at the PREEMPT_RT code in a long time, but years ago
> there was a tension in that there is not an easy way track ownership
> of timers. Thus timers all fired at the same priority of the hrtimer
> irq thread. This thread could be moved up or down in priority, but the
> problem was all timers would fire with the same priority. So either
> the thread priority was so high that low-priority process could
> generate a bunch of timers which would interrupt higher priority
> tasks, or the thread priority was lower, so a high priority task could
> block all timers.

Yeah, we had that long ago. It was complex and nasty.
 
> There was some handwavy talk of trying to keep per-process timer
> lists, so the hrtimer irq could still be in irq context but the firing
> logic it didn't do anything but mark its task as runnable and do the
> the actual timer firing logic before we eventually run the task (in
> proper rt priority order), in a fashion similar to signals. But I'm
> not sure if any attempts were made in that direction. I also think it
> was an open question if there's any logic in kernel that depend on
> strict in-order kernel timer processing, so its possible there could
> be odd inversion issues where high priority timer logic is waiting on
> /expecting lower priority timers to fire, etc, so its probably an area
> of research.

Well, the main issues are actually the signal based posix-timers. The
problem is not to keep track of them, them problem is which of the threads
to wake up for which timer. I've had experimental code which kinda worked,
but ran into issues with the signal masking and the horrors of sighand
lock. Definitely more research required for that. It might have become
simpler, but still sighand lock cannot be taken from hard interrupt context
on RT.

Thanks,

	tglx
