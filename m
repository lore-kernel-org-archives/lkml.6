Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B037C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77252081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546286910;
	bh=AHNh+5sV20Jm6n+Nt4JXs0G1nBTP2KvgJj/KDwFx3Xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JftZ8us9Lm70T4+A4v6PHe8UX0CEC+0bBLA5Gnc02RNK69eEd3c/ngaSeg4K402gE
	 HPCVkU6bfubObtzXEngcp1CCDLj4wzwbzoMJw5PbmZi3iIZoRPpLtLPqla6E30j+Jq
	 9Ro1dKtgEzuon+LWyYFmdM4GMpqEioT7bp86/sRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeLaUIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbeLaUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 15:08:29 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B4A21871
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546286908;
        bh=AHNh+5sV20Jm6n+Nt4JXs0G1nBTP2KvgJj/KDwFx3Xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t8E/OUAZ9pm7wjTvnB2YVutHI0Rw3Gbb0YO0cMGykhc5FV2BkkLCL/hCadzZWMJKk
         mo7Kt0vV4yhwjj31stI6TVtmu6lHfxd9NPthIfo636R7SD0l/lUIn+MwQNZ7nndhB/
         sGBTX8ftddyB24iA96xqOFczbeZQO4KcnEXyTIOQ=
Received: by mail-wm1-f45.google.com with SMTP id d15so24003075wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 12:08:28 -0800 (PST)
X-Gm-Message-State: AA+aEWbqWzY8TJgnpcg7bffiHerY/mjAQkLsQQTG3GDDctvqZrvo6ttD
        TKBXPMNEgFLbLtHxx6jpTGGt554E3jU98nxb9LT5UA==
X-Google-Smtp-Source: AFSGD/Uvm3yw+Q4rDuHOa68breLDqDngNTbdXmXyLv5GFEQmbFfSsvXpKY4Rb34fkbsXvfulhGOCLShxxWfr+lHFg6w=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr33304419wmf.32.1546286907085;
 Mon, 31 Dec 2018 12:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20181231072112.21051-1-namit@vmware.com> <20181231072112.21051-2-namit@vmware.com>
In-Reply-To: <20181231072112.21051-2-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 31 Dec 2018 12:08:15 -0800
X-Gmail-Original-Message-ID: <CALCETrXqdgqYgsKd0xR7RMvVvotu1u==+n3gYyDgTZvbvmJ5VQ@mail.gmail.com>
Message-ID: <CALCETrXqdgqYgsKd0xR7RMvVvotu1u==+n3gYyDgTZvbvmJ5VQ@mail.gmail.com>
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
>
> It is sometimes beneficial to have a restartable sequence - very few
> instructions which if they are preempted jump to a predefined point.
>
> To provide such functionality on x86-64, we use an empty REX-prefix
> (opcode 0x40) as an indication for instruction in such a sequence. Before
> calling the schedule IRQ routine, if the "magic" prefix is found, we
> call a routine to adjust the instruction pointer.  It is expected that
> this opcode is not in common use.
>
> The following patch will make use of this function. Since there are no
> other users (yet?), the patch does not bother to create a general
> infrastructure and API that others can use for such sequences. Yet, it
> should not be hard to make such extension later.

The following patch does not use it.  Can you update this?


> +asmlinkage __visible void restart_kernel_rseq(struct pt_regs *regs)
> +{
> +       if (user_mode(regs) || *(u8 *)regs->ip != KERNEL_RESTARTABLE_PREFIX)
> +               return;

else?

I suspect something is missing here.  Or I'm very confused.

> +}
