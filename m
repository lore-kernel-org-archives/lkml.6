Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FC520870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FC520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbeKTKYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:24:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35430 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeKTKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:24:00 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3B2B28090E; Tue, 20 Nov 2018 00:57:46 +0100 (CET)
Date:   Tue, 20 Nov 2018 00:57:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kyungtae Kim <kt0755@gmail.com>, pavel.tatashin@microsoft.com,
        osalvador@suse.de, rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181119235748.GC7367@amd>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <20181113094305.GM15120@dhcp22.suse.cz>
 <20181113151503.fd370e28cb9df5a0933e9b04@linux-foundation.org>
 <d88fae5c-e12d-ca35-d200-587a2ff02ec9@suse.cz>
 <20181113153204.ea0c0895866838de9e3bc8d0@linux-foundation.org>
 <1f4439c8-d669-a1ac-53f5-36c04da72a51@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <1f4439c8-d669-a1ac-53f5-36c04da72a51@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> >>>> --- a/mm/page_alloc.c
> >>>> +++ b/mm/page_alloc.c
> >>>> @@ -4364,6 +4353,15 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsign=
ed int order, int preferred_nid,
> >>>>  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocati=
on */
> >>>>  	struct alloc_context ac =3D { };
> >>>> =20
> >>>> +	/*
> >>>> +	 * There are several places where we assume that the order value i=
s sane
> >>>> +	 * so bail out early if the request is out of bound.
> >>>> +	 */
> >>>> +	if (unlikely(order >=3D MAX_ORDER)) {
> >>>> +		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> >>>> +		return NULL;
> >>>> +	}
> >>>> +
> >>>
> >>> I know "everybody enables CONFIG_DEBUG_VM", but given this is fastpat=
h,
> >>> we could help those who choose not to enable it by using
> >>>
> >>> #ifdef CONFIG_DEBUG_VM
> >>> 	if (WARN_ON_ONCE(order >=3D MAX_ORDER && !(gfp_mask & __GFP_NOWARN)))
> >>> 		return NULL;
> >>> #endif
> >>
> >> Hmm, but that would mean there's still potential undefined behavior for
> >> !CONFIG_DEBUG_VM, so I would prefer not to do it like that.
> >>
> >=20
> > What does "potential undefined behavior" mean here?
>=20
> I mean that it becomes undefined once a caller with order >=3D MAX_ORDER
> appears. Worse if it's directly due to a userspace action, like in this
> case.

We should really check if value from userspace is sane _before_
passing it to alloc_pages(). Anything else is too fragile. Maybe
alloc_pages should do the second check, but...

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvzTfwACgkQMOfwapXb+vJrxQCfQWRQidsCidtn9kylt9QlaV9b
HX8AoJNp4zXtXxXm0nbOi7G27O/MZVJy
=y6KK
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
