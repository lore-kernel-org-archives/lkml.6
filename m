Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8089AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E212082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E212082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLKIUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:20:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:59162 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeLKIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:20:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 00:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="97808474"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 00:20:14 -0800
Date:   Tue, 11 Dec 2018 16:32:07 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211083207.b5mbbuohsiorqnoj@shbuild888>
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
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Tue, Dec 11, 2018 at 05:07:43PM +0900, Sergey Senozhatsky wrote:
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

Here is the v1 patch: https://lkml.org/lkml/2018/10/11/304 

And actually no one ruled out the v1 patch :), I don't have HW of other
archs like arm/ppc, so I just read some of the arch code, and found
most of them use the similar flow like x86, that's why I chosed to
finding a soluton inside panic.c itself.

Thanks,
Feng

