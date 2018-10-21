Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D36ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0441220869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="shuDviQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJUXGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJUXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:06:43 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1361820836;
        Sun, 21 Oct 2018 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540133528;
        bh=tTVAoDJlB+jPcb2yIxC6nZjUyFjzdL0aUvqrFJmE61o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=shuDviQ3TZNcAwA0+AO9335okGWiixEaZk0uTZM/m582PZF1axlmPQcPsI5vPQUuV
         HUBv4qe+GF6iTGGU+PadruE5ufYCfvZXzYLb0i2ZWA2KhlVZSqEOXrCr8Dim39NOks
         sPpJiGdLrtgdVdbh/VKba3s0SWuPNGuXbuC9Kslw=
Date:   Sun, 21 Oct 2018 15:52:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181021155202.5fe5a49f@archlinux>
In-Reply-To: <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
References: <20181017144716.GA11485@nishad>
        <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
        <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 09:40:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/18/2018 09:28 AM, Phil Reid wrote:
> [...]
> >> +=C2=A0=C2=A0=C2=A0 chip->rdwr_pin =3D devm_gpiod_get(&spi_dev->dev, "=
rdwr", GPIOD_IN);
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(chip->rdwr_pin)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(chip->rdwr=
_pin);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&spi_dev->dev, "Fa=
iled to request rdwr GPIO: %d\n",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -=C2=A0=C2=A0=C2=A0 gpio_direction_input(chip->rdwr_pin); =20
> >=20
> > The RD/WR pin is an input to the AD78xx. So this doesn't make sense bei=
ng
> > GPIOD_IN. =20
>=20
> One thing at a time. This patch is a straight forward conversion to the G=
PIO
> descriptor interface. It keeps the existing semantics of the driver as th=
ey are.
>=20
> Now these semantics are obviously wrong and should be fixed but that shou=
ld
> be a separate patch from changing the interface.
Agreed.  Useful to raise these issues however, and I've added a note to the
patch to bring this to anyone's attention should they be interesting.

Thanks,

Jonathan
