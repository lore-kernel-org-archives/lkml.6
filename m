Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2320CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7E620818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXGMmccz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7E620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeKHGRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKHGRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:17:16 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0CA20818
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 20:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541623511;
        bh=sYAG5qSkNjkdVgQXlXDaMklo4lLlxNQp41L/8eGK9GM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iXGMmcczzWFpdyNLchEdjKWD1asjTbouQdXbI/ytz46q82qDEF5DH4Jwz5TnJv+sY
         WyMWpDe8rBaV+3Bmd+r3vUAEfPAtXU15S8mf/7uEVjhQWYB8OQPJdKlEqRwV0D85Sj
         1u+Zgxl+py44TdOOhGQCYAtwhvyArVCeMr1fFQgY=
Received: by mail-wr1-f50.google.com with SMTP id x12-v6so18852667wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:45:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gJMCt9VdrAN34IuP6rls0DHH0B512jneLEyOXKsL/jr1z44RRzv
        km4nsszpxi71I2Pxrm+II7rOqDjD+6QUYIoNjjujQQ==
X-Google-Smtp-Source: AJdET5dnuodkriX23fX0+OZmuFRQiwyQO9UL5cD+Xq8ANWWWRM/loouIbUGpucBfbO5U5E8wGu/QUffUo4bpNnR6j1Q=
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr1614172wrr.308.1541623509888;
 Wed, 07 Nov 2018 12:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20181107042751.3b519062@akathisia>
In-Reply-To: <20181107042751.3b519062@akathisia>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 7 Nov 2018 12:44:58 -0800
X-Gmail-Original-Message-ID: <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Message-ID: <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GET_SYSCALL_INFO request
To:     lineprinter@altlinux.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        strace-devel@lists.strace.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 6, 2018, at 7:27 PM, Elvira Khabirova <lineprinter@altlinux.org> w=
rote:
>
> PTRACE_GET_SYSCALL_INFO lets ptracer obtain details of the syscall
> the tracee is blocked in. The request returns meaningful data only
> when the tracee is in a syscall-enter-stop or a syscall-exit-stop.
>
> There are two reasons for a special syscall-related ptrace request.
>
> Firstly, with the current ptrace API there are cases when ptracer cannot
> retrieve necessary information about syscalls. Some examples include:
> * The notorious int-0x80-from-64-bit-task issue. See [1] for details.
> In short, if a 64-bit task performs a syscall through int 0x80, its trace=
r
> has no reliable means to find out that the syscall was, in fact,
> a compat syscall, and misidentifies it.
> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
> Common practice is to keep track of the sequence of ptrace-stops in order
> not to mix the two syscall-stops up. But it is not as simple as it looks;
> for example, strace had a (just recently fixed) long-standing bug where
> attaching strace to a tracee that is performing the execve system call
> led to the tracer identifying the following syscall-exit-stop as
> syscall-enter-stop, which messed up all the state tracking.
> * Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721b=
e3
> ("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
> and process_vm_readv become unavailable when the process dumpable flag
> is cleared. On ia64 this results in all syscall arguments being unavailab=
le.
>
> Secondly, ptracers also have to support a lot of arch-specific code for
> obtaining information about the tracee. For some architectures, this
> requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
> argument and return value.
>
> PTRACE_GET_SYSCALL_INFO returns the following structure:
>
> struct ptrace_syscall_info {
>    __u8 op; /* 0 for entry, 1 for exit */

Please consider adding another op for a seccomp stop.

>    __u8 __pad0[7];
>    union {
>        struct {
>            __u64 nr;
>            __u64 ip;
>            __u64 args[6];
>            __u8 is_compat;
>            __u8 __pad1[7];
>        } entry_info;
>        struct {
>            __s64 rval;
>            __u8 is_error;
>            __u8 __pad2[7];
>        } exit_info;
>    };
> };
>
> The structure was chosen according to [2], except for two changes.
> First: instead of an arch field with a value of AUDIT_ARCH_*, a boolean
> is_compat value is returned, because a) not all arches have an AUDIT_ARCH=
_*
> defined for them, b) the tracer already knows what *arch* it is running o=
n,
> but it does not know whether the tracee/syscall is in compat mode or not.

I don=E2=80=99t like this for a few reasons:

1. A 32-bit tracer can=E2=80=99t readily tell what is_compat =3D=3D 0 means=
.

2. There is no actual guarantee that there are only two syscall
architectures available.  In fact, I think that arm64 is seriously
considering adding a third.  x86 ought to have three, but, for
arguably dubious historical reasons, it only has two, and x32 is
distinguished only by nr.

3. Your patch will be a whole lot shorter if you use
syscall_get_arch().  You'd have to add syscall_get_arch()
implementations for the remaining architectures, but that's still less
code.

> Second: a boolean is_error value is added to rval. This way the tracer ca=
n
> more reliably distinguish a return value from an error value.

Sounds reasonable to me.

Also, maybe use the extra parameter to ptrace to have userspace pass
in the size of the structure so that more fields can be added later if
needed.
