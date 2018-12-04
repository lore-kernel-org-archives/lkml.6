Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA43C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC13820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLDH4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:56:09 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45867 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeLDH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:56:09 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so5426966uam.12;
        Mon, 03 Dec 2018 23:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcogNWpZu54uDZOkaOo6fOMgxfk8n223Y+G8bBpezGY=;
        b=Ci+XmGSFhdxmayndFPC1u9cRqm6qaaqkHILC7triNII2aYw7Kh8Wyd0gXMPopG+6KD
         /Gip+Asd53SbJnhIcmPaxWF8ilZAl7t9icUKQYShVdM7jQXkzbslqeW04Jxamo4sjxUM
         +weVP8CXhT1XfuionzD2VQhvcTMRx5oIMnuqoa7mJASXuQTSCUP7aQNqcWNp+VQp75Po
         1n+8yedtGhZGZbotefE/9bMr/RA++JRrlM33Ro0aqrpfVwk431X6rV+HJShC6qn7kwyf
         n7HZrrKouR89fTPpr4zZ8KkEN6jTvxcmZMubgdVoOBB8pf6+h3T/+fSK/ym2zRqYCkun
         8Beg==
X-Gm-Message-State: AA+aEWaOI5KOEK5oHrfWZAhe2oZLDu4HLBeR73vlOk2s8Xpy0VRyE8UE
        bDgu5EVAwDKnbYwGTKEpo5rG14h1VuvXfsU9W4c=
X-Google-Smtp-Source: AFSGD/W+/6Mmk+M8Rxn+4tRYkQMuc89OYlaZ+iDD6zAN/d6+NlG9EVA3oF0X/DRxEc/W52MkPbW3UJiqvD/vfhFyA9k=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr8839307ual.20.1543910167860;
 Mon, 03 Dec 2018 23:56:07 -0800 (PST)
MIME-Version: 1.0
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
 <1542088829-19790-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVsBwL9vcqejfc47GN793wMXdQ=SwEsSUP1fbpMt-OoWw@mail.gmail.com>
 <CALxhOnggoJ8Ds-0AXxg5Tfa7QwccqjWExKuYRuNv+Km1FTVj1w@mail.gmail.com>
In-Reply-To: <CALxhOnggoJ8Ds-0AXxg5Tfa7QwccqjWExKuYRuNv+Km1FTVj1w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 08:55:55 +0100
Message-ID: <CAMuHMdUabwAN7uaSWopZAbHDGDRMPo3eLwZHEmcXes-sta_88Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] m68k: add system call table generation support
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Dec 4, 2018 at 4:22 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Sun, 2 Dec 2018 at 19:27, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Nov 13, 2018 at 7:01 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > The system call tables are in different format in all
> > > architecture and it will be difficult to manually add,
> > > modify or delete the syscall table entries in the res-
> > > pective files. To make it easy by keeping a script and
> > > which will generate the uapi header and syscall table
> > > file. This change will also help to unify the implemen-
> > > tation across all architectures.
> > >
> > > The system call table generation script is added in
> > > kernel/syscalls directory which contain the scripts to
> > > generate both uapi header file and system call table
> > > files. The syscall.tbl will be input for the scripts.
> > >
> > > syscall.tbl contains the list of available system calls
> > > along with system call number and corresponding entry
> > > point. Add a new system call in this architecture will
> > > be possible by adding new entry in the syscall.tbl file.
> > >
> > > Adding a new table entry consisting of:
> > >         - System call number.
> > >         - ABI.
> > >         - System call name.
> > >         - Entry point name.
> > >
> > > syscallhdr.sh and syscalltbl.sh will generate uapi header
> > > unistd_32.h and syscall_table.h files respectively. Both
> > > .sh files will parse the content syscall.tbl to generate
> > > the header and table files. unistd_32.h will be included
> > > by uapi/asm/unistd.h and syscall_table.h is included by
> > > kernel/syscall_table.S - the real system call table.
> > >
> > > ARM, s390 and x86 architecuture does have similar support.
> > > I leverage their implementation to come up with a generic
> > > solution.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh

> > > +       printf "#endif\n"
> > > +       printf "\n"
> > > +       printf "#endif /* %s */" "${fileguard}"
> >
> > The above line is lacking a "\n", causing:
> >
> >     ./arch/m68k/include/generated/uapi/asm/unistd_32.h:370:42:
> > warning: no newline at end of file
>
> I was wondering, I haven't seen this warning when I compiled it.

It seems to depend on the compiler version.
One more thing found by my good old gcc-4.1 ;-)
(which I plan to retire soon, as I need to revert too many "drop support
 for old gcc" patches to keep it working :-(.

> > Changing it to:
> >
> >     printf "#endif /* %s */\n" "${fileguard}"
> >
> > fixes this.
>
> Yes.
>
> > Interestingly, this issue seems to be present on powerpc, parisc, sparc,
> > sh, xtensa (and probably more, I gave up looking), too?
>
> I kept the script to generate files *almost* identical. so this will be present
> all 10 architecture.
>
> > Apart from that, it seems to work fine on m68k.
>
> I have three options here to fix this;
> 1. I can send v6 by fixing this one.
> 2. I can post a single patch which add \n in the script.
> 3. Could you able to add \n in the script.
>
> Please choose one, I can act accordingly.

So your plan is for me to apply your series to the m68k tree?
In that case there's no need to send a v6, I can incorporate the fix myself.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
