Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7C721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeKVDt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:49:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33589 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKVDt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:49:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so4641684qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/nbbnLcoB2UD/mJAsAgrOoPAKxIOgOaJZPIaXY/YOo=;
        b=mWNRdzDpnKmU415fwZvSDDqkXeSzE14DpmA8vjyZmZmFXuJ0U/hxIP3FDAozN4vuih
         08mZGwdgdjwbNAKweZHmlm2BvtlDosTKAhy2c85+jy3Favr3Y0q0z3XciuaTlgQZo3qo
         PvKEdrOMmcQ9qfbT99qgKkYRd4NaeFr4nlhh0bv87gMi2nJtFa+2x7LfeW0w1nQ7hjCF
         WbrzzmYdUIzYF+AmKxiS9C3aR5Z+K9uUNlwq5rxvN1I70jy/2A4WDHfxQsFBNxBlQZ6p
         AQ3nS2wXllcnSs2K98P1yhNNy+P7C7EQXoGv5HmFtElXl+8zMjNnbg7HCRuECXzntVht
         iL1Q==
X-Gm-Message-State: AGRZ1gKgIV3nscTsvcrhMwxzcLmdXJTDeTFWlODxs8qvTsURlbqhCVyw
        grQNHNe08ftfTQkRArWHnaUbxBOjHML/PdWBoMHCQmCx
X-Google-Smtp-Source: AJdET5dOReUZzP5i29xsDu/xS4HE76l9/jsm14iYRyX540HXzjkh81Bq2qVFTQbtv9jT9wr9pmtdyCODHrVLN3CGguY=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr6717396qte.212.1542820479445;
 Wed, 21 Nov 2018 09:14:39 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
In-Reply-To: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Nov 2018 18:14:23 +0100
Message-ID: <CAK8P3a2E7RAOSUJRbc_0WeQO8vVH+GsZXuo=GMHj0Rvu+_A2ZQ@mail.gmail.com>
Subject: Re: Cleaning up numbering for new x86 syscalls?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>, carlos@redhat.com,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:25 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Hi all-
>
> We currently have some giant turds in the way that syscalls are
> numbered.  We have the x86_32 table, which is totally sane other than
> some legacy multiplexers.  Then we have the x86_64 table, which is,
> um, demented:
>
>  - The numbers don't match x86_32.  I have no idea why.

I think it was an early attempt at cleanup up the table, and only
adding those that were still used. Back in the days, each architecture
had its own table, and of course they started out as separate
top-level architectures.

>  - We use bit 30, which triggers in_x32_syscall().  It should have
> been bit 31, bit I digress.
>
>  - We have this weird set of extra x32 syscalls that start at 512.
> Who wants to bet whether we have no bugs if someone does syscall with,
> say, nr == 512 (i.e. not 512 | BIT(30)) or nr == (16 | BIT(30))?  The
> latter would be non-compat ioctl with in_x32_syscall() set and hence
> in_compat_syscall() set.

The comment in the table says it's purely for keeping the calls
in separate cache lines. I don't know if the cache lines make
a difference in the end, but it seems that once we start running
into the x32 syscall numbers, I think we just treat them like any
others, we just choose to never call them from a 64-bit glibc.

> I propose we consider some subset of the following:
>
> 1. Introduce restart_syscall_2().  Make its number be 1024.  Maybe
> someday we could start using it instead of restart_syscall().  The
> only issue I can see is programs that allow restart_syscall() using
> seccomp but don't allow the new variant.
>
> 2. Introduce an outright ban on new syscalls with nr < 1024.

This would leave a hole of several hundred numbers if we do it
for all architectures. Wasting multiple kilobytes for a cosmetic
cleanup might be considered excessive.

> 3. Introduce an outright ban on the addition of new __x32_compat
> syscalls.  If new compat hacks are needed, they can use
> in_compat_syscall(), thank you very much.

I would definitely want to keep anything regarding x32 out of the
common syscall implementation. If you want to add on to that
pile, please do it in arch/x86, not in kernel/ or fs/.

If we decide that x32 is a failed experiment and we don't keep
it working in the future, let's just kill it off right away. I'm fairly
sure nobody depends on it for anything real, the only users I
could find are either for showing off benchmark results or for
playing around with it for fun. Most of that fun part has apparently
ended many years ago, but there is still some work going into
debian/x32. We probably need to coordinate with them and see
if they know of actual users before removing it. Popcon lists
5 active users [1] and a sharp downward trend.

> 4. Modify the wrappers of the __x32_compat entries so that they will
> return -ENOSYS if in_x32_syscall() returns false.

No objection here, but what would that help?

> 5. Adjust the scripts so that we only have to wire up new syscalls
> once.  They'll have a nr above 1024, and they'll have the same nr on
> all x86 variants.
>
> Thoughts?

I would definitely welcome assigning the same syscall numbers across
all architectures. It is a needless burden for the libc developers to
figure out for each syscall which kernel is known to support it.
When a call gets added, they typically add logic to check for the
system call at runtime, but for older syscalls, it helps to know when
all architectures support it once the minimum kernel version for
a libc has been raised beyond that.

Please see also the work that Firoz Khan has been posting
for generalizing the tables on all architectures to use the
format we have on x86, arm and s390. I hope we can merge it
all for 4.21, and then build on top of that for generalization and
cleanups.

      Arnd

[1] https://popcon.debian.org/stat/sub-x32.png
