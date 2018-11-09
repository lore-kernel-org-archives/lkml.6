Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8139AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5558420855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5558420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeKJDRA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:17:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47494 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbeKJDRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:17:00 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gLAgj-00015V-DS; Fri, 09 Nov 2018 18:35:21 +0100
Date:   Fri, 9 Nov 2018 18:35:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 02/23] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181109173521.2m6iijp5wkncgi77@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-3-bigeasy@linutronix.de>
 <20181108145721.GC7543@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181108145721.GC7543@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 15:57:21 [+0100], Borislav Petkov wrote:
> On Wed, Nov 07, 2018 at 08:48:37PM +0100, Sebastian Andrzej Siewior wrote:
> > This is a preparation for the removal of the ->initialized member in the
> > fpu struct.
> > __fpu__restore_sig() is deactivating the FPU via fpu__drop() and then
> > setting manually ->initialized followed by fpu__restore(). The result is
> > that it is possible to manipulate fpu->state and the state of registers
> > won't be saved/restore on a context switch which would overwrite state.
> 
> 		restored
> 
> > 
> > Don't access the fpu->state while the content is read from user space
> > and examined / sanitized. Use a temporary buffer kmalloc() buffer for
> 
> one "buffer" too many.

corrected.

> More importantly, what I'm missing here is more detailed explanation
> about how that manipulation can happen. Especially since the comment
> over fpu__drop() you're removing below is claiming the exact opposite.
> AFAICT.

fpu__drop() stets ->initialized to 0. As a result the context switch
will not save current FPU registers and so _not_ write to fpu->state.
This also means that CPU's FPU register will be random (inherited from
the last context) after the context switch. This is also true for usage
in softirq via kernel_fpu_begin().

The "new" FPU state is prepared in fpu->state and once it is done, it
gets loaded via
  fpu->initialized = 1; // make sure fpu__initialize() in fpu__restore()
                        // is a nop
  fpu__restore();	// Load the registers.

Since I plan to remove the ->initialized member, I don't have the luxury
to play with fpu->state because the "new" content obtained by
copy_from_user() will be overwritten with CPU's current FPU state during
a context switch.
Now with that information, what do you plan to alter? :)

> Yeah, FPU code has always been nasty and tricky to follow so I think
> we'd need to have this stuff explained in much more detail.

Yeah, tell me about it. Now that you made me look into this again, I
spotted this gem:

| __fpu__restore_sig()
…
|        if (ia32_fxstate) {
…
|                 fpu__drop(fpu);
…
|	/* prepare new FPU state in fpu->state */
| 
|                 fpu->initialized = 1;

*BOOM* context switch. ->initialized == 1 is seen so it stashes current
CPU's FPU state into fpu->state and overwrites what has been prepared
before.

On the switch back to this task, the fpu__restore() becomes a "nop"
because the saved registers are the same but not what was expected /
prepared before.

|                 preempt_disable();
|                 fpu__restore(fpu);
|                 preempt_enable();
|

So. The fix would be:
@@ -344,10 +344,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
                        sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
                }
 
+               local_bh_disable();
                fpu->initialized = 1;
-               preempt_disable();
                fpu__restore(fpu);
-               preempt_enable();
+               local_bh_enable();
 
                return err;
        } else {

local_bh_disable() due to possible kernel_fpu_begin() usage in softirq.
How much do we care here about a theoretical race on 32bit anyway? I
don't think someone complained :) I would have to rebase my queue…
otherwise…

> Thx.

Sebastian
