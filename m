Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C630C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE3520850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE3520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLDTm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:42:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46192 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:42:59 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 10D2E80910; Tue,  4 Dec 2018 20:42:53 +0100 (CET)
Date:   Tue, 4 Dec 2018 20:42:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204194255.GB28651@amd>
References: <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz>
 <20181204093310.GE73770@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20181204093310.GE73770@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-04 10:33:10, Ingo Molnar wrote:
>=20
> * Michal Hocko <mhocko@kernel.org> wrote:
>=20
> > I dunno. I do not use hibernation. I am a heavy user of the suspend=20
> > though. I s2ram all the time. And I have certainly experienced cases=20
> > where suspend has failed and I onlyi found out later when I've picked=
=20
> > up my laptop from my heat up bag. Nothing fatal has resulted from that=
=20
> > but this is certainly annoying.
>=20
> Hm, so I (mistakenly) thought freezing was mostly limited to hibernation=
=20
> and to a few weird cases when in flight DMA must not be suspended - but=
=20
> I'm wrong and in practice we always freeze tasks during s2ram, right?
>=20
> And indeed:
>=20
>  config SUSPEND_FREEZER
>         bool "Enable freezer for suspend to RAM/standby" \
>                 if ARCH_WANTS_FREEZER_CONTROL || BROKEN
>         depends on SUSPEND
>         default y
>=20
> which is essentially always enabled on x86.
>=20
> TIL ...

pavel@amd:~$ wtf til
Gee...  I don't know what til means...
?

> s2ram is obviously a huge deal.
>=20
> Just a newbie question: any chance to not do any freezing at all on=20
> modern laptops when doing s2ram, or at least only warn if it fails and=20
> try to suspend?

Not really.

> Because in practice losing power due to failed freezing *will* result in=
=20
> data loss, in about 90% of the time ...

Ugh. What are you talking about?

I don't know how you use your machines, but 95% of s2ram's I do,
machines are running on AC power, and I'll notice that freezer
failure, because the machine keeps making noise when it should be
sleeping.

There's big difference between "sync; forced_poweroff" and
"forced_poweroff", which are annoying but quite harmless (editors keep
backups, web browser stores session periodically, and filesystems have
journal...) and real data corruption as in "Pavel found another bug in
fsck.ext3, which is great, but his filesystem is corrupted, which is
not so great".

(BTW one of those bugs is unfixable; I managed to corrupt ext3 in such
a way that fsck is not able to automatically repair it, and likely
never will be. Fun?)

> So I don't even know what we are trying to protect against by refusing to=
=20
> freeze - avoiding a 0.001% data loss risk against a 90% data loss risk?

Where did you get those 0.001% and 90% numbers?

I don't see freezer failures too often.

I see machine that is sleeping, but fails to resume, maybe once in
month. That's "sync; forced_poweroff" type failure. Not nice,
but... Unfortunately fairly hard to debug. And not worse than usual
"hard crashes" I see at about same frequency.

I did have real filesystem corruption, at least twice while debugging
hibernation. Trust me. You don't want to have that, and you certainly
don't want your users to have that.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwG2L8ACgkQMOfwapXb+vIS2ACfSv9A9FtOThGulm6OSg5iQjni
Ly4AniRjPAtmnKUepoEm9LN0lmOMs71h
=iHw3
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
