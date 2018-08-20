Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C1BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B721760
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BqakvhwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58B721760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHUDGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:06:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55381 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeHUDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:06:32 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so1807490itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPL1WqoUGHlUSj/j69gUDeDqGZu6DtEHdBCbsNWzBuU=;
        b=BqakvhwYMHRVF6SHFHWA5Hb17jq+dN7Yo/yf3A2d5zOdsWWY7uvWYo3eLQtmgiLoFw
         H8VaNApIODEv/DPfHF1U4N8itDLws7UVTDM+cscDKMcNJQXC13Fs9nPJ7AQ4ulGIkxLH
         lJgp/aqeeM/Fq+H5tqW1LVbuw+mJVky6YMprA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPL1WqoUGHlUSj/j69gUDeDqGZu6DtEHdBCbsNWzBuU=;
        b=Td2rrARQZ6gv7CiPllIzdNpMMZjdWVOAoRrIqqUU735dw0lCWGILI1+wqfYKvS7Yth
         Wvlg79Cg5AakvXac6Rw61oPZ57rIGrqgnq4PZuZcCh4MA6onM8/sTkifVLK6U3ipEvwx
         ekm+5695Um00vpO+H8JP/WzMKxbwTxxjYrTFA/h56V2XxFkecgJIsfhmbFRWmmlM/sZ+
         /Yftvr4YGckfqOMxs3OIqK+UCg1elIYyiTNXt9ajHaRoXZOguRI+Siu86T4cG1CgBWcw
         RYmUAWw/8U6f/yMgm2ACIFYPa1hWqdGH4Q5fXlzv3rdyv9JMfzGwpTuOBjguBWKYkQQw
         c0Eg==
X-Gm-Message-State: AOUpUlGp+I9XLD6ZzXiwKr+uGAaKiO4APR5vx124ZhsLGFInrqPl3mBC
        IHrbSuMk5Q1sA2ENpPX2Bjxxw17EFeu1NULXQ4c=
X-Google-Smtp-Source: AA+uWPxXAEpC8oRaScCvPUPoUv0EACEoYaiseh3aFGtSo17jIJaekh7hS+6D7SuxIs9HEV5qbnhtxY3snrNYQvLJ6CI=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr35241119itb.123.1534808929886;
 Mon, 20 Aug 2018 16:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
 <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com> <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
In-Reply-To: <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 16:48:38 -0700
Message-ID: <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Simon Horman <horms@verge.net.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        natechancellor@gmail.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 10:58 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + akpm, Linus
>
> Bumping for review.

Ugh. I am not personally a huge fan of this endless "fix up one at a time".

Just do a patch that removes current_text_addr() entirely and be done
with it, if that's what we want the end result to be.

Don't bother with these small "let's remove the remaining ones one by
one". Just get it over and done with.

                Linus
