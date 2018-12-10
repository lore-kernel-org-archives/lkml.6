Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3262082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3262082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLJJiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:38:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:34128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:38:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 01:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="108352872"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2018 01:38:13 -0800
Date:   Mon, 10 Dec 2018 17:45:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        bp@suse.de, keescook@chromium.org, mm-commits@vger.kernel.org,
        sergey.senozhatsky@gmail.com, stable@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
References: <20181204102033.ltdvc7gmev2gvlkq@pathway.suse.cz>
 <20181204154936.wbgcovzpc54n6dvs@shbuild888>
 <20181205022654.GA503@jagdpanzerIV>
 <20181205024713.nqyt6qiamokq7qtl@shbuild888>
 <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207095004.GB3729@jagdpanzerIV>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

+ lkml.

On Fri, Dec 07, 2018 at 06:50:04PM +0900, Sergey Senozhatsky wrote:
> On (12/06/18 11:58), Feng Tang wrote:
> > > Same here, I tried on several platforms and hardly get the sysrq magic key
> > > working, though it works while system is running.
> > > 
> > > And it make me wondering if those workqueue dependent led blinking code
> > > can still really work.
> > 
> > Also, IMHO, if we need a panic blink method, it should better be simple
> > and robust with only HW registers access plus delay function, as I'm not
> > sure if the scheduling can still work. 
> > 
> > Anyway, can I propose to make the "local_irq_enable" conditional and off
> > by default, and add a warning.
> 
> I'm not sure what to do about this. I think that the behaviour is platform
> specific. For instance, arm64 keeps secondary CPUs in a busy loop
> 	while (1)
> 		cpu_relax();

Yes, it's similar to x86's handling for non-panic CPU.

> 
> (masked out) and on panic_cpu disables only SDEI (interrupts from firmware,
> if I got it right); so it seems that arm64 can handle IRQs after panic. And
> if there are platforms that handle IRQ (including sysrq) after panic, then
> both options - making printk a noop or keeping local irqs off - maybe can
> cause some problems. Or maybe not. We better ask arch people.

Yes, this is very valid concern. And after Petr and you raised it, I did
some experiments with 3 x86 platforms at my hand, one Apollolake IOT device
with serial console, one IvyBridge laptop and one Kabylake NUC, the magic key
all works well before panic, and fails after panic. But I did remember the
PageUp/PageDown key worked on some laptop years ago. And you actually raised a
good question: what do we expect for the post-panic kernel? 

For the v4 patch, my thought is, for experienced developers to make
sysrq/panic_blink work, it's easy to add "panic_keep_irq_on" to kernel cmdline,
or runtime change it by 
 "echo Y > /sys/module/kernel/parameters/panic_keep_irq_on"
while for normal user, they can by default see the clean panic call stack
either on a screen or a serial console. 

Thanks,
Feng

> 
> Personally, on my x86 laptop, I'd prefer the srollback to work after panic.
> Just my 5 cents.
> 
> 	-ss
