Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEDMYw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:24:52 -0400
Received: from sauhun.de ([88.99.104.3]:51556 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbeEDMYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:24:50 -0400
Date: Fri, 4 May 2018 14:24:47 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
Message-ID: <20180504122447.u3xgrkperxz5dpcz@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kht52n2ohte3uw3"
Content-Disposition: inline
In-Reply-To: <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kht52n2ohte3uw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grygorii,

thanks for stepping in.  I kept thinking about better I2C core support
for such situations and the more input the better.

> And you have to fix it (touch screen) - not your i2c driver. Otherwise, y=
ou can get
> situation when set of I2C transfers (executed from some kthread/work/thre=
aded_irq/..)
> will be just interrupted in the middle - usual behavior after this is (I2=
C timeout) [and/or
> not-functional I2C client device [and/or I2C bus stuck (worst case)].

This. I also tend to think that most issues need to be fixed in the
client drivers ensuring proper states of client devices when suspending
/ resuming.. I wonder, though, if the core shouldn't assist by
guaranteeing that an on-going transfer has finished before suspending?
Or more technically, wait for a locked adapter to become unlocked again?

I still need to set it up and test, yet seeing that the EEPROM driver
at24.c has no suspend/resume callbacks, I'd assume a big write operation
will only be partially done when interrupted by a suspend.

> In case, somebody is trying to access I2C after .suspend_noirq() stage I2=
C bus driver=20
> should produce big fat warning and, most probably, abort suspend.
> Above, in general, can be part of I2C core functionality.

Also this. However, there might be an exception of devices like PMICs
which may need to be accessed to trigger the final suspend state.

I at least know of some Renesas boards which needed the I2C connected
PMIC to do a system reset (not sure about suspend, need to recheck
that). That still today causes problems because interrupts are disabled
then.

To handle that, I imagined an additional adapter callback like
'master_xfer_irqless' to be used for such special I2C messages. These
kind of special messages could be tagged with a new I2C_M_something
flag.

And maybe this could be used here, too? Introduce this flag for very
late/early messages. If they have it, messages are even sent in
suspend_noirq() phase with the master_xfer_irqless() callback, otherwise
we will have the WARNing printed out.

Thoughts? Any other cases missed so far?

Kind regards,

   Wolfram


--3kht52n2ohte3uw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrsUQoACgkQFA3kzBSg
KbZs+hAAomsL2h4cBH6MXh3Ni5rDcvYMfGOxLvvJAkJwiV61hRbKJnXyQ+3EqxCM
TC5Ja+IxuwAu0yybd5giGaOYHpmQI5Hu2SCLWXFVdyAlTesoi5CQNzEiAgd09Dil
TMfq+9m38VnRayj01HyNNJ66C1IbLafUtzLYnJ6AWwwYPAYoqlfiUa0Nx/LOXi3j
mxHCFKcxBLMmfahd/r+zeTS6s21c1aAnnxBmj5mrU+h0OJpY/KXHPPCuwfbRSJbu
ZF/gnJBodja1zElhckSit4cJebJcCJ6JnwOgrpNPipj54mPtI7crPEccvjI23PeL
I35kqUeb0tvOdoAMq0euuDz4y5w0P/6si1TJ70z5RzexeAKjw8kxtleDR33CUdhS
eyFgy/bi6isFSJ/UEq2E8TB7CjdoVY6uXUdwZwatTrNw4nAbSvsWj067ZDVFk25o
+78/6D8HabP+FkpP3cxICPMR7HGe8Ahq35Iwy8IgoHyuJ4BdnVha1rHbfJeNSWyL
JMI+iOr7avXWIjyWS8EA2Y6p1J/M6Wx8ptssS/Kh2KxIglTWeUNf93LxPfZTFp85
Vb6amB2o5skPFLg8QkgANIv5jY2q/hssd08q0X0oJe+sSfmt55j6vW6b7njeDXaY
bQSA7jkWnNcARu3/wfzTYZ59joB+IXUQBRxYalAhJpfGyEGwGZw=
=5+F9
-----END PGP SIGNATURE-----

--3kht52n2ohte3uw3--
