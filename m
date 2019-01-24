Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54CC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F14B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548369686;
	bh=k+kztCmBaXjD7kREzHoQpwFEViSbeAc9Ddlz0bZdawM=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=FkGvBTQ/j+DpCwKv4FGbifdLFoStmYiWmui7hwJnOfditrPsrKUMVgAzgevIM2JIG
	 OQ7NATuy9eSMf24rnepMmWOTo8mz4vVMM6eUzyo+0HinvUp03ndZikqwJ9NAgiM2uB
	 XPOTb1uXWPao/Uz/77wAP+ubHACm6lpuZ1d/0+TY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfAXWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAXWlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:41:23 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A5421872;
        Thu, 24 Jan 2019 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548369682;
        bh=k+kztCmBaXjD7kREzHoQpwFEViSbeAc9Ddlz0bZdawM=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=r6q0Wm0m+7ed8ty+jdYDLsN1YhUGUDyNpNt6ArP84dJTyqWYzovoM5z96MCx/o5f3
         /1+IgzU6g4F0vNgdTnQNAP2C9LJirOZMx2R32GqGE9rz4WJkgnfE56KKWgvGQfIyOd
         9t6kESaQOahIc2YAqkf60gwuhTrlgyeoVJbPXq7E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external clock reference
References: <20181206091052.7644-1-mircea.caprioru@analog.com> <20181208152954.596529f8@archlinux> <154475156267.19322.6284056396098102605@swboyd.mtv.corp.google.com> <20181216100741.4e362a17@archlinux>
User-Agent: alot/0.8
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181216100741.4e362a17@archlinux>
Message-ID: <154836968107.136743.11352935762099070131@swboyd.mtv.corp.google.com>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 24 Jan 2019 14:41:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2018-12-16 02:07:41)
> Rob, Clk experts, questions for you below.
>=20
> Jonathan
>=20
>=20
> On Thu, 13 Dec 2018 17:39:22 -0800
> Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jonathan Cameron (2018-12-08 07:29:54)
> > > On Thu, 6 Dec 2018 11:10:51 +0200
> > > Mircea Caprioru <mircea.caprioru@analog.com> wrote:
> > >  =20
> > > > This patch adds a clock to the state structure of ad7192 for gettin=
g the
> > > > external clock frequency. This modifications is in accordance with =
clock
> > > > framework dt bindings documentation.
> > > >=20
> > > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com> =20
> > >=20
> > > +cc Rob and the clk list for advise on how to do the binding for this=
 one.
> > >=20
> > > It is basically 2 pins, you can put a clock in on one of them or conn=
ect
> > > a crystal across them.  The driver has to set a register to say which=
 is
> > > the case. =20
> > >=20
> > > Current proposal is two optional clocks (fall back to internal oscill=
ator)
> > > but that doesn't seem to be commonly done, so I'm wondering if there
> > > is a 'standard' way to handle this sort of thing.
> > >  =20
> >=20
> > I'm not sure I fully understand, but I think perhaps
> > assigned-clock-parents would work? Or does that not work because either
> > way some parent is assigned, either the crystal or the optional clk that
> > isn't a crystal?
> >=20
> My concern is they aren't really separate clock inputs.   They are just d=
ifferent
> ways of providing the same fundamental clock.  So I think we may want to =
just
> provide a single clock and have another dt binding to say what it is.
>=20
> So lots of ways we could do it, but I'm not sure what the right one to
> go with is!
>=20

Sorry for getting back to this so late. Is the datasheet public for this
device? If so, any link to it?

If it's two pins, and sometimes one pin is connected and other times two
pins are connected but a register needs to be set if the pins are
connected in one configuration or the other I would say your plan for a
DT property indicating how the pins are configured sounds good. Usually
the hardware can figure these things out itself so I find this sort of
odd, but if this is how it is then there's not much that we can do.

It sounds like there aren't two different clk inputs to the device.
Given that information specifying two optional clks is incorrect because
there is only one 'slot' is the external clk source.

