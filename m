Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEQNG7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:06:59 -0400
Received: from sauhun.de ([88.99.104.3]:51116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbeEQNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:06:56 -0400
Date: Thu, 17 May 2018 15:06:54 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
Message-ID: <20180517130653.vp3sw7duqz6ygazk@ninjato>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
 <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
 <20180515085833.4z4cvsxoqqbny53q@ninjato>
 <87286831-408c-b542-46e9-fe8aba151d5f@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jobdgfrfnsgdr4ki"
Content-Disposition: inline
In-Reply-To: <87286831-408c-b542-46e9-fe8aba151d5f@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jobdgfrfnsgdr4ki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > hopefully I have time to write a small coccinelle rule to find if
> > constant values are returned in a function declared as master_xfer.
>=20
> That would be a good thing.

Did that now and only found drivers which have a (meanwhile) needless
parameter check for 'num'. Will set you on CC for those fixes. I didn't
find any drivers incorrectly returning 0 instead of num. Except the ones
you already fixed.


> Maybe a long term goal is to simply return
> zero on success for .master_xfer, because currently the only expected
> success value is the number of messages sent, but the caller is in all
> likelihood already aware of that count, so it all seems rather like
> something that is just pointless and easy to get wrong...

Yes, the comment in the core is still true:

        /* REVISIT the fault reporting model here is weak:
         * ...

Returning 0 or -ERRNO sounds best to me, too. But we would need to make
sure there is no in-kernel user relying on the current behaviour. As you
said, this is a long-term goal at best.

> > What do you mean with "short success for some sequence" here?
>=20
> By "short" I mean not all requested messages transferred. By "success"
> I mean non-negative.

Ah, I understand now, thanks.

> I.e. when I look at rcar_i2c_master_xfer(), it sets things up for all
> messages to be transferred, starts things off and waits for completion
> (or timeout). But the driver is too involved for it to be easy to say
> that either all messages are transferred or a negative error is
> returned. I never managed to see that anyway.

Well, I am the maintainer of that driver, so I can say something about
that :) The HW design has a flaw for older SoCs which makes the driver
prone to a race condition. This is why we set up new messages in
interrupt context, too. Everything else turned out to be too expensive.

> And the function has that "ret =3D num - priv->msgs_left;" statement
> indicating that whomever wrote it thought it perfectly ok to return
> such a "short success" (which noone is expecting).

I copied over that old behaviour when refactoring the driver. But I see
what you mean, and couldn't also really see a path where a "short
success" could actually happen.

Thanks,

   Wolfram


--jobdgfrfnsgdr4ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9fmkACgkQFA3kzBSg
Kbbddw//Quj0zNyC1646l51BOaEW5SqbHJH71KpXOVZvQzw6jA8BY/XR4SmJifzf
64zMZpFLWpNvI1NT75XkFljnCb6l1X71JO0KC9LZySORFX2KLAnkDnlT1r33IrJJ
mslzCDjvwwWZW7IHFzPg19ydbFuVmsky2fr8ta5/X0Qcvqs/2yKV+M5B9aLO1tVJ
30dcC9RH9H3hcK7vRqmLBD+SUSPte44SPQPFiZM1qOBxCIqvj7qoAEXRH/vj+nqc
mdBf+rZhQQBfkbmzhqQlN7azwmyVJ8kfpkRBnGVi3NV0aKFbe0/vfRnpw6lZcTZ+
6RZZjjc+yXebBWsDiAlUjKVjrh0aPTl/HV9QSOe2NCy5LYHtbWwbn/RO7ExDPH16
UNGxxvvOe5wlLHDbyl0+Q4C3iQF9Wvs/OZlj08KWaZj+wWuBRSmHX+47NN1laAZ7
2P+rQ1f4w1jlwvH6MA7VCYz5NcIlsdW4atjPxqm2jHOnyoH3nxJRyYmu3aPI7g9x
wIFur45uufHNctuYzjVBGHc7iQG3tmymeuqHpFT0bXW3POXd9OMB/4N36SNyrDhR
btU6eGC2AaDcT7vg7nlUFOHhkwU1uknQuAUQZkmIzhKHki+NRJAG0hTyXdz6XGWr
RDVLFy8fSbxOW6LAcJGDE7iAbvRriWkeYEJoLDCD7l9sMUOiDiw=
=vNvu
-----END PGP SIGNATURE-----

--jobdgfrfnsgdr4ki--
