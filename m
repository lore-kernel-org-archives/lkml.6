Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850C32075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850C32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJHPeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:34:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40373 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJHPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:34:18 -0400
Received: by mail-ua1-f65.google.com with SMTP id c21so5138610uap.7;
        Mon, 08 Oct 2018 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+i0d/eZ830ZcQw7SqRYZNFUW03iPkwPgliiumsiRJl4=;
        b=KhmSe6gYfUKG9nZ/qiDfCgKXaAPxHNMhFCw8ptyRvIaLkiK80g0H9hZoS5AWxB8Mg4
         1TzjvpzCQ9laHeV9Zz/5/TBTiPBiNqRKH+z1PeZX67wcVe9SMgwhVxANRMNu0A0uOr2X
         qLI0wyjvTN6EHAQocFsFy/XcylGulDoxJKL+faaImzTunnfePWsTtmGQS/zKx/nvjim5
         r8D4wrA05VaUystXt5eiZun2z472rjWOAtkzf/4nF8t6Tek3blVOTW8CCKW2mlWEXJj0
         lklVAdybfF/FR92TP4/B9wlz5/cpYVf80xC7L1f9gW5iqUq6hgreZbFEvusfJPstWRDH
         hzRA==
X-Gm-Message-State: ABuFfoib5vx/RLhqMNvO/plhnH0IMMFArooex9Rs3HYbHoRWw7wFzfuX
        QFew116NqdW93Guxu+eWYd1ugssom5UAAmYFe6ym7g==
X-Google-Smtp-Source: ACcGV60+YGwNQKXcImvfTovFZ2JLBPAAXz4EvtWuhUUtPn48Jrv0p0mD3eS9kmrFqroShPqnadDGpIKtw6XyZ1OXXj8=
X-Received: by 2002:a9f:35f1:: with SMTP id u46-v6mr8911639uad.20.1538987025286;
 Mon, 08 Oct 2018 01:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
In-Reply-To: <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 10:23:33 +0200
Message-ID: <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
To:     firoz.khan@linaro.org
Cc:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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

On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
> > On 08.10.2018 07:52, Firoz Khan wrote:
> > > On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
> > >> On 08.10.2018 07:16, Firoz Khan wrote:
> > >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > >>> ---
> > >>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> > >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > >>> index 4e85293..4334bb7 100644
> > >>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > >>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > >>> @@ -349,4 +349,5 @@
> > >>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> > >>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > >>>  349     common  statx                           sys_statx
> > >>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > >>> \ No newline at end of file
> > >>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > >>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
> > >>
> > >> You can't add the rseq syscall for parisc yet.
> > >> It needs additional code in the kernel for parisc which hasn't been tested yet.
> > >> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> > >
> > > Thanks for your update!
> > >
> > > When I compiled the kernel I got below warnings.
> > >
> > > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> > >
> > > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > > syscall is gone. But we definitely have to keep rseq entry on parisc
> > > architecture.
> >
> > I prefer to keep the warning for rseq for now.
>
> I'm fine with this.
>
> > It reminds me that we still may want the rseq syscall.
> > If the warning is a problem, you may simply add the __IGNORE_rseq define.
>
> But I still feel to keep an IGNORE entry, so once you test your patch; we can
> remove IGNORE entry and update the syscall.tbl.

If the warning is bogus (e.g. obsolete syscall), an IGNORE entry
should be added.
If the warning is due to a not-yet-implemented feature, IMHO it should not be
silenced, as that would give the false impression that the feature is
present and
implemented.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
