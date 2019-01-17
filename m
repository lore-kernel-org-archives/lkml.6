Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8954D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAQJjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:39:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36834 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:39:54 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 27DBF807A7; Thu, 17 Jan 2019 10:39:46 +0100 (CET)
Date:   Thu, 17 Jan 2019 10:39:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 14/17] mm: Make hibernate handle unmapped pages
Message-ID: <20190117093950.GA17930@amd>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20190117003259.23141-15-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> For architectures with CONFIG_ARCH_HAS_SET_ALIAS, pages can be unmapped
> briefly on the directmap, even when CONFIG_DEBUG_PAGEALLOC is not configu=
red.
> So this changes kernel_map_pages and kernel_page_present to be defined wh=
en
> CONFIG_ARCH_HAS_SET_ALIAS is defined as well. It also changes places
> (page_alloc.c) where those functions are assumed to only be implemented w=
hen
> CONFIG_DEBUG_PAGEALLOC is defined.

Which architectures are that?

Should this be merged to the patch where HAS_SET_ALIAS is introduced? We
don't want broken hibernation in between....


> -#ifdef CONFIG_DEBUG_PAGEALLOC
>  extern bool _debug_pagealloc_enabled;
> -extern void __kernel_map_pages(struct page *page, int numpages, int enab=
le);
> =20
>  static inline bool debug_pagealloc_enabled(void)
>  {
> -	return _debug_pagealloc_enabled;
> +	return IS_ENABLED(CONFIG_DEBUG_PAGEALLOC) && _debug_pagealloc_enabled;
>  }

This will break build AFAICT. _debug_pagealloc_enabled variable does
not exist in !CONFIG_DEBUG_PAGEALLOC case.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxATWYACgkQMOfwapXb+vLhEwCfboaaFJileFziF32t0acTiuuz
dewAn0oneo6RWHmnu+B3dnprdMW4dCOy
=4kpb
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
