Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C389C20845
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHWf0in2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C389C20845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIAC0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeIAC0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:26:08 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB81820861
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 22:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535753798;
        bh=5JcqvgJ5R2KgZ6pLdpuoRLSxlhBC0jlWlwtyhAoCMfw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eHWf0in22zR/F+5SRwoSi4NeknMkd0W4tEdLzm+MLOZkOgsJNulpoX/Ri+dz0BMuE
         wNSTjm/OLAYbja83W7TBVLec4arx1fQrrljqV6sN4kxHbrsWVpBM0gN6cW7wc238nB
         H5VQXSRDPCpr9KAsQ0LOxhV+3zK+uRZZSjZm0ogM=
Received: by mail-wr1-f42.google.com with SMTP id k5-v6so12455439wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:16:37 -0700 (PDT)
X-Gm-Message-State: APzg51C7DtuOM48Qopfn+1q/V6pqHVTIgKOBRjAGAzVCk6N4yDuIhxM0
        qITi+0nHQ3xm05ULFh9be0l7uP8lufHqcIJzDwkgCw==
X-Google-Smtp-Source: ANB0VdaIjZj/C6hV9CnxyEN2VP3iGTe1FmM03H/POMYeSNN+Eydx6s/Zotvlm88GYlF0PhZUBDxb/xscidE6ePGzJQc=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr12543468wrh.148.1535753796032;
 Fri, 31 Aug 2018 15:16:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 15:16:15
 -0700 (PDT)
In-Reply-To: <1535752180.31230.4.camel@intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-20-yu-cheng.yu@intel.com>
 <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
 <CALCETrW78UKt6AQJeN8GkhtxjuASnH1PV5QSpzQtDz9-2d3Asw@mail.gmail.com>
 <1535646146.26689.11.camel@intel.com> <1535752180.31230.4.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Aug 2018 15:16:15 -0700
X-Gmail-Original-Message-ID: <CALCETrV_aDasfkd6LD1cT11Hs1dO064uHjROLQPyhQfy_iuS8w@mail.gmail.com>
Message-ID: <CALCETrV_aDasfkd6LD1cT11Hs1dO064uHjROLQPyhQfy_iuS8w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 2:49 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> On Thu, 2018-08-30 at 09:22 -0700, Yu-cheng Yu wrote:
>> On Thu, 2018-08-30 at 08:55 -0700, Andy Lutomirski wrote:
>> >
>> > On Thu, Aug 30, 2018 at 8:39 AM, Jann Horn <jannh@google.com>
>> > wrote:
>> > >
>> > >
>> > > On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.c
>> > > om
>> > > >
>> > > > wrote:
>> > > >
>> > > >
>> > > > WRUSS is a new kernel-mode instruction but writes directly
>> > > > to user shadow stack memory.  This is used to construct
>> > > > a return address on the shadow stack for the signal
>> > > > handler.
>> > > >
>> > > > This instruction can fault if the user shadow stack is
>> > > > invalid shadow stack memory.  In that case, the kernel does
>> > > > fixup.
>> > > >
>> > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> > > [...]
>> > > >
>> > > >
>> > > > +static inline int write_user_shstk_64(unsigned long addr,
>> > > > unsigned long val)
>> > > > +{
>> > > > +       int err = 0;
>> > > > +
>> > > > +       asm volatile("1: wrussq %1, (%0)\n"
>> > > > +                    "2:\n"
>> > > > +                    _ASM_EXTABLE_HANDLE(1b, 2b,
>> > > > ex_handler_wruss)
>> > > > +                    :
>> > > > +                    : "r" (addr), "r" (val));
>> > > > +
>> > > > +       return err;
>> > > > +}
>> > > What's up with "err"? You set it to zero, and then you return
>> > > it,
>> > > but
>> > > nothing can ever set it to non-zero, right?
>> > >
>> > > >
>> > > >
>> > > > +__visible bool ex_handler_wruss(const struct
>> > > > exception_table_entry *fixup,
>> > > > +                               struct pt_regs *regs, int
>> > > > trapnr)
>> > > > +{
>> > > > +       regs->ip = ex_fixup_addr(fixup);
>> > > > +       regs->ax = -1;
>> > > > +       return true;
>> > > > +}
>> > > And here you just write into regs->ax, but your "asm volatile"
>> > > doesn't
>> > > reserve that register. This looks wrong to me.
>> > >
>> > > I think you probably want to add something like an explicit
>> > > `"+&a"(err)` output to the asm statements.
>> > We require asm goto support these days.  How about using
>> > that?  You
>> > won't even need a special exception handler.
>
> Maybe something like this?  It looks simple now.
>
> static inline int write_user_shstk_64(unsigned long addr, unsigned
> long val)
> {
>         asm_volatile_goto("wrussq %1, (%0)\n"
>                      "jmp %l[ok]\n"
>                      ".section .fixup,\"ax\"n"
>                      "jmp %l[fail]\n"
>                      ".previous\n"
>                      :: "r" (addr), "r" (val)
>                      :: ok, fail);
> ok:
>         return 0;
> fail:
>         return -1;
> }
>

I think you can get rid of 'jmp %l[ok]' and the ok label and just fall
through.  And you don't need an explicit jmp to fail -- just set the
_EX_HANDLER entry to land on the fail label.
