Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1D620848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1D620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJZArg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:47:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40055 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:47:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id z9-v6so10526091qto.7;
        Thu, 25 Oct 2018 09:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3LXVVasdJKF778RgUuO4lJ6BM5jsyB1NU7WJ456Erk=;
        b=cA7pvcCOGsAn2bTBDjr/QBquEZrpAvNASeNbo1gqpOPkIUtG4iTji8KQh5vGHxqxUN
         rEHt/aDYq82Oev5krWZjX+GnGDTPHiuvo0AbbRg68x+uhJh3621Whdg33g+YiVAQ3NhQ
         BE0CgFnBq/zHoA/QFRaoFKLHJ9tKCZ8NgfR6nd8BTOxWu0KpdpdMQt3feoGEwTa1fgSu
         3Rrcw9lz0ASYQKDBd04ceU2IMq5zn790ctItsLWgTGxb6x6wpaYWbzkqcTLjVVGhiHwP
         B88NsYj/raXWesU5AEc9N15HLCJhjAzkini1RVluEQvtkaEuu+LwgjIDI+T0E7RjFphY
         s4EQ==
X-Gm-Message-State: AGRZ1gLo5py+LclPB4AuJm9oZfqsSBm2lwE5vcjc2aqwAujmj9fQQNjZ
        o88NesjBaWk2rdP2GGucumYOiJRewiis6vPM2eg=
X-Google-Smtp-Source: AJdET5df6/3XEn4EmudjpsWG8ZOgg+8OGLpiFFIn1ZQsEMlYADTHcU7OA4zguJu/wTLx2Uh6vcJsuMvGL9l6f5Fv/GE=
X-Received: by 2002:a0c:c68f:: with SMTP id d15-v6mr2202319qvj.40.1540484047699;
 Thu, 25 Oct 2018 09:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com> <20181025180720.1790f6a1@bbrezillon>
In-Reply-To: <20181025180720.1790f6a1@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Oct 2018 18:13:51 +0200
Message-ID: <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
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

On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu, 25 Oct 2018 17:30:26 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > Hi Arnd,
> > >
> > > On Mon, 22 Oct 2018 15:34:01 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >
> > >
> > >> +
> > >> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master
> > >> *master,
> > >> +                                      u8 *bytes, int nbytes)
> > >> +{
> > >> +  readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
> > >
> > > Vitor reported a problem with readsl(): this function expects the 2nd
> > > argument to be aligned on 32-bit, which is not guaranteed here. Unless
> > > you see a better solution, I'll switch back to a loop doing:
> > >
> > >     for (i = 0; i < nbytes; i += 4) {
> > >             u32 tmp = __raw_readl(...);
> > >             memcpy(bytes + i, &tmp,
> > >                    nbytes - i  > 4 ? 4 : nbytes - i);
> > >     }
> >
> > Could we maybe mandate that the buffer itself must be aligned here?
> > What would be a reason why we see an unaligned target buffer?
>
> Well, the buffers we pass to i3c_send_ccc_cmd() are not necessarily
> aligned because they're not dynamically allocated (allocated on the
> stack) and are not naturally aligned on 32-bits (either because they
> are smaller than 32bits or because the struct is declared __packed).
>
> I guess I could dynamically allocate the payload, but that requires
> going over all users of i3c_send_ccc_cmd() to patch them.

This reminds me that Wolfram mentioned in his ELC talk that the
buffers on i3c should all be DMA capable to make life easier for
i3c master drivers that want to implement DMA transfers.

If we have buffers here that are not aligned to cache lines
(or even just 32 bit words), doesn't that also mean that the
same buffers are not DMA capable either?

        Arnd
