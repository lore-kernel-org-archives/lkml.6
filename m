Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DF9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565A620685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeIZRY5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:24:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49220 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:24:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g57jz-0004VH-8g; Wed, 26 Sep 2018 13:12:23 +0200
Date:   Wed, 26 Sep 2018 13:12:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to
 userspace
Message-ID: <20180926111222.hihueuagmb4qfmtz@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-11-bigeasy@linutronix.de>
 <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net>
 <20180919170515.ptqmmpsxrdjsi64j@linutronix.de>
 <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net>
 <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 21:15:35 [-0700], Andy Lutomirski wrote:
> > I mean the fpu.initialized variable entirely. AFAIK, its only use is for kernel threads — setting it to false lets us switch to a kernel thread and back without saving and restoring. But TIF_LOAD_FPU should be able to replace it: when we have FPU regs loaded and we switch to *any* thread, kernel or otherwise, we can set TIF_LOAD_FPU and leave the old regs loaded.  So we don’t need the special case for kernel threads.
> > 
> > Which reminds me: if you haven’t already done so, can you add a helper to sanity check the current context?  It should check that the combination of owner_ctx, last_cpu, and TIF_LOAD_FPU is sane. For example, if owner_ctx or last_cpu is says the cpu regs are invalid for current but TIF_LOAD_FPU is clear, it should warn.  I think that at least switch_fpu_finish should call it.  Arguably switch_fpu_prepare should too, at the beginning.
> 
> Looking some more, the “preload” variable needs to go away or be renamed. It hasn’t had anything to do with preloading for some time.
okay.

> Also, the interaction between TIF_LOAD_FPU and FPU emulation needs to be documented somewhere.  Probably FPU-less systems should never have TIF_LOAD_FPU set.
Yes, they should not.

> Or we could decide that no one uses FPU emulation any more.

Oh. Removing unused code? I'm all yours.
There is this Intel Quark thingy which comes to mind can still be
bought. Its data sheet[0] has this:
| 13.1 Features:
| Note: The processor does not provide an x87 Floating Point Unit (FPU) and does
| not support x87 FPU instructions

so not only it does not support the lock prefix, no, it also relies on
soft-FPU.
The latest bsp release notes quotes a package named
	quark_linux_v3.14+v1.2.1.1.tar.gz

so they still use v3.14 (which is not a supported kernel anymore).
And then I took a look into their Yocto-BSP and found this:
| $ fgrep -R MATH_EMULATION .
| ./meta-intel-quark/recipes-kernel/linux/files/quark_3.14.cfg:# CONFIG_MATH_EMULATION is not set

so they don't set this option. This is small SoC and does not run on any
Distro due to the missing lock prefix. So if they use yocto to recompile
everything, they can rebuild their toolchain with soft-fpu support which
is more efficient than calling into the kernel for every opcode.

So I *think* nobody relies on FPU-emulation anymore. I would suggest to
get this patch set into shape and then getting rid of
CONFIG_MATH_EMULATION?

[0] https://www.intel.de/content/dam/www/public/us/en/documents/datasheets/quark-c1000-datasheet.pdf
[1] https://downloadmirror.intel.com/23197/eng/Quark_SW_RelNotes_330232_007.pdf

Sebastian
