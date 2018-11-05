Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A13C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C235B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C235B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeKFFuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:50:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:50:23 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJlU7-0004n6-EB; Mon, 05 Nov 2018 21:28:31 +0100
Date:   Mon, 5 Nov 2018 21:28:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
In-Reply-To: <CALCETrXwci8L=53UTq8=LEs+5yPgdHnidFf6iz3wZ0SkZwd1Eg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811052126310.1659@nanos.tec.linutronix.de>
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-3-namit@vmware.com> <20181105140925.GD22467@hirez.programming.kicks-ass.net> <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net> <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
 <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net> <8DF7BED8-F1B2-4102-9452-46437D3E4FC6@vmware.com> <CALCETrXwci8L=53UTq8=LEs+5yPgdHnidFf6iz3wZ0SkZwd1Eg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018, Andy Lutomirski wrote:
> On Mon, Nov 5, 2018 at 11:25 AM Nadav Amit <namit@vmware.com> wrote:
> Linus, hpa, or Dave, a question for you: suppose I map some page
> writably, write to it, then upgrade permissions to allow execute.
> Must I force all CPUs that might execute from it without first
> serializing to serialize?  I suspect this doesn't really affect user
> code, but it may affect the module loader.
> 
> To be safe, shouldn't the module loader broadcast an IPI to
> sync_core() everywhere after loading a module and before making it
> runnable, regardless of alternative patching?
> 
> IOW, the right sequence of events probably ought to me:
> 
> 1. Allocate the memory and map it.
> 2. Copy in the text.
> 3. Patch alternatives, etc.  This is logically just like (2) from an
> architectural perspective -- we're just writing to memory that won't
> be executed.
> 4. Serialize everything.
> 5. Run it!

I'd make that:

1. Allocate the memory and map it RW
2. Copy in the text.
3. Patch alternatives, etc.  This is logically just like (2) from an
   architectural perspective -- we're just writing to memory that won't
   be executed.
4. Map it RX
5. Serialize everything.
6. Run it!

Thanks,

	tglx
