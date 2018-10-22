Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC2FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8562220779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHvLiAKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8562220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJVSKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:10:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41331 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeJVSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:10:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so36334494lja.8;
        Mon, 22 Oct 2018 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozISLo3xAi9TSU5L7p7SKN5+d47Xsy+1ctEHN8dJBWk=;
        b=fHvLiAKway712yQlSAlR/phPbI0sBqLJ1r5NThC+Snj91UrsM/uuzcbSkL0O6xoxNu
         SNc1rAwajjmjWPCU3mToGljfwOzCYNgoD1tPkg7F7Kv9aLHbw671AGLO5ozfChqpfTcH
         3LEhWVHGw2crLAVcBFYAuI58v/VrpL9xxPTA4qRMYMfpqI/aS06L+kU1EXqQxMxb7DQb
         RHkLFIO7mc6Sdf4iYSwkaD5EdridUsOY1dRi7tk7l7D/Wffn8ZSz71bwPBbsxz6ICpxE
         s99ofowUWeHxP2EPdsq3lDPtkhPhUIL+6CFpt/4KYBhDQS4kxn0lATpdJa/uul1HO/5I
         sZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozISLo3xAi9TSU5L7p7SKN5+d47Xsy+1ctEHN8dJBWk=;
        b=EI6saGjdvhrP7haEhUeGkCsVDSer7vKKcgC2oUEfGMbIjG1xSWgDC2MGjg070IRizr
         xbahJ1n3KLLoCq4ujr9D/FuGAiobwNhgPhDYNronZnRvNTzShr5qsJ3aivQ7YehFfSNW
         athFDpiFS16V841clJ9x2eb8bJZ/Bgvt5edQVAA8259dzOZEwBZlZ3vKsoxnNHWyUxAp
         s5HCEgJjtrcXz2lt5ORAWsfzY0i1VpFZJjsBv/HnKKw6ZIhxkiBjtvFR7rVplE9pRyAe
         r11GanQTa2xMtTGpFA9upuS5KQAzA3UR86wWjjAPbtnebFZq2mAQB2dG+/srjMzK7zKq
         6IyQ==
X-Gm-Message-State: ABuFfojsBRdDUp7S2egx+fvNsSdXtT52Qk3cNCkAx/pQpTjQIlAVduR4
        r8SwAhaAyJKzTHT0ZVawbNPtlgIJWvJVPnyLwrA=
X-Google-Smtp-Source: AJdET5dSofrrtfZt2GwnlLDQOUZJbGFiD0o1r0By8H6HhInbXEa8/2npupJnE8IbaymFRE8UeIYlK43epsx7o43H2dY=
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr7325701ljk.139.1540201930509;
 Mon, 22 Oct 2018 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com> <f46baa5bb0e3373c89d09b6e0d15170902e5f55c.camel@perches.com>
In-Reply-To: <f46baa5bb0e3373c89d09b6e0d15170902e5f55c.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 11:51:59 +0200
Message-ID: <CANiq72=Eo-c7M1g1gmE0kXNpxe4vkOBT54n9gMB9UBSEfzTMAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use __fallthrough
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 8:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2018-10-21 at 19:14 +0200, Miguel Ojeda wrote:
> > Let gcc know these cases are meant to fall through to the next label
> > by annotating them with the new __fallthrough statement attribute;
> > and remove the comment since it conveys the same information
> > (which was also parsed by gcc to suppress the warning).
>
> Instead of many individual conversion patches,
> perhaps a script to do all the conversions at once.

Note that this was only an example of the attribute (some people asked
for an example when introducing another one, so I preemptively did it
for this one).

Doing the conversion (and how :-) I left it for afterwards, if people
agree with the attribute.

>
> Maybe:
>
> pattern='(?:\/\*\s*fall(?:\s*|\s*\-\s*)thr(?:u|ough)\s*\*\/|\/\/\s*fall\s*thr(?:u|ough)\s*$)'
> git grep -P -i --name-only "$pattern" -- '*.[ch]' |
>     xargs perl -p -i -e "s/$pattern/__fallthrough;/gi"


By the way, I checked first if coccinelle could match input comments,
but it doesn't, according to Julia. I am also thinking whether a
compiler plugin could easily do this, but I don't have my hopes high
given these are comments...

Also, regardless of how it is done, the patches need to be sent
individually to maintainers, no? I have a vague memory that big &
automated conversions were a bit frozen upon in the kernel. Greg...?

Cheers,
Miguel
