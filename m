Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfBVKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:23:38 -0500
Received: from sauhun.de ([88.99.104.3]:44396 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBVKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:23:38 -0500
Received: from localhost (p54B331E2.dip0.t-ipconnect.de [84.179.49.226])
        by pokefinder.org (Postfix) with ESMTPSA id BBAA03E4AA3;
        Fri, 22 Feb 2019 11:23:35 +0100 (CET)
Date:   Fri, 22 Feb 2019 11:23:35 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jim Broadus <jbroadus@gmail.com>, ckeepax@opensource.cirrus.com,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Message-ID: <20190222102335.GA1771@kunai>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
 <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 11:15:59AM +0100, Benjamin Tissoires wrote:
> On Fri, Feb 22, 2019 at 12:26 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> > > A previous change allowed I2C client devices to discover new IRQs upon
> > > reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ =
was
> > > assigned in i2c_new_device, that information is lost.
> > >
> > > For example, the touchscreen and trackpad devices on a Dell Inspiron =
laptop
> > > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > > client device structures are initialized during an ACPI walk. After
> > > removing the i2c_hid device, modprobe fails.
> > >
> > > This change caches the initial IRQ value in i2c_new_device and then r=
esets
> > > the client device IRQ to the initial value in i2c_device_remove.
> > >
> > > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> >
> > Adding Benjamin to CC
>=20
> Sorry, I should have answered earlier.
>=20
> I am a little bit hesitant regarding this patch. The effect is
> correct, and I indeed realized a few weeks ago that something were
> wrong as we couldn't rmmod/modprobe i2c-hid.
>=20
> But I still have the feeling that the problem is not solved at the
> right place. In i2c_new_device() we are storing parts of the fields of
> struct i2c_board_info, and when resetting the irq we are losing
> information. This patch solves that, but I wonder if the IRQ should
> not be 'simply' set in i2c_device_probe(). This means we also need to
> store the .resources of info, but I have a feeling this will be less
> error prone in the future.
>=20
> But this is just my guts telling me something is not right. I would
> perfectly understand if we want to get this merged ASAP.
>=20
> So given that the code is correct, this is my:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> But at least I have expressed my feelings :)

Which I can relate to very much. I see the code solves the issue but my
feeling is that we are patching around something which should be handled
differently in general.

Is somebody willing to research this further?

Thanks for your input.


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxvzaMACgkQFA3kzBSg
KbbUsw/9H6SYDNq9lijeQJjaMColPeWgLWcyg+FDVbKx0yTf2VXnXE4lFpxOu5U2
o98P7dwhiQ/M0RXjmK2pWSKyPkHmbpCKRl+hfs9IT7amDoqCnIhMWwgcpNFCsud/
FoTgxSoGj0PaMXm2qjwkHtwuh4iSGYZsOJqLk2HwySgC2iwS291z6FJOa2/qud3I
5Pn3USc0IWsp5kUfkGUfec4cX/gdO0tOZTns1DBDsp3i/hgU5WcQyu07n2dcCS9A
qNFvT+DAMU6r8Y3L4YJlsKKVi1BtB1MDeQpBKS3OPeTmPTlKVwQi8QEYV1zDPVHM
NITiBlghVI4VeTA35U5iwpOmuWjTk1cS5vm4QHxnSBxtaWPDmTbiDEE2XL6DGaaP
pB1kljVIyHTtHq0Arar+YGZ51Mbe5o1wvafkPuQJtt6q+hQj30BTfwepEurOCy3f
3yrvpQVfzO3UpVW1GSbNtOloF3T3x8naOLEIBUOz3zNs78bNlZ3Hnul9cR0xve6h
1/BEz5PF5B84HUBXNVgQhhS4MphlYE9l6CHV8gd/ms6TmoJavfcEjawmaxTZJbnX
Xak1KMNzAVPEY397B4JUQCoA+NTsQFtgoJCAyQDZ/0YHAI9kjiF1CBy7xoXBG/MB
wtApsxgsBc14rsI3k7xDVLOC7cUFkbAO9zcswS+3XuNK9GSGMdk=
=UkBh
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
