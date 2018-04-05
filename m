Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeDENyj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:54:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36070 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDENyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:54:38 -0400
X-Google-Smtp-Source: AIpwx4/moGmsn975R2ajIswJz/XaS2yPkzt4zPiHZQzZ0kv+DiqH5Sk+RvNvyxQjjoay2+qvgo8j3Q==
Date: Thu, 5 Apr 2018 15:54:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Patrice CHOTARD <patrice.chotard@st.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Message-ID: <20180405135435.GA10860@ulmo>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo>
 <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
 <1f7d0738-1963-21c5-c293-e46fb0214ecf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1f7d0738-1963-21c5-c293-e46fb0214ecf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 03:27:03PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 05-04-18 15:17, Patrice CHOTARD wrote:
> > Hi Thierry
> >=20
> > On 04/05/2018 11:54 AM, Thierry Reding wrote:
> > > On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
> > > > Add support to get and control a list of resets for the device
> > > > as optional and shared. These resets must be kept de-asserted until
> > > > the device is enabled.
> > > >=20
> > > > This is specified as shared because some SoCs like UniPhier series
> > > > have common reset controls with all ahci controller instances.
> > > >=20
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > ---
> > > >    .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
> > > >    drivers/ata/ahci.h                                 |  1 +
> > > >    drivers/ata/libahci_platform.c                     | 24 ++++++++=
+++++++++++---
> > > >    3 files changed, 23 insertions(+), 3 deletions(-)
> > >=20
> > > This causes a regression on Tegra because we explicitly request the
> > > resets after the call to ahci_platform_get_resources().
> >=20
> > I confirm, we got exactly the same behavior on STi platform.
> >=20
> > >=20
> > >   From a quick look, ahci_mtk and ahci_st are in the same boat, addin=
g the
> > > corresponding maintainers to Cc.
> > >=20
> > > Patrice, Matthias: does SATA still work for you after this patch? This
> > > has been in linux-next since next-20180327.
> >=20
> > SATA is still working after this patch, but a kernel warning is
> > triggered due to the fact that resets are both requested by
> > libahci_platform and by ahci_st driver.
>=20
> So in your case you might be able to remove the reset handling
> from the ahci_st driver and rely on the new libahci_platform
> handling instead? If that works that seems like a win to me.
>=20
> As said elsewhere in this thread I think it makes sense to keep (or re-add
> after a revert) the libahci_platform reset code, but make it conditional
> on a flag passed to ahci_platform_get_resources(). This way we get
> the shared code for most cases and platforms which need special handling
> can opt-out.

Agreed, although I prefer such helpers to be opt-in, rather than
opt-out. In my experience that tends make the helpers more resilient to
this kind of regression. It also simplifies things because instead of
drivers saying "I want all the helpers except this one and that one",
they can simply say "I want these helpers and that one". In the former
case whenever you add some new (opt-out) feature, you have to update all
drivers and add the exception. In the latter you only need to extend the
drivers that want to make use of the new helper.

With that in mind, rather than adding a flag to the
ahci_platform_get_resources() function, it might be more flexible to
split the helpers into finer-grained functions. That way drivers can
pick whatever functionality they want from the helpers.

Thierry

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrGKpgACgkQ3SOs138+
s6HSKA/7BWzpQMlq3BAf0hZ3rDVbOwWJhmJQwIiAdKf+B0ndSEVo4vblW0Sekfwz
uUqYANthL+uEOMU7cFinJvKs6+g5vkTjEr1Cd6ziAz6JR6JGfJMnM3RdbYjqr5xC
lrdWxbjUHjHg6C2LqMtanXY3eAhlPdXnjFJ5OvbBMQSgQi/5hoF/TTl7+8v7QWaG
tSZ8ob8M+i8sF4H+ObBRUcRieGSRse8gfgNaHZaEf1NfytnG4hf92HivV/+SAS8S
FKd0oCkAulyHxZqlPl+Qf3qTkhyHhR+InrdSMRAtZwuNPneTMITB6ANx90sIqq98
PVZ/Xvfz6UsxZPVsQrCUHnqtYiZ8swe/geHppydD5lkOe7DibqP+wRrl+49XxK1V
+Y3A/7xDxDkepO/cTnXgDL3DFdGfKcZ/B5s3iX92XL/c4J7KqkEKx3wgS98di/o/
K3LevdQ3AUDXEtFZ5kxO/XJMLy9EnvQTXrdq7ZgQtaXNhgHCcB1bnn/QPqNEZ+v2
0JoHfRECq5bar/hiw5Ni8IxrHXq3jBnqPXiye3eKh9eyJIMtna8X20i1sQefCyKA
gp8cvS5ZM5osbhUatUQ+pK1MrEBAWCxdRPrRPl5bi3quxuiEu47rHHm6wFBg6n1R
u1CDk+Cofnv1qptcH1e9Vs1IesX2qpRP6GrJjB4AG72fpURkdso=
=F112
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
