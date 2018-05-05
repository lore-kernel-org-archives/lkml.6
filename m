Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEEBzF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:55:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeEEBzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:55:03 -0400
Date: Sat, 5 May 2018 10:54:58 +0900
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
Message-ID: <20180505015458.GM13402@sirena.org.uk>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Content-Disposition: inline
In-Reply-To: <20180504122447.u3xgrkperxz5dpcz@ninjato>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2018 at 02:24:47PM +0200, Wolfram Sang wrote:

> To handle that, I imagined an additional adapter callback like
> 'master_xfer_irqless' to be used for such special I2C messages. These
> kind of special messages could be tagged with a new I2C_M_something
> flag.

> And maybe this could be used here, too? Introduce this flag for very
> late/early messages. If they have it, messages are even sent in
> suspend_noirq() phase with the master_xfer_irqless() callback, otherwise
> we will have the WARNing printed out.

It feels like it'd be more elegant to have the core select the irqless
function automatically if called after interrupts have been disabled -
otherwise we end up with the need to special case through other layers
of the stack like regmap as well which seems like it'd be error prone.
OTOH it does mean we might not notice things happening later than they
should so it's not 100% clear...

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrtDvEACgkQJNaLcl1U
h9AVzwf9HXeIb5jst5K9BIC9uAe0uVBSWC4Whk8+Msy2998H1IYDuWsKc+bQN7ad
ZtJgocc06oHrltwR+gKBzbhCaIDfan6jbdl4HaevTOQBzqfMRpRG/UJN5SVkY7ky
GV3lR9Dr6rbhPuyDuR1iYgsXMBDRr6a5oixAWwdo+xXdVbSqt7s6XtVIsV7AyR5t
vjQPDDu9O29Z19uU2eiDAOMe4fjfqu5OnWshJSHNarTiuIvi0KDl6gZIoBNvDY+f
WY+iCZX/OB+/gile7FNjf0Syl5lT9PaUU0Eq8AD0LKb0Q8em0P5Ce7Q43zPKoM0E
JJCDupBjKy9yULYv/5nDI/GspFu8ug==
=kOM9
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--
