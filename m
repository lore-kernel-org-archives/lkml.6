Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40836C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091902081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIg/h7IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091902081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeKFXXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388273AbeKFXXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:23:51 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED21821019;
        Tue,  6 Nov 2018 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541512709;
        bh=10z+PpoOW7vXkeqE8qebmbdxJXgkTqTfvQhET6fCD04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WIg/h7IOzypff0EfVos1Sjuj6u5ld0wEbqQ+saBLsyH8p9NRkgKkpoCYXX0H6+OQv
         VpZ8mZHqxLxoaSG1t5nSlHmhxyjtk+l1yYH2cfwu3/gxEA95x+6aOmjb2sD7YnWpzi
         OBUcG9QJaBaTI+cXO1LAgj+Tt5Kp8+2+BLqiqFeg=
Received: by mail-qk1-f178.google.com with SMTP id u68so18405335qkg.9;
        Tue, 06 Nov 2018 05:58:28 -0800 (PST)
X-Gm-Message-State: AGRZ1gKk6w4/1cbh0eWxRV0JEfiTC2NWd/zA3A+Zbc7y2qH6mPiHgcDM
        xq9p0NlSfTwwjKdayqAHKrJ3+5QBaFo0y7Balg==
X-Google-Smtp-Source: AJdET5ehXzdQy9JR1A3rqsq8Ts2vxBMuMFsYxLQDNTT3w0lcOpGXLwuMiUjfgKw8JyV0wwXrPdNu1mCabk5joWp2Ttk=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr24703752qkb.326.1541512707990;
 Tue, 06 Nov 2018 05:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
 <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
In-Reply-To: <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 07:58:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
Message-ID: <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 3:50 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Mon, Nov 5, 2018 at 4:20 PM Rob Herring <robh@kernel.org> wrote:
> >
> > bridge vs. host are confusing me as those are often the same thing. But
> > here bridge is just some auxilliary controls for the bus and the host is
> > the actual bus with devices? I'm not sure why you split this into 2 DT
> > nodes? How many devices are connected to the host processor (i.MX) bus?
> >
>
> The anybus can only have a single client card (device) on the bus. I
> know, we can criticise the name, but that's how HMS Industrial
> Networks designed it.
>
> The anybus-bridge is how we (at arcx / Archronix) physically connect
> anybus slots to the iMX. It is a CPLD chip connected to the i.MX WEIM
> bus on the SoC side. On the other side of the CPLD, there are two
> anybus slots. Each slot may hold an anybus card (profinet, flnet,
> cc-link, ...)
>
> The anybuss-host implements the anybus specification in a
> platform-independent way. Some other company could attach anybus slots
> to their CPU through a completely different bus, or spi, and they
> could still attach the anybuss-host driver onto it. All the driver
> needs is a regmap providing access to the anybus slot memory, an
> interrupt, and a reset controller.

It doesn't really sound like the host should be in DT. The bridge
should register itself as an anybus provider and that should in turn
enable the anybus host protocol.

Rob
