Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB36ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497F21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3497F21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbeITPUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:20:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41634 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeITPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:20:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id h1-v6so4210468uao.8;
        Thu, 20 Sep 2018 02:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9yN+5j7ulWcbHYg8o+zXyj8XwJgDCQXaiRxGnFVYuY=;
        b=ngyvPWylmzcMqRHgW7mlFAJGiFTvGvt9yZLlt0skFypJh9xPFmM21uN4yvuHZR+aam
         GyMiKcuLVsmGgO7qe4plmUWpal8iP/ikARwVEs+Y/Ke7Ghbg2YK+DpJatR107nBTrUw5
         PskuY9EN5ZtuSteDoN+7qFHHVpCsKvYn7PRlVzt+mzs7imDiihXMhoslAUroTbpSd/r8
         AV9zFCBA2wY/HV9BBVgm9vn80MRpPB1Qi4JbbOCsYfmtq50lQ1TmjYeuU+m4wQhb9v2H
         sKdyJE6AkeB6lz3oYpaKhFkwAuQbWsTrLwWdhjl0ajsOG6j+zM2mUzfjpQ6FvxBSrGHH
         LcWQ==
X-Gm-Message-State: APzg51C/8iSQITItsH6g+f18CoTj8A5LwXSU73KtBIahdVzxLzKSdgsd
        REcLL0sTjxIlMEFp02zLYK6dQEVfL854nQTVhjE=
X-Google-Smtp-Source: ANB0VdYl3fUF88nd/DDi5wbcL7jxbpooGO1aQHtTib+MtXzy0bi/QfDR5RYnEPtleXICw9ChP/HS2DmSgPyO/Dw9Okw=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr11300508uam.153.1537436284828;
 Thu, 20 Sep 2018 02:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180917163955.19023-1-geert+renesas@glider.be>
 <20180917163955.19023-2-geert+renesas@glider.be> <1537369098.6816.6.camel@pengutronix.de>
 <CAMuHMdWSO6JcBRmmpwCPz0u-85ZC3ffZkNbdd8DjokJT2opAtw@mail.gmail.com> <1537435641.4156.1.camel@pengutronix.de>
In-Reply-To: <1537435641.4156.1.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Sep 2018 11:37:52 +0200
Message-ID: <CAMuHMdUaXjvOOAYTxTJ+ZzJn359CFYHsGKYoKf4ZkU_Goyen6g@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset controls
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On Thu, Sep 20, 2018 at 11:27 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Wed, 2018-09-19 at 17:24 +0200, Geert Uytterhoeven wrote:
> > On Wed, Sep 19, 2018 at 4:58 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> [...]
> > > I consider requesting exclusive access to a shared reset line a misuse
> > > of the API. Are there such cases? Can they be fixed?
> >
> > I guess there are plenty.
>
> I did a cursory search for drivers that request exclusive reset controls
> for resets that have multiple phandle references in the corresponding
> DT. So far I have found none.

OK.

> > Whether a line is shared or dedicated depends on SoC integration.
> >
> > The issue is that a driver requesting exclusive access has no way to know
> > if the reset line is dedicated to its device or not. If no other
> > driver requested the reset control (most drivers don't use reset
> > controls), it will succeed.
>
> True. It would be great to have a way to make sure an exclusive request
> for a shared reset line never succeeds.
>
> > > > Sometimes a driver needs to reset a specific hardware block, and be 100%
> > > > sure it has no impact on other hardware blocks.  This is e.g. the case
> > > > for virtualization with device pass-through, where the host wants to
> > > > reset any exported device before and after exporting it for use by the
> > > > guest, for isolation.
> > > >
> > > > Hence a new flag for dedicated resets is added to the internal methods,
> > > > with a new public reset_control_get_dedicated() method, to obtain an
> > > > exclusive handle to a reset that is dedicated to one specific hardware
> > > > block.
> > >
> > > I'm not sure a new flag is necessary, this is what exclusive resets
> > > should be.
> >
> > So perhaps the check should be done for the existing exclusive resets
> > instead, without adding a new flag?
>
> That would be my preference, if possible.

OK, will make it so.

> > > Also I fear there will be confusion about the difference between
> > > exclusive (refering to the reset control) and dedicated (refering to
> > > the reset line) reset controls.
> >
> > Indeed, exclusive has multiple meanings here:
> >   1. Exclusive vs. shared access to the reset control,
> >   2. Reset line is dedicated to a single device, or shared with multiple
> >      devices.
>
> 2. is the more important factor, and that's what I have in mind when
> talking about exclusive vs. shared resets. Admittedly, the kernel doc
> comments only mention 1.

OK. That did contribute to my confustion...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
