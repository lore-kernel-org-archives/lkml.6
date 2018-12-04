Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC70C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8252082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8252082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLDTzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:55:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46548 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLDTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:55:08 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CF3D88093E; Tue,  4 Dec 2018 20:55:02 +0100 (CET)
Date:   Tue, 4 Dec 2018 20:55:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhocko@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204195505.GA28832@amd>
References: <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz>
 <20181204093310.GE73770@gmail.com>
 <20181204095802.GF1286@dhcp22.suse.cz>
 <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-04 09:31:11, Linus Torvalds wrote:
> On Tue, Dec 4, 2018 at 1:58 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > AFAIU both suspend and hibernation require the system to enter quiescent
> > state with no task potentially interfering with suspended devices. And
> > in this particular case those de-thread-ed threads will certainly not
> > interfere so silencing the lockdep sounds like a reasonable workaround.
>=20
> I still think it would be better to simply not freeze killed user process=
es.
>=20
> We already  have things like
>=20
>         if (test_tsk_thread_flag(p, TIF_MEMDIE))
>                 return false;
>=20
> exactly because we do not want to freeze processes that are about to
> die due to being killed. Very similar situation: we don't want to
> freeze those processes, because doing so would halt them from freeing
> the resources that may be needed for suspend or hibernate.
>=20
> How about something like we set PF_NOFREEZE when we set PF_EXITING? At
> that point we've pretty much turned into a kernel thread, no?

I'd be careful about that. Exiting task needs to write to disk (space
of unlinked but open files needs to be freed), so we can't just ignore
them.

And given that ptrace example (where it deadlocks w/o freezer anywhere
nearby), I'd say attempt to simplify the locking should be made, first.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwG25kACgkQMOfwapXb+vJ3PwCfa9L6ANtUic0o9b783bZZ+/ZO
PasAn1mkg2Q9Gj4m3+G9iR7OVfHtMP3o
=qkqc
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
