Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38117ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E319A20779
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E319A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeJVDxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:53:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40241 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJVDxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:53:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BF59D80703; Sun, 21 Oct 2018 21:38:26 +0200 (CEST)
Date:   Sun, 21 Oct 2018 21:38:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Message-ID: <20181021193827.GB26042@amd>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In order to minimize the performance impact (for usecases that do require
> spectrev2 protection), issue the barrier only in cases when switching bet=
ween
> processess where the victim can't be ptraced by the potential attacker (a=
s in
> such cases, the attacker doesn't have to bother with branch buffers
> at all).

Testing if attacker can ptrace victim is very good approximation, and
certainly better than "dumpable" check, but it is still not correct.

Imagine JIT running evil code (flash, javascript). JIT will prevent
evil code from doing ptrace() (or maybe there is syscall filter in
effect or something like that), but if evil code can poison branch
buffers and do timings, security problem stays.

Do we need prctl(I_DONT_RUN_EVIL_CODE)?

Or maybe we should just do barrier unconditionally for now?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvM1bMACgkQMOfwapXb+vLQNACgvHrW1v9BYJxo13RLG7e3893o
ipgAoK7W5/wQwYkC/UnIeWvPxJiyPv0l
=qIJa
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
