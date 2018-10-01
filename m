Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6285FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A12083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4A12083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeJAO35 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:29:57 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41886 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:29:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id e128-v6so6925414vsc.8;
        Mon, 01 Oct 2018 00:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fse7KpQK4D3pkd1OwWmBP3xPIZzYRxGU9L0taz7PM74=;
        b=FD95kY5xM09Ee5xWtJwGVlMAzSkRXGOszflRnUSrzCqfDAVafT2tiswlZUV6OV7dFM
         H270Xv4Fcf4aUP8vnOCMCLbgXIOTd4snRr0aRmLfM8jhu5gClQb+ZSvPSxIt7ha2kzBJ
         e3MeWUDJxo4yMPOQ8YANP5hymd2f5SzBXsnhDfrsq7/KM/OUNjHi3iW4mEBQLCKoolzp
         aSgTPT5Zs+9cXoSWJzbRlxK6vlteRvWp7AyEKlox+RfOHlP60LLbL1SyQD7suxD1XPR5
         9fFM9JoF1aaXMTyIYXCvOBm0g/+gH5K5SARXrtcEN6x2CEfffaYix1ESTDkZXCfcv7MH
         soIA==
X-Gm-Message-State: ABuFfoihBqwdtMDOTYht5dVfpJb25O2sTyxKxroyCXSSSSWJF3AHman/
        f8cqCtEj1Rr1Irbw9h5lhu+/VRVwATx2g0Uk8ak=
X-Google-Smtp-Source: ACcGV609Lnu4FrPRGnyP3xS+u5v5KhwZ0H6OXDWYS6T9uI8bo8Xc8VsCR1ipQNkeRLUb/myWD7qYgFOZKy5VkxSRMSA=
X-Received: by 2002:a67:68ce:: with SMTP id d197-v6mr3626847vsc.152.1538380409478;
 Mon, 01 Oct 2018 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de> <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
In-Reply-To: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Oct 2018 09:53:15 +0200
Message-ID: <CAMuHMdW_+PNZrh5JXo8MxVwg3YSZL7bszMcUJjCqMFfBz8HDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>, ley.foon.tan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 8:42 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 28, 2018 at 12:21 PM Andreas Färber <afaerber@suse.de> wrote:
> > Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >> Even x86 can enable OF and OF_UNITTEST.
> > >>
> > >> Another solution might be,
> > >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> > >>
> > >> This is actually what ACPI does.
> > >>
> > >> menuconfig ACPI
> > >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > >>         depends on ARCH_SUPPORTS_ACPI
> > >>          ...
> > >
> > > ACPI is a real platform feature, as it depends on firmware.
> > >
> > > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > > even if it has ACPI ;-)
> >
> > How would loading a DT overlay work on an ACPI platform? I.e., what
> > would it overlay against and how to practically load such a file?
>
> The DT unittests do just that. I run them on x86 and UM builds. In
> this case, the loading source is built-in.
>
> > I wonder whether that could be helpful for USB devices and serdev...
>
> How to load the overlays is pretty orthogonal to the issues to be
> solved here. It would certainly be possible to move forward with
> prototyping this and just have the overlay built-in. It may not even
> need to be an overlay if we can support multiple root nodes.

You indeed need to refer to some anchors for most use cases, although a
simple MMIO device could just be anchored to the root node.

Topologies hanging off a USB device would be my first use case, too,
for serdev, or for e.g. the mcp2210 USB-SPI bridge.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
