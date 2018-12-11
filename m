Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41416C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FF22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeLKIWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:22:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbeLKIWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:22:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 722BBAEBD;
        Tue, 11 Dec 2018 08:22:22 +0000 (UTC)
Date:   Tue, 11 Dec 2018 09:22:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211082221.3wovowe6tql5o3s4@pathway.suse.cz>
References: <20181205024713.nqyt6qiamokq7qtl@shbuild888>
 <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
 <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
 <20181211080743.GB521@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211080743.GB521@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-11 17:07:43, Sergey Senozhatsky wrote:
> On (12/10/18 16:57), Petr Mladek wrote:
> > > > (masked out) and on panic_cpu disables only SDEI (interrupts from firmware,
> > > > if I got it right); so it seems that arm64 can handle IRQs after panic. And
> > > > if there are platforms that handle IRQ (including sysrq) after panic, then
> > > > both options - making printk a noop or keeping local irqs off - maybe can
> > > > cause some problems. Or maybe not. We better ask arch people.
> > > 
> > > Yes, this is very valid concern. And after Petr and you raised it, I did
> > > some experiments with 3 x86 platforms at my hand, one Apollolake IOT device
> > > with serial console, one IvyBridge laptop and one Kabylake NUC, the magic key
> > > all works well before panic, and fails after panic. But I did remember the
> > > PageUp/PageDown key worked on some laptop years ago. And you actually raised a
> > > good question: what do we expect for the post-panic kernel?
> > 
> > I am not sure why it does not work. But it would be nice if sysrq
> > worked.
> 
> Absolutely.
> 
> [..]
> > I still think that calming down printk() is acceptable when
> > it can be restored from sysrq.
> 
> I would agree; peeking one of the two solutions, printk patch is
> probably preferable.
> 
> > I think that only few people might be interested into debugging
> > post-panic problems. We could print a warning for them about
> > that printk() has got disabled.
> 
> Dunno. This _maybe_ (speculation!) can upset folks on those platforms
> that have sysrq working after panic. printk is a common code.
> 
> I'm probably missing a lot of things here, but just in case, I'm not
> sure at which point the idea of patching some files under arch/x86
> directory was ruled out and why.

I suggested to clear the panic_blinking (or whatever name) in
__handle_sysrq(). The idea is that sysrq needs manual intervention.
It allows to see the original message before it gets overridden
by a potential sysrq-related output.

It assumes that sysrq is the only interesting operation when
printk() might be useful at this state.

Best Regards,
Petr
