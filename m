Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEQRER (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:04:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58050 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:04:15 -0400
Date: Thu, 17 May 2018 18:04:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
Message-ID: <20180517170410.GU20254@sirena.org.uk>
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
 <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
 <20180511020049.GD949@sirena.org.uk>
 <7cc158bb-3471-4d8e-d066-2e7f535812eb@baylibre.com>
 <20180513022202.GA17611@sirena.org.uk>
 <201167c6-304c-138a-358f-bee096767527@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czRehjsqUdpaVUeF"
Content-Disposition: inline
In-Reply-To: <201167c6-304c-138a-358f-bee096767527@baylibre.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czRehjsqUdpaVUeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:12:49AM +0200, Jorge Ramirez-Ortiz wrote:
> On 05/13/2018 04:22 AM, Mark Brown wrote:

> > > So I dont see where/how your recommendation fits; maybe you could cla=
rify a
> > > bit more please?

> > As I've been saying if you explicitly need a write to happen don't use
> > regmap_update_bits(), do something that guarantees you'll get a write
> > like regmap_write() or regmap_write_bits().

> I do understand your point but Mark, that interface you mention sits above
> the user request (as a client the user does not call regmap_update_bits or
> regmap_write_bits or regmap_write(): none of those functions mean anything
> to the foo_regmap definition below - that is why we have an interface).

=2E..

> and all this request means is that it expects foo_volatile_regs to be tak=
en
> into consideration when accessing the reg_write callback: so whoever is
> calling the interface reg_write (be it regmap_update_bits or
> regmap_write_bits or whoever it is, I dont know) must make sure the volat=
ile
> request applies.

Right, but your code can expect a lot of things and not have them happen
if they're not good expectations - that's explicitly not what we've been
meaning by volatile registers (they're just registers that can't be
cached).  I mean, you mentioned that you were doing this for an ALSA
control and since ALSA reports noop updates to userspace it'd be
entirely reasonable for an implementation change there were to suppress
the write before it gets to regmap (this is the sort of thing I was
thinking of when I said I was suspicious of what you're doing there,
this doesn't sound like a normal ALSA control).

I get what you're saying, it just doesn't feel like this is the right
place to solve whatever your end use case is, it feels like it's going
to be fragile one way or another and end up adding more complexity -
having a hand coded ALSA control for this feels more secure at that
level never mind anything that's going on in regmap.=20

--czRehjsqUdpaVUeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9tgoACgkQJNaLcl1U
h9D1HAf6Agrr6hbmXGJ69LcYyB7GsIBAZoC/mBfI6kssnEJUtlfi5UV9nYGoehhN
KP6kn2VaJ9MHWTz0amh5fuCwpHG+R0ANSGwTkRPyiqX0azPmoa6c6I9xAIKMlwaU
tiUCfOVRk5UOqlYBEFdiTZtFcXMQJNHs7q/mAoWJEE7Ue33jPch/1b28JwZKzzdw
Q5bcDS4OhEwGOGBKEIUdm7/2LAsVeRcSFxhRcLCDZtX7vPqP9bmk9Qodqz3I40id
hZDj/BAW0APU06Rof2VIwaJpBXa8M0HkNMWk+AqgfNwL43Ia4UjNrc67H/XUb6RG
cOJSEGmPUTrM6MPDIVdnxa8vFXD1fw==
=257N
-----END PGP SIGNATURE-----

--czRehjsqUdpaVUeF--
