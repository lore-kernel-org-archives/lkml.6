Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeFEKq4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:46:56 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:45810 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeFEKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:46:55 -0400
Message-ID: <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>, Chris Chiu <chiu@endlessm.com>,
        Darren Hart <dvhart@infradead.org>
Cc: Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>
Date: Tue, 05 Jun 2018 12:46:46 +0200
In-Reply-To: <0443419b-3147-163b-374d-bb8651b08837@redhat.com> (sfid-20180605_123103_271620_F1F8BDCF)
References: <20180604123238.82200-1-chiu@endlessm.com>
         <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
         <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
         <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
         <20180605023124.GE47042@localhost.localdomain>
         <CAB4CAwc-J3+xaXzKKpFc-UMeuCsX8zbs0S7-a82x2LJcD5r7jA@mail.gmail.com>
         <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
         <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
         <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
         <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
         <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
         (sfid-20180605_123103_271620_F1F8BDCF)
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QtbsNiEpvSwUb0UXili9"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QtbsNiEpvSwUb0UXili9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, 2018-06-05 at 12:31 +0200, Hans de Goede wrote:
> On 05-06-18 12:14, Bastien Nocera wrote:
> > On Tue, 2018-06-05 at 12:05 +0200, Hans de Goede wrote:
> > > On 05-06-18 11:58, Bastien Nocera wrote:
> > > > [SNIP]
> > >=20
> > > Ok, so what are you suggestion, do you really want to hardcode
> > > the cycle behavior in the kernel as these 2 patches are doing,
> > > without any option to intervene from userspace?
> > >=20
> > > As mentioned before in the thread there are several example
> > > of the kernel deciding to handle key-presses itself, putting
> > > policy in the kernel and they have all ended poorly (think
> > > e.g. rfkill, acpi-video dealing with LC brightnesskey presses
> > > itself).
> > >=20
> > > I guess one thing we could do here is code out both solutions,
> > > have a module option which controls if we:
> > >=20
> > > 1) Handle this in the kernel as these patches do
> > > 2) Or send a new KEY_KBDILLUMCYCLE event
> > >=20
> > > Combined with a Kconfig option to select which is the default
> > > behavior. Then Endless can select 1 for now and then in
> > > Fedora (which defaults to Wayland now) we could default to
> > > 2. once all the code for handling 2 is in place.
> > >=20
> > > This is ugly (on the kernel side) but it might be the best
> > > compromise we can do.
> >=20
> > I don't really mind which option is used, I'm listing the problems with
> > the different options. If you don't care about Xorg, then definitely go
> > for adding a new key. Otherwise, processing it in the kernel is the
> > least ugly, especially given that the key goes through the same driver
> > that controls the brightness anyway. There's no crazy cross driver
> > interaction as there was in the other cases you listed.
>=20
> Unfortunately not caring about Xorg is not really an option.
>=20
> Ok, new idea, how about we make g-s-d behavior upon detecting a
> KEY_KBDILLUMTOGGLE event configurable, if we're on a Mac do a
> toggle, otherwise do a cycle.
>
> Or we could do this through hwdb, then we could add a hwdb entry
> for this laptop setting the udev property to do a cycle instead of
> a toggle on receiving the keypress.

If we are adding hwdb entries anyway to control the userspace
interpretation of the TOGGLE key, then we could also add the new CYCLE
key and explicitly re-map it to TOGGLE. That requires slightly more
logic in hwdb, but it does mean that we could theoretically just drop
the workaround if we ever stop caring about Xorg.

> I guess alternatively I could live with hardcoding this in the
> kernel as these 2 patches do, but that solves it just for *this*
> laptop, I've a feeling that if we do that we end up with similar
> code in all laptop vendor drivers under drivers/platform/x86
> soon.  Which really is the acpi_video.brightness_event thing
> again, where the kernel would handle brightness key-presses
> but only if the acpi_video backlight interface was in use
> and not on models with a vendor specific or native-hardware
> backlight driver.  Hmm, so writing this, I'm still quite sure
> the kernel approach is actually a bad idea.

Benjamin
--=-QtbsNiEpvSwUb0UXili9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlsWahYACgkQq6ZWhpmF
Y3DsvQ//WIq+C0ldZo05gfwEdsv8hIO/Ih2QBO+tgEXO1QpZ1GIZ3ym+Q758FsxM
PbtJduBRTyCo8oAKYHr/m3EsQbHrXJ3tS1DpGgUnMwy4zbGGBxHkohccSZYfdazx
2aP5rpHt6/QWJC5EoJzUpii5/l4lhThXYG9F60Z6m5z6hZ5gPi9BjYyepqmAWKYr
ZhoNtDbfOupmaCv6SEDomrIz3RpWO4zobUNveG4TAuxwQqhQ7zBqEI8Qdc/4PWqs
6F/iVQ6VV4N1CkT9H3+6U2fwzVfiNBdIUTWLOi4HBQ6//ozjuIb3xJItEgshVK2B
VU4GkRhkYj1x1Kg2SpS5tqtw2DaW/YVf8Y8HZMzAjERHP6uc0rSMT4O/LDj4VAKE
ps6g2dMAr7eK/EpdlwRhH3dzHcuaV2PHlVi7hrnc1G8ckDnb25mSPMIfNCuJ4/6A
hlpErQrtjzcPhK0o9bCCUjilDZE/2ApThWtBIjXs9XGGn98i2RW5iKhaUrgsgNEb
zAEp1r/DElvEoF8/fwbZIIuIICtPxo7tEF3yeQVSdO1VfxqJt48wMUM1GFu7LASk
7ImINXe+o1tRFxL8GhjVRWcn7Tq1yxk8AKXG1R7bk34jkzGEjYAbc3wS+42bcagn
MUKx2zy7A1EE1d1A8xl7WJ//r+Af13zipCSdddELQImvagfmaCg=
=KnOm
-----END PGP SIGNATURE-----

--=-QtbsNiEpvSwUb0UXili9--
