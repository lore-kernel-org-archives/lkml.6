Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C79620864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKl+1rjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C79620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLCXfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeLCXfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:35:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE2420850;
        Mon,  3 Dec 2018 23:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543880111;
        bh=sUraBo94mptqp8XTw/adaqoZFeEnJjizpj3C2c03q7s=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NKl+1rjEoTgBW1k/Bl7CtJTgIxA/fofNrP1rPo69vzJ57999RuuLyvArSNc/jgHYs
         Z2zItscIgcxZc+J34FtQfzjeNFCDML5s7u9NLf9rspVlTgDcxza1tOCoRr1MamsCo4
         rdtxT41CgezmJ/757/oDy6qops+mkAzyLuma1qrw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130105022.GA15388@localhost.localdomain>
Cc:     mazziesaccount@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
Message-ID: <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Date:   Mon, 03 Dec 2018 15:35:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-11-30 02:50:22)
> Hello Stephen,
> =

> Thanks a bunch for taking the time and reviewing this!
> =

> On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > With MFD devices the clk properties may be contained in MFD (parent) =
DT
> > > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to=
 MFD
> > > subdevice not to MFD device (parent). Add
> > > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > > =

> > > Also clkdev registration lacks of managed registration functions and =
it
> > > seems few drivers do not drop clkdev lookups at exit. Add
> > > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > > releasing at exit.
> > =

> > Please split this into clkdev and non-clkdev devm functionality.
> Allright. I'll split this to two patches.
> =

> > > --- a/Documentation/driver-model/devres.txt
> > > +++ b/Documentation/driver-model/devres.txt
> > > @@ -238,6 +238,9 @@ CLOCK
> > >    devm_clk_put()
> > >    devm_clk_hw_register()
> > >    devm_of_clk_add_hw_provider()
> > > +  devm_of_clk_add_parent_hw_provider()
> > > +  devm_clk_hw_register_clkdev()
> > > +  devm_clk_release_clkdev()
> > =

> > The 'release' or non-common functions shouldn't be documented here.
> So I will drop the line mentioning devm_clk_release_clkdev()
> =

> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index af011974d4ec..9bb921eb90f6 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(stru=
ct device *dev, void *res)
> > >         of_clk_del_provider(*(struct device_node **)res);
> > >  }
> > >  =

> > > -int devm_of_clk_add_hw_provider(struct device *dev,
> > > +static int __devm_of_clk_add_hw_provider(struct device *dev,
> > >                         struct clk_hw *(*get)(struct of_phandle_args =
*clkspec,
> > >                                               void *data),
> > > -                       void *data)
> > > +                       struct device_node *of_node, void *data)
> > >  {
> > > -       struct device_node **ptr, *np;
> > > +       struct device_node **ptr;
> > >         int ret;
> > >  =

> > >         ptr =3D devres_alloc(devm_of_clk_release_provider, sizeof(*pt=
r),
> > > @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device =
*dev,
> > >         if (!ptr)
> > >                 return -ENOMEM;
> > >  =

> > > -       np =3D dev->of_node;
> > > -       ret =3D of_clk_add_hw_provider(np, get, data);
> > > +       *ptr =3D of_node;
> > > +       ret =3D of_clk_add_hw_provider(of_node, get, data);
> > >         if (!ret) {
> > > -               *ptr =3D np;
> > =

> > Why is this moved outside of the if condition?
> I completely removed the local variable np and just unconditionally set
> the allocated devres to point at the node (if allocation succeeded). We
> could of course only do this if the provider registration succeeded and
> save one assignment - but I guess I intended to remove the curly braces
> and thus decided to go for one liner after if. But apparently I didn't
> remove the braces O_o. Well, I can put the assignment inside the
> condition if you prefer that.
> =

> > In fact, why isn't just
> > the first line in this hunk deleted and passed to this function as
> > struct device_node *np?
> =

> I am sorry but I don't quite follow your suggestion here. Do you mean we
> could just pass the struct device_node *np in devres_add()? I thought
> the pointer passed to devress_add() should be allocated using
> devres_alloc. Can you please elaborate what you mean?

I'm just trying to reduce the diff in the patch.

> =

> > =

> > >                 devres_add(dev, ptr);
> > >         } else {
> > >                 devres_free(ptr);
[..]
> > =

> > > +int devm_of_clk_add_hw_provider(struct device *dev,
> > > +                       struct clk_hw *(*get)(struct of_phandle_args =
*clkspec,
> > > +                                             void *data),
> > > +                       void *data)
> > > +{
> > > +       return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, =
data);
> > > +}
> > >  EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
> > >  =

> > > +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> > > +                       struct clk_hw *(*get)(struct of_phandle_args =
*clkspec,
> > > +                                             void *data),
> > > +                       void *data)
> > > +{
> > > +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->o=
f_node,
> > =

> > I'm wondering if we can somehow auto-detect this in
> > devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
> > If it isn't there, then we go to the parent node and look for a
> > #clock-cells property there in the DT node for that device. Does that
> > make sense? Then there isn't any new API and we can attach the lifetime
> > of the devm registration to the presence of the property indicating this
> > is a clk controller or not.
> =

> Huh. I don't know why but building this kind of logic in core is a bit
> scary to me. I guess I can try implementing something like this - but I
> am not really a fan of this. (Accidentally) omit the #clock-cells from
> node and we go to parent node - I am a novice on this area but this
> sounds like a potential hazard to me. I believe the driver should know
> if it's properties should be in own or parent node - and if they are
> not, then there should be no guessing but error. The lifetime is topic
> where I would like to get information from you who know the kernel
> better than I do =3D) But I guess the parent node is there at least as
> long as the child device is alive. So for me the life time of
> get-callback is more crucial - but as I said, I don't understand the
> kernel in details so you probably know it better than me. But please let
> me know your final take on this and I will follow the guidance =3D)

Please do the magic instead of adding another API. It makes things
simpler and will work for this case without having to change anything
besides of_clk_add_provider().

If the DT doesn't have the #clock-cells property in the node being
registered then calling clk_get() will fail for any consumer devices
that point to the node with a phandle and clock specifier. I don't
expect us to get very far into development if that's the case.

Of course, we don't fail in of_clk_add_provider() if there isn't a
#clock-cells property in the node, we just happily add the node to the
provider list and carry on. I doubt anyone is failing to specify the DT
property, but maybe they are, in which case we could keep not failing
and just add the node of whatever we're called with originally if
neither the parent or the passed node have the #clock-cells property. I
wouldn't try to go any higher than one node above the current node and
look for a #clock-cells though.

If this all still seems scary then don't worry about it, I'll implement
it myself.

