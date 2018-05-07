Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeEGIok (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:44:40 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36672 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeEGIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:44:35 -0400
X-Google-Smtp-Source: AB8JxZraqzoSMbp5rumBoBTE+7WCa/EAiZlwoWYgGa0QKfTrEnv4md0pqYobzolU0te8DQ52s9HRxA==
Date: Mon, 7 May 2018 10:44:31 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180507084431.r2dipv32wt3vbx3k@pali>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="asjchmkbtcxqj7g7"
Content-Disposition: inline
In-Reply-To: <20180506134733.zttaitnf6ej4tith@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asjchmkbtcxqj7g7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 06 May 2018 15:47:33 Pali Roh=C3=A1r wrote:
> On Thursday 01 February 2018 11:29:45 Dmitry Torokhov wrote:
> > Hi Pali,
> >=20
> > On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Roh=C3=A1r wrote:
> > > Hi Dmitry!
> > >=20
> > > I'm observing a problem with internal touchpad (handled by psmouse.ko)
> > > on Dell laptops connected to Dell E docking station. When I connect
> > > external PS/2 keyboard to docking station then internal laptop touchp=
ad
> > > switch from multitouch absolute mode to relative bare PS/2 mode.
> > >=20
> > > And because ALPS driver in psmouse.ko is capable to process interleav=
ed
> > > bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> > > trackstick data on some ALPS models), ALPS driver does not show any
> > > message about this "downgrade" from multitouch to bare mode. And
> > > continue working in bare mode.
> > >=20
> > > When I rmmod psmouse and modprobe it again, then touchpad switch back=
 to
> > > multitouch mode.
> > >=20
> > > Mario told me that Dell Embedded Controller, which handle internal
> > > keyboard, internal touchpad and external PS/2 keyboard, automatically
> > > send RESET command to *all* those devices when external PS/2 keyboard=
 is
> > > connected. Therefore this is reason why touchpad downgrade to to bare
> > > mode. And according to Mario, host system should issue vendor specific
> > > PS/2 commands to re-initialize all PS/2 devices when this situation
> > > happen. Mario also told me that Windows is doing this action.
> >=20
> > Yeah, I remember fun with Inspiron 8100 - when you dock it it woudl
> > silently switch Synaptics touchpad into standard mode and it would not
> > come back as Synaptics until you disconnect. And there was no
> > notification to the kernel as far as I could tell.
> >=20
> > It could be that we need to monitor dock events and then kick reconnect
> > of serio port, either from userspace via udev (I think that would be
> > preferred), or in kernel.
> >=20
> > >=20
> > > Every time when I connect external PS/2 keyboard to dock I see this
> > > message in dmesg:
> > >=20
> > > Spurious ACK... Some program might be trying to access hardware direc=
tly.
> > >=20
> > > I see it also every time when I dock laptop into docking station (to
> > > which is keyboard already connected). And it happens also when I conn=
ect
> > > external PS/2 mouse to dock.
> > >=20
> > > Dmitry, how to handle this situation to re-initialize psmouse.ko when
> > > external PS/2 device is connected to Dell E docking station? According
> > > to Mario, this is how Dell Embedded Controller is designed and suppose
> > > how OS should work with it.
> > >=20
> > > Manually rmmoding and modprobing for every docking/undocking laptop is
> > > not ideal solution.
> > >=20
> > > Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd.c =
be
> > > handled on Dell systems (probably via DMI) as an event to reset and
> > > reinitialize all PS/2 devices?
> >=20
> > So we need to figure out what exactly we are getting from the docking
> > station in this case. We do try to handle the new device 0xaa 0x00
> > announcements:
> >=20
> > 	/* Check if this is a new device announcement (0xAA 0x00) */
> > 	if (unlikely(psmouse->packet[0] =3D=3D PSMOUSE_RET_BAT && psmouse->pkt=
cnt <=3D 2)) {
> > 		if (psmouse->pktcnt =3D=3D 1) {
> > 			psmouse->last =3D jiffies;
> > 			goto out;
> > 		}
> >=20
> > 		if (psmouse->packet[1] =3D=3D PSMOUSE_RET_ID ||
> > 		    (psmouse->protocol->type =3D=3D PSMOUSE_HGPK &&
> > 		     psmouse->packet[1] =3D=3D PSMOUSE_RET_BAT)) {
> > 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> > 			serio_reconnect(serio);
> > 			goto out;
> > 		}
> >=20
> > ...
> >=20
> > I am not sure where the "spurious ACK comes from". Can you enable i8042
> > debug before trying to dock and capture the data stream from the mouse?
> >=20
> > Thanks.
> >=20
>=20
> Hi Dmitry!
>=20
> I enabled unmask_kbd_data and debug and here is output from dmesg.
>=20
> echo Y >=C2=A0/sys/module/i8042/parameters/debug
> echo Y > /sys/module/i8042/parameters/unmask_kbd_data
>=20
> PS/2 keyboard is already connected in dock and laptop was just docked:
>=20
> [25461.552314] i8042: [6365474] fa <- i8042 (interrupt, 0, 1)
> [25461.552319] atkbd serio0: Spurious ACK on isa0060/serio0. Some program=
 might be trying to access hardware directly.
> [25462.707296] i8042: [6365763] ed -> i8042 (kbd-data)
> [25462.851289] i8042: [6365799] fa <- i8042 (interrupt, 0, 1)
> [25462.851303] i8042: [6365799] 00 -> i8042 (kbd-data)
> [25462.858437] i8042: [6365801] fa <- i8042 (interrupt, 0, 1)
> [25462.869512] i8042: [6365804] fa <- i8042 (interrupt, 0, 1)
> [25462.869517] atkbd serio0: Spurious ACK on isa0060/serio0. Some program=
 might be trying to access hardware directly.
> [25463.670515] i8042: [6366004] ed -> i8042 (kbd-data)
> [25463.670647] i8042: [6366004] fa <- i8042 (interrupt, 0, 1)
> [25463.670655] i8042: [6366004] 02 -> i8042 (kbd-data)
> [25463.676769] i8042: [6366005] fa <- i8042 (interrupt, 0, 1)
>=20
>=20
> Laptop is docked and PS/2 keyboard was just connected:
>=20
> [26571.014368] i8042: [6642848] fa <- i8042 (interrupt, 0, 1)
> [26571.014380] atkbd serio0: Spurious ACK on isa0060/serio0. Some program=
 might be trying to access hardware directly.
>=20
>=20
> In both cases there is no events from touchpad, only from keyboard. So
> Dell EC silently reset PS/2 touchpad when PS/2 keyboard is attached.
>=20
> So I think we should capture 0xFA and on Dell machines we should
> reinitialize PS/2 drivers. As there is really nothing more then 0xFA.

Info about PS/2 mouse:

In case I have laptop already docked and just connect PS/2 mouse there
is absolutely no i8042 event.

To check that mouse is worked I clicked button and then in dmesg
appeared:

[ 3945.481403] i8042: [986322] 09 <- i8042 (interrupt, 1, 12)
[ 3945.482486] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
[ 3945.483667] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
[ 3945.483917] input: PS/2 ALPS Mouse as /devices/platform/i8042/serio1/inp=
ut/input36
[ 3945.594926] i8042: [986351] 08 <- i8042 (interrupt, 1, 12)
[ 3945.596062] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)
[ 3945.597203] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)

So we have no way to detect when external PS/2 mouse was connected to
dock. But ALPS driver can deal with it and process these mouse events.

And when I have already connected PS/2 mouse to the dock and I'm just
putting laptop into dock, then I get following events:

[ 4336.481381] i8042: [1084079] fa <- i8042 (interrupt, 0, 1)
[ 4336.481388] atkbd serio0: Spurious ACK on isa0060/serio0. Some program m=
ight be trying to access hardware directly.
[ 4337.653275] i8042: [1084372] ed -> i8042 (kbd-data)
[ 4337.949198] i8042: [1084446] fa <- i8042 (interrupt, 0, 1)
[ 4337.949202] atkbd serio0: Spurious ACK on isa0060/serio0. Some program m=
ight be trying to access hardware directly.
[ 4338.623167] i8042: [1084615] ed -> i8042 (kbd-data)

So again, no event from mouse, just from keyboard.

Note that in these tests I have disconnected my PS/2 keyboard from
dock.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--asjchmkbtcxqj7g7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWvAR7AAKCRCL8Mk9A+RD
UiG0AJ93cVO2sfNuf4i7YemVhGAnZA4a7ACfeAdvJjQYi/frKm/NZQ0KzKq7tp8=
=024B
-----END PGP SIGNATURE-----

--asjchmkbtcxqj7g7--
