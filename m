Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD720848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFD720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLCOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:46:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48876 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeLCOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:46:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2F65680854; Mon,  3 Dec 2018 15:45:34 +0100 (CET)
Date:   Mon, 3 Dec 2018 15:45:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203144536.GA15279@amd>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20181203141737.GY31738@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-03 15:17:37, Michal Hocko wrote:
> On Mon 03-12-18 15:14:59, Pavel Machek wrote:
> > On Mon 2018-12-03 14:53:51, Michal Hocko wrote:
> > > On Mon 03-12-18 14:10:06, Pavel Machek wrote:
> > > > On Mon 2018-12-03 13:38:57, Michal Hocko wrote:
> > > > > On Mon 03-12-18 13:31:49, Oleg Nesterov wrote:
> > > > > > On 12/03, Michal Hocko wrote:
> > > > > > >
> > > > > > > Now, I wouldn't mind to revert this because the code is reall=
y old and
> > > > > > > we haven't seen many bug reports about failing suspend yet. B=
ut what is
> > > > > > > the actual plan to make this work properly?
> > > > > >=20
> > > > > > I don't see a simple solution...
> > > > > >=20
> > > > > > But we need to fix exec/de_thread anyway, then we can probably =
reconsider
> > > > > > this patch.
> > > > >=20
> > > > > My concern is that de_thread fix might be too disruptive for stab=
le
> > > > > kernels while we might want to have a simple enough fix for the t=
he
> > > > > suspend issue in the meantime. That was actually the primary reas=
on I've
> > > > > acked the hack even though I didn't like it.
> > > >=20
> > > > Do we care about failing sleep in stable? Does someone hit the issu=
e there?
> > > >=20
> > > > This sounds like issue only Android is hitting, and they run very
> > > > heavily patched kernels, far away from mainline or stable.
> > >=20
> > > But the underlying issue is the same and independent on their patches
> > > AFAIU. And is this really a common problem to care about in stable? I
> > > dunno to be honest but it sounds annoying for sure. Failing suspend is
> > > something that doesn't make your day when you are in hurry and want
> > > find out only later when your laptop heats up your bag ;)
> >=20
> > In general, yes. In practice, if it happens 1 in 1000000 suspends, you
> > don't care that much (but Android cares).
>=20
> This argument just doesn't make any sense. Rare bugs are maybe even
> more

I guess argumenting about this just does not make sense. Just bear in
mind -stable is not for theoretical problems.

> annoying because you do not expect them to happen. But I would be more
> interested to see whether they are any downside. Is there any actual
> risk to silence the lockup detector that you can see?

As someone else noticed:

a) the bug can be triggered outside suspend

b) the lockdep report is real. You'll still get suspend failure, but
you now need two processes to trigger it

> > Do we actually have reports of this happening for people outside
> > Android?
>=20
> Not that I am aware of.

Good.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwFQZAACgkQMOfwapXb+vKiWQCfWz53qjgUAKALyYgCJreXkzra
Ib0AoLhkCplesk1GXWa5hUS0Ke5AgJvN
=QQzV
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
