Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1479BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0242064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0242064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeKAWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:53:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeKAWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:53:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 677B0206D8; Thu,  1 Nov 2018 14:50:16 +0100 (CET)
Received: from qschulz (lfbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 06C4320717;
        Thu,  1 Nov 2018 14:50:06 +0100 (CET)
Date:   Thu, 1 Nov 2018 14:50:05 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, maxime.ripard@bootlin.com,
        Hans de Goede <hdegoede@redhat.com>, icenowy@aosc.io
Subject: Re: [PATCH v6 4/6] power: supply: core: Add some helpers to use the
 battery OCV capacity table
Message-ID: <20181101135005.cqufebdryffm6ray@qschulz>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <f1529c567a340e4d31354a4b117954eeebf89942.1540189330.git.baolin.wang@linaro.org>
 <CAMz4kuJm5eO1QwW7L+QyD_5VcTWqtq4gz9m_QDpQ-zn4zzukvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bx2txevspscynaw"
Content-Disposition: inline
In-Reply-To: <CAMz4kuJm5eO1QwW7L+QyD_5VcTWqtq4gz9m_QDpQ-zn4zzukvQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bx2txevspscynaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Thu, Nov 01, 2018 at 03:22:18PM +0800, Baolin Wang wrote:
> Hi Quentin,
>=20
> On 29 October 2018 at 22:48, Quentin Schulz <quentin.schulz@bootlin.com> =
wrote:
[...]
> >
> >> +             return len;
> >> +     } else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
> >> +             dev_err(&psy->dev, "Too many temperature values\n");
> >> +             return -EINVAL;
> >> +     } else if (len > 0) {
> >> +             of_property_read_u32_array(battery_np, "ocv-capacity-cel=
sius",
> >> +                                        info->ocv_temp, len);
> >> +     }
> >> +
> >> +     for (index =3D 0; index < len; index++) {
> >
> > This won't work as intended as we can reach this part of the code with
> > len =3D -EINVAL;
>=20
> No, the condition (index < len) is false if len =3D -EINVAL, maybe one
> reason keep index as 'int' type.
>=20

Ugh. Next time I'll make sure my brain is wired before reviewing a
patch, sorry :)

[...]
> >> +             if (!info->ocv_table[index]) {
> >> +                     power_supply_put_battery_info(psy, info);
> >> +                     return -ENOMEM;
> >> +             }
> >> +
> >> +             for (i =3D 0; i < tab_len; i++) {
> >> +                     table[i].ocv =3D be32_to_cpu(*list++);
> >> +                     table[i].capacity =3D be32_to_cpu(*list++);
> >
> > Please check these are valid values.
>=20
> Um, It is hard to validate the values for OCV and capacity, because
> now we do not know each battery's parameters. Any good suggestion?
>=20

You know the capacity is between 0 and 100 (since it's an unsigned
value, checking against 100 is enough), that's a good start.

For the OCV, I'd say it's basically between the minimum and maximum
voltage a battery can hold. I don't know enough about batteries to
give the correct bounds unfortunately :(

[...]
> > What is the use case for letting a user call this function? I can
> > understand you want to delete the arrays if they're invalid in the
> > get_function, which could be done thanks to a goto statement or with
> > this function if you really want (if it does not mess with refs) but I
> > don't see why you want to export this function.
>=20
> Cause some drivers will copy the OCV tables into their own structures,
> one helper function to help to free memory of battery information. In
> future, this can be expanded to clean up more resources of battery
> information.
>=20

Couldn't they only use a pointer to the appropriate table? Or do you
plan on the drivers directly modifying the table but wanting to keep a
clean copy on the core side?

I find it weird to free the tables. I'd suppose that a driver wants to
keep all tables available to be able to chose the appropriate one
depending on the current temperature of the battery (which is what
power_supply_batinfo_ocv2cap is for if I understood correctly) and not
only at definite time (probe function for the driver you attached to the
patch series IIRC). If you need to keep all tables, why would you want
to copy them to the driver and not keep them in the core and use a
pointer to the table in current use?

I'm sure I'm missing something, let me know what it is. Thanks.

[...]
> > I would like to give my specific use case of the OCV on X-Powers PMICs
> > so that hopefully we can get things sorted out before it's too late to
> > make modifications that might be needed.
> >
> > I'm adding a few people on Cc that work on the X-Power PMICs so that
> > hopefully we can have all the correct pieces of information and go
> > towards the right solution.
> >
> > In the AXP818/AXP288 datasheet[1] (p.57), we have access to OCV values
> > and battery RDC register.
> >
> > The hardware learns from the battery or from the given OCV and RDC
> > values and then updates the returned battery capacity accordingly (in
> > another register).
> > I've 32 values (see the issue with a max of 20 values?) to be written in
>=20
> I think you misunderstood the 20, it is means we can have max 20 OCV tabl=
es now.
>=20

Indeed, misread the patch, thanks for clarifying.

> > different registers that represent the battery capacity at a given
> > voltage. I do not have to do any computation on the kernel side, I just
> > have to set the registers with the correct values and the battery
> > capacity will be auto-updated by the PMIC. With this patch series,
> > should I just call power_supply_get_battery_info, get the OCV tables and
>=20
> I think so.
>=20
> > do my thing in the driver? Could we have a more generic way to do it
> > (does it make sense to have a generic one?)?
>=20
> Sorry, maybe I did not follow you here. You said your hardware will
> help to get the capacity automatically if you set the register, so
> what generic way you want to introduce? Could you elaborate on?
>=20

I think I got my thoughts tangled-up, I can't honestly find a generic
way right now.

> >
> > We also definitely need a sysfs entry so that the user can enter the new
> > values of the RDC/OCV since it changes during the life cycle of the
> > battery IIRC.
>=20
> Why it changed? Due to different temperatures or other factors? If the
> factor is temperature, I think we have supplied one generic way:
> https://lore.kernel.org/patchwork/patch/1002350/
>=20

Apparently age is a factor in the OCV curve. I don't know if it's
substantial enough to care about though.

Anyway, I have a very strong bias towards not having to modify the
Device Tree or recompile the kernel when a piece of hardware can be
replaced easily by something different. I see the battery as such a
piece of hardware. I understand the need to define the battery that
comes with a product but I also like to let the users switch the battery
(for a bigger one for example) without getting their hands dirty with
getting the kernel sources, recompiling, etc.

What if the provided OCV curves are not the best ones and the user has
found better ones?

For that, I like to let the user configure parameters that impact the
battery after we've optionaly set the default one.

I'd be mad to have to recompile the Device Tree or kernel when switching
devices on a USB bus for example.

Does that make sense?

Thanks,
Quentin

--4bx2txevspscynaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvbBIwACgkQhLiadT7g
8aM45g/9GwhwslT3Lj0CjLOa//X03/Eye8gfaDKvgrGoRQDt6+ykaVgwL5BVpeVM
x0OkKD0XcSCaNztmeJRj3czg2cvyUoax9g42Ep0mEC6uJI6U45FxfnUMebUwU1Kf
fxxcDx0EkOnjxUTAqnG2Nhs/3dS96VVxuFoG93bbRAJMmmwgCeTNagqv6sSfWJu1
NWIhT18SaC2i1RGxHxyNm+Mo0ZbtkntA5heYsj+E0Rwo1XTjCW8E+7pdj6WJ/x1p
6fFPacgKCiWyZ4EhyzE32sRhgYoYmH9EAmNlNk48xv8TEP4xazysg5P2mcLwwlvl
FbX7v1bFdmlxvPsuLKi6RmJ3V9IfiSbsaGiHhVzyeg2hWezv/vRJ07PYZ+9hYp3f
iu8mX6QxCfoZw4KbyNWQtzFhVtzU4yKH1/bCqIiE1CRcai+BGSeRaTF5YGI1yvck
EaimFbnqhYTumxaEWbKBI4wKSMDpc1qv2d079Q7+qsnUOwU7HrXvD4xNvlfOZig1
4Q1QTbZBlcn6yRmvL8nDSxdr81qsyQWMjDRxRA/9aNyw+KFyOpjCm5ljNGm5+P14
wt0meHJ3okGc6HJAWLyNHrB5WU6GvC6ejUbKp9mroybgnhYsEiD4QoC61JQpSpZF
w0MSCyeO+YtRt/F6eZbv8nbxoEYLrNMMqOo9zFKHz/MOMY+6v1I=
=+Gfk
-----END PGP SIGNATURE-----

--4bx2txevspscynaw--
