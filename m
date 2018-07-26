Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B68B20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH1MNyE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B68B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbeGZQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730781AbeGZQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:44:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6350520846;
        Thu, 26 Jul 2018 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532618833;
        bh=7R9YMxSO6WlB/iiFO1ePU+BXvzSZX/1EKmuWBtjw3YM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=vH1MNyE5Ez443ivzZC8ot159G0fKWYv8f68XaSzbgYBk2Gjh2lJnY/fL7IqjConEr
         k2Q2N1gDyIdIax4DKqIIX30LkQHquloUEfYOErg35RbkQG9dXaanEaL5Y+m/DhO3/l
         iqhfSqNqgQgvCXTLoqjUv2nuXcaxCeD5EFwE+G9c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajan Vaja <RAJANV@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CY1PR02MB2091CE50B9163419EB7D67EFB72B0@CY1PR02MB2091.namprd02.prod.outlook.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
References: <1531833420-27175-1-git-send-email-rajan.vaja@xilinx.com>
 <153253683456.48062.11538822357721957211@swboyd.mtv.corp.google.com>
 <CY1PR02MB2091CE50B9163419EB7D67EFB72B0@CY1PR02MB2091.namprd02.prod.outlook.com>
Message-ID: <153261883266.48062.5136812490732432669@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure
Date:   Thu, 26 Jul 2018 08:27:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2018-07-26 06:03:16)
> Hi Stephen,
> =

> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: 25 July 2018 10:11 PM
> > To: Rajan Vaja <RAJANV@xilinx.com>; mturquette@baylibre.com
> > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Rajan Vaja
> > <RAJANV@xilinx.com>
> > Subject: Re: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in =
case of
> > failure
> > =

> > Quoting Rajan Vaja (2018-07-17 06:17:00)
> > > Fixed factor clock has two initializations at of_clk_init() time
> > > and during platform driver probe. Before of_clk_init() call,
> > > node is marked as populated and so its probe never gets called.
> > >
> > > During of_clk_init() fixed factor clock registration may fail if
> > > any of its parent clock is not registered. In this case, it doesn't
> > > get chance to retry registration from probe. Clear OF_POPULATED
> > > flag if fixed factor clock registration fails so that clock
> > > registration is attempted again from probe.
> > >
> > > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > > ---
> > >  drivers/clk/clk-fixed-factor.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-f=
actor.c
> > > index d72ef2d..f3ae4ff 100644
> > > --- a/drivers/clk/clk-fixed-factor.c
> > > +++ b/drivers/clk/clk-fixed-factor.c
> > > @@ -177,8 +177,15 @@ static struct clk *_of_fixed_factor_clk_setup(st=
ruct
> > device_node *node)
> > >
> > >         clk =3D clk_register_fixed_factor(NULL, clk_name, parent_name=
, flags,
> > >                                         mult, div);
> > > -       if (IS_ERR(clk))
> > > +       if (IS_ERR(clk)) {
> > > +               /*
> > > +                * If parent clock is not registered, registration wo=
uld fail.
> > > +                * Clear OF_POPULATED flag so that clock registration=
 can be
> > > +                * attempted again from probe function.
> > > +                */
> > > +               of_node_clear_flag(node, OF_POPULATED);
> > >                 return clk;
> > > +       }
> > =

> > BTW, this patch was seriously mangled for me so I had to apply it by
> > hand. Please be more careful next time and consider using something like
> > git-send-email and git-format-patch to send patches.
> [Rajan] I used git-send-email only and sent same way as I used to send ot=
her patches. Not sure where was issue.
> Sorry for the inconvenience.  =

> =


It must be your Outlook server messing things up. I see
Content-Transfer-Encoding: quoted-printable in the headers, which
probably caused my MUA to choke and line break things in the wrong
place.

