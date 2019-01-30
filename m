Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DFBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D56D20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfA3MGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:06:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46843 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA3MGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:06:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1goodj-0006kl-Iv; Wed, 30 Jan 2019 13:06:47 +0100
Date:   Wed, 30 Jan 2019 13:06:47 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
Message-ID: <20190130120647.abbf2cbbpguaz356@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190130113555.GC18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130113555.GC18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 12:35:55 [+0100], Borislav Petkov wrote:
> On Wed, Jan 09, 2019 at 12:47:22PM +0100, Sebastian Andrzej Siewior wrote:
> > This is a refurbished series originally started by by Rik van Riel. The
> > goal is load the FPU registers on return to userland and not on every
> > context switch. By this optimisation we can:
> > - avoid loading the registers if the task stays in kernel and does
> >   not return to userland
> > - make kernel_fpu_begin() cheaper: it only saves the registers on the
> >   first invocation. The second invocation does not need save them again.
> 
> Btw, do we have any benchmark data showing the improvement this brings?

nope. There is sig_lat or something like that which would measure how
many signals you can handle a second. That could show how bad the
changes are in the signal path.
I don't think that I need any numbers to show that all but first
invocation of kernel_fpu_begin() is "free". That would be the claim in
the second bullet.
And for the first bullet. Hmmm. I could add a trace point to see how
often we entered schedule() without saving FPU registers for user tasks.
That would mean the benefit is that we didn't restore them while we left
schedule() and didn't save them while entered schedule() (again).
I don't know if hackbench would show anything besides noise.

Sebastian
