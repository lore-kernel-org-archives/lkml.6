Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F39C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0C20811
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B0C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeKKWLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:11:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45097 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeKKWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:11:13 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D5120806D1; Sun, 11 Nov 2018 13:22:42 +0100 (CET)
Date:   Sun, 11 Nov 2018 13:22:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        sebastian.reichel@collabora.co.uk,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessm.com,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita 
        <jprvita@endlessm.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Message-ID: <20181111122243.GB28794@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
 <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
 <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-11-11 12:57:12, Hans de Goede wrote:
> Hi,
>=20
> On 11/7/18 5:53 AM, Daniel Drake wrote:
> >On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> >>Plus, I don't think "100% charge" is right test for "battery full". At
> >>least on thinkpads, there's configuration option, and it is common
> >>_not_ to charge batterry above 95% or so (to increase its lifetime).
> >
> >Hans also touched on this area in his response:
> >
> >>As for this kernel-side fix I do not believe that fixing thus in
> >>the kernel is the right thing to do. We try to stay away from
> >>heuristics using full_charge_capacity in the kernel since that
> >>is not really reliable / deterministic.
> >
> >I'm not fully convinced by this argument though.
> >
> >The ACPI spec is not very clear on what conditions you should apply to
> >decide when the battery is full. Instead, ACPI seems to provide a
> >pretty decent amount of data, and the decision about whether to
> >interpret that as "battery full" is left for consumers.
>=20
> Right, but in this case the "discharging" status bit is explicitly
> set, to me it feels wrong to report "full", when the firmware
> is reporting "discharging" IMHO, at best we are "not charging"
> (on AC, below the threshold where a new charge cycle starts) and
> that is what we are currently reporting.
>=20
> Anu heurstics to decide that "not charging" is close enough to full
> to report it as full to the user belongs in userspace IMHO.
>=20
> Anyways this ultimately is Rafael's call. If Rafael is ok with this
> patch then I would like to see Pavel's comment addressed and otherwise
> it is fine with me.
>=20
> Note that we will still often get the case where a laptop is charged,
> reports full, is unplugged for 5 minutes and then replugged and then
> reports a capacity of 97% combined with "not charging", so we will
> still need to fix userspace to handle this.

For the record, I don't think I'm okay with this.

There's nothing special about 100% charge.

This changes userland ABI and I don't think it has good enough reasons
to do that.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoHxMACgkQMOfwapXb+vIIUQCguwFYiFzv+drOvbVcJxSDgTjM
Br0AoLhAGWVQ+vX2BHEfgRYHRu6X1Cf/
=kwEp
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
