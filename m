Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpL5MWfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfAWIuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:50:15 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34854 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:50:14 -0500
Received: by mail-yb1-f194.google.com with SMTP id h81so575719ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vP++zywrewyllFoY8SFFzZndvScys639HwssjycDzc=;
        b=TpL5MWfFO8ISsmbcwyNb5vMW0TpSc3hyOxVBFCVdRl0jXEEycMPwnvftAfHjo0w0Tp
         DAzSMuvgvq0Z/w6URa3cJ1S+zxU3SAxo3/eLc7Pn+sybzRO1ZfrP+pPB1O56V4y01xp1
         zBlY7tEgR7N6WTw9En/NqSYh6OPwibdVx5rZQuJ4Iw0dDDF4zL1okNvBb+RLe6noNNtT
         AsQeHI51M7YaB2YLXimiU4ZwHS1KEOEItp8yC6/lc6u/ipskI0M+j8SSh39YiDmX19Fh
         ekkCklfCE6AUpQacFzecuptKQ7JYXf1rvhyy3eAj21K47sFa50uztfFg0w2hyjrYq5BK
         56Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vP++zywrewyllFoY8SFFzZndvScys639HwssjycDzc=;
        b=sKr9X9PcAU9+CNtqgE1t9BD2izMdS/aO7eWD+cmW36WaB4IhIZnuQYUAZO+DeEMdf4
         GgRP1NDsVmJP+gq0b6cZc4qLQm0dBR/wUHh4AMoOhKIXGoEJaq/80iYV8g8OT05XVFe1
         kVQuo9QuXVB1boAhOTAAAr/4lP//MPuZx+DqqIZMdOjw2M62Q1vaXIV+LwYJlZBydMhu
         9fQ4FwN0Gp8DALR+7v+pXfD9QtSIAbUFUPl0Bhh/n08g1jJg8Dg881RdxM96GeWue+J4
         h04Ocvnsierx7hyMT64/32iE3PrsTwKDqIPMohbIkXOBtq7DIaTp6i9DR7nbU2jZXc60
         haNg==
X-Gm-Message-State: AJcUukfbkfXBoXPAghhx78ncqkT1sUQdFdAQkaAl2+AMsaB4BQWu4KAL
        rdGSGn8ry76rSpijOvzp+W+2rz1yvNI=
X-Google-Smtp-Source: ALg8bN5ijyyRqZqanTlbAOpXm2j/CprmOuWUdOhTtlIYta4uuuP0h3koMUg8Jt4/ludpeHvnkYIYXw==
X-Received: by 2002:a25:aa64:: with SMTP id s91mr1096543ybi.245.1548233413632;
        Wed, 23 Jan 2019 00:50:13 -0800 (PST)
Received: from dumbo ([83.137.2.252])
        by smtp.gmail.com with ESMTPSA id s185sm14134629yws.69.2019.01.23.00.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 00:50:06 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:50:00 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Ben Finney <bignose@debian.org>
Cc:     Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        919356@bugs.debian.org, debian-legal@lists.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: Licensing of include/linux/hash.h
Message-ID: <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y6pzhqfh5wkjxynx"
Content-Disposition: inline
In-Reply-To: <20190115170017.5gxarqxzfezgr5ld@dumbo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6pzhqfh5wkjxynx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ben Finney <bignose@debian.org> writes:
> Domenico Andreoli <cavok@debian.org> writes:
>=20
> >   the situation of dwarves-dfsg improved a lot over the weekend
>=20
> That's good to hear. What is the event you're referring to? Can you give
> a URL to something that describes this change?

Upstream (in CC) reacted to my request of clarification and patches
have been applied upstream and on Salsa. See bug 919356 [0] (please
keep in CC).

> > the only knot left is now the license of hash.h
> >
> > This file is also present in the kernel [0] with an updated copyright
> > but still without license.
>=20
> The file you show (in the Linux code base) seems likely to have an
> equivalent implementation under a different license, from some other
> code base.

This will require research and work unlikely to be done before Buster
release. Are we going to drop this package for now?

> > I received a private email from somebody in the kernel community who
> > already tried to contact Nadia in the past but did not get any reply.
>=20
> Thank you also for contacting the Linux developers forum to ask
> <URL:https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1900588=
=2Ehtml>.

(also in CC now)

> > I think that pushing it to non-free is formally the right thing but I
> > actually feel it's not the right thing.
>=20
> To know that work (that file) is free software, we need a clear grant of
> some specific license, for that work.
>=20
> If the work is not free, it would be incorrect to have the work in Debian.

Is it possible that for the kernel it is instead correct because it is,
as whole, covered by its COPYING?

> Alternatives, for complying with the Debian Free Software Guidelines with
> this package, include:
>=20
> * Find a credible grant of license under some GPL-compatible free
>   license to that exact file. Document that explicit grant in the Debian
>   package. This demonstrates the work is DFSG-free.
>=20
> * Convince =E2=80=98dwarves-dfsg=E2=80=99 upstream to replace that file w=
ith a different
>   implementation (I don't know whether such an implementation exists)
>   under a license compatible with the same version of GNU GPL. Document
>   that explicit grant in the Debian package. This demonstrates the
>   modified work is DFSG-free.

Arnaldo, what priority would you give to this task?

>=20
> * Replace that file in Debian only, with a different implementation as
>   above. Document that explicit grant in the Debian package. This
>   demonstrates the modified Debian package is DFSG-free.
>=20
> * Move the work to the =E2=80=98non-free=E2=80=99 area.
>=20
> * Remove the work altogether.
>=20
> Those are in descending order of (my recommended) preference.

Thanks,
Domenico

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D919356

--=20
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13

--y6pzhqfh5wkjxynx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEqwJ7wH2QqDPtVNX+Tg9k0miCQVoFAlxIKrIACgkQTg9k0miC
QVpJaQ/+OmlHW6Y4OL2kw2mBvO9/p4VZaVfjM/7+eaf5AJ5IRWkoGpjexJGyCGMz
8TaiFu1yaGuhvfYSM9g1NcxxGEK4nNMgp+MZsjSX5zRBH57ojknuvZwHsjRS3ofw
lFWMG8gGaunrNNuC7jHKRc68d9J3/PLVwXbYyXFHmRt3Q58/ec8gfavk6u+mrN6h
yyTqmec1bHLSCCofuQFFnlBJQXhAowu8FaqmtkuVFimeye3Epy6qHuh5SI408pPa
4LyElnk6VzdMb70AK1WAjDjMFtziXoZQzQTgyIur5T4oBtg0qVTtxblXh7GU0cjX
0DVqBrjpN4kemqhtZ+qNOq4Yn0xtOaqPdjpAt3h+lGTuQaJskBExuMlHEOh/ZBJo
cUctYon4QgJXLhbTct5RtI4T+Vz0hhRawVCG3h3BcBi6SvIrHGLipxW1TeopIuDG
jGg3ifudpBeZ1JEy0J1jiZucl5Sy/7n/0AsVDCVSdFq84RjPLka//CW+yWBcMMpJ
xJv0iNCbJA6JZuUISc8mBKQhkI6Z7U3DBh60DZcXqmqqbzhNpCpQUWAFuWZRuoEM
G8LcrGOFlc3TdZkLPTIHIzaXix6ic9X7ZT//pmbTAufeGWp2NOJALOVfDG1r9rv+
fKWI0MfH4OLTNHTrWGcbehGOh8+GaP0cyUv/O0j3sI0A17HNQzM=
=iy41
-----END PGP SIGNATURE-----

--y6pzhqfh5wkjxynx--
