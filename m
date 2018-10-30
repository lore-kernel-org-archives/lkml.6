Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BACC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13C20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeJaHTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:19:11 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:13430 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbeJaHTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:19:11 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C5F2F42844;
        Tue, 30 Oct 2018 23:23:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 1sQtVVSfcsWL; Tue, 30 Oct 2018 23:23:46 +0100 (CET)
Date:   Wed, 31 Oct 2018 09:23:39 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030222339.ud4wfp75tidowuo4@yavin>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctrs4pwa23lyq57l"
Content-Disposition: inline
In-Reply-To: <20181030214243.GB32621@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctrs4pwa23lyq57l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 31, 2018 at 07:45:01AM +1100, Aleksa Sarai wrote:
> [...]=20
> > > > (Unfortunately
> > > > there are lots of things that make it a bit difficult to use /proc/=
$pid
> > > > exclusively for introspection of a process -- especially in the con=
text
> > > > of containers.)
> > >=20
> > > Tons of things already break without a working /proc. What do you hav=
e in mind?
> >=20
> > Heh, if only that was the only blocker. :P
> >=20
> > The basic problem is that currently container runtimes either depend on
> > some non-transient on-disk state (which becomes invalid on machine
> > reboots or dead processes and so on), or on long-running processes that
> > keep file descriptors required for administration of a container alive
> > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
> > attacks). Usually both.
> >=20
> > What would be really useful would be having some way of "hiding away" a
> > mount namespace (of the pid1 of the container) that has all of the
> > information and bind-mounts-to-file-descriptors that are necessary for
> > administration. If the container's pid1 dies all of the transient state
> > has disappeared automatically -- because the stashed mount namespace has
> > died. In addition, if this was done the way I'm thinking with (and this
> > is the contentious bit) hierarchical mount namespaces you could make it
> > so that the pid1 could not manipulate its current mount namespace to
> > confuse the administrative process. You would also then create an
> > intermediate user namespace to help with several race conditions (that
> > have caused security bugs like CVE-2016-9962) we've seen when joining
> > containers.
> >=20
> > Unfortunately this all depends on hierarchical mount namespaces (and
> > note that this would just be that NS_GET_PARENT gives you the mount
> > namespace that it was created in -- I'm not suggesting we redesign peers
> > or anything like that). This makes it basically a non-starter.
> >=20
> > But if, on top of this ground-work, we then referenced containers
> > entirely via an fd to /proc/$pid then you could also avoid PID reuse
> > races (as well as being able to find out implicitly whether a container
> > has died thanks to the error semantics of /proc/$pid). And that's the
> > way I would suggest doing it (if we had these other things in place).
>=20
> I didn't fully follow exactly what you mean. If you can explain for the
> layman who doesn't know much experience with containers..
>=20
> Are you saying that keeping open a /proc/$pid directory handle is not
> sufficient to prevent PID reuse while the proc entries under /proc/$pid a=
re
> being looked into? If its not sufficient, then isn't that a bug? If it is
> sufficient, then can we not just keep the handle open while we do whateve=
r we
> want under /proc/$pid ?

Sorry, I went on a bit of a tangent about various internals of container
runtimes. My main point is that I would love to use /proc/$pid because
it makes reuse handling very trivial and is always correct, but that
there are things which stop us from being able to use it for everything
(which is what my incoherent rambling was on about).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ctrs4pwa23lyq57l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvY2eoACgkQSnvnv3De
m5/2pRAAklfOwY/pnZ7CSbcT6jX5A/OQHbK/B/IXA7LhlFGI2sun5cAptMidvfGN
FoM+BwXsYpac7XMUPBX3iNHBDRj7pWgpb923i1jUaCwWx4Y4gLbVyCMNgxpHA+23
wz51k4lNGuCpbGHVNa+RbvODmw8pQx/Kt9HlTXhlpjKA+t/Ga6i+1E7PQWYYrE6G
LDNVxtrXJRiIxFdLOFwP/Ecurm5qq6Qio8JgUJBBU6PQ6YBLmDRxzyf9DAbzqKbs
Kt9ujV1+//v8C89KcNDe0HMTwOVjRfqyJ49SMijhSzhmB221HraASJ1dpSk/DCCQ
asEP7/B6jB2VHfZuDjkZ2WVeRdC2k4/bfRxDm61Bikak6WLzepiuH+nJ0B3vXPqA
LtacbO2sqEGjtlwXfp4+B2xIN4UjbeerrWMBd90hrG0juNvl6S9ZEDPZwaGpSQof
mFX5XGM4YHB8ihE6950PDzhtWv4txpLWWPAdERA6zV05kgysRcmkS9uWPcgZmvyr
uDVy0ReiC/lk1whKdEIsnSRh9yBbpzEmBRtsP0kODKabsxox7kEG+iHD+h75CTn4
TFhJUXPtXkAz3XraL9MYpIkzNo45ba4yfrFMQKlkSKnwa+EObbakomQMY7AWYCHs
7lKLSydb0kO4V6KXbKv3HVYi9WTUqKY1dUylMvGXLdk93sJk7wk=
=nVn+
-----END PGP SIGNATURE-----

--ctrs4pwa23lyq57l--
