Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4B3208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuFrcoVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4B3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH0XNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeH0XNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:13:23 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5074A208A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535397926;
        bh=DJu8OEx/EUN4WOTgGH171mnug75BJG8Sba/QGQ8icbg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QuFrcoVCn3GQ6LAlknYxu9kl+qzb5Q8mYG5jbHaFMVlgCOfbSSTx5XY7oXHIwMsyA
         sA6jLVrWsklrB4wWzgmVZtvSV/evRRw079pn/7zoVDqvycEEu5isgsRltRHH+2TejQ
         XX8zwa/QwHZvnpeE5FMyKKNy1x9RX7z2LmqBYnhI=
Received: by mail-wr1-f45.google.com with SMTP id z96-v6so65258wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:25:26 -0700 (PDT)
X-Gm-Message-State: APzg51C6w91psYD599Jn4Po+rKa6qGoV+IpY/3KNRgj1x1iapfl+hx9f
        Ap/ADJQR6qUfyXNfbWVoAUb8o1TGzxG+Djk8sB9iUg==
X-Google-Smtp-Source: ANB0VdYsD8sCLP1xqEOT9UHvoXfsxRfroNJSSWigT2jj77NjXY/72se31sx1zF+gmyR6dA7t824o6c/zZ1f07Lg4Zgc=
X-Received: by 2002:a5d:4c49:: with SMTP id n9-v6mr10106622wrt.71.1535397924841;
 Mon, 27 Aug 2018 12:25:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 12:25:04 -0700 (PDT)
In-Reply-To: <CAG48ez0=-nDmQVQiJtD_6ingdWWVJE+y+5_oWQrggQ9Eqg-UKQ@mail.gmail.com>
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-4-jannh@google.com>
 <CALCETrUeRA63Vt_LBOGmUHc_M9gc3J7+ewK6j+sB8P=9ijk7ag@mail.gmail.com> <CAG48ez0=-nDmQVQiJtD_6ingdWWVJE+y+5_oWQrggQ9Eqg-UKQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 12:25:04 -0700
X-Gmail-Original-Message-ID: <CALCETrX6G68o=rjMjG1_02ZjqR9NYz9Byi8XOzqB+R8D=JzFCw@mail.gmail.com>
Message-ID: <CALCETrX6G68o=rjMjG1_02ZjqR9NYz9Byi8XOzqB+R8D=JzFCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] x86: stop calling fixup_exception() from kprobe_fault_handler()
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:22 PM, Jann Horn <jannh@google.com> wrote:
> On Mon, Aug 27, 2018 at 9:02 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
>> > This removes the call into exception fixup that was added in
>> > commit c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for
>> > x86_64").
>> >
>> > On X86, kprobe_fault_handler() is called from two places:
>> > do_general_protection() (for #GP) and kprobes_fault() (for #PF).
>> > In both paths, the fixup_exception() call in the kprobe fault handler is
>> > redundant.
>> >
>> > For #GP, fixup_exception() is called immediately before
>> > kprobe_fault_handler() is invoked - if someone wanted to fix up our #GP,
>> > they've already done so, no need to try again. (This assumes that the
>> > kprobe's fault handler isn't going to do something crazy like changing RIP
>> > so that it suddenly points to an instruction that does userspace access.)
>>
>> This needs review by someone who understands kprobes better than I do.
>> What happens if someone puts a kprobe on a uaccess instruction and the
>> uaccess subsequently faults?
>
> Ugh, good point. I'll admit to not having thought about that properly.
>
> I think that's the "if (unlikely(regs->ip == (unsigned
> long)cur->ainsn.insn))" branch in kprobe_fault_handler(), which I'm
> not touching.
>
> For #PF, both without and with my patch, stuff should get fixed up by
> the normal pagefault handler, since the fixup happens after the kprobe
> handler has fiddled with the exception state.
>
> For #GP, we're already past the fixup call, and I think both without
> and with my patch, nothing will catch it - so I think that's a bug,
> but I don't think it's one I'm introducing.

Fair enough.  If there is indeed a problem, it'll be easier to fix
sanely with your patch applied :)
