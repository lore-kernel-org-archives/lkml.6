Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6CC6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2AC20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2AC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeLJP5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:57:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:37742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbeLJP5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:57:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E38CBAC3D;
        Mon, 10 Dec 2018 15:57:06 +0000 (UTC)
Date:   Mon, 10 Dec 2018 16:57:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
References: <20181204154936.wbgcovzpc54n6dvs@shbuild888>
 <20181205022654.GA503@jagdpanzerIV>
 <20181205024713.nqyt6qiamokq7qtl@shbuild888>
 <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-10 17:45:54, Feng Tang wrote:
> Hi Sergey,
> 
> + lkml.
> 
> On Fri, Dec 07, 2018 at 06:50:04PM +0900, Sergey Senozhatsky wrote:
> > On (12/06/18 11:58), Feng Tang wrote:
> > > > Same here, I tried on several platforms and hardly get the sysrq magic key
> > > > working, though it works while system is running.
> > > > 
> > > > And it make me wondering if those workqueue dependent led blinking code
> > > > can still really work.
> > > 
> > > Also, IMHO, if we need a panic blink method, it should better be simple
> > > and robust with only HW registers access plus delay function, as I'm not
> > > sure if the scheduling can still work. 
> > > 
> > > Anyway, can I propose to make the "local_irq_enable" conditional and off
> > > by default, and add a warning.
> > 
> > I'm not sure what to do about this. I think that the behaviour is platform
> > specific. For instance, arm64 keeps secondary CPUs in a busy loop
> > 	while (1)
> > 		cpu_relax();
> 
> Yes, it's similar to x86's handling for non-panic CPU.
> 
> > 
> > (masked out) and on panic_cpu disables only SDEI (interrupts from firmware,
> > if I got it right); so it seems that arm64 can handle IRQs after panic. And
> > if there are platforms that handle IRQ (including sysrq) after panic, then
> > both options - making printk a noop or keeping local irqs off - maybe can
> > cause some problems. Or maybe not. We better ask arch people.
> 
> Yes, this is very valid concern. And after Petr and you raised it, I did
> some experiments with 3 x86 platforms at my hand, one Apollolake IOT device
> with serial console, one IvyBridge laptop and one Kabylake NUC, the magic key
> all works well before panic, and fails after panic. But I did remember the
> PageUp/PageDown key worked on some laptop years ago. And you actually raised a
> good question: what do we expect for the post-panic kernel?

I am not sure why it does not work. But it would be nice if sysrq
worked.


> For the v4 patch, my thought is, for experienced developers to make
> sysrq/panic_blink work, it's easy to add "panic_keep_irq_on" to kernel cmdline,
> or runtime change it by
>  "echo Y > /sys/module/kernel/parameters/panic_keep_irq_on"
> while for normal user, they can by default see the clean panic call stack
> either on a screen or a serial console.

I see this problematic from two reasons:

First, the blinking and especially sysrq might be handy but they
are disabled by default. It is too late to do anything when the
system is panicing.

Second, new parameters or configure options should be avoided
whenever possible. They are easy to implement but the are less
easy to use. The current amount of them is already overhelming.


I still think that calming down printk() is acceptable when
it can be restored from sysrq.

I think that only few people might be interested into debugging
post-panic problems. We could print a warning for them about
that printk() has got disabled.

Best Regards,
Petr
