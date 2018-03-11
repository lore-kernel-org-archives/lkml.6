Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCKOa3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:30:29 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53141 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932149AbeCKOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:30:27 -0400
X-Google-Smtp-Source: AG47ELsCA9CwYrWGDM1A9MGZ0YY3a2G0hHpZmxmiOk7TXksnVtz3FIHYzXX8fkBzGfPXBcc73J2aHA==
Date: Sun, 11 Mar 2018 15:30:18 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: kai.heng.feng@canonical.com, mjg59@srcf.ucam.org, dvhart@infradead.org,
        andy@infradead.org, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180311143018.u64cldtxuv7divta@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
 <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
 <20180310103809.5nnwoulua2u64rku@pali>
 <ea9ab148c4bb45b9ae7369020300b74b@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gsne4cu2stnnwixf"
Content-Disposition: inline
In-Reply-To: <ea9ab148c4bb45b9ae7369020300b74b@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsne4cu2stnnwixf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 11 March 2018 14:03:13 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver=
-x86-
> > owner@vger.kernel.org] On Behalf Of Pali Roh=C3=A1r
> > Sent: Saturday, March 10, 2018 6:38 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: kai.heng.feng@canonical.com; mjg59@srcf.ucam.org; dvhart@infradead.=
org;
> > andy@infradead.org; tiwai@suse.com; platform-driver-x86@vger.kernel.org=
; linux-
> > kernel@vger.kernel.org; alsa-devel@alsa-project.org
> > Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller=
 for Dell
> > platforms with Switchable Graphics
> >=20
> > On Friday 09 March 2018 09:59:39 Mario.Limonciello@dell.com wrote:
> > > > > Pali is your concern that this code for matching vendor/subsystem=
 is running
> > > > > on non-Dell too?  The only other recommendation I think that can =
be to restrict
> > > > > to matching Dell OEM strings in SMBIOS table, but I don't think t=
hat's any better
> > > > > than the matching for VID/SSVID.
> > > >
> > > > My concern is about adding a new machine specific code into generic
> > > > driver, which check is done just by PCI vendor and subvendor.
> > > >
> > > > In future there can be new models or other PCI devices which matches
> > > > above condition even they would not have any switchable graphics, n=
or
> > > > they would manufactured by Dell.
> > >
> > > Uh Dell subsystem ID means it's Dell no?
> >=20
> > What would prevent you to take PCI device marked with Dell ID and put it
> > into non-Dell computer? I do not believe that Dell PCI devices are
> > configured to work only in Dell branded devices and refuse to power up
> > in others.
>=20
> I think the missing aspect is that this is only used in AIO and laptop fo=
rm
> factors where the discrete graphics is in a non-removable form factor.

Why we are not checking if kernel is running on AIO or laptop form
factor then? Or it is not possible?

Basically what I see there is that we need to detect if current HW
platform has switchable graphics and check how is configured AUDIO MUX.

But instead of directly checking hw state of audio MUX, we are trying to
check something different which could get us information of state of the
audio mux.

I suspect that we do not have a way how to check audio MUX directly, so
it needs to be done indirectly -- via some Dell SMBIOS call and some
other heuristic. This is something which should be specified either in
comment or in commit message (problem of type: we need X, but check for
Y).

And if we are doing this check indirectly, we should do the most
specific test and not more general.

I think that PCI vendor ID check of audio device is more general test
then checking if kernel is running on Dell laptop (check via DMI). And
if we can check also if running on AIO or laptop form, then it would be
more specific test.

> Running with your hypothetical though, what would happen is if it's
> on a non-Dell machine the PCI check would pass and then the code
> would not be executed by dell-laptop (since dell-smbios didn't load).

Right.

> If it was on a Dell machine it would load but the BIOS would return
> either Switchable graphics turned off, or invalid token.
>=20
> Even though these aren't real for switchable graphics on Dell I don't
> see a problem with either of these situations if it ever came up.

I see, this solution is working...

=2E.. but, I see there a very bad precedense. What would happen if another
laptop manufactor comes with similar solution for hybrid graphics. Does
it mean that hda audio driver would try to call for every one vendor its
vendor dependent API function (EFI, SMM, WMI, whatever) to check if
current HW has some switchable graphics and needs special checks?

Those vendor dependent API functions (which Dell SMBIOS is) should be
really called on vendor hardware.

Otherwise audio drivers would load bunch of the other vendor dependent
platform modules and all of those modules (except maximally one) just
return error.

> >=20
> > If there is Dell ID then it just means that PCI device itself is Dell's.
> > And not that machine in which that device is plugged is also Dell.
> >=20
> > > > Also I can imagine that in future (or maybe already now?) it is pos=
sible
> > > > to find PCI device which pass above checks and connect this PCI dev=
ice
> > > > into desktop /server / any non-laptop device.
> > > >
> > > > If this switchable graphics solution is specific to dell laptops, t=
hen
> > > > rather checking for PCI vendor/subvevendor main check, there should=
 be
> > > > main check via DMI strings.
> > >
> > > Right now this is affected to both AIO desktop and laptops.
> > >
> > > IIRC you won't end up with switchable graphics in traditional desktop=
 that you
> > > can remove PCI card.  If this code was run on a traditional desktop w=
ith a
> > > AMD PCI card that BIOS query result should be invalid token (which wi=
ll infer
> > > switchable off to this routine).
> > >
> > > >
> > > > Hardware is changing relatively quickly and there is absolutely no
> > > > guarantee that e.g. NVIDIA would not start providing audio controll=
er in
> > > > similar like AMD and it would be put in those Dell machines.
> > >
> > > Kai Heng can explain exactly why NVIDIA isn't affected.
> > > This is probably good information to include in the commit message to=
o.
> >=20
> > Yes, extending commit message is a good idea.
> >=20
> > But here I'm talking about future, NVIDIA cards could be in future.
> >=20
> > I still think that whitelisting devices based on vendor ID by some
> > measurements at one time is a bad idea. It is fragile which can stop
> > working in the future.
>=20
> Compiling a whitelist is a wasted effort because it will have to change
> Every year for every new platform that has AMD switchable graphics.

I agree, But see that this patch already uses vendor ID whitelisting.

> This heuristic that is selected covers switchable graphics back for the
> past generations that Canonical has tested and fixed, not just this
> current one.
>=20
> If that situation you refer to happens, it will be on new hardware that's
> not yet enabled by the Linux kernel.  We can cross that bridge when we
> come to it with either a newly proposed heuristic or some adjustments
> for whitelist/blacklist.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--gsne4cu2stnnwixf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqU9eAAKCRCL8Mk9A+RD
UgDdAJ9sl5bdeT1maV1eeEmiV+V0ASpDEwCfX2AHE0WpoEAjXMtkPOvK9yTiutM=
=wDLP
-----END PGP SIGNATURE-----

--gsne4cu2stnnwixf--
