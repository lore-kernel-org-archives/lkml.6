Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F7C677F8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85866206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWOwApxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85866206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeI2BHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeI2BHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:07:09 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F63820836;
        Fri, 28 Sep 2018 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538160124;
        bh=ucBQEM+GHr4wAfjxvfsvuLdN+zja3rG4l1rL7brbDIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWOwApxPVXhTZzLNGDNie7QGQ6zjYUNWaw9gD1Nn/xr1OKMkD8Z06XO0fA0tskmq4
         GiZLo4ieCTrrgPVTTHYmPfRsuY3axXgvJYF1TFpJn3W5WPBdBaG/IixaS50cJC/P0L
         aQjtpJvYErvzH3GNSEMwRHca/3fju5penFgw6Dtc=
Received: by mail-qk1-f180.google.com with SMTP id g20-v6so3350175qke.9;
        Fri, 28 Sep 2018 11:42:04 -0700 (PDT)
X-Gm-Message-State: ABuFfoh/uBzCf8WNrTmbjcCTMoouTz6cYOCrtK2UMqjsuDdnhbmxWUlx
        jPbOvn7So6ox8T5kai0jHL+2NyagNrkG/KXKQA==
X-Google-Smtp-Source: ACcGV621ZkVMH2JDxjibLp+pDwz3KJn7xglLxR2Ca15PWxniRLjeSUc+Io2a4Km0KoyI6YxAzRAeW+wnTH0sratRei4=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr12468517qku.184.1538160123207;
 Fri, 28 Sep 2018 11:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com> <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
In-Reply-To: <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 13:41:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
Message-ID: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:21 PM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Hi Geert,
>
> Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> Even x86 can enable OF and OF_UNITTEST.
> >>
> >> Another solution might be,
> >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> >>
> >> This is actually what ACPI does.
> >>
> >> menuconfig ACPI
> >>         bool "ACPI (Advanced Configuration and Power Interface) Suppor=
t"
> >>         depends on ARCH_SUPPORTS_ACPI
> >>          ...
> >
> > ACPI is a real platform feature, as it depends on firmware.
> >
> > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platfor=
m,
> > even if it has ACPI ;-)
>
> How would loading a DT overlay work on an ACPI platform? I.e., what
> would it overlay against and how to practically load such a file?

The DT unittests do just that. I run them on x86 and UM builds. In
this case, the loading source is built-in.

> I wonder whether that could be helpful for USB devices and serdev...

How to load the overlays is pretty orthogonal to the issues to be
solved here. It would certainly be possible to move forward with
prototyping this and just have the overlay built-in. It may not even
need to be an overlay if we can support multiple root nodes.

Rob
