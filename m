Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE88AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A3521A11
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A3521A11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHFOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:19:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52194 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbeHFOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:19:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04737206ED; Mon,  6 Aug 2018 14:10:58 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id 88C10203EC;
        Mon,  6 Aug 2018 14:10:57 +0200 (CEST)
Date:   Mon, 6 Aug 2018 14:10:57 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: add support for interrupt controller
Message-ID: <20180806121057.nvlckdxrdxpopwaw@qschulz>
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
 <20180725122621.31713-2-quentin.schulz@bootlin.com>
 <CACRpkdbq2Q-J8scsuaUS0hP1x12xh0zd+RMrCp0TYB773bOAdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spxixv56wptgjyni"
Content-Disposition: inline
In-Reply-To: <CACRpkdbq2Q-J8scsuaUS0hP1x12xh0zd+RMrCp0TYB773bOAdg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--spxixv56wptgjyni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Aug 06, 2018 at 01:06:23PM +0200, Linus Walleij wrote:
> Hi Quentin, sorry for delays!
>=20

No worries :)

> On Wed, Jul 25, 2018 at 2:27 PM Quentin Schulz
> <quentin.schulz@bootlin.com> wrote:
>=20
> > This GPIO controller can serve as an interrupt controller as well on the
> > GPIOs it handles.
> >
> > An interrupt is generated whenever a GPIO line changes and the
> > interrupt for this GPIO line is enabled. This means that both the
> > changes from low to high and high to low generate an interrupt.
> >
> > For some use cases, it makes sense to ignore the high to low change and
> > not generate an interrupt. Such a use case is a line that is hold in a
> > level high/low manner until the event holding the line gets acked.
> > This can be achieved by making sure the interrupt on the GPIO controller
> > side gets acked and masked only after the line gets hold in its default
> > state, this is what's done with the fasteoi functions.
> >
> > Only IRQ_TYPE_EDGE_BOTH and IRQ_TYPE_LEVEL_HIGH are supported for now.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
>=20
> Patch applied, it's such a pretty and straight-forward patch.
> Also IRQ is probably very nice to have, so let's get this in and
> supported.
>=20
> Please consider addressing the following in follow-up patch(es):
>=20
> > +static int ocelot_irq_set_type(struct irq_data *data, unsigned int typ=
e);
>=20
> Can't you just move the function above so you don't have to forward-decla=
re
> this?
>=20

No I can't, not in the current implementation at least.

In this function, I set the irq chip handler which needs one of the
below irq_chip. As you can see, the set_type function is also defined in
those two structures.

> > +static struct irq_chip ocelot_eoi_irqchip =3D {
> > +       .name           =3D "gpio",
> > +       .irq_mask       =3D ocelot_irq_mask,
> > +       .irq_eoi        =3D ocelot_irq_ack,
> > +       .irq_unmask     =3D ocelot_irq_unmask,
> > +       .flags          =3D IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDL=
ED,
>=20
> As you see the latter part of the define is "IF_HANDLED".
>=20
> > +       .irq_set_type   =3D ocelot_irq_set_type,
> > +};
> > +
> > +static struct irq_chip ocelot_irqchip =3D {
> > +       .name           =3D "gpio",
> > +       .irq_mask       =3D ocelot_irq_mask,
> > +       .irq_ack        =3D ocelot_irq_ack,
> > +       .irq_unmask     =3D ocelot_irq_unmask,
> > +       .irq_set_type   =3D ocelot_irq_set_type,
> > +};
>=20
> Is it really neccessary to have two irqchips?
>=20
> Is this to separate ACK and EOI because the EOI version
> doesn't survive an ACK?
>=20

Let me give you a real world use case, the reason why I used EOI.

I've a PHY interrupt line that connects to a GPIO of this controller.
The PHY holds the line until the PHY acknowledges the reason for
generating an interrupt. So we can say that it's a LEVEL_HIGH
"interrupt".

The GPIO interrupt controller generates an interruption whenever the
GPIO line has changed (0->1 or 1->0).

In a "normal" use case, I'd have the PHY holding high the line, the GPIO
controller generating an interrupt because the line has changed. We
acknowledge the interrupt in the GPIO controller. Later, we acknowledge
in the PHY the reason why we had to generate an "interrupt" on the PHY
side, resulting in the line being now held low. This generates another
interrupt on the GPIO controller side. However, only one actual
interrupt should have been generated by the GPIO controller as there's
only one event that resulted in an "interrupt" generation from the PHY.

So, we need EOI so that the GPIO controller interrupt gets acked only
when the PHY event is acked so that we don't receive an unexpected
interrupt.

However, we also need the common irq handler behaviour as we might want
to have the interrupt generated for 0->1 AND 1->0 transition depending
on the IP connected to the GPIO.

I could make my use case work with EOI but I find it very specific to my
use case and thus added the support for a more commonly found (IMHO) use
case.

I'd say that, yes, the two irqchips are needed but I may be missing
another way to handle all that.

Thanks,
Quentin

--spxixv56wptgjyni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltoOtEACgkQhLiadT7g
8aNVmBAAr/UkRmpUGrarrLTJAEtdTXIWznWVXojklYEiUkpGRqt1oc2ZHwDAbFS/
bunyihtVD9p4pM3gE5g4Hdccfq6deJrCmauhBzRXz2ULjlh0iwN9652acDhU3hsf
nACOeo0fE40TZAx6lMw2FndeJRAop6J6wrabzLrBIKxL/DUboUfsGSLSyEN22uSi
AAlOd4K6LPBmDVP0tLzWT/juiB6Q6vCyvyrjwNpGKT/dqCpsh0CKdtcIJk8a7DZq
TCKZDGs4ZcJxAMyp9K+Nwi+bJqjY1MuZg9z5QYv2DUUMj7wJHbqI4iQV66xLq35P
JtiyawfqTs2ixpvPsOtU08nPRXZbZbSxfD/inpypJJWR5IG5kE/CuBnfDNGItKKU
B3/o1ZcHf60hc2TsWhRUoEvB0rK1LwbP3CD7MDA2Kr/GgyWBRGbJ0o96X3oP9iYn
Ar4i6FTtMC4yQ7XlHwteCX68CgFRvCywqNSbc5q7g0Y/zU7mtnBQnggqt5cl9SSx
7xh2+GwsEfuFPJxX0aAXq/0mBPru26nxLtU6b1yAg0SRZw3ieHiTLClS/ZEoBzHX
THDXJVw4uzdlQSV5J7Ecaj0goeUJuWZRqgrHgd346VPD/N32HMwXGin4CUL6hveY
uG0RC5MeBsPqrDhoVZcBd1gWjkYovT8NnLv1pHCJqP5/QNon948=
=qNHL
-----END PGP SIGNATURE-----

--spxixv56wptgjyni--
