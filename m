Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F84EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429D62080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxUcol3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbeKTLAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732448AbeKTLAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:00:33 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80E3214D9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542674054;
        bh=kjPLWuLgkxHxl7KLxin+ondjsAXh8WYjFfawxa6AY5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxUcol3nbqLYQoVCowW25qYy3A2XhaAtq3iGhOWiYMuN3FEV202uBLeZHLJkOHEKE
         3OJUEYAE/TIfiRYIEnUNaOTwTeUQlqgoJBoMZKby5ukRJYxRVoW9Gry8PXaUE1BZfR
         PuYt2+JbFghO1qFvoog0QemQlU6rIbvaZ4VIjyR0=
Received: by mail-wr1-f46.google.com with SMTP id v6so110687wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:34:13 -0800 (PST)
X-Gm-Message-State: AGRZ1gLjYbpni4dETgSHgpoaTgndVE56b5jlZMgYoFDfaaRCX+bVziTS
        +OqjmqzMpkfa5pKSPwm7dcEUBFDaXExtzPHIthQ13g==
X-Google-Smtp-Source: AJdET5c1rjFBv6gQmAbazx4aTLgAZaP0CcSKFJeUcyr9yuTOivZOdHjHpZYJg4OC2iUKEeomwPR9SKVD/bJ+8DXvYwk=
X-Received: by 2002:adf:afdc:: with SMTP id y28-v6mr19350810wrd.176.1542674052084;
 Mon, 19 Nov 2018 16:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco> <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
 <20181119230709.GB4992@cisco> <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
 <20181120003247.a776bej54baxqoxv@brauner.io>
In-Reply-To: <20181120003247.a776bej54baxqoxv@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 16:34:00 -0800
X-Gmail-Original-Message-ID: <CALCETrU+_MkDR4AYkbTB72vDRteOY3TDhQkARL0PyXzc3KUgfQ@mail.gmail.com>
Message-ID: <CALCETrU+_MkDR4AYkbTB72vDRteOY3TDhQkARL0PyXzc3KUgfQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 4:33 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Nov 19, 2018 at 04:27:49PM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 19, 2018 at 3:07 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > These tools also care about ioctls. Adding a system call is a pain,
> > > > but the solution is to make adding system calls less of a pain, not to
> > > > permanently make the Linux ABI worse.
> > >
> > > For user-defined values of "worse" :)
> > >
> >
> > I tend to agree with Tycho here.  But I'm wondering if it might be
> > worth considering a better ioctl.
> >
> > /me dons flame-proof hat
> >
> > We could do:
> >
> > long better_ioctl(int fd, u32 nr, const void *inbuf, size_t inlen,
> > const void *outbuf, size_t outlen);
>
> I'm the writer of this patch so take this with a grain of salt.
> I think it is a bad idea to stop this patch and force us to introduce a
> new type of ioctl().

I agree completely.

> An ioctl() is also not easy to use for this task because we want to add
> a siginfo_t argument which I actually think provides value and makes
> this interface more useful.
>

You could always have a struct procfd_kill and pass a pointer to
*that*.  But sure, it's ugly.
