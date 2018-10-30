Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9FECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305922080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305922080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJaHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:44:44 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:56274 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeJaHon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:44:43 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BBC1DA11BD;
        Tue, 30 Oct 2018 23:49:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id gMV-MhX8UvsS; Tue, 30 Oct 2018 23:49:15 +0100 (CET)
Date:   Wed, 31 Oct 2018 09:49:08 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030224908.5rsldg4jsos7o5sa@yavin>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rutzm3ujqe4ffmok"
Content-Disposition: inline
In-Reply-To: <20181030223343.GB105735@joelaf.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rutzm3ujqe4ffmok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > [...]=20
> > > > > > (Unfortunately
> > > > > > there are lots of things that make it a bit difficult to use /p=
roc/$pid
> > > > > > exclusively for introspection of a process -- especially in the=
 context
> > > > > > of containers.)
> > > > >=20
> > > > > Tons of things already break without a working /proc. What do you=
 have in mind?
> > > >=20
> > > > Heh, if only that was the only blocker. :P
> > > >=20
> > > > The basic problem is that currently container runtimes either depen=
d on
> > > > some non-transient on-disk state (which becomes invalid on machine
> > > > reboots or dead processes and so on), or on long-running processes =
that
> > > > keep file descriptors required for administration of a container al=
ive
> > > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesys=
tem
> > > > attacks). Usually both.
> > > >=20
> > > > What would be really useful would be having some way of "hiding awa=
y" a
> > > > mount namespace (of the pid1 of the container) that has all of the
> > > > information and bind-mounts-to-file-descriptors that are necessary =
for
> > > > administration. If the container's pid1 dies all of the transient s=
tate
> > > > has disappeared automatically -- because the stashed mount namespac=
e has
> > > > died. In addition, if this was done the way I'm thinking with (and =
this
> > > > is the contentious bit) hierarchical mount namespaces you could mak=
e it
> > > > so that the pid1 could not manipulate its current mount namespace to
> > > > confuse the administrative process. You would also then create an
> > > > intermediate user namespace to help with several race conditions (t=
hat
> > > > have caused security bugs like CVE-2016-9962) we've seen when joini=
ng
> > > > containers.
> > > >=20
> > > > Unfortunately this all depends on hierarchical mount namespaces (and
> > > > note that this would just be that NS_GET_PARENT gives you the mount
> > > > namespace that it was created in -- I'm not suggesting we redesign =
peers
> > > > or anything like that). This makes it basically a non-starter.
> > > >=20
> > > > But if, on top of this ground-work, we then referenced containers
> > > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
> > > > races (as well as being able to find out implicitly whether a conta=
iner
> > > > has died thanks to the error semantics of /proc/$pid). And that's t=
he
> > > > way I would suggest doing it (if we had these other things in place=
).
> > >=20
> > > I didn't fully follow exactly what you mean. If you can explain for t=
he
> > > layman who doesn't know much experience with containers..
> > >=20
> > > Are you saying that keeping open a /proc/$pid directory handle is not
> > > sufficient to prevent PID reuse while the proc entries under /proc/$p=
id are
> > > being looked into? If its not sufficient, then isn't that a bug? If i=
t is
> > > sufficient, then can we not just keep the handle open while we do wha=
tever we
> > > want under /proc/$pid ?
> >=20
> > Sorry, I went on a bit of a tangent about various internals of container
> > runtimes. My main point is that I would love to use /proc/$pid because
> > it makes reuse handling very trivial and is always correct, but that
> > there are things which stop us from being able to use it for everything
> > (which is what my incoherent rambling was on about).
>=20
> Ok thanks. So I am guessing if the following sequence works, then Dan's p=
atch is not
> needed.
>=20
> 1. open /proc/<pid> directory
> 2. inspect /proc/<pid> or do whatever with <pid>
> 3. Issue the kill on <pid>
> 4. Close the /proc/<pid> directory opened in step 1.
>=20
> So unless I missed something, the above sequence will not cause any PID r=
euse
> races.

(Sorry, I misunderstood your original question.)

The problem is that holding /proc/$pid doesn't stop the PID from dying
and being reused. The benefit of holding open /proc/$pid is that you
will get an error if you try to use it *after* the PID has died -- which
means that you don't need to worry about explicitly checking for PID
reuse if you are only operating with the file descriptor and not the
PID.

So that sequence won't always work. There is a race where the pid might
die and be recycled by the time you call kill(2) -- after you've done
step 2. By tying step 2 and 3 together -- in this patch -- you remove
the race (since in order to resolve the "kill" procfs file VFS must
resolve the PID first -- atomically).

Though this race window is likely very tiny, and I wonder how much PID
churn you really need to hit it.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rutzm3ujqe4ffmok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvY3+QACgkQSnvnv3De
m5/xExAArWrrPvGbFNWCpH9s0JEtzgkpYZhAiCvFxLavDm7/UeSZEoc9CPX7mWdJ
0rRwprX81j4ZirQj926ZfWvxJ3wrWGZzxiIqZqOhNeTxhRuXcPDt0cDXTtPEyzXG
VUYvbCkbZK9OReojq8iiOlD8iJf9nlvmUSr+jNXKepmwAv2J9+LX2MuQQ7xJihQ5
1Tmip4a8CHRJBn8k2QTO9cjG4gN9BAPDBxIg/PukLclJHlsXq2++7mr46MiXuI0A
2LHNoERiIMckYhcvNJB0kNp94A05UGxHPpONmNpR4EB0avhDz1TwC12DteCIvFUu
Fx9P0FysCWQDJ6Quq7fK3KPeXb4fomj97XmPUNVfQmxQz2KKMg+Lkj+dU/v/LaVk
5p8qMlXH4PU5ptWjn413rulljGlCmxRUVlT2iw+8slWg2a4S21+G8A2bnAAPY0TP
qLwEeXahy9g0mhXSk7KxbiGdezflN+U5v1QGo1+3g41EAyiQxWvoSbo0FTyivlaR
h3YpMQQrzf36om9CqJ6y2JRxfVhL0l6W7jZA4JNVSXq+O9Ao9gpM6xkUy/+Y0Cnn
7UIcQzgC95xkbdhNOyXAMGM9s1rN7DMbWTkj4GjpdHTWrRHGY70bCFzFWMQufer0
/7rvPvl7eILtQ2AqlHUxH0XcmYaIef5hdCe5jipakgXzLASoPgY=
=dxRO
-----END PGP SIGNATURE-----

--rutzm3ujqe4ffmok--
