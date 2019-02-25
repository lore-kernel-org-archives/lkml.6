Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E638213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551118597;
	bh=sUmXborKR9L/2IbHxrvDCJBIawuflLI0cGtgvZ4I56o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NTd0p5lyjkTSjJWaAIz3HZhHAsYjhkTz93sAdWxrOZzAHXxehk6d2QR9NEE+/vmHI
	 L/c8Ds6tuoRsKptNs6bmYAqryWfD39f5FamUpG+el2Cd3jEnJzaEsy0SDsc8xP9Kfk
	 5/jRMqbul67qKyb5oM0+7zuSBZoRbKmeicxg62oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfBYSQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:16:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYSQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:16:35 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A05217F4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551118594;
        bh=sUmXborKR9L/2IbHxrvDCJBIawuflLI0cGtgvZ4I56o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYj5I/HcIRRXJXCQAkIxxj+MxyB7+JIRR1E9kDbmwonUvZ9axqLd2UsXmyAf2Wy3Y
         V9ryOvsp8tYUXRIB0tdYlcr7KE5QL0dSPLGOPNImNumA1gizhiDR+jGTHjDrF1cEmX
         oyzjGiinvtcoxo2HArGFJ9tv5NRzwFe/zLYonwHg=
Received: by mail-wm1-f44.google.com with SMTP id v26so125702wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:16:34 -0800 (PST)
X-Gm-Message-State: AHQUAubHQVR4Ek6qyUYt3Bxooc+hccgOZrZVz7MauHt+bYKbsSExwzj/
        0V7ebwjvg4EpXo9UCH2TlQUZm4UyB5WJ+Mf8zjHEhA==
X-Google-Smtp-Source: AHgI3IZNMh2oBuErXXXKn1ATRvHGxgYLaVPgF/f33RcnuUaG1wsiesQQ1onUl/xCky7SYjHM0o2IsaIxI8oYpWeUNhI=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr79655wml.108.1551118592647;
 Mon, 25 Feb 2019 10:16:32 -0800 (PST)
MIME-Version: 1.0
References: <155110348217.21156.3874419272673328527.stgit@devbox>
 <155110354092.21156.13871336589042178985.stgit@devbox> <20190225150603.GE32494@hirez.programming.kicks-ass.net>
 <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
In-Reply-To: <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Feb 2019 10:16:20 -0800
X-Gmail-Original-Message-ID: <CALCETrU1dx+Om9k0Q7KbXSVRUpapFWe1bLr7ETm8Rdq=7c9AHw@mail.gmail.com>
Message-ID: <CALCETrU1dx+Om9k0Q7KbXSVRUpapFWe1bLr7ETm8Rdq=7c9AHw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read functions
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 9:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 25, 2019 at 7:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Would something like so work for people?
>
> Looks reasonable to me.
>
> > Why not keep it simple:
> >
> >         mm_segment_t old_fs = get_fs();
> >
> >         set_fs(USER_DS);
> >         ret = __strncpy...();
> >         set_fs(old_fd);
> >
> >         return ret;
>
> So none of this code looks sane. First odd, there's no real reason to
> use __get_user(). The thing should never be used. It does the whole
> stac/clac for every byte.
>
> In the copy_from_user() case, I suggested re-doing it as one common
> routine without the set_fs() dance for the "already there" case to
> simplify error handling. Here it doesn't do that.
>
> But honestly, I think for the strncpy case, we could just do
>
>   long strncpy_from_unsafe_user(char *dst, const void __user *src, long count)
>   {
>       long ret;
>       mm_segment_t old_fs = get_fs();
>
>       set_fs(USER_DS);
>       pagefault_disable();
>       ret = strncpy_from_user(dst, src, count);
>       pagefault_enable();
>       set_fs(old_fs);
>       return ret;
>   }
>
> and be done with it. Efficient and simple.
>
> Note: the above will *only* work for actual user addresses, because
> strncpy_from_user() does that proper range check.
>

Can we also stick the nmi_uaccess_okay() thing in here and kill an
extra bird with the same stone?  Basically, this is "I have no idea
what context I'm in, but I want to try to read a string from current's
address space, so do your best."  In which case, we need to handle the
fact that we might be in KERNEL_DS *and* we need to handle the fact
that CR3 might be wrong.
