Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEUMZU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:25:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeEUMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:25:19 -0400
Date: Mon, 21 May 2018 14:25:14 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To: Ales Novak <alnovak@suse.cz>
Cc: a.zummo@towertech.it, akpm@linux-foundation.org,
        rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        jkosina@suse.cz
Subject: Re: rtc: fix chardev initialization races
Message-ID: <20180521122509.GA4251@taurus.defre.kleine-koenig.org>
References: <1393410793-7315-1-git-send-email-alnovak@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <1393410793-7315-1-git-send-email-alnovak@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 11:33:13AM +0100, Ales Novak wrote:
> In many rtc modules, the chardevice file in rtc module probe is
> being created prematurely. If the probe fails after the chardevice
> file has been created (e.g. after rtc_device_register), it's possible
> for a program to open() it, which subsequently can cause memory
> corruption.
>=20
> The race looks like that (thanks Jiri):
>=20
> CPU0:                                CPU1:
> sys_load_module()
>  do_init_module()
>   do_one_initcall()
>    cmos_do_probe()
>     rtc_device_register()
>      __register_chrdev()
>      cdev->owner =3D struct module*
>                                      open("/dev/rtc0")
>     rtc_device_unregister()
>   module_put()
>   free_module()
>    module_free(mod->module_core)
>    /* struct module *module is now
>       freed */
>                                       chrdev_open()
>                                        spin_lock(cdev_lock)
>                                        cdev_get()
>                                         try_module_get()
>                                          module_is_live()
>                                          /* dereferences already
>                                             freed struct module* */

[Context: For a patch to rtc-pcf2127.c Alexandre Belloni asked not to
fail after rtc_device_register successfully finished and pointed to this
reasoning as explaination.]

If there is really such a race then (I hope) there is
something in the cdev code that needs fixing. According to my
understanding, when rtc_device_unregister returned, the cdev is gone and
so chrdev_open is supposed to fail.

Otherwise the same problem can be triggered when the device is unbound
and the module unloaded while another cpu opens the char dev.

I added a msleep(5000) to chrdev_open like this:

        if (current->pid !=3D 1) {
                pr_info("%s:%d: sleeping to open race window\n", __func__, =
__LINE__);
                msleep(5000);
                pr_info("%s:%d: done sleeping\n", __func__, __LINE__);
        }

before the spinlock is taken. If I trigger that (using

	a =3D open("/dev/rtc0")

in a Python shell) and then do rmmod rtc_pcf2127 (which is the driver
backing my rtc0), I get:

	OSError: [Errno 6] No such device or address: '/dev/rtc0'

> This patch is proposing a solution, splitting the function
> {devm_,}rtc_device_register into {devm_,}rtc_device_register{_fs,}.
> The {devm_}rtc_device_register_fs which is creating the files, should
> be called after it is clear that the probe will pass. It will set the
> RTC_DEV_FILES_EXIST into rtc_device->flags.

So this split is not a complete fix but only a work around for some
cases at best.

Maybe there isn't even a problem?

Best regards
Uwe
=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlsCuqIACgkQwfwUeK3K
7AnEhgf/Vj/D2FzcmADX0wvZM+0sq/9zEFviSDobEQ3EAqjedwEbyug8C5N5j/39
wBHVrd61jpl5/W88KdB7YdwhlC+R3pSMm7Eu6GXfE/LmqMQsAFNVifFvnFw24GNg
kawwzvJX5TPiEVRmgD3e5Y+HdJypSIr24RWHL6xUCMeLcnkvh8YnAKAVQxWmZgme
xaGKBHo686djotKnE3UPEP1oOch22LlBLMm4FnhE+ReT8elufLtrqh3D1de8m74i
bnaes7r5qrKx3x32w9pwTRSt5Awm/Tx2L3yWxK136fFDNpfFicDFsSTymjt+OBEi
KW3WW/ZNUQctw7y+kJt8dARYfNbcwA==
=o6r5
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
