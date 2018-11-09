Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF71C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CA020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEZWlYiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CA020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKJCkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbeKJCkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:40:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FCB20855;
        Fri,  9 Nov 2018 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541782754;
        bh=Z5nDyzdTk6p2V+0QKGguEMnNTJMDmLFvBX3dWwLzzfQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=PEZWlYiulFJCjG/TVoYQDg/DD0RdM0H3fvD+Fkt0xRC4Z+gdSkqR9YqzvkLTcCLSC
         yOVl+uL8GWC7PtrBmlPfPOEElnd7NBGaAMNYQBbZVzXMyJhMLUK7+b8M5NGfhK6BVV
         PIxUfJtbhFGRrZO8xmoKTFxact5Pgl1AISFB7WZs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ryder.lee@mediatek.com, Frank Rowand <frowand.list@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
 <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com>
Message-ID: <154178275324.88331.16237880990995819011@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date:   Fri, 09 Nov 2018 08:59:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2018-11-09 01:56:01)
> On Wed, Nov 7, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Rob Herring (2018-11-06 12:44:52)
> > > On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >         int (*probe)(struct platform_device *pdev);
> >   };
> >
> >   struct of_platform_driver_probe_func mtk_probes[] =3D {
> >         mtk_probe1,
> >         mtk_probe2,
> >         mtk_probe3,
> >   };
> >
> >   struct platform_driver mtk_driver =3D {
> >         .of_probes =3D &mtk_probes;
> >         .driver =3D {
> >                 .name =3D "mtk-foo";
> >                 .of_match_table =3D mtk_match_table,
> >         },
> >   };
> =

> This looks worse to me: people tend to be very good at keeping multiple
> arrays in sync :-(

To be _not_ very good? Agreed, and so specifying the probe function as
another member in struct of_device_id seems to be the way to go.

