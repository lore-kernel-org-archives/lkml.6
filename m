Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6921721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548164723;
	bh=5/j3u3sZlwdpjGBXUtougPs3U/DWZfx6ioM/i2tKqpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iNrzMXPaNSA7KyCTGDuJN96INMDLUuJTZqJ+7hMbX9kykq+nnzZDtV8Yt1O9qbM/y
	 9Rmj10M0RaCE/dPDP2hnz80Pm6/O4DyuaIDoOHZyhnsDo6yfNAK/hLWJP39Vts8fAu
	 YNpW6uLhTQ0TAs9el3ciBPpWNvdi8LmXCmHdaO9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfAVNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfAVNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:20 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E889B217D6;
        Tue, 22 Jan 2019 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548164719;
        bh=5/j3u3sZlwdpjGBXUtougPs3U/DWZfx6ioM/i2tKqpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h75TWyvJ6pAqKCETd70uYMwTRU8oQ/JAjyStfqw8CZpPckhG5uaK81PxttYNBydca
         arhW1h4dFLQ8CnkSrHNZ/Cc0yjisfmnNFtfJST8ZySOp1kVGpTMRezP1AfoOgR64Nb
         zI3mAaCMjmG2tPIjgZrZuy10n466ZSSkr5lBFkdk=
Received: by mail-qt1-f169.google.com with SMTP id y20so27496863qtm.13;
        Tue, 22 Jan 2019 05:45:18 -0800 (PST)
X-Gm-Message-State: AJcUukc0PZ2BFLHU/VqDVXJWXxYzLkJS8UdjrTZiP2S/hFjabvdIeAdK
        JYwBf2pyEGwUZ4EDk4k/cAO4Omsk9cbB+2bwog==
X-Google-Smtp-Source: ALg8bN5ypl8yXAikTeuLoh0sHZnMN6oz9ieY1pXeYTX/2WutPM6pTyREueVZVCJLmxssjI2I0fA0YDh5jPHUlPFb8f0=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr30262023qtd.257.1548164718107;
 Tue, 22 Jan 2019 05:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20190116064820.20007-1-ran.wang_1@nxp.com> <20190116064820.20007-2-ran.wang_1@nxp.com>
 <20190122010310.GA5165@bogus> <AM5PR0402MB286524243DB67DA15AE4EA42F1980@AM5PR0402MB2865.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB286524243DB67DA15AE4EA42F1980@AM5PR0402MB2865.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Jan 2019 07:45:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SULX5Y2C1Br+3reUHQ+1xJ=oZbuRBP+QJsEWeRgnuPg@mail.gmail.com>
Message-ID: <CAL_Jsq+SULX5Y2C1Br+3reUHQ+1xJ=oZbuRBP+QJsEWeRgnuPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 8:38 PM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rob,
>
> On January 22, 2019 09:03, Rob Herring wrote:
> >
> > On Wed, Jan 16, 2019 at 06:48:06AM +0000, Ran Wang wrote:
> > > When DWC3 is set to host mode by programming register DWC3_GCTL,
> > VUBS
> >
> > s/VUBS/VBUS/
>
> Yes, will fix it in next version.
>
> > > (or its control signal) will on immediately on related Root Hub ports.
> >
> > /will on/will turn on/
>
> Got it. Thanks.
>
> > > Then the VUBS will be de-asserted for a little while during xhci reset
> > > (conducted by xhci driver) for a little while and back to normal.
> > >
> > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > boot with them connected. One SW workaround which can fix this is to
> > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > late to do it in xhci-plat.c or xhci.c).
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > index 8e5265e..dadb530 100644
> > > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > @@ -106,6 +106,9 @@ Optional properties:
> > >                     When just one value, which means INCRX burst
> > mode enabled. When
> > >                     more than one value, which means undefined length
> > INCR burst type
> > >                     enabled. The values can be 1, 4, 8, 16, 32, 64, 128
> > and 256.
> > > + - snps,avoid-vbus-glitch-when-set-host: Power off all Root Hub ports
> > immediately
> > > +                   after setting host mode to avoid vbus (negative)
> > glitch happen in later
> > > +                   xhci reset. And the vbus will back to 5V automatically
> > when reset done.
> >
> > Can't you imply this from the compatible string. You should have an SoC
> > specific compatible.
>
> Sorry, not quite get your point here? Actually I have discussed with Soc design guys
> and Felipe, it seems to be DWC3 native behavior rather than SoC specific issue.
> https://lkml.org/lkml/2018/11/23/387
> https://lkml.org/lkml/2018/12/12/140
>
> I think there could be 2 reasons why we got no report for a long time till now:
> 1. Most USB devices are not so sensitive to this VBUS glitch, they would works fine.
> 2. A proper VBUS pump circuit design can successfully filter this glitch out. I have
> confirmed this with scope, which means some platforms might resolve issue in
> this way already (some might not, of cause).
>
> > Does this even need to be conditional? What would be the harm in doing
> > this unconditionally for all DWC3 hosts?
>
> From the logic level, I don't see a harm to DWC3 hosts if unconditionally apply this.
> However, since this is not a only solution (can fix it in HW way), I prefer to let it
> controlled by property in DTS node for those questionable board already existing
> in market.

Okay, sounds fine.

I would shorten the name a bit: snps,host-vbus-glitches

Rob
