Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFAC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E074223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1m0dV1f6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E074223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKNFo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeKNFo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:44:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 101E1216FD;
        Tue, 13 Nov 2018 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542138291;
        bh=p7CX0gDvZdAxNLwNYAGh6FphTMIN1RSTmFJLR5AkL90=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1m0dV1f61NWqw3r4Bji21Bsg6CIyU1WASApLpj5OzGbNx88Oaxj/PB3HjYI8/WmQT
         O/SYfpZssRYaF47/uQeTYnvtZyasOtsrhwebg8UlmcHpTdpFCe+AmAYXEzMYLw093P
         kAN0s/oMIXoWjx/YyqgpkWqoD3P5WLrm2Hup/Hq0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <TY1PR01MB1769B2978D73DBC2EADC6B8DF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
 <1535724443-21150-2-git-send-email-phil.edworthy@renesas.com>
 <153576994987.19113.11376893046599589648@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769CBB6FC715E94B10815BFF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB1769B2978D73DBC2EADC6B8DF50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <154213829039.88331.14286655280073748584@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v5 1/2] clk: Add of_clk_get_by_name_optional() function
Date:   Tue, 13 Nov 2018 11:44:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Edworthy (2018-09-03 06:21:02)
> Hi Stephen,
> =

> On 03 September 2018 10:33 Phil Edworthy wrote:
> > On 01 September 2018 03:46, Stephen Boyd wrote:
> > > Quoting Phil Edworthy (2018-08-31 07:07:22)
> > > > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c index
> > > > 9ab3db8..4adb99e 100644
> > > > --- a/drivers/clk/clkdev.c
> > > > +++ b/drivers/clk/clkdev.c
> > > > @@ -54,30 +54,29 @@ EXPORT_SYMBOL(of_clk_get);
> > > >
> > > >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> > > >                                         const char *dev_id,
> > > > -                                       const char *name)
> > > > +                                       const char *name,
> > > > +                                       bool optional)
> > > >  {
> > > >         struct clk *clk =3D ERR_PTR(-ENOENT);
> > > > +       struct device_node *child =3D np;
> > > > +       int index =3D 0;
> > > >
> > > >         /* Walk up the tree of devices looking for a clock that mat=
ches */
> > > >         while (np) {
> > > > -               int index =3D 0;
> > > >
> > > >                 /*
> > > >                  * For named clocks, first look up the name in the
> > > >                  * "clock-names" property.  If it cannot be found, =
then
> > > > -                * index will be an error code, and of_clk_get() wi=
ll fail.
> > > > +                * index will be an error code.
> > > >                  */
> > > >                 if (name)
> > > >                         index =3D of_property_match_string(np, "clo=
ck-names",
> > name);
> > > > -               clk =3D __of_clk_get(np, index, dev_id, name);
> > > > -               if (!IS_ERR(clk)) {
> > > > -                       break;
> > > > -               } else if (name && index >=3D 0) {
> > > > -                       if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> > > > -                               pr_err("ERROR: could not get clock =
%pOF:%s(%i)\n",
> > > > -                                       np, name ? name : "", index=
);
> > > > +               if (index >=3D 0)
> > > > +                       clk =3D __of_clk_get(np, index, dev_id, nam=
e);
> > > > +               if (!IS_ERR(clk))
> > >
> > > Was this change necessary? It looks like we can leave it all alone an=
d keep
> > > passing a negative number to __of_clk_get() and have that return an e=
rror
> > > pointer which we then return immediately as an error. But, if the clo=
ck is
> > > optional and we've passed a name here, shouldn't we treat an error fr=
om
> > > of_property_match_string() as success too? This is all looking pretty=
 fragile
> > so
> > > maybe it can be better commented and also more explicit instead of re=
lying
> > > on the reader to jump through all the function calls to figure out wh=
at the
> > > return value is in some cases.
> > If we call __of_clk_get, with index < 0, we will not be able to differe=
ntiate
> > between clock provider not present and other errors with the passed dat=
a,
> > as it will just return -EINVAL.
> > =

> > of_property_match_string() will return -EINVAL if the "clock-names"
> > property
> > is missing, or -ENODATA if the specified clock name in the "clock-names"
> > property is missing. That is why I have changed the code to conditional=
ly
> > call __of_clk_get, so the code will correctly treat optional clocks tha=
t are not
> > present.
> When getting named optional clocks, if the node has a "clock-names" prope=
rty,
> but no clock matching the name we want, I think the function should stop =
there
> and *not* walk up the tree of devices looking for a matching clock. In th=
is case,
> the code determines that the optional clock is not present.
> =

> If there isn=E2=80=99t a "clock-names" property in the current node, the =
function should
> walk up the tree of devices looking for a matching optional clock. If the=
re are no
> parent nodes left and we haven't found a matching optional clock, we dete=
rmine
> that the clock isn=E2=80=99t there.
> =

> Is that how this should work?
> =


Yes that sounds right.

