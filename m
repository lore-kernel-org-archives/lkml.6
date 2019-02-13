Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0982222E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbfBMPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:54:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391483AbfBMPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:54:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gtwrr-0005yB-BC; Wed, 13 Feb 2019 16:54:35 +0100
Date:   Wed, 13 Feb 2019 16:54:35 +0100
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
Message-ID: <20190213155435.vnvgzu76ienzvfhv@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190130113555.GC18383@zn.tnic>
 <20190130120647.abbf2cbbpguaz356@linutronix.de>
 <20190130122713.GG18383@zn.tnic>
 <20190208131233.5g5guefglq6ik2ow@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208131233.5g5guefglq6ik2ow@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-08 14:12:33 [+0100], To Borislav Petkov wrote:
> Then we have lat_sig [0]. Without the series 64bit:
> |Signal handler overhead: 2.6839 microseconds
> |Signal handler overhead: 2.6996 microseconds
> |Signal handler overhead: 2.6821 microseconds
> 
> with the series:
> |Signal handler overhead: 3.2976 microseconds
> |Signal handler overhead: 3.3033 microseconds
> |Signal handler overhead: 3.2980 microseconds

Did a patch-by-patch run (64bit only, server preemption model, output in
us ("commit")):

2.368 ("Linux 5.0-rc5")

2.603 ("x86/fpu: Always store the registers in copy_fpstate_to_sigframe()")
  copy_fpstate_to_sigframe() stores to thread's FPU area and then copies
  user stack area.

2.668 ("x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD")
  this should be noise since preempt_disable/enable is a nop -
  test_thread_flag() isn't.

2.701 ("x86/fpu: Inline copy_user_to_fpregs_zeroing()")
  This pops up somehow but is simply code movement.

3.474 ("x86/fpu: Let __fpu__restore_sig() restore the !32bit+fxsr frame from kernel memory")
  This stands out. There a kmalloc() + saving to kernel memory + copy
  instead a direct save to kernel stack.

2.928 ("x86/fpu: Defer FPU state load until return to userspace")
  The kmalloc() has been removed. Just "copy-to-kernel-memory" and
  copy_to_user() remained.

So this looks like 0.3us for the save-copy + 0.3us for copy-restore. The
numbers for the preempt/low-lat-desktop have the same two spikes and
drop at the end.

Sebastian
