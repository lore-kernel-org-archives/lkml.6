Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B8FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E3120843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E3120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJ1ATD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:19:03 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18818 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeJ1ATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:19:03 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 618FBA114A;
        Sat, 27 Oct 2018 17:37:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id VoBHB5k5HvI1; Sat, 27 Oct 2018 17:37:37 +0200 (CEST)
Date:   Sun, 28 Oct 2018 02:37:23 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Ed Maste <emaste@freebsd.org>,
        David Drysdale <drysdale@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181027153723.nfro756r4o2vxqqr@ryuk>
References: <20181009065300.11053-3-cyphar@cyphar.com>
 <20181027014114.GA52393@freebsd.org>
 <20181027071729.xbnvfii6iwdwymrn@ryuk>
 <20181027075348.GN32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="po2m5ugz2nquu7oo"
Content-Disposition: inline
In-Reply-To: <20181027075348.GN32577@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--po2m5ugz2nquu7oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-27, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> On Sat, Oct 27, 2018 at 06:17:29PM +1100, Aleksa Sarai wrote:
>=20
> > I'm going to send out a v4 "soon" but I would like to know what folks
> > think about having resolveat(2) (or similar) to separate the scoping O_*
> > flags and produce an O_PATH -- since unsupported O_* flags are ignored
> > by older kernels userspace will have to do some plenty of checking after
> > each path operation.
> >=20
> > Personally, I believe this (along with AT_EMPTY_PATH for openat(2))
> > would help with some other O_PATH issues.
>=20
> The trouble with resolveat(2) is that for anything directory-modifying
> you really want directory locked before the lookup for last component.
> IOW, funlink(2) et.al. are hopeless.

Ah, right... In those cases I think that AT_SYMLINK_NOFOLLOW could help,
or maybe we would need to have some of the scoping flags for other
syscalls (though this would be an issue in either case for scoping
unlinkat(2) -- even if we used O_BENEATH). :/

But my main issue at the moment with O_PATH is that /proc/self/fd/...
re-opening allows for some very odd delayed-access-check attacks.
openat(2) doesn't give you an O_EMPTYPATH but that is what you get with
/proc.

For instance, take /proc/self/exe. Tautologically, it is impossible to
open it O_RDWR -- if you are resolving it through an "exe" magic symlink
then it is being used as a process's ->mm (and thus is locked from
writing). *However* you can open it O_PATH and then later re-open it
through /proc/self/fd. We had cases where a container runtime joining a
container would be able to do this and overwrite the container binary
*on the host*. This has been mitigated now (as part of CVE-2016-9962),
but I would be very shocked if there was no other places where this sort
of thing would happen.

My proposal for resolveat(2) would let us have some sort of "I want
these access bits" API for O_PATH. Of course there are some quite
not-nice changes I think you'd need to allow for this usecase -- my
back-of-the-envelope proposal would be to stash away the fmode bits
inside 'struct path' so that do_last() can see whether we are doing a
re-open of an existing 'struct file' (but I'm sure this sounds awful).

Is this a problem you think deserves solving / is there a better way of
going about it? Thanks.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--po2m5ugz2nquu7oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvUhjMACgkQnhiqJn3b
jbQiNg/9EUPo5YUBft7w5yogDlRYWgaoZeQz/WHPb9ndAvWEn54aebevYTfodT1k
QSO0k8QzQUOwSYVS1nCarRL7mb/V4v7vNlHC/1MpCPZULnU8AJ16pOKA5obUE6nS
a7ukHvEOOlyh88p0Lcn4IvZNBHWSXznjr1avINfarvupjxmv6DD+R+n3vijMrSqs
KTCEc4Iw7qXyBE8m8VIxACG3m8JWWJl5nGucsSPIVgT5tnV26sloM4ofPVe4c6QN
AMlq+INKmyt1teMaidCxBaMDcgCEA4Vdx1v3JPL1qcUE354ZVqDwBA1D6zUP/IO+
nhYRqWWhc9e+BLW5IRLe0d7b+xRYaOOS9jN3ZqFyBbqMcfuDBTGMwmky4koHgb0f
ftVb0ywsOYw6yN7W80+od+yuwpO6ox7xcr6v05oVBahOtyKiprrQpN9bvaJwTH6W
vfxVB3+jDRIz5WcpB5qmt/LPqYm3fl3XkJHd/xE8aZl3xg/6E/x5mC4xk/LVGOqI
a+cJBUYFGqNCcjMZl37KL1Onsp66PPAhRRGKnYd4ojmAJvXH28FBLfw/MksD2Lne
gS48erzeJm7R5f7TXxX1w8jMyeKHzdrWQkXRZvGRg2F/Iiym3UuFIFYfQKW10uNf
73/GZ/q78UoE2kG+lTL9Tp0ipl28wnJYyzd2ONapgey06Qhrods=
=HEAw
-----END PGP SIGNATURE-----

--po2m5ugz2nquu7oo--
