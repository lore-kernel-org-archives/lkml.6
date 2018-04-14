Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbeDNKt4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 06:49:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42618 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 06:49:54 -0400
X-Google-Smtp-Source: AIpwx4/wjjzPExEXOzI4ZfBsxr47qh7RI8YCOYWzdY2w9nvZX30Zwmkh9b2GUM6Kx+gRoM8n/ww4nQ==
Date: Sat, 14 Apr 2018 12:49:50 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180414104950.ngomyjy5l5cwhb5i@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="li3pzsurnzk4x4tk"
Content-Disposition: inline
In-Reply-To: <20180414104512.GA27158@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--li3pzsurnzk4x4tk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > >>@@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,
> > > >>struct pci_dev *pci,
> > > >> 	if (err < 0)
> > > >> 		return err;
> > > >>
> > > >>+	if (check_dell_switchable_gfx(pci)) {
> > > >>+		pci_disable_device(pci);
> > >=20
> > > Now looking at it again... This code disables all ATI and NVIDIA sound
> > > cards available in any Dell System (laptop or AIO) if system says that
> > > SG is enabled, right?
> > >=20
> > > It means that also any external ATI or NVIDIA PCI card with audio dev=
ice
> > > connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> > > unconditionally disabled too?
> >=20
> > I never thought of this case, thanks for bringing this up.
> > Do you have any suggestion to check if it connects to the system via
> > Thunderbolt?
>=20
> Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> like this:
>=20
> if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))

And what about PCI-e device attached to ExpressCard slot?

> > >>>+	/* Only need to check for Dell laptops and AIOs */
> > >>>+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)=
 ||
> > >>>+	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> > >>>+	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> > >>>+	    !(pdev->vendor =3D=3D PCI_VENDOR_ID_ATI ||
> > >>>+	      pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA))
> > >>>+		return false;
>=20
> It sure would be nice if someone could add macros for the chassis type
> to include/linux/dmi.h so that we don't have to use these magic numbers
> everywhere:
>=20
> $ git grep -l DMI_CHASSIS_TYPE
> drivers/firmware/dmi-id.c
> drivers/firmware/dmi_scan.c
> drivers/input/keyboard/atkbd.c
> drivers/input/serio/i8042-x86ia64io.h
> drivers/platform/x86/asus-wmi.c
> drivers/platform/x86/dell-laptop.c
> drivers/platform/x86/samsung-laptop.c
> include/linux/mod_devicetable.h
> scripts/mod/file2alias.c
>=20
> Thanks,
>=20
> Lukas

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--li3pzsurnzk4x4tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWtHcygAKCRCL8Mk9A+RD
UrpSAJ494oA3o0/1MGVtCDcKfNdvpJ9h7gCdGmvlaP/qVIu6pX2MuqsFKA2fh/s=
=YVP3
-----END PGP SIGNATURE-----

--li3pzsurnzk4x4tk--
