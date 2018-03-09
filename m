Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeCITf0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:35:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50816 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbeCITfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:35:25 -0500
Date: Fri, 9 Mar 2018 20:35:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Message-ID: <20180309193523.GA2977@amd>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
 <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-09 10:45:16, Kees Cook wrote:
> On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
> >
> >> If a codec is not attached to the sound soc, a NULL deref is possible =
as a
> >> regular user in /sys.
> >
> > I can't parse this, sorry.  What is the "sound soc"?
>=20
> SoC's sound component? I'm not sure either. :) I was just sending the
> patch that I mentioned from the thread where Pavel mentioned this
> Oops.
>=20
> Pavel, can you isolate the specific file that is causing the oops?
> (Maybe this patch should be a WARN() instead of silent return 0, since
> we still don't want to crash, but it should be considered a bug...)

Crash is reproducible on linux-next on Nokia N900. But I seen hang on
Nokia N9, with different kernel, that may be related.

And yes, WARN() would be nicer.

> >> +++ b/sound/soc/soc-core.c
> >> @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_c=
odec *codec, char *buf,
> >>       size_t total =3D 0;
> >>       loff_t p =3D 0;
> >>
> >> +     if (!codec || !codec->driver)
> >> +             return 0;
> >> +
> >
> > How are we managing to create a sysfs file for a CODEC which doesn't
> > have a CODEC struct associated with it?  That is obviously nonsensical
> > and suggests we've got some more serious problem going on here - if
> > there's no CODEC those sysfs attributes simply shouldn't be there.
>=20
> No idea! Hopefully Pavel has more details...

Pavel probably can reproduce it...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqi4fsACgkQMOfwapXb+vLbIQCgnLjHPQpsXjX6HNyg7+Wcx3z6
5fMAoIIqbOg+YWWcLv0MEgToQ8EJY188
=d5yl
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
