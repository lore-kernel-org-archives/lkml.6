Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C3AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8152087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8152087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJHQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:09:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44759 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJHQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:09:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id v18-v6so10953138vsl.11;
        Mon, 08 Oct 2018 01:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRV5EHtl76ZhhsGH5Ticw2ko265G9mFdWhqbwno+9jA=;
        b=qMWgdWQy3jxJawd4mDWBjsykvxDDXonHVoffHQN1phL1J4PeEkk1Y/GCyOFWfbrbiD
         wW3LjzztuRO+XLjQjeCOHL8jaNnsLDvsBELdam4Mv4z1U8rKpKf1Yqjq07n4QDZHuLgd
         ITMgIdqxMMb0bekWZ57/XoP6sbo2bwaPzGORmjydFLap3KduiFwAg1mtbD7xDr8Ewa20
         0TBj/+8hmeo12N0ywaGV1natIKvIse3xoA0g8iww0x0QT6vaFM29cYp3OlQu4ZHsDUyV
         4SSjAofiifUI7VHuf9+CZmS3KAOAz/oan6YDGVKRnQRhyDnD2fqezNASEIt40uG7T9EG
         M3Pg==
X-Gm-Message-State: ABuFfoi5b3sm9I+5G3eKfOVO9mdbZ9pQ3iHUvatVbQG5FpjPgt2rwPhU
        WQyi0iOrlmaa/9e/LTS3WDtlcJ/YRFUCECs+S5s=
X-Google-Smtp-Source: ACcGV62RC2nniqucWulQbhn+m46kFN4ipyICcGYThc3D/CTm6pwNMpEWm38VDTMA5/opG5wSAEZpPD6nhhn35jPWQMA=
X-Received: by 2002:a67:e015:: with SMTP id c21mr7623759vsl.63.1538989124947;
 Mon, 08 Oct 2018 01:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com> <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
In-Reply-To: <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 10:58:33 +0200
Message-ID: <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
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

On Mon, Oct 8, 2018 at 10:55 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
> > > > On 08.10.2018 07:52, Firoz Khan wrote:
> > > > > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > > > > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> > > > >
> > > > > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > > > > syscall is gone. But we definitely have to keep rseq entry on parisc
> > > > > architecture.
> > > >
> > > > I prefer to keep the warning for rseq for now.
> > >
> > > I'm fine with this.
> > >
> > > > It reminds me that we still may want the rseq syscall.
> > > > If the warning is a problem, you may simply add the __IGNORE_rseq define.
> > >
> > > But I still feel to keep an IGNORE entry, so once you test your patch; we can
> > > remove IGNORE entry and update the syscall.tbl.
> >
> > If the warning is bogus (e.g. obsolete syscall), an IGNORE entry
> > should be added.
>
> nfsservctl  look like an obsolete one, so I added an IGNORE entry in
> script/checksyscalls.h

Yes it is.

> > If the warning is due to a not-yet-implemented feature, IMHO it should not be
> > silenced, as that would give the false impression that the feature is
> > present and
> > implemented.
>
> Helge had done some implementation for rseq but not tested. So we
> either add an IGNORE
> entry or leave the warning as it is.

Personally, I prefer keeping the warning, for the above reason.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
