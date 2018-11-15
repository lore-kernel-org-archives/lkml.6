Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D4621582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeKORy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:54:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48522 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeKORy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:54:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8D2B180691; Thu, 15 Nov 2018 08:48:08 +0100 (CET)
Date:   Thu, 15 Nov 2018 08:48:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 6/6] PM / Hibernate: exclude all PageOffline() pages
Message-ID: <20181115074810.GA9055@amd>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20181114211704.6381-7-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-14 22:17:04, David Hildenbrand wrote:
> The content of pages that are marked PG_offline is not of interest
> (e.g. inflated by a balloon driver), let's skip these pages.
>=20
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index b0308a2c6000..01db1d13481a 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zo=
ne *zone, unsigned long pfn)
>  	BUG_ON(!PageHighMem(page));
> =20
>  	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
> -	    PageReserved(page))
> +	    PageReserved(page) || PageOffline(page))
>  		return NULL;
> =20
>  	if (page_is_guard(page))
> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone=
, unsigned long pfn)
>  	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>  		return NULL;
> =20
> +	if (PageOffline(page))
> +		return NULL;
> +
>  	if (PageReserved(page)
>  	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>  		return NULL;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvtJLoACgkQMOfwapXb+vIKwQCgqMCGJ4BEWmMsp5gihD0MR/cx
lFwAnAqKSOIHgjFwhl+uKuaItXeOXj2x
=TTZ/
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
