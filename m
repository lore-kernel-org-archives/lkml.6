Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B455C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39343208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj3vRJKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39343208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK2JBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2JBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:01:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9938920832;
        Wed, 28 Nov 2018 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442326;
        bh=J1URiUcjv1+jcennxN+CO+eOnhqNpdfAbzRs/TdYEjk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gj3vRJKKKZBjnP7kOZSRHuUg6hfHP8tXrHO3h1jrn2ARcfrLr0rMELUwDZXv87+Tm
         KeQY1aSZogy28VCKPwUYPq1Gzwr9mfSYL4Ui6zBaFECF/LhSrUrYGfngqzYkUM5+yg
         UNFuEJ9dMwgK89xYfNcB+mgoWTzHlF8FNpbtIWRw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87wooymqo3.fsf@bootlin.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-4-gregory.clement@bootlin.com>
 <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
 <87y39tufwe.fsf@bootlin.com> <87wooymqo3.fsf@bootlin.com>
Message-ID: <154344232606.88331.9141020759033189289@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
Date:   Wed, 28 Nov 2018 13:58:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-11-27 08:27:40)
> Hi Stephen,
>  =

>  On ven., nov. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wro=
te:
> =

> >>> +static int ap_cpu_clock_probe(struct platform_device *pdev)
> >>> +{
> >>> +       int ret, nclusters =3D 0, cluster_index =3D 0;
> >>> +       struct device *dev =3D &pdev->dev;
> >>> +       struct device_node *dn, *np =3D dev->of_node;
> >>> +       struct ap_cpu_clk *ap_cpu_clk;
> >>> +       struct regmap *regmap;
> >>> +
> >>> +       regmap =3D syscon_node_to_regmap(np->parent);
> >>
> >> Can we just call dev_get_remap() on pdev->dev.parent?
> >
> > we could do regmap =3D dev_get_regmap(pdev->dev.parent, NULL); instead =
of
> > this line. But is it really better?
> =

> Actually we can't, because we really depend on a syscon and at this
> moment there is no regmap. It is the syscon_node_to_regmap function which
> creates this regmap when needed.
> =


Ah ok. Nevermind then.

