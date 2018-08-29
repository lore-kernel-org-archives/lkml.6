Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632FBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174D520658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174D520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeH2R7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727651AbeH2R7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:59:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37E51AFEE;
        Wed, 29 Aug 2018 14:02:40 +0000 (UTC)
Date:   Wed, 29 Aug 2018 16:03:10 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, security@kernel.org
Subject: Re: [PATCH v2] x86/dumpstack: don't dump kernel memory based on
 usermode RIP
Message-ID: <20180829140310.GG6337@nazgul.tnic>
References: <20180828154901.112726-1-jannh@google.com>
 <20180829071042.GB6337@nazgul.tnic>
 <CAG48ez37HBh=0YfP=rLVGGEcFV0zJL_PLVgedFxDtyRgXHMROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez37HBh=0YfP=rLVGGEcFV0zJL_PLVgedFxDtyRgXHMROQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:55:32PM +0200, Jann Horn wrote:
> > > diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> > > index 9c8652974f8e..14b337582b6f 100644
> > > --- a/arch/x86/kernel/dumpstack.c
> > > +++ b/arch/x86/kernel/dumpstack.c
> > > @@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long address, int reliable,
> > >   * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
> > >   * guesstimate in attempt to achieve all of the above.
> > >   */
> > > -void show_opcodes(u8 *rip, const char *loglvl)
> > > +void show_opcodes(struct pt_regs *regs, const char *loglvl)
> > >  {
> > >  #define PROLOGUE_SIZE 42
> > >  #define EPILOGUE_SIZE 21
> > >  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
> > >       u8 opcodes[OPCODE_BUFSIZE];
> > > +     u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
> >
> > Just a nitpick:
> >
> > <--- newline here.
> 
> The code below this point is still part of the declarations. Do you
> want a newline here anyway? If you say yes, I'll adjust and resend.

Yeah, but I'd like the comment to separate out better. As I said, just a
nitpick.

But no need to resend - I believe tglx is (still) nice enough to fix it
up while applying.

:-)))

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
