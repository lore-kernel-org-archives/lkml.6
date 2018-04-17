Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDQOyx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:54:53 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:22542 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDQOyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:54:51 -0400
Date: Tue, 17 Apr 2018 16:54:20 +0200
From: Alban <albeu@free.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Alban <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180417165420.423a691b@avionic-0020>
In-Reply-To: <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/00OHJ=59GszSgSCM9WZWFKb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/00OHJ=59GszSgSCM9WZWFKb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Apr 2018 13:54:07 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 24/03/18 23:24, Alban Bedel wrote:
> > Having the cells as subnodes of the provider device without any
> > compatible property might clash with other bindings. To avoid this
> > problem update the binding to have all the cells in a 'nvmem-cells'
> > subnode with a 'nvmem-cells' compatible string. This new binding
> > guarantee that we can turn any kind of device in a nvmem provider.
> >=20
> > While discouraged for new uses the old scheme is still supported for
> > backward compatibility. =20
>=20
> Am not sure if this a really good idea to change nvmem bindings based on=
=20
> provider requirements. This can be a beginning of other problems!!

I think you misunderstood something here, this proposed new binding
would be for all new nvmem bindings, not just mtd backed nvmem.

> Did you know that we can pass nvmem cells info via nvmem config ?
>=20
> Why can't mtd-nvmem provider populate the nvmem_config->cells from
> its dt "nvmem-cells" subnode before it registers the provider?

The DT based lookup of nvmem-cells doesn't use nvmem_config->cells, so
that's not an option. In fact here the problem come from the MTD side
because it also had a similar binding using subnodes without compatible
string. Just to make things clear, here is an example of the clash
using the current nvmem binding on an unpartitioned MTD device:

flash@0 {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	compatible =3D "s25sl064a";
	reg =3D <0>;

	calibration: calib@404 {
		reg =3D <0x404 0x10>;
	};
};

This will not only allow reading the calibration data from nvmem, but
will also create a partition on the MTD device, which is not acceptable.
With my proposed binding this would become:

flash@0 {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	compatible =3D "s25sl064a";
	reg =3D <0>;

	nvmem-cells {
		compatible =3D "nvmem-cells";
		#address-cells =3D <1>;
		#address-cells =3D <1>;

		calibration: calib@404 {
			reg =3D <0x404 0x10>;
		};
	};
};

Which would work fine as the MTD code will ignore the nvmem-cells
subnode thanks to its compatible string.

IMHO subnodes without any compatible properties should never be used in
such generic bindings, as it is very likely that it will at some point
clash with another generic binding or with a device specific binding.

Alban

--Sig_/00OHJ=59GszSgSCM9WZWFKb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1gqdAAoJEHSUmkuduC28wiQQAN81pxiNZy1GBNnelz+TqmWz
QoQqmaiwcBDs0/H0Dnx01Kwo5mUFTQW++GP0Ae2ybdNF5ONFBesTYzhA7FB1Ew7e
z9IdDJVhco5zgINFlc8gdvtfHAMkif407hGDt3c0rZoE7Se+93H6oEEZXBERIg36
96xlzzctk0FRSx5vFRYXcKdf+2EQn3KBm5ni/Q1WnMgqHY6A7hjNEFzWjpbySSIO
iAdX7D3zU/+wd8rr+PBTVbt3zdOgO/W92tUFWPwtw37AjEr74NavZ2hidK/XUJfp
qPubryYr+Iuye6uhIbn/Fu4BE/zGHO2BqBRsLxd3BKSkys4ver7BJiu73WEwZpNt
9swIG7yNQtC/ZJytCspEn8K+BM3NgPTDSR8bjbg9NdHmuWONRhQTD1rxqz79pSWl
+xj5ZqTco8uZh6/V3XNvlbswYX7HRGWS0pUmAm5eOw40mfTDyo9dRZcAsnM96nSy
37W4JtQ6sC442MtR9FXPG3tYjhoG2rTl6w13j7hNf5MfEvzcLKmDH75mmxu6YE8P
lKhZdSabrDPuGc1n3X7jbUQ3dQ7vEaqC3A3XYZ2xemVNbYp3Hb30R4hldmuIgABb
bPPB+7aHF7uh27aJusfkrBAAV/bcR8IIYTGbi2Yd/d27Wo2xYAHZLhG3K044Pih1
2Or0U4M0QyWAgiA4TFN4
=DCd6
-----END PGP SIGNATURE-----

--Sig_/00OHJ=59GszSgSCM9WZWFKb--
