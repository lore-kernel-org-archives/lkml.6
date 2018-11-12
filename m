Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E888223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E888223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeKMJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:08:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60864 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeKMJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:08:57 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A694D80707; Tue, 13 Nov 2018 00:13:34 +0100 (CET)
Date:   Tue, 13 Nov 2018 00:13:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181112231336.GA19782@amd>
References: <20181029221037.87724-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>=20
> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.

I'd really prefer this to use a new syscall, taking directory fd as an
argument. Various security solutions (seccomp, chromium sandbox,
ptrace/subterfugue) could be pretty surprised what write to a file is
doing...

> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".

Actually.. if you open /proc/123 directory, is pid 123 still going to
be reused?

If so... could we simply block reuse of that pid as long as directory
is open? It would solve the race w/o new file and w/o new syscall...

Good luck,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvqCSAACgkQMOfwapXb+vIo3gCdEmoJndbQ+y+GOcPqUKHUGyph
P8gAoMSRdCx9YsYEsnRJtD701eG8m+QQ
=xYQD
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
