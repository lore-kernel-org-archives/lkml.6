Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeEHQcZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:32:25 -0400
Received: from sauhun.de ([88.99.104.3]:57384 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755404AbeEHQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:32:23 -0400
Date: Tue, 8 May 2018 18:32:21 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
Message-ID: <20180508163221.2slrtg3cidvpj7g2@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
 <bef80500-4727-d324-f0c8-4fc6016f43ed@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtcrtj3x3rvhprwe"
Content-Disposition: inline
In-Reply-To: <bef80500-4727-d324-f0c8-4fc6016f43ed@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mtcrtj3x3rvhprwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Grygorii,

thanks a lot for your input. Much appreciated!

> That would be great, but note:
> 1) only i2c_transfer() operations are locked, so if driver is doing=20
> i2c_transfer(1)
> i2c_transfer(2) <- suspend in the middle
> <- suspend in between
> i2c_transfer(3)
> It will not help.

Will it not improve the situation by ensuring that at least the transfer
with its (potenitally) multiple messages got completed? That we are at
least in a bus-free state (assuming single-master here) before
suspending?

> Everything depends on timings :( - in my practice 10000 suspend iteration=
 tests
> where required to run many times to catch 3 buggy I2C client drivers.

Matches my experiences that creating a reliable test case for that is
not that easy as I thought. Or I am missing something obvious.

> 2) It's normal to abort suspend if system is busy, so if I2C core will be=
 able
> to catch active I2C operation - it should abort, but again I do not see h=
ow it
>  can be detected 100% with current I2C core design or without reworking h=
uge number of drivers.

I agree. After second thought, waiting for i2c_transfer to finish maybe
won't be enough, I am afraid. We don't know if STOP has been put on the
wires yet. My best bet now is that we implement such a
'is-transfer-ongoing'-check in the suspend function of the master
driver? That check should be optional, but recommended.

> 3) So, only one thing I2C core potentially can do - catch invalid access =
and
> report it. "wait for transfer to finish" wouldn't work as for me.

And we do this in suspend_noirq function of the i2c core.

> > I at least know of some Renesas boards which needed the I2C connected
> > PMIC to do a system reset (not sure about suspend, need to recheck
> > that). That still today causes problems because interrupts are disabled
> > then.
>=20
> this was triggered few times already (sry, don't have links), as of now,
>  and as I know, the only ways to W/A this is:
> - to create barametal platform driver (some time in ASM)
> - or delegate final suspend operation to another system controller (co-pr=
ocessor),
>   as example TI am335x SoCs,
> - or implement I2C driver in hw - TI AVS/SmartReflex.=20

Yes. Please note that this is only needed for reset, not suspend. So, it
is a bit easier. Still, it might make more sense to use a platform based
solution. I'll think about that.

> Sry, but 99% percent of I2C client drivers *should not* access I2C bus af=
ter
> .suspend_noirq() stage it's BUG-BUG!! Any W/A will just hide real problem=
s.

I do believe you, still is there documentation about such things? I like
to understand more but didn't dig up something up to now. E.g. I grepped
for "noirq" in Documentation/power.

> "master_xfer_irqless" might be a not bad idea, but, in my opinion, it=20
> should be used explicitly by platform code only, and each usage should
> be proved to exist.=20

Yes, we can think about it once it is really needed.

> Some additional info:

Thanks a lot for that!

> I'm attaching some very old patch (don't ask me why it was not sent :()
> I did for Android system - which likes suspend very much. Some
> part of below diff are obsolete now (like omap_i2c_suspend()),
> but .noirq() callback are still valid and can show over all idea.
> Really helped to catch min 3 buggy client drivers with timers, delayed
> or periodic works.

Ok, so what do you think about my plan to:

1) encourage drivers to check if there is still an ongoing transfer in
their .suspend function (or the core can do that, too, if we agree that
checking for a taken adapter lock is sufficient)

-> to ensure transfers don't get interrupted in the middle

2) use a .suspend_noirq callback in i2c_bus_type.pm to reject and WARN
about transfers still going on in that phase

-> this ensures that buggy drivers are caught

3) write some documentation about our findings / assumptions /
recommendations to a file in Documentation/i2c/

-> this ensures we won't forget why we did things like they are ;)

?

Kind regards,

   Wolfram


--mtcrtj3x3rvhprwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrx0REACgkQFA3kzBSg
KbYpJg//TOEZo59SzV210itR56njIa7vNNMFi7lM5Bk9A+d2AVvxBEGvnAS71LF2
6+zTocb1QIyreAy+i0dehuFAZRKKo3E2+u171lTKlS60y52YR7Z7pSKnJuT1ebd2
I2Ow9leIzLZPugdtlA7FzTYybzok0m740i7QCwQXXSbhTtG+w3ItlDSCx039yPZo
AQwtSsq3es7bhMOstlV1BzSE1Ed+TIJ4sQgV/vN1oPQJS5oWtVV6kHeT26Gt58WO
MM2Ic4/JiGg0yxvlclw/udYMExeXQR1OohvCSu1lHnusCi5wFCEV0hUtTvft2u9I
RFTK5hfDvSCaHF4dsJDfT8eYmjeLOoL1MWsdC/8VR+QH4Ar874kvEKtrIHyq42ah
3pMs7/4lw6iF6xfAWah1l2ZNF1Ip7C3/xEjwa5WKeEpp3dE5blZ33pInTeyayzjh
4ywHNpryOcVHb0AGLUAoCFZkorjilngtJb+8cT0hv8jyPMhSDrAnpaKrlzCShpZ4
H5lqKufWcIXjsK2se7fuVri018ZE1PmZSvwm6AgPFctzKPQkd/3pXOTC85HPAn8r
NMquesRZaZHvQ3hL/poih6ZaNzHZ3RGXCEVLQMNEazlxGkq7+WpRMiFFIbd9IWz7
lanziiWFPvcCy+t0e+H1qDPoPOzE1lgHyVttcwryc/uOZ2n3BkA=
=FuV4
-----END PGP SIGNATURE-----

--mtcrtj3x3rvhprwe--
