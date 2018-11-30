Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="06nqnrTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAB52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK3SLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbeK3SLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:11:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3A12145D;
        Fri, 30 Nov 2018 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543561408;
        bh=RkKCI7Pxt7bx3MBwO+HtfwrHSzsfYZtr5xl/nny+qBE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=06nqnrTff+RccCtByMEXZoCjJlHmqOGCacHXWQ9tPpdybTG4HxGG+vgshuNOta7gX
         u5Fa1hxGSFZ/qPoDLzve73sou4Sfm28v/Bll6FTyJMiZtkMldq3DsnHUWC+Yfs/+Aw
         zoqrWbr+zYXyl/kryH3aQphSkNpkJ3QgELI2d9qk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
 <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
 <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Message-ID: <154356140759.88331.15666344779026803117@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date:   Thu, 29 Nov 2018 23:03:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-11-29 17:01:54)
> On Thu, Nov 29, 2018 at 6:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Stephen Boyd (2018-11-07 10:37:31)
> > > appropriate structure with to_platform_device() or to_i2c_client()?
> > >
> > > So the example would become
> > >
> > >   struct of_driver_probe_func {
> > >         int (*probe)(struct device *dev);
> > >   };
> > >
> > >   struct of_driver_probe_func mtk_probes[] =3D {
> > >         mtk_probe1,
> > >         mtk_probe2,
> > >         mtk_probe3,
> > >   };
> > >
> > >   struct platform_driver mtk_driver =3D {
> > >         .driver =3D {
> > >                 .name =3D "mtk-foo";
> > >                 .of_match_table =3D mtk_match_table,
> > >                 .of_probes =3D &mtk_probes;
> > >         },
> > >   };
> > >
> > > And the probe functions might need to container_of() the device point=
er
> > > to get the struct they know they need. The probe function could also =
be
> > > added to of_device_id and then we would have to look and see if that
> > > pointer is populated when the device is matched in generic device cod=
e.
> > >
> >
> > I guess I'll go down the path of extending the of_device_id structure?
> =

> Unfortunately, I don't think you can change of_device_id as it's part
> of the kernel ABI.

Ok. Then I'll go down the path of making it a parallel array?

