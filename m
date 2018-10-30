Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB786C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A74B2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJaFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:40:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:54374 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeJaFkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:40:14 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 13BBCA11E6;
        Tue, 30 Oct 2018 21:45:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id Kf5wuDb_gLPY; Tue, 30 Oct 2018 21:45:08 +0100 (CET)
Date:   Wed, 31 Oct 2018 07:45:01 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030204501.jnbe7dyqui47hd2x@yavin>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttptq65jxnckrurq"
Content-Disposition: inline
In-Reply-To: <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttptq65jxnckrurq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-30, Daniel Colascione <dancol@google.com> wrote:
> >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> >> write the signal number in base-10 ASCII to the kill file of the
> >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> >>
> >> Semantically, /proc/pid/kill works like kill(2), except that the
> >> process ID comes from the proc filesystem context instead of from an
> >> explicit system call parameter. This way, it's possible to avoid races
> >> between inspecting some aspect of a process and that process's PID
> >> being reused for some other process.
> >
> > (Aside from any UX concerns other folks might have.)
> >
> > I think it would be a good idea to (at least temporarily) restrict this
> > so that only processes that are in the same PID namespace as the /proc
> > being resolved through may use this interface. Otherwise you might have
> > cases where partial container breakouts can start sending signals to
> > PIDs they wouldn't normally be able to address.
>=20
> That's a good idea.

(Oh and I wonder how this interacts with SELinux/AppArmor signal
mediation.)

> > (Unfortunately
> > there are lots of things that make it a bit difficult to use /proc/$pid
> > exclusively for introspection of a process -- especially in the context
> > of containers.)
>=20
> Tons of things already break without a working /proc. What do you have in=
 mind?

Heh, if only that was the only blocker. :P

The basic problem is that currently container runtimes either depend on
some non-transient on-disk state (which becomes invalid on machine
reboots or dead processes and so on), or on long-running processes that
keep file descriptors required for administration of a container alive
(think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
attacks). Usually both.

What would be really useful would be having some way of "hiding away" a
mount namespace (of the pid1 of the container) that has all of the
information and bind-mounts-to-file-descriptors that are necessary for
administration. If the container's pid1 dies all of the transient state
has disappeared automatically -- because the stashed mount namespace has
died. In addition, if this was done the way I'm thinking with (and this
is the contentious bit) hierarchical mount namespaces you could make it
so that the pid1 could not manipulate its current mount namespace to
confuse the administrative process. You would also then create an
intermediate user namespace to help with several race conditions (that
have caused security bugs like CVE-2016-9962) we've seen when joining
containers.

Unfortunately this all depends on hierarchical mount namespaces (and
note that this would just be that NS_GET_PARENT gives you the mount
namespace that it was created in -- I'm not suggesting we redesign peers
or anything like that). This makes it basically a non-starter.

But if, on top of this ground-work, we then referenced containers
entirely via an fd to /proc/$pid then you could also avoid PID reuse
races (as well as being able to find out implicitly whether a container
has died thanks to the error semantics of /proc/$pid). And that's the
way I would suggest doing it (if we had these other things in place).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ttptq65jxnckrurq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvYws0ACgkQSnvnv3De
m59tqg//SJHM++rBB5LiwC+95XIVUdw1DmHVa+8z0p6QbArCWyzbDF47DGc6+31W
R5X9lEOiEH0Rtreq5ZN9xrK4VsjWVqeriu5/Cg4pY41UGsjF5Yc6V8td85mI5Km+
fw+b02qdtbNHO3JSRmKkwcwBr5Y5SX0rn/78YSDFxb2jbgke1ApUVDunkoHwzw2N
JoQaIq1iHRqPRMy9COMH1l2qJ/XCCmpyUathKmw6HNCx55aRJHkFrWWoiNbviHZ7
Qst2pM1AKK/dK80oBdGtb1vNb2oI2mOlROESwf0LxUOMbSCrXIDjO3WvDvoOw48P
ACO2DHeBqKYam8ZE5aM3Koz9vGbYR5S4Pb0vs6IgR0bLXGGicgxTNASRK/+hBkAi
IozExc8PQpgqwP62mM0Za4cRqHO2bW3bgM4ULTHmx7VHhhOkyL2lZf4lVznQ8rh3
D3hQTln8QqYAts32bvWLj/2YePo3maKxF66VwLgz+dkF/IKZ9SRG8wkt4ItSTA3+
+R1SsAVLkKLzn5bXVnR8eteE51MvB0ccn66gjgW7MJJhrSzIhisUv/Ayv2VVhzvk
34sCpiHbK+YFnFpuxTr2mqa6bB9bAeIg2Hiqqlq5NidMpdYSymAiYqrbXnzeXMo7
pHOtuiU7mzdN16sbiENBvJL14w3sMj7d7Wg0hQmRFToOH3j3liA=
=VYkc
-----END PGP SIGNATURE-----

--ttptq65jxnckrurq--
