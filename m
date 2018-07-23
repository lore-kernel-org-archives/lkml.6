Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FF920779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FF920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbeGWI5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:57:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeGWI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:57:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D14EA95;
        Mon, 23 Jul 2018 07:57:45 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:57:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [4.4 STABLE BACKPORT] x86: paravirt: make native_save_fl extern
 inline
Message-ID: <20180723075743.GD31879@kroah.com>
References: <20180718090702.GA6212@kroah.com>
 <20180720223642.126080-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720223642.126080-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:36:41PM -0700, Nick Desaulniers wrote:
> native_save_fl() is marked static inline, but by using it as
> a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
> 
> paravirt's use of native_save_fl() also requires that no GPRs other than
> %rax are clobbered.
> 
> Compilers have different heuristics which they use to emit stack guard
> code, the emittance of which can break paravirt's callee saved assumption
> by clobbering %rcx.
> 
> Marking a function definition extern inline means that if this version
> cannot be inlined, then the out-of-line version will be preferred. By
> having the out-of-line version be implemented in assembly, it cannot be
> instrumented with a stack protector, which might violate custom calling
> conventions that code like paravirt rely on.
> 
> The semantics of extern inline has changed since gnu89. This means that
> folks using GCC versions >= 5.1 may see symbol redefinition errors at
> link time for subdirs that override KBUILD_CFLAGS (making the C standard
> used implicit) regardless of this patch. This has been cleaned up
> earlier in the patch set, but is left as a note in the commit message
> for future travelers.
> 
> Reports:
> https://lkml.org/lkml/2018/5/7/534
> https://github.com/ClangBuiltLinux/linux/issues/16
> 
> Discussion:
> https://bugs.llvm.org/show_bug.cgi?id=37512
> https://lkml.org/lkml/2018/5/24/1371
> 
> Thanks to the many folks that participated in the discussion.
> 
> Acked-by: Juergen Gross <jgross@suse.com>
> Debugged-by: Alistair Strachan <astrachan@google.com>
> Debugged-by: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Tom Stellar <tstellar@redhat.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
> Backport for 4.4. 4.4 is missing commit 784d5699eddc "x86: move exports to
> actual definitions" which doesn't apply cleanly, and not really worth
> backporting IMO. It's simpler to change this patch from upstream:
> + #include <asm-generic/export.h>
> rather than
> + #include <asm/export.h>

Now applied, thanks.

greg k-h
