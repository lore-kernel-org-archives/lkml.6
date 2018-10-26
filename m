Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE26C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBRr4Cu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A292E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJZV6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:58:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34647 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:58:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so619339qkg.1;
        Fri, 26 Oct 2018 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VJPdP1GaF4HbvxJXs2SPcVuJaX9CjSo8l0/5Taz3raY=;
        b=CBRr4Cu+Jqf5ZwrIJhF6fyG2hDFrzVfcvPVznYV0N51xGKek/WkUaG1rNMbgBftMhS
         tVJhlWcaD6dcTgtKs3lSpGbEgcnGPxFEZ02W0pJ8jQTcQQpQ1ZohjiVjgbeYtratEJkJ
         WqA3Qgs/dpEqDgn+hfgF0cIO8nNcBhfmgovtaTHXbyzTF6Qj0p56F1Zd/x4ePkfLyTLC
         sj3rdCpnZRNMhim/aBBmH+wxyYkPiKezmD4VtIIas2oJCvoIop2oI7hvQP0SNk++svTa
         UXjZikmsK3y2z2z1K5Zj91RvexPLSQEGbxLtw30Bb5p38JmkQ45OzavcNO6fuecKKcf+
         uL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VJPdP1GaF4HbvxJXs2SPcVuJaX9CjSo8l0/5Taz3raY=;
        b=fULN8jLZqMMgn+CRWyM+r0T3TBgpTSPs/Q6geQTIFXpTx/execcRWAsYHcrsbDmU4s
         DosbTPhv/iWEQCO8d4dXeIBRVAiRjDMyYhtF2GQ9pJMC2KmKz4a0DAGeCaDJkcBAwxMv
         oJl8zZVljTShfcNBQhJapCklm0YtApZ/1j3ueFRLFuhc+/EKNYCkJNwCn0KCszUdgF6W
         0c0yxWvNldVnhIlax3R/8PNrQrgar6aTovtXnn3d+oECBftXjksgyT9YmldjSNLJ+5hb
         +0z6qVhkyRIOtbHes+mx6wKPzY7Wj2dFTURL7JsHqLAyxMhsG4OzwuBnorJ7KNx5mA+K
         AqIw==
X-Gm-Message-State: AGRZ1gI16AqlH3IAcI1GTJe3Z5aQUfezgWmIohWZCD8ytux8gzs+/1Jt
        YDX8Hx++//Pja1EoG0s8SMmGJxB1SR30lhnfqNw=
X-Google-Smtp-Source: AJdET5fy6lX0oayUAM6sTvP9xc6f99B++9fYLx03eZX3gWIEF92JE7fEKY4+7TdfC2PhDpL1eiymA1hGrhkt794MrRM=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr2860641qka.107.1540560092946;
 Fri, 26 Oct 2018 06:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 06:21:31
 -0700 (PDT)
In-Reply-To: <20181026144647.11926142@bbrezillon>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
 <20181025180720.1790f6a1@bbrezillon> <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
 <20181025183005.3c0fa452@bbrezillon> <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
 <20181026095707.3cd9b511@bbrezillon> <CAK8P3a0_En6e6ORvNqxprBcsT3+NmFO8nFnQ3nNiv-5Hq2LjrQ@mail.gmail.com>
 <20181026144647.11926142@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 15:21:31 +0200
X-Google-Sender-Auth: PENYDRNSXgjBqcG2wOwrr7wvOvo
Message-ID: <CAK8P3a08jhpUZyiGsUVUFggi1C88SAqYHG7CY1GysZN7iwm5gw@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 2:46 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 26 Oct 2018 12:01:52 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Oct 26, 2018 at 9:57 AM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > On Fri, 26 Oct 2018 09:43:25 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
> > > > <boris.brezillon@bootlin.com> wrote:
> > > > > On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > > > > > On Thu, 25 Oct 2018 17:30:26 +0200
> >
> > This is apparently not allowed on ARC when 'buffer' is
> > unaligned. I think what we need here is to use
> > put_unaligned() instead of the pointer dereference.
> > For architectures that can do unaligned accesses,
> > the result is the same, but for ARC it will fix the problem.
>
> Okay, so writesl()/readsl() should deal with unaligned pointers, and
> default implementations should be fixed. I guess you'll send a patch to
> use put/get_unaligned().

That's one way of doing it, though thinking about it some more,
this can also introduce overhead on machines that don't support
unaligned buffers and only work on drivers that are guaranteed
to see fully aligned data.

We could also override these specifically for ARC, and risk
running into the same problem elsewhere, rather than be sure
to fix everyone while risking to introduce noticeable performance
regressions in existing drivers.

> > > > One way to address this might be to always bounce any
> > > > messages that are less than a cache line through a
> > > > (pre-)kmallocated buffer, and require any longer messages
> > > > to be cache capable. This could also solve the issue with
> > > > readsl(), but it would be a rather confusing user interface.
> > > >
> > > > Another option might be to have separate interfaces for
> > > > "short" and "long" messages at the API level and have
> > > > distinct rules for those: short would always be bounced
> > > > by the i3c code, and long puts restrictions on the buffer
> > > > location.
> > >
> > > Hm, let's keep the API simple. I'll just mandate that all payload bufs
> > > passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated.
> >
> > Ok. What about i2c commands sent to the same i3c controller
> > then?
>
> Still not taken care of.
>
> > Do we need to copy those to satisfy the requirements
> > of the i3c layer?
>
> I guess we should. The question is, should we do that unconditionally
> or should we try to optimize thins with something like:
>
>         if (!virt_addr_valid(xfer->buf) ||
>             object_is_on_stack(xfer->buf))
>                 /* Alloc bounce buf. */
>         else
>                 /* Use provided buf. */

There may be too many cases that we need to handle here that
are not DMA capable. To be on the safe side, I'd probably always
copy all data that is not a multiple of fully aligned cache lines,
as well as pointers that fails to meet some other requirements
(stack, vmalloc, kmap, ...)

        Arnd
