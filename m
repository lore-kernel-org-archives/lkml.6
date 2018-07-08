Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1650C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8EF2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8EF2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGHKtn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:49:43 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39820 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932725AbeGHKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:49:42 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so10071568uad.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6Xb1ivkbddSChoJrasjZ0NHXotZkPiF0gAy0S/xPfY=;
        b=d+Zpvp/QcypQV61qlnoc6Jw+UsYNzfUiSIIYutHdrKmliST8ynuwYff5MRlZNbltPY
         U5SVE6SUGTjgsnDXAhQZueL7f3lNL205skT2RDlVijHottRFDtbJSo3xf5V1pfDTAU8v
         +dKFyo1ZuQHD9tYBmu2Xfr6Vc9Eoa0z5kTO1ykV8rn5GVgconKj9H0YIc6dnIehPyvdl
         g8b29hNRqw1YKhQ1q6UP5lSu1NB+4GptkRc+/zZMCgFV+cY2+iX3QHn1DqHVX0ykpZyT
         EP9dQc6sVvx61ftvzHdk5ASG5cS3lF6zf/HMb165zfaAI1btKbwbHqTXfodbE9mSujAe
         cdQA==
X-Gm-Message-State: APt69E214jLCUInCtydfcumqrlDLWkrpLdqp1pWae8MAP18D6oxskXHR
        2xRmMyE+l3j0fhaSWgDRhws+Do2ir19y3Z3Zjj8=
X-Google-Smtp-Source: AAOMgpfgkoqNK619apm6x+vWTD7uq3dOrErin9ltGFD1CSbvkIVLRAEVW8Im4BhnK+TU9+0khYra1IhAPESFP5UDtgM=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr11057621uan.33.1531046981370;
 Sun, 08 Jul 2018 03:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
 <alpine.LNX.2.21.1806221455570.14@nippy.intranet> <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
In-Reply-To: <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 8 Jul 2018 12:49:29 +0200
Message-ID: <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Finn,

On Fri, Jun 22, 2018 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 22, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Tue, 19 Jun 2018, Arnd Bergmann wrote:
> >
> >> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
> >> 32-bit value starting in 1904, which overflows in 2040, about two years
> >> later than everyone else, but this gets wrapped around in the Linux code
> >> in 2038 already because of the deprecated usage of time_t and/or long in
> >> the conversion.
> >>
> >> Getting rid of the deprecated interfaces makes it work until 2040 as
> >> documented, and it could be easily extended by reinterpreting the
> >> resulting time64_t as a positive number. For the moment, I'm adding a
> >> WARN_ON() that triggers if we encounter a time before 1970 or after 2040
> >> (the two are indistinguishable).
> >>
> >
> > I really don't like the WARN_ON(), but I'd prefer to address that in a
> > separate patch rather than impede the progress of this patch (or of this
> > series, since 3/3 seems to be unrelated).
> >
> > BTW, have you considered using the same wrap-around test (i.e. YY < 70)
> > that we use for the year register in the other RTC chips?
>
> That wrap-around test would have the same effect as the my original
> version (aside from the two bugs I now fixed), doing rougly
>
> -        return time - RTC_OFFSET;
> +        return (u32)(time - RTC_OFFSET);
>
> or some other variation of that will give us an RTC that supports all dates
> between 1970 and 2106. I don't think anyone so far had a strong
> preference here, so I went with what Mathieu suggested and kept the
> original Mac behavior, but added the WARN_ON().

So, is this safe to apply?
Especially in light of the warnings seen by Meelis with the PPC version.

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
