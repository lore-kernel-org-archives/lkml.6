Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40073C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C820661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="21aPeBg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93C820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeLEE04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:26:56 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40744 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEE0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:26:54 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wB54Qhop005439;
        Wed, 5 Dec 2018 13:26:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wB54Qhop005439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543984004;
        bh=bjrC8SIQ9Wql171658JORppkFGAKHljcN7ccyt7AwBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=21aPeBg7px8xMsiWQzLanwJVQXrp+U4zUe2Fd90WWCYukQIchiQ5eXHRdZI4JB9Le
         oifQhnt/awZbKMX+9LJUNxcavSf8Iy/JrdMFiZeDFSnrGZMGEgFr9caET3lNEjdVJp
         PseiOvWn3+Imp5GSJLEZAeikyz2Utinz6Iau/Cr4I/Fopy3tAvSTBhv+G18OiFou8n
         kd67y4Ou4plC1MKSpDb1cgIoiWxBbefxKU7WtsctlBm/8xpOvd1W560exKLZKsxqUH
         IqKcTgN++3xrAKPtK0wvoRPVYRoE6tDbyFjz4u4hcwoXPUzZoyTpoMjezAdgr3muNQ
         MfjajEtbZb4pA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id u19so6638909uae.4;
        Tue, 04 Dec 2018 20:26:43 -0800 (PST)
X-Gm-Message-State: AA+aEWZx7YNKEnuXB7oFl0tLXE6fbjDgRgKEOZGTKgNshRZ+nvm5JRCT
        HNRojbv0Wq55SIhrYzhq65WLNNxAsm4haeie+1s=
X-Google-Smtp-Source: AFSGD/U7L09EmqlP4nFCW429bLOC9WG8gDY+Gjv2srOpTTlT6dhYmbTXIX5XRkmQBMbYKbIljHGEmnh9dAnee7Dgp/s=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr10487783uad.55.1543984002635;
 Tue, 04 Dec 2018 20:26:42 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com> <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
In-Reply-To: <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Dec 2018 13:26:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
Message-ID: <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     sugaya.taichi@socionext.com, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:14 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Masahiro Yamada (2018-12-04 03:03:53)
> > Hi Stephen,
> >
> >
> > On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > > Add Milbeaut M10V clock ( including PLL ) control.
> > >
> > > Please give some more details here.
> > >
> > > >
> > > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > > ---
> > > >  drivers/clk/Makefile   |   1 +
> > > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > And this is different from Uniphier? Maybe we need a socionext
> > > directory under drivers/clk/.
> >
> >
> >
> > This is always a difficult question,
> > and I do not have a strong opinion.
> >
> >
> > I am fine with moving the files to drivers/clk/socionext
> > although no file would be shared.
> >
> >
> > FYI
> >
> > UniPhier and Milbeaut are completely different platforms
> > developed/maintained by different teams.
> >
> > They happen to live in the same company now
> > just because Socionext merged the LSI business from Panasonic and Fujitsu.
> >
> > UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> >
>
> Thanks for the background info. I'd prefer to defer to however the dts
> files are getting split up into directories. If they're all put under
> arch/arm64/boot/dts/socionext/ then I would say combine the two clk
> drivers into a socionext directory. Otherwise, keep them split out.


If you want to align with the DT directory structure,
the answer is clear.


Milbeaut DT files will be put together with UniPhier ones
into socionext directory.


For arm64, DT directories are already sorted out by vendors.

Even 32-bit ARM is going to that way.

Rob Herring just posted a python script
to move all DT files in arch/arm/boot/dts/
into vendor subdirectories.


Please let me know if you want me to
move drivers/clk/uniphier/* to drivers/clk/socionext/*.



-- 
Best Regards
Masahiro Yamada
