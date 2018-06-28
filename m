Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A40C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA152707F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA152707F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934309AbeF1Hxc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:53:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55414 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeF1Hxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:53:31 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYRk2-0002pc-UL; Thu, 28 Jun 2018 09:53:23 +0200
Date:   Thu, 28 Jun 2018 09:53:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 04/16] x86/split_lock: Use non locked bit set
 instruction in set_cpu_cap
In-Reply-To: <20180627233504.GJ18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806280945120.1778@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-5-git-send-email-fenghua.yu@intel.com> <20180621195540.GC13636@worktop.programming.kicks-ass.net> <20180627233504.GJ18979@romley-ivt3.sc.intel.com>
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

On Wed, 27 Jun 2018, Fenghua Yu wrote:
> On Thu, Jun 21, 2018 at 09:55:40PM +0200, Peter Zijlstra wrote:
> > On Sun, May 27, 2018 at 08:45:53AM -0700, Fenghua Yu wrote:
> > > set_bit() called by set_cpu_cap() is a locked bit set instruction for
> > > atomic operation.
> > > 
> > > Since the c->x86_capability can span two cache lines depending on kernel
> > > configuration and building evnironment, the locked bit set instruction may
> > > cause #AC exception when #AC exception for split lock is enabled.
> > 
> > That doesn't make sense. Sure the bitmap may be longer, but depending on
> > if the argument is an immediate or not we either use a byte instruction
> > (which can never cross a cacheline boundary) or a 'word' aligned BTS.
> > And the bitmap really _should_ be 'unsigned long' aligned.
> > 
> > If it is not aligned, fix that too.
> > 
> > /me looks at cpuinfo_x86 and finds x86_capability is in fact a __u32
> > array.. see that's broken and needs fixing first.
> 
> Do you mean x86_capability's type should be changed from __u32 to unsigned
> long?
> 
> Changing x86_capability's type won't directly fix the split lock in
> set_cpu_cap(), right? BTS still may access x86_capability across cache
> line no matter x86_capability's type.

Errm. No.  BTS & al are accessing a single 64bit location which is

   base_address + (bit_offset % 64) * 8

So if the base address is properly aligned then BTS & al will _NEVER_ have
to lock more than a single cache line. And it does not matter wheter we fix
the type or enforce 64bit alignement of the array by other means.

If that's not true then BTS & al are terminally broken and you can stop
working on #AC right away.

Thanks,

	tglx
