Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CDF208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoRCg6vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CDF208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH0Wuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeH0Wuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:50:32 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3F5214C5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535396561;
        bh=jOQeFCFgulsSIlVU0+/by2syD0T1c8OeOWxloZhebtA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eoRCg6vorb72rlRoflMEu4iI+HMHHm18r0i4RcXhRq38vEoqbisiiQXZkSCYIiXSW
         eT8ZTsJJtkK1Ju178+t2IQ+2csmoLhoHXPvcI4YVDvctqho+9SUveMCBo1gbU1w0i0
         PdqYWPNW3qvTWKP/mHxLgP3FOTiCGDCR2zgJpgFY=
Received: by mail-wr1-f47.google.com with SMTP id w11-v6so23962wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:02:40 -0700 (PDT)
X-Gm-Message-State: APzg51AwUsazs7x3rThWCSm8E1uQCU5PWtZIl2ueGUY669IQoEZJqtcK
        JMJEss8/8pQ+SHOvpuWe3mSQfkLhyA1vmp+9pjaqZA==
X-Google-Smtp-Source: ANB0VdaINVSSd/f3IUxKkHg6gUqfwwWmWa1yJPSDI2ZHcXAI9FbSmo8J/kHAre+RyE66TP3XYTJGmh3h5JZNmS1LENo=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr9821323wrm.21.1535396559383;
 Mon, 27 Aug 2018 12:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 12:02:19 -0700 (PDT)
In-Reply-To: <20180827185631.163506-4-jannh@google.com>
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-4-jannh@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 12:02:19 -0700
X-Gmail-Original-Message-ID: <CALCETrUeRA63Vt_LBOGmUHc_M9gc3J7+ewK6j+sB8P=9ijk7ag@mail.gmail.com>
Message-ID: <CALCETrUeRA63Vt_LBOGmUHc_M9gc3J7+ewK6j+sB8P=9ijk7ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] x86: stop calling fixup_exception() from kprobe_fault_handler()
To:     Jann Horn <jannh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
> This removes the call into exception fixup that was added in
> commit c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for
> x86_64").
>
> On X86, kprobe_fault_handler() is called from two places:
> do_general_protection() (for #GP) and kprobes_fault() (for #PF).
> In both paths, the fixup_exception() call in the kprobe fault handler is
> redundant.
>
> For #GP, fixup_exception() is called immediately before
> kprobe_fault_handler() is invoked - if someone wanted to fix up our #GP,
> they've already done so, no need to try again. (This assumes that the
> kprobe's fault handler isn't going to do something crazy like changing RIP
> so that it suddenly points to an instruction that does userspace access.)

This needs review by someone who understands kprobes better than I do.
What happens if someone puts a kprobe on a uaccess instruction and the
uaccess subsequently faults?

>
> For #PF on a kernel address from kernel space, after the kprobe fault
> handler has run, we'll go into no_context(), which calls fixup_exception().
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 467ac22691b0..7315ac202aad 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1021,13 +1021,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>                 if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
>                         return 1;
>
> -               /*
> -                * In case the user-specified fault handler returned
> -                * zero, try to fix up.
> -                */
> -               if (fixup_exception(regs, trapnr))
> -                       return 1;
> -
>                 /* fixup routine could not handle it. */
>         }
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
