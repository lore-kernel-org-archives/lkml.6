Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395AF222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394213AbfBOWzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:55:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46000 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393015AbfBOWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:55:24 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F267D80454; Fri, 15 Feb 2019 23:55:14 +0100 (CET)
Date:   Fri, 15 Feb 2019 23:55:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, Wouter Verhelst <w@uter.be>,
        nbd@other.debian.org
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190215225520.GA21165@amd>
References: <20190215191953.GB17897@amd>
 <20190215224126.GX12500@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20190215224126.GX12500@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-15 22:41:26, Richard W.M. Jones wrote:
> On Fri, Feb 15, 2019 at 08:19:54PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > I watched fosdem talk about
> > nbdkit... https://www.youtube.com/watch?v=3D9E5A608xJG0 . Nice. But word
> > of warning: I'm not sure using it read-write on localhost is safe.
> >=20
> > In particular, user application could create a lot of dirty data
> > quickly. If there's not enough memory for nbdkit (or nbd-client or
> > nbd-server), you might get a deadlock.
>=20
> Thanks for the kind words about the talk.  I've added Wouter Verhelst
> & the NBD mailing list to CC.  Although I did the talk because the
> subject is interesting, how I actually use nbdkit / NBD is to talk to
> qemu and that's where I have most experience and where we (Red Hat)
> use it in production systems.
>=20
> However in January I spent a lot of time exercising the NBD loop-mount
> + nbdkit case using fio in order to find contention / bottlenecks in
> our use of threads and locks.  I didn't notice any particular problems
> then, but it's possible my testing wasn't thorough enough.  Or that
> fio only creates small numbers of dirty pages (because of locality in
> its access patterns I guess?)
>=20
> When you say it's not safe, what could happen?  What would we observe
> if it was going wrong?

I'm not saying I've seen it happen, or have a test. But my
understanding of memory management says it could deadlock... if nbd
tried allocating memory while memory was "full" of dirty data.

Dunno, something like ... take 1GB block device with 1GB RAM
machine. Create memory pressure so that nbdkit (etc) is dropped from
memory. Then quickly make all the data on the block device dirty.

I believe that scenario is something that can not happen on system
without NBD in loopback configuration.

Situation may be made worse if nbdkit needs to allocate memory due for
compression buffers or something like that.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnQ1gACgkQMOfwapXb+vKLzACdHOcDBVY5chhH+UTwSdTqjeWM
XfoAnRH0/ItGERddhiTijzSImaorfOVE
=B76J
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
