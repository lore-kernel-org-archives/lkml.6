Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E79E2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VYYIa1iM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E79E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLDRVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:21:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34262 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ooNVp0bEOpurSzUeQMQi460/AiSx/S32yZc6WkOpKw=; b=VYYIa1iMPn930LCR3yMBTt4JL
        UogyBjevnf6+cJKsr8hi07gTysHCh5J/uP67d6d5gbxfynFxGy5je6NV0NGqHJEZ392J6P14JgE/o
        ymqoQc+/D6iMVa/PkIIhwqRLU3gqSL0p0Dxm2cKPJgyPWqoHsH4J8h4afoAexKpPQNZbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUEO9-0007uz-LY; Tue, 04 Dec 2018 17:21:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2CF4711251E3; Tue,  4 Dec 2018 17:21:37 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:21:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181204172137.GE6809@sirena.org.uk>
References: <20181130085908.GA24983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20181130085908.GA24983@localhost.localdomain>
X-Cookie: The sum of the Universe is zero.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 10:59:08AM +0200, Matti Vaittinen wrote:

> IRQ handling is implemented so that each sub block has own
> status/ack/mask registers and then there is one main status
> register. When any of the sub blocks gets unmasked IRQ,
> corresponding 'main status register' bit is set in main status
> register.

This sounds exactly like the wm831x which uses cascaded irqchips for
this, though not regmap-irq.

> Problem I faced is that I don't know how to create two regmap-irq chips f=
or
> the same i2c decvice - because the regmap-irq gets the DT node from regmn=
ap
> - and thus both of the irq chips would have same DT node. My assumption is
> that the DT - xlate functionality for this setup would not be quite corre=
ct,
> right? I guess the "main irq" interrupts would be hookable via DT? But
> the devices are interested in "sub IRQs". So I thought that the correct
> solution would be to model the interrupts from this PMIC as just one
> irq-chip. So I wonder if addin this "main IRQ register" support for

I suspect the idiomatic way to handle this in DT is to make DT nodes
(and devices) for the subfunction interrupt controllers and expose the
internal structure of the chip to the DT.  This does make some sense as
the individual interrupt controllers within the chip are clearly
reusable IP blocks though it means that the chip starts looking a bit
weird externally so perhaps that's not ideal and your suggestion makes
sense.

> configuring IRQ pins as level triggered. So I thought we could add
> support for setting the type to level_low or level_high. This change
> would require adding 'supported_types' information to all drivers which
> are currently using regmap-irq for supporting type-setting - but quick
> grep for drivers allow me to think that it is currently only the=20
> gpio-max77620 which uses the type setting in-tree.

That seems pluasible but definitely seems like a separate change.

> + * @main_status: Base main status register address. For chips which have
> + *		 interrupts arranged in separate sub-irq blocks with own IRQ
> + *		 registers and which have a main IRQ registers indicating
> + *		 sub-irq blocks with unhandled interrupts. For such chips fill
> + *		 sub-irq register information in status_base, mask_base and
> + *		 ack_base.
> + * @sub_reg_offsets: arrays of mappings from main register bits to sub i=
rq
> + *		 registers. First item in array describes the registers
> + *		 for first main status bit. Second array for second bit etc.
> + *		 Offset is given as sub register status offset to status_base.
> + *		 Should contain num_regs arrays. Can be provided for chips with
> + *		 more complex mapping than 1.st bit to 1.st sub-reg, 2.nd bit to
> + *		 2.nd sub-reg, ...

This interface feels a little awkward in that we define the sub
interrupts in this separate array and require them all to be in separate
single registers which probably won't be true in general (IIRC it wasn't
how the wm831x worked).  How about instead we have the individual
interrupts mark which main status bits flag them, then build up a
mapping in the other direction during init of subregisters to read?
I've not tried to implement that so there might be annoying difficulties
during implementation though.

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwGt6AACgkQJNaLcl1U
h9BNVgf7BDyuGkBZFqQbkqj7+ekR57dFIlPIJDosT0zmlr+bVGsYFsDwx+XwxK8y
dK2mwMMcK2v6Vgv4Tvc/JnW7ZAH5bxDtSafCjL4Qd7zFE4b8qFpV7Kl2rKu65ikr
6cRXRp6Q7riokC1zf/mfN5L6+OStnnWZ8qX5PCVlbLYGcmF3wUvXmYbkraxWt2LI
toIvgaTjqMT0lX8z/z/jredpz4HT3gfrATw7KV44cXijBzYJ7UnXepGTtmOZ+O8y
ggzcIQhlPZtAJsFgtyJVX/dArEcM9lk5TOSg/Bl5V3Lg2+9p9WG9wVojROVikY9c
/LxfcxaMNgPYOwUmGV5IOVFqNQMhmQ==
=WwsZ
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
