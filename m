Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA792C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A8C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfARVh0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:37:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50478 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfARVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:37:26 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gkbpF-00084z-RR; Fri, 18 Jan 2019 22:37:17 +0100
Date:   Fri, 18 Jan 2019 22:37:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190118213717.fkbj5jmcdok7dbmb@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 13:17:28 [-0800], Dave Hansen wrote:
> On 1/18/19 1:14 PM, Sebastian Andrzej Siewior wrote:
> > The kernel saves task's FPU registers on user's signal stack before
> > entering the signal handler. Can we avoid that and have in-kernel memory
> > for that? Does someone rely on the FPU registers from the task in the
> > signal handler?
> 
> This is part of our ABI for *sure*.  

I missed that part. I will try to look it up and look see if says
something about optional part.
But ABI means we must keep doing it even if there are no users?

> Inspecting that state is how
> userspace makes sense of MPX or protection keys faults.  We even use
> this in selftests/.

Okay. MPX does not check for FP_XSTATE_MAGIC[12] and simply assumes it
is there. That is why I didn't find it.
So we would break MPX. But then MPX is on its way out, so…

Sebastian
