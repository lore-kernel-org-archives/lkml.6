Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF9CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2857A2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2857A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbeGKQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:34:03 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:45358 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbeGKQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:34:03 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fdHz1-0003vn-3V; Wed, 11 Jul 2018 18:28:51 +0200
Date:   Wed, 11 Jul 2018 18:28:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, riel@surriel.com,
        dave.hansen@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
Message-ID: <20180711162850.52jmzsuwegpk7rag@breakpoint.cc>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
 <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-15 22:33:47 [+0200], Jason A. Donenfeld wrote:
> On Fri, Jun 15, 2018 at 8:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> > quite in the form you imagined.  The idea that we've tossed around is
> > to restore FPU state on return to user mode.  Roughly, we'd introduce
> > a new thread flag TIF_FPU_UNLOADED (name TBD).
> > prepare_exit_to_usermode() would notice this flag, copy the fpstate to
> > fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() -- No
> > one has quite thought it through, but I think it should be outside the
> > loop.)  We'd update all the FPU accessors to understand the flag.
> 
> Yes! This is exactly what I was thinking. Then those calls to begin()
> and end() could be placed as close to the actual FPU usage as
> possible.

I was thinking about this myself. Did anyone try to hack something in
the meantime? I might want to look into this, too :)

Sebastian
