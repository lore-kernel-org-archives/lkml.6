Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD0C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2620652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJODpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:45:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49916 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbeJODpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 23:45:01 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SGPal5CobBuT; Sun, 14 Oct 2018 22:02:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDC0500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 970701EC0987;
        Sun, 14 Oct 2018 22:02:52 +0200 (CEST)
Date:   Sun, 14 Oct 2018 22:02:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Use assembly instruction mnemonics instead of .byte
 streams in arch_hweight.h
Message-ID: <20181014200241.GD7667@zn.tnic>
References: <20181014183510.18908-1-ubizjak@gmail.com>
 <20181014184735.GC7667@zn.tnic>
 <CAFULd4YZyQUjdVbLiM-HUCL_dbvA_oKNhDCXbAKr2L8y0cvSrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4YZyQUjdVbLiM-HUCL_dbvA_oKNhDCXbAKr2L8y0cvSrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:15:00PM +0200, Uros Bizjak wrote:
> The ChangeLog says "real INSTRUCTION mnemonics", e.g. POPCNTQ and POPCNTL.

Right, INSTRUCTION.

> The compiler will generate the register name with the correct implied
> width (e.g. %rax for long, %eax for int), so the assembler will be
> able to cross check if operands fit the instruction

The __arch_hweightXX functions already enforce the proper type and
the inline asm() operands already place the arguments in the proper
registers where the instruction encoding expects them.

So if you're going to relax this, then you could relax the inline asm
operand specifications too. I say you "could" because then you need to
fix arch/x86/lib/hweight.S too, which would be at least ugly. So I think
we're stuck with %xDI/xAX and %xAX as operands, where 'x' is either 'r'
or 'e'.

> And there will be a couple of ugly #defines less.

That's the only advantage of this change AFAICT. How about you reflect
that in your commit message?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
