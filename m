Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F1C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EF2217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfAZKZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:25:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38434 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:25:48 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so7173384vsa.5;
        Sat, 26 Jan 2019 02:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXFk2P3Vse2UsQPQiWrGQq6Z73B1APMdhn/Ravn5Ong=;
        b=aPOF54xOSwo7OV8taGvyq8tLlpe88AfQjXS+tfpyC4WxqM308KUUHLHw4zWNVsrzhH
         ZsqSJ1ez9dKDOwoNyQWhTRpycj4APHHafrmteWQ3CnzJTQujojIgRyBBnfG9zP1yMWXC
         kXL/o/0H4JuzBuAVqZfs1HOyoTSnYkVNL/RHcYo07LfTyiv8Z7nR9YqR+wdKQL9mchEc
         p4PH9nDkueEFMDq6/eU96XB6DMsIjkG0d/MB2suy/v8P6vdWLohsle+EaJjmoj2n0h0n
         xNtL6kmhVCugmUrYStV2yiy6R1BKc5Yzis+YQaqhPx7QGZEBfM/ZZsaY4EzZJJh2AUhx
         sojw==
X-Gm-Message-State: AJcUukf8litZwrxJv3kDYJCzs64ma3GGuuTDM0nf1Das0gIbD7MrVqWy
        4ZlzPHk7EaSBueJuIZAxCEuEbFtlgnlD2or2gz8=
X-Google-Smtp-Source: ALg8bN56Ye9gQEq1QfAzJZtqgQjizkdeCg+xKE+X7E6/8Fy2d1elBSx0ZpeBE0hAHtJS592zlX4haNmQiqUU0aguj5g=
X-Received: by 2002:a67:d119:: with SMTP id u25mr5540086vsi.63.1548498346735;
 Sat, 26 Jan 2019 02:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20190125114429.20066-1-jonas@norrbonn.se> <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se> <20190125174713.GA6939@sirena.org.uk>
 <20190125175031.GA25898@sirena.org.uk> <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
In-Reply-To: <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 26 Jan 2019 11:25:34 +0100
Message-ID: <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Sat, Jan 26, 2019 at 8:53 AM Jonas Bonn <jonas@norrbonn.se> wrote:
> On 25/01/2019 18:50, Mark Brown wrote:
> > On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
> >> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> >>> Having this as device property rather than a transfer property allows this
> >>> to be configured one time in setup() rather than having to fiddle with the
> >>> configuration register for every transfer.
> >
> >> That doesn't mean that the coniguration should be done in DT though, and
> >> given that this presumably is a property of the device there seems to be
> >> no reason why we'd have it in DT - if every instance of the device is
> >> going to need to set the property we should just figure it out from the
> >> compatble string instead.
> >
> > To be clear here: the suggestion is to add a parameter the slave device
> > can set in spi_device which sets the default word_delay similarly to how
> > max_speed_hz works.
>
> I'm confused... isn't that exactly what this patch does?  It adds a
> field word_delay to spi_device in the same manner as max_speed_hz.
>
> I also added the ability to set it via DT, which I can break out into a
> separate patch if that's an issue.  Or is the problem that it's set via
> DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10
> other slave-node properties related to transfer characteristics;
> word_delay is just another such characteristic.
>
> But again, I'm having trouble parsing your response  Is the patch wrong,
> should be broken up, or you just misunderstood it?

IIUIC, Mark means that it may be a non-configurable property of the slave
device, and thus should be handled (fixed setting) in the SPI slave driver.

Compare this to CPHA/CPOL, which are properties of the SPI slave device,
but which may be configurable. E.g. many SPI FLASHes support multiple
configurations. See e.g. commit 9c5becce21af35e5 ("ARM: shmobile: koelsch:
Fix QSPI mode of SPI-Flash into mode3").

Again, max_speed_hz is something different: while both the SPI master and
slave may support high speeds, board wiring (capacitance/inductance) may
need to force a slower speed than supported by the devices, so it makes
sense to make that configurable from DT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
