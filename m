Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeCPNlo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:41:44 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:46645 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCPNlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:41:42 -0400
X-Google-Smtp-Source: AG47ELtS12t1r+zrq2iJy+PX4sP/tVyZlod/Ksp64ruwffQmW+guxO0tTB++IT9VSCeC4SD7rfzBwQ==
Date: Fri, 16 Mar 2018 14:41:36 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fix deadlocks in autosuspend
Message-ID: <20180316134136.GC31029@gmail.com>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20180228133803.30040-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ping.

Would someone please have a look?

Thanks,
Marcus Folkesson

On Wed, Feb 28, 2018 at 02:37:57PM +0100, Marcus Folkesson wrote:
> Hello,
>=20
> I have not recieved any feedback on these so I resend them.
>=20
> I got this deadlock on my own driver (pxrc) when using the same
> construction.
>=20
> Please have a look
>=20
> Here is a clip from=20
> [PATCH v3] input: pxrc: new driver for PhoenixRC Flight Controller Adapte=
r [1]
> that describes the problem.
>=20
> -------------------------------8<----------------------------------------=
------
> Also, I think we have a deadlock in the synaptics_usb driver.
>=20
> When the device is suspended and someone is open the device, the input
> subsystem will call input_open_device() which takes the
> input_dev->mutex and then call input_dev->open().
>=20
> synusb_open() has a call to usb_autopm_get_interface() which will
> result in a call to the registered resume-function if the device is
> suspended. (see Documentation/driver-api/usb/power-manaement.rst).
>=20
> In the case of snaptics_usb, it will take the input_dev->mutex in the
> resume function.
>=20
> I have no synaptic mouse, but tested to put the same code into my
> driver just to confirm, and got the following dump:
>=20
> [ 9215.626476] INFO: task input-events:8590 blocked for more than 120 sec=
onds.
> [ 9215.626495]       Not tainted 4.15.0-rc8-ARCH+ #6
> [ 9215.626500] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 9215.626507] input-events    D    0  8590   4394 0x00000004
> [ 9215.626520] Call Trace:
> [ 9215.626546]  ? __schedule+0x236/0x850
> [ 9215.626559]  schedule+0x2f/0x90
> [ 9215.626569]  schedule_preempt_disabled+0x11/0x20
> [ 9215.626579]  __mutex_lock.isra.0+0x1aa/0x520
> [ 9215.626609]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
> [ 9215.626622]  ? pxrc_resume+0x37/0x70 [pxrc]
> [ 9215.626632]  pxrc_resume+0x37/0x70 [pxrc]
> [ 9215.626655]  usb_resume_interface.isra.2+0x39/0xe0 [usbcore]
> [ 9215.626676]  usb_resume_both+0xd2/0x120 [usbcore]
> [ 9215.626688]  __rpm_callback+0xb6/0x1f0
> [ 9215.626699]  rpm_callback+0x1f/0x70
> [ 9215.626718]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
> [ 9215.626726]  rpm_resume+0x4e2/0x7f0
> [ 9215.626737]  rpm_resume+0x582/0x7f0
> [ 9215.626749]  __pm_runtime_resume+0x3a/0x50
> [ 9215.626767]  usb_autopm_get_interface+0x1d/0x50 [usbcore]
> [ 9215.626780]  pxrc_open+0x17/0x8d [pxrc]
> [ 9215.626791]  input_open_device+0x70/0xa0
> [ 9215.626804]  evdev_open+0x183/0x1c0 [evdev]
> [ 9215.626819]  chrdev_open+0xa0/0x1b0
> [ 9215.626830]  ? cdev_put.part.1+0x20/0x20
> [ 9215.626840]  do_dentry_open+0x1ad/0x2c0
> [ 9215.626855]  path_openat+0x576/0x1300
> [ 9215.626868]  ? alloc_set_pte+0x22c/0x520
> [ 9215.626883]  ? filemap_map_pages+0x19b/0x340
> [ 9215.626893]  do_filp_open+0x9b/0x110
> [ 9215.626908]  ? __check_object_size+0x9d/0x190
> [ 9215.626920]  ? __alloc_fd+0xaf/0x160
> [ 9215.626931]  ? do_sys_open+0x1bd/0x250
> [ 9215.626942]  do_sys_open+0x1bd/0x250
> [ 9215.626956]  entry_SYSCALL_64_fastpath+0x20/0x83
> [ 9215.626967] RIP: 0033:0x7fbf6358f7ae
>=20
>=20
> tablet/pegasus_notetaker.c and touchscreen/usbtouchscreen.c has the same
> construction (taking input_dev->mutex in resume/suspend and call
> usb_autopm_get_interface() in open()).
>=20
> I will create a separate "pm_mutex" to use instead of input_dev->mutex
> to get rid of the lockups in those drivers=20
>=20
> -------------------------------8<----------------------------------------=
------
>=20
>=20
> [1] https://lkml.org/lkml/2018/1/20/191
>=20
> Thanks,
>=20
> Best regards
> Marcus Folkesson
>=20

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqryYsACgkQiIBOb1ld
UjLSRw/8Dz8L0gZjZ5gIAzHmyt5Qb/4dk2J7pMEsQ7haeRPdwQXmmKkT6vDXVFDV
7qofRlelDJkF8dGWFGJgsA0HJHGzIVfFv8e+sqTJSE5fz3lMfzgctw6BNawlj1si
mNn+rXId8L7TkhrkjI9+mb5hdXerFZNqPLpi73+DsXPaIMTH/bU2yxJdhIb0W0zJ
hOBRLFmTvnhxUTqVOtwX4AbfrbpjVYhILQdiGiKhA5aMU5P94VnCt56kH+Gy/ehl
eCrhArfOF7dMsbXOyTzvClFgWMl9/QCGHodTTdd8jDNiWlUSPkIC6GDS56OdrUw9
wUnGXgfTAYqoRp1ERowNK8rHn25MwD15PoIHFvMKMZU5uCZL66fLlyQd7ssQShua
oQ2Pln8t7oAbtyQHTHTn7mkOoueltf5QZKiWU+QF8SmEuxnuW39QZBq9yp81QSs0
Bi85Q4cYNbUK96rDoXTqjFGNfMa4TyaPmjz7kAb8hpavJba9y6k2yQg/rClktGpy
n1gBfiUvTFpvP2gHSRcknJf4yeHGvDv0Nk+zfNdwT/288S0WfyMh0gf2AyCFgrsP
f9vKxFAY+es9Lejr7W02YY+Nu07GG19fT3qmm2E7ZCJeNphv0/cevOgnLvuKpOvc
8yDkTetaMzZZZsLJVlvQ9Hl9Nuw6+dFAvSNHu3RIOC261LZhVnE=
=YU7i
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
