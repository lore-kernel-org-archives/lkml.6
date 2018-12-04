Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C0820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL5I9ftx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C0820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLDTWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLDTWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:22:40 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3BB2087F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543951359;
        bh=SfqPuQ4iYheesaOVi87RbOWTGb9cf9PC0ZMwuCJAggw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aL5I9ftxeeRkL0lvCWuLTOCfShxR6wORpoeziaAMFObSQGN22w9/SLVZdjduCAA8U
         S0Arc+qOl/fIqjTHvciIbx0lF4D4o+m5ey1um4mAKXl6PZouwk6CyOt0p1w5qmekwg
         Uy2wDRvRlPw+v/VIX/6rk/XT9ek4bc6Jj2zxGHZE=
Received: by mail-wr1-f42.google.com with SMTP id l9so17172139wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:22:39 -0800 (PST)
X-Gm-Message-State: AA+aEWaPwYKNlXgzZAWJuVqhfE+RNgOR2HIfGc0+uQ8C7Hp9HsJ6N3tt
        RMoaiuPz1MBPpxBhSA8sAkcL83G2pGIxe13QEyT0EQ==
X-Google-Smtp-Source: AFSGD/Wixv5XkCWiXqwW2mkjfcq+FFrvBoQWhkziYEEjE43B/ZhGL4cz9AhNOOtlNsX2ytAZQumWbKM0WbosCrWMAoM=
X-Received: by 2002:adf:8323:: with SMTP id 32mr18446547wrd.176.1543951357608;
 Tue, 04 Dec 2018 11:22:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542841400.git.luto@kernel.org> <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com> <20181127153202.GA27075@linux.intel.com>
In-Reply-To: <20181127153202.GA27075@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 11:22:25 -0800
X-Gmail-Original-Message-ID: <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
Message-ID: <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 7:32 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Nov 22, 2018 at 09:41:19AM +0100, Ingo Molnar wrote:
> >
> > * Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > One of Linus' favorite hobbies seems to be looking at OOPSes and
> > > decoding the error code in his head.  This is not one of my favorite
> > > hobbies :)
> > >
> > > Teach the page fault OOPS hander to decode the error code.  If it's
> > > a !USER fault from user mode, print an explicit note to that effect
> > > and print out the addresses of various tables that might cause such
> > > an error.
> > >
> > > With this patch applied, if I intentionally point the LDT at 0x0 and
> > > run the x86 selftests, I get:
> > >
> > > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > > HW error: normal kernel read fault
> > > This was a system access from user code
> > > IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe0000001000 (limit=0x7f)
> > > LDTR: 0x50 -- base=0x0 limit=0xfff7
> > > TR: 0x40 -- base=0xfffffe0000003000 limit=0x206f
> > > PGD 800000000456e067 P4D 800000000456e067 PUD 4623067 PMD 0
> > > SMP PTI
> > > CPU: 0 PID: 153 Comm: ldt_gdt_64 Not tainted 4.19.0+ #1317
> > > Hardware name: ...
> > > RIP: 0033:0x401454
> >
> > I've applied your series, with one small edit, the following message:
> >
> >   > HW error: normal kernel read fault
> >
> > will IMHO confuse the heck out of users, thinking that their hardware is
> > broken...
> >
> > Yes, the message is accurate, in MM pagefault language it's indeed the HW
> > error code, but it's a language very few people speak.
> >
> > So I edited it over to say '#PF error code'. I also applied a few other
> > minor cleanups - see the changelog below.
>
> I responded to the original thread a hair too late...
>
> What about something like this instead of manually handling the case
> where error_code==0 so that we get e.g. "[KERNEL] [READ]" instead of
> "normal kernel read fault"?  Getting "[PROT] [KERNEL] [READ]" seems
> useful.
>
> IMO "[normal kernel read fault]" followed by "This was a system access
> from user code" is still confusing.
>
> ---
> 8b29ee4351d5c625aa9ca2765f8da5e Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> Date: Tue, 27 Nov 2018 07:09:57 -0800
> Subject: [PATCH] x86/fault: Print "KERNEL" and "READ" for #PF error codes
>
> ...and explicitly state that it's a "code" that's being printed.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/mm/fault.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2ff25ad33233..510e263c256b 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>         err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
>         err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
>         err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> -
> -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> +       err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
> +       err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> +                                                         "[READ]");
> +       pr_alert("#PF error code: %s\n", err_txt);
>

Seems generally nice, but I would suggest making the bit-not-set name
be another parameter to err_str_append().  I'm also slightly uneasy
about making "KERNEL" look like a bit, but I guess it doesn't bother
me too much.

Want to send a real patch?
