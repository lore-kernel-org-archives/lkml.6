Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEMCWI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:22:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeEMCWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:22:07 -0400
Date: Sun, 13 May 2018 11:22:02 +0900
From: Mark Brown <broonie@kernel.org>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap: allow volatile register writes with cached only
 read maps
Message-ID: <20180513022202.GA17611@sirena.org.uk>
References: <1525817169-29233-1-git-send-email-jramirez@baylibre.com>
 <20180509083919.GU13402@sirena.org.uk>
 <65607fde-d0e9-0f08-3042-f6a58b760896@baylibre.com>
 <20180511020049.GD949@sirena.org.uk>
 <7cc158bb-3471-4d8e-d066-2e7f535812eb@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <7cc158bb-3471-4d8e-d066-2e7f535812eb@baylibre.com>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2018 at 12:29:42PM +0200, Jorge Ramirez-Ortiz wrote:
> On 05/11/2018 04:00 AM, Mark Brown wrote:

> > We don't currently suppress writes except when regmap_update_bits()
> > notices that the modification was a noop.  You probably want to be using
> > regmap_write_bits() here instead of regmap_update_bits(), that will
> > always do the write.

> but isnt that interface at a different level?

It's at the level where we suppress writes - the write suppression isn't
a feature of the caching, it's something that regmap_update_bits() does
if it notices that it won't change anything.  It'll happen even if
there's no cache at all.

> I am not sure if you are asking me to review my patch or just discarding the
> RFC and highlighting that I have a configuration problem.

I don't understand your patch as-is.

> In my use case and what triggered this RFC (config below), an 'amixer set'
> might never reach the driver's .reg_write interface even though the register
> is configured as volatile (to me this is not consistent since volatile_reg
> is being silently ignored).

I'm not seeing any inconsistency there.  Volatility means the register
can't be cached as it might change underneath us, it doesn't have any
impact on writes and it's happening at a lower level.  Like I say if you
absolutely need a write to happen you should be explicitly doing a
write, though if you need a write to happen for a noop control change it
sounds like there's something weird with that control that's possibly a
problem anyway.

> So I dont see where/how your recommendation fits; maybe you could clarify a
> bit more please?

As I've been saying if you explicitly need a write to happen don't use
regmap_update_bits(), do something that guarantees you'll get a write
like regmap_write() or regmap_write_bits().

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr3oUcACgkQJNaLcl1U
h9BqWQf+J/FO1A4fGK5nlXvar2tkRXv3Z1XbKO9W6XctjGQv1dwlaROBKIBSOm7V
dhIutCcd9m7lONj5Ibqe1Q8BkM3M8L8PkyQxT76d/5nZup6tSVgXD+/CPzVhHF+j
EQ7only3SkEUb/vzLQCDhIAghf2+Qk/8BEEQT3JAu5JPXCis8prPRKeD6yt4Sklo
vqKS9oHXNJ2c3M8dDeEQajaOPjxj8rCO5akbe2vFyHxIuKMGRSLOv9qJxyMlqRVE
fVl4T3aiFNkBA2umWBPyp4v+iB3SFzKezpJRhfGbjr5Z2QzA9zWPy5vew8AyltgJ
Ou34KtTScwIb09fAwZzUuBBVQbsFZQ==
=Q90z
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
