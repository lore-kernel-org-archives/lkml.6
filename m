Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF5C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46F020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544030376;
	bh=uzsaPsig8b873ezprISC8EwBO8YotKaZo0BtH68T5RA=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=qKkUJOKJ2QrbOZm1248HGb7JONHGIp0ClwF7JsNpA6cawdO4jEG3uXurDHsdrFCTd
	 HjyBi4OtTuJbw9s5AszbGtb3o91IqSDnulKfUb77cd0rGclkLwC4yaFQLI929xGGKj
	 9ZsPBBvRvtVEe5BASNh78GjCIaUKcDLwgIThshwc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46F020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeLERTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbeLERTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:19:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32222082B;
        Wed,  5 Dec 2018 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544030373;
        bh=uzsaPsig8b873ezprISC8EwBO8YotKaZo0BtH68T5RA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=htYb7sr6bXuk8/biWoQ2AHhvWW1EZMe8nLkOVHeliuOUBx8kKGZEdUBUIfB4Q/yzf
         TQ28c4lstuiIv0o4P8Fx6h0mwOTbXmZ2y7UeHTDDVG4f7W3xr3mAwmX486ZANyX0UN
         rMEx/IUTXCGAVsPqlCT1jYwBIaUJVMrBVXeT9Q4c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
X-Patchwork-Hint: ignore
In-Reply-To: <20181205070046.GD31204@localhost.localdomain>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
Message-ID: <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered device
 has no provider info
Date:   Wed, 05 Dec 2018 09:19:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 23:00:46)
> Hello Stephen,
> =

> I copied some parts of the v4 discussion here as well. Let's continue
> them under this one email thread. (and yep, this is my bad we now have
> multiple email threads - I did these new patches without waiting for
> the final conclusion. I should try to be more patient in the future...)
> =

> > > > I think we should use parent device's node, not the paren node in D=
T,        =

> > > > right? But I agree, we should only look "one level up in the chain"=
.         =

>                                                                          =
        =

> > > Are these two things different? I'm suggesting looking at            =
          =

> > > device_node::parent and trying to find a #clock-cells property.      =
          =

>                                                                          =
        =

> > I thought that MFD sub-devices may completely lack the DT node but I
> > will verify this tomorrow.
> =

> So yep. It appears that the DT node for MFD sub-device is left NULL.
> This is quite logical as there really is no clk sub-node in MFD (pmic)
> node. The option to "hack around" this would be setting the of_node to
> parent node in driver code. But this feels wrong. Drivers should not
> mess with the "dt node ownership" - and it also feels a bit odd when
> many devices use same DT node. I think we may hit in problems when
> obtaining resources or doing reference counting. Hence I think we should
> keep the of_node NULL for sub-device if the sub-device does not have own
> node inside the main devie node. And I think Rob was not a fan of having
> own nodes for sub-devices inside the MFD node (AFAIR my first driver
> draft for this device had it but Rob and you thought that was not correct=
).

Yes let's not change this.

> > > @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struc=
t device *dev, void *res)
> > >   *
> > >   * Returns 0 on success or an errno on failure.
> > >   *
> > > - * Registers clock provider for given device's node. Provider is aut=
omatically
> > > - * released at device exit.
> > > + * Registers clock provider for given device's node. If the device h=
as no DT
> > > + * node or if the device node lacks of clock provider information (#=
clock-cells)
> > > + * then the parent device's node is scanned for this information. If=
 parent node
> > > + * has the #clock-cells then it is used in registration. Provider is
> > > + * automatically released at device exit.
> > >   */
> > >  int devm_of_clk_add_hw_provider(struct device *dev,
> > >                         struct clk_hw *(*get)(struct of_phandle_args =
*clkspec,
> > > @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device=
 *dev,
> > >         struct device_node **ptr, *np;
> > >         int ret;
> > >  =

> > > +       np =3D dev->of_node;
> > > +
> > > +       if (!of_is_clk_provider(dev->of_node))
> > > +               if (of_is_clk_provider(dev->parent->of_node))
> > > +                       np =3D dev->parent->of_node;
> > =

> > As said on v5, let's just modify of_clk_add_provider() to do the parent
> > search.
> =

> But that won't solve the issue if we don't do "dirty hacks" in driver.
> The devm interface still only gets the device-pointer, not the DT node
> as argument. And if DT node for device is NULL (like in MFD cases) -
> then there is no parent node, only parent device with a node. For plain
> of_clk_add_provider() the driver can just give the parent's node pointer
> in cases where it knows it is the parent who has the provider data in
> DT. But our original problem is in devm interfaces.
> =


I was misunderstanding the MFD design. Should still work though, so I
squashed this into the patch to clean things up a bit. Does this work
for you?

------8<-----

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bb689161f0f5..6ff852bda892 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,9 +3893,23 @@ static void devm_of_clk_release_provider(struct devi=
ce *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 =

-static int of_is_clk_provider(struct device_node *np)
+/*
+ * We allow a child device to use its parent device as the clock provider =
node
+ * for cases like MFD sub-devices where the child device driver wants to u=
se
+ * devm_*() APIs but not list the device in DT as a sub-node.
+ */
+static struct device_node *get_clk_provider_node(struct device *dev)
 {
-	return !!of_find_property(np, "#clock-cells", NULL);
+	struct device_node *np, *parent_np;
+
+	np =3D dev->of_node;
+	parent_np =3D dev->parent ? dev->parent->of_node : NULL;
+
+	if (!of_find_property(np, "#clock-cells", NULL))
+		if (of_find_property(parent_np, "#clock-cells", NULL))
+			np =3D parent_np;
+
+	return np;
 }
 =

 /**
@@ -3920,17 +3934,12 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	struct device_node **ptr, *np;
 	int ret;
 =

-	np =3D dev->of_node;
-
-	if (!of_is_clk_provider(dev->of_node))
-		if (of_is_clk_provider(dev->parent->of_node))
-			np =3D dev->parent->of_node;
-
 	ptr =3D devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 =

+	np =3D get_clk_provider_node(dev);
 	ret =3D of_clk_add_hw_provider(np, get, data);
 	if (!ret) {
 		*ptr =3D np;
@@ -3981,13 +3990,8 @@ static int devm_clk_provider_match(struct device *de=
v, void *res, void *data)
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
-	struct device_node *np;
-
-	np =3D dev->of_node;
+	struct device_node *np =3D get_clk_provider_node(dev);
 =

-	if (!of_is_clk_provider(dev->of_node))
-		if (of_is_clk_provider(dev->parent->of_node))
-			np =3D dev->parent->of_node;
 	ret =3D devres_release(dev, devm_of_clk_release_provider,
 			     devm_clk_provider_match, np);
 =


