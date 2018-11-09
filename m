Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B01C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pofcNiPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeKJCLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeKJCLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:11:43 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8A720883;
        Fri,  9 Nov 2018 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541781025;
        bh=e0cgVl2QlG8CrHpu2myDpziM/BVAydAUsg5tbUr7DS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pofcNiPpLyVYrdOadj7VTBsAHdLKfgnaEeGxqbsOr3/uDnkYWJN6rfh57InFwo51P
         oIh/mDv9uCHfIYvlSfPC1aYptHBBvOW8CVJc6JOf+0PcOw1rfWAekEB9GmtRqhwOC5
         ybVkYh9JXaIDeUPMCpOTmb1nN6mn+/1u3G352TLk=
Received: by mail-qk1-f174.google.com with SMTP id y16so2531330qki.7;
        Fri, 09 Nov 2018 08:30:25 -0800 (PST)
X-Gm-Message-State: AGRZ1gKJOob8uoblD+rsRWJiHMIL7i/5791iw3lmCq6hBQ+hX1iaVgyG
        BoiJBzndNyVlJCSUzhJvnuEMSEfDbot141iR4Q==
X-Google-Smtp-Source: AJdET5eDwkqfwYyknGMAjMhOxbqFTffkWslfJ4XGq8H9hJWvBqZsksXvRtHj+N1TEJdI3DQZm7QmZ0a4i7Zwn7N1iCs=
X-Received: by 2002:ac8:173d:: with SMTP id w58mr9122465qtj.76.1541781024298;
 Fri, 09 Nov 2018 08:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com> <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
 <0f2bb386-ba92-544c-e980-c95309944b22@gmail.com> <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
In-Reply-To: <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Nov 2018 10:30:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VuP6EkObw4wFeqOKoZEd9ktEErQaFfncz-2DfvNhp0A@mail.gmail.com>
Message-ID: <CAL_Jsq+VuP6EkObw4wFeqOKoZEd9ktEErQaFfncz-2DfvNhp0A@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Matthias,
>
> On Fri, Nov 9, 2018 at 11:29 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > On 08/11/2018 18:58, Stephen Boyd wrote:
> > > Quoting Matthias Brugger (2018-11-08 00:29:46)
> > >> On 06/11/2018 19:36, Stephen Boyd wrote:
> > >>> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
> > >>> +{
> > >>> +     int (*probe_func)(struct platform_device *pdev);
> > >>> +
> > >>> +     probe_func = of_device_get_match_data(&pdev->dev);
> > >>
> > >> Shouldn't we check if probe_func is not NULL?
> > >
> > > Is the oops from the NULL pointer deref insufficient?
> >
> > Do you think we should crash the machine if someone uses the call wrongly? Or
> > should we provide the possibility to error out on the caller side?
>
> I believe that would be a bug in the driver, to be discovered ASAP.
> So yes, please do crash ;-)

Depends on the driver. If it's not needed to get a console out, then
it should just WARN. Otherwise, you've got to go enable earlycon to
see the crash. Of course, someone could just as easily stick data in
here instead of a function ptr and we'll be back to a crash.

Rob
