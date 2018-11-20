Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C12C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D3A20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVHQjDrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D3A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeKTSBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:01:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36381 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKTSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:01:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so1094731wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xFTYpDqArKpE8nrO0ZL5DI6HXwWmak4a9c1Uk03sWsg=;
        b=UVHQjDrwUXxpeqvJ32XjzUj/wJmpH41i0UZel872+LjIxrOK8XaJr5hMPsGG1ImGCG
         Jne97CHLNdZst5E6TODYc2C7LzO0d1EULlHcXLe6c4UKUf+rZQ6NmLFIkGAqhZTlmoCL
         V2EriaIBFu1yLODJaRZDfQ6a9t3iCE6CO6Z1ZV5rNxfV+iiMwnCko377omFBdequrW+Q
         HisNpJa8JRAfhO8LP6vXJPPnjvarT7bff/qRrD1S3sB6LmR7OEjE/ED/dnsJ3q3kMiiZ
         86n/han2KUuibzizFvNoqL6uO/DKaB71ORp0cnReosfzvxoSwu1xwPPY+aQ2NR/b0mhp
         2Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFTYpDqArKpE8nrO0ZL5DI6HXwWmak4a9c1Uk03sWsg=;
        b=CjX01pfC9SBsfxOAwzvk3KTXAwYtj4YnrF45lE0r+9nKnWY/3CC5otnMQrTpRoEZvr
         jihZJ2jgbLbds4ff/eidE5hwuo8wScDzAlIlPHOTiU2UOOAuTbKiTTQJFCdjyIsGHovN
         EzsxFM7TYs9Q5i1/o6g4EynOu73BdngQDI0ZNEhVEoxVaZhpvxwbfSg6NUpn2vLbpKyx
         7VfbM8fqNUYVa0sazRbnjfkWOzgtwxPQWzArJkfsTv/PSAjgwT3ZOLoAyuBit3Km4dww
         ab+I5Z14mugOR98VGxaOxr9ysZdj8esmUBkanTlVGMEyZfOESjHjgJmTua3u65GPtgyw
         6eOQ==
X-Gm-Message-State: AA+aEWZzVux1CHQtmRqge+XgeK3Pdg0BZWEJ77mPnMK2IDlzSH0RbXZ9
        BNr2Wf9SDRugBlv1CehZ90E=
X-Google-Smtp-Source: AJdET5dQHvAlzp1KTU7qqPoQT1fOslUMR4v7REDJo8eJxawy7nQmnPuRdvQyU61IouF0w/n8dVllEg==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr442933wmf.32.1542699235544;
        Mon, 19 Nov 2018 23:33:55 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i7-v6sm48722289wrb.3.2018.11.19.23.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 23:33:54 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:33:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Subject: Re: Cleaning up numbering for new x86 syscalls?
Message-ID: <20181120073352.GA79825@gmail.com>
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> Hi all-
> 
> We currently have some giant turds in the way that syscalls are
> numbered.  We have the x86_32 table, which is totally sane other than
> some legacy multiplexers.  Then we have the x86_64 table, which is,
> um, demented:
> 
>  - The numbers don't match x86_32.  I have no idea why.
> 
>  - We use bit 30, which triggers in_x32_syscall().  It should have
> been bit 31, bit I digress.
> 
>  - We have this weird set of extra x32 syscalls that start at 512.
> Who wants to bet whether we have no bugs if someone does syscall with,
> say, nr == 512 (i.e. not 512 | BIT(30)) or nr == (16 | BIT(30))?  The
> latter would be non-compat ioctl with in_x32_syscall() set and hence
> in_compat_syscall() set.
> 
>  - Bloody restart_syscall() has a different number on x86_64 and
> x64_32, which is a big mess.
> 
> I propose we consider some subset of the following:
> 
> 1. Introduce restart_syscall_2().  Make its number be 1024.  Maybe
> someday we could start using it instead of restart_syscall().  The
> only issue I can see is programs that allow restart_syscall() using
> seccomp but don't allow the new variant.
> 
> 2. Introduce an outright ban on new syscalls with nr < 1024.

Also let's make sure it results in a build error or boot panic if someone 
tries.

> 3. Introduce an outright ban on the addition of new __x32_compat
> syscalls.  If new compat hacks are needed, they can use
> in_compat_syscall(), thank you very much.

Here too build-time and runtime enforcement would be nice.

> 4. Modify the wrappers of the __x32_compat entries so that they will
> return -ENOSYS if in_x32_syscall() returns false.
> 
> 5. Adjust the scripts so that we only have to wire up new syscalls
> once.  They'll have a nr above 1024, and they'll have the same nr on
> all x86 variants.
> 
> Thoughts?

Fully agreed:

6. Is x32 even used in practice? I still think it was a mistake to add it 
   and some significant distributions like Fedora are not enabling it.

Barring any sane way to phase out x32 support I'd suggest we implement 
all your suggestions.

Thanks,

	Ingo
