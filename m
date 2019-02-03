Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6AFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B42A217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkUQ7e6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBCSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 13:34:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40463 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfBCSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 13:34:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id z3so7265863vsf.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/Eo19UyMM1/yDFrFs8P3azPRyQpK7JynsH5sza0dOQ=;
        b=fkUQ7e6XsmR30VStRa4bpZt7Y7U+5gRZPgT8BquxjzexoBbDkCLoGY1Mhxb6L29vPe
         stJqDqtijjZkoXSLyX6VclUtA/5XaH1BlvNpFP5vFBISs+nPXFu0YIbj2a9k/5rUUb3R
         S+gBGenVKyDQDr/MBZHkR29LGiXIThM4Y/0Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/Eo19UyMM1/yDFrFs8P3azPRyQpK7JynsH5sza0dOQ=;
        b=m+2KEf5gSQjARSPq6flvcwygDeo1uVZYU6qkExHVPPR0p9eN0YVaorPplg8drFVbJC
         mpODSdspm0lVJuGlFtfgGF4jBNyL0T1GCNu5UUZae/nxLtycXPA5h801q6Y2nBPkv+Ci
         kMSmO5nNy5fZCF5iM/414ClBewAGiffbxWn5IRRHpaWAOYH7Mo9AkH6eJNGrv3PNPAkA
         C9q4vMu0hy++5OPzk1L5WtIH+6hEJVNv4T8no6pzIfND/yXMivVJ7aLJOJ243F+99Sjq
         240DgeIEowlnNfnige056ZjT4HA5dD7rreJkMTJ1DFRTXrmgChpuGCoMBUr25yItoFAS
         R4yg==
X-Gm-Message-State: AJcUukfWsRShIHUpUsGKATM5ra2t8RG+x4omzcESkbWyVg4ivapLDiMO
        IViT/yAgJH2W3exuGLEHKGHBGN2Z6/M=
X-Google-Smtp-Source: ALg8bN77k9TcBRCJvKgr9zQ6A3QNlVaZe4q+wJZdoRKIzSRc+CVfAkx8zGLcQ4Wfs44kRz1Jn2e/sA==
X-Received: by 2002:a67:4482:: with SMTP id y2mr20648903vsf.4.1549218851717;
        Sun, 03 Feb 2019 10:34:11 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id x20sm7768357uan.12.2019.02.03.10.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 10:34:10 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id v70so2711002vkv.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 10:34:10 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr20132141vka.4.1549218849622;
 Sun, 03 Feb 2019 10:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20190203074939.7261-1-jackoalan@gmail.com> <20190203083933.ee4a6j4mdecesbn2@brauner.io>
In-Reply-To: <20190203083933.ee4a6j4mdecesbn2@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 3 Feb 2019 10:33:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
Message-ID: <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
To:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 12:39 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Sat, Feb 02, 2019 at 09:49:38PM -1000, Jack Andersen wrote:
> > The patch titled
> > `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> > created a regression for users of PTRACE_GETSIGINFO needing to
> > discern signals that were raised via the tgkill syscall.
> >
> > A notable user of this tgkill+ptrace combination is lldb while
> > debugging a multithreaded program. Without the ability to detect a
> > SIGSTOP originating from tgkill, lldb does not have a way to
> > synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> > entire process.
> >
> > This patch allocates the siginfo as it did previously whenever the
> > SI_TKILL code is present.
> >
> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
>
> The  commit you're trying to fix has been discussed before wrt to
> seccomp tests:
>
> commit 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
> Author: Kees Cook <keescook@chromium.org>
> Date:   Thu Dec 6 15:50:38 2018 -0800
>
>     selftests/seccomp: Remove SIGSTOP si_pid check
>
>     Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
>     means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
>     Since it's believed[1] there are no other userspace things depending on the
>     old behavior, this removes the behavioral check in the selftest, since it's
>     more a "extra" sanity check (which turns out, maybe, not to have been
>     useful to test).
>
>     [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
>
>     Reported-by: Tycho Andersen <tycho@tycho.ws>
>     Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>     Signed-off-by: Shuah Khan <shuah@kernel.org>
>
> Ccing Kees on this. Seems that this commit might be worth given that
> there's some parts of userspace relying on it and not just internal
> kernel tests.

Yup, so this is the "real" userspace example that Eric was looking for.

Eric, how does the proposed fix look? I'd also like to revert my
seccomp selftest change too, since it clearly found a real-world use.
:)

-- 
Kees Cook
