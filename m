Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB89C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AC2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJOXRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeJOXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F4DC3002723;
        Mon, 15 Oct 2018 15:31:48 +0000 (UTC)
Received: from treble (ovpn-125-6.rdu2.redhat.com [10.10.125.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B9027C59;
        Mon, 15 Oct 2018 15:31:46 +0000 (UTC)
Date:   Mon, 15 Oct 2018 10:31:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, nick.desaulniers@gmail.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015153144.buuow3yof2njjzjm@treble>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox>
 <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015152221.GA16375@flashbox>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Oct 2018 15:31:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 08:22:21AM -0700, Nathan Chancellor wrote:
> > >>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > >>>                 * and then double-fault, though, because we're likely to
> > >>>                 * break the console driver and lose most of the stack dump.
> > >>>                 */
> > >>> -               asm volatile ("movq %[stack], %%rsp\n\t"
> > >>> +               asm volatile (UNWIND_HINT_SAVE
> > >>> +                             "movq %[stack], %%rsp\n\t"
> > >>>                              "call handle_stack_overflow\n\t"
> > >>> -                             "1: jmp 1b"
> > >>> +                             "1: jmp 1b\n\t"
> > >>> +                             UNWIND_HINT_RESTORE
> > >>>                              : ASM_CALL_CONSTRAINT
> > >>>                              : "D" ("kernel stack overflow (page fault)"),
> > >>>                                "S" (regs), "d" (address),
> > >> 
> > >> NAK.  Just below this snippet is unreachable();
> > >> 
> > >> Can you reply with objtool -dr output on a problematic fault.o?  Josh,
> > >> it *looks* like annotate_unreachable() should be doing the right
> > >> thing, but something is clearly busted.
> > >> 
> > >> Also, shouldn't compiler-clang.h contain a reasonable definition of
> > >> unreachable()?
> > >> 
> > >> --Andy
> > > 
> > > Hi Andy,
> > > 
> > > Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
> > > should have pasted it here instead):
> > > https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e
> > > 
> > > 
> > 
> > Hmm, -dr wasn’t quite enough to dump the .discard bits, assuming they’re there at all. Can you just put the whole .o file somewhere?
> 
> Here you go: https://nathanchance.me/downloads/.tmp/fault.o

$ eu-readelf -S /tmp/fault.o  |grep reachable
[12] .discard.reachable   PROGBITS     0000000000000000 00002bc0 00000014  0        0   0  1
[13] .rela.discard.reachable RELA         0000000000000000 00002bd8 00000078 24 I     32  12  8

That confirms that you need a clang version of the unreachable() macro.

-- 
Josh
