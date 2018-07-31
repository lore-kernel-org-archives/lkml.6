Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE792208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0fDCauQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE792208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGaKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:52:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53566 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5UZwBIW7S3NpZ8DmRAnDwkmVrQbw4ELPeSjCQikn/JI=; b=0fDCauQhdJBhQFOtLJA+0GUxs
        UjSJ9DZyrnqdG1CeKEqOFEyrNrCaeiUl+4YtjbvWIfmwIXbjXK50I6Ab4HQk9MvjK8Hyq8U1AJP/T
        DTRPA3zRbJ8uxjdSevY2KvUkbfmONdXeYqAVjglRzE0BUVpq9YA9blVVYurtm4ik4K729OzdjY1Tf
        Pb93ZQ5XNuy+szE19qlGLPLOq+LGbx0XUZYiUDEfIfoZxBwsNYgImTQePyRgolnW2FUcOkZ0ayK1s
        M2Ben5/wmMxhha1jEhqwEEKf4XExCGNQlzIpzdX7CB9mb/Dw+1Y8dNXhlWftNWHjo/FN5KzwGSaSH
        8PCsFrqeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkQi3-0004pP-6c; Tue, 31 Jul 2018 09:12:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B82C62027585B; Tue, 31 Jul 2018 11:12:48 +0200 (CEST)
Date:   Tue, 31 Jul 2018 11:12:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180731091248.GS2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
 <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com>
 <20180730095502.GG2494@hirez.programming.kicks-ass.net>
 <1532961011.28585.30.camel@surriel.com>
 <20180730162653.GM2494@hirez.programming.kicks-ass.net>
 <1532999155.28585.56.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbjgUHX6eyHhY7pW"
Content-Disposition: inline
In-Reply-To: <1532999155.28585.56.camel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nbjgUHX6eyHhY7pW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 09:05:55PM -0400, Rik van Riel wrote:
> On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
> >=20
> > So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and therefore
> > ->active_mm =3D=3D ->mm.
>=20
> Close, but not true for kernel threads, which have a=20
> NULL ->mm, but a non-null ->active_mm that gets passed
> to enter_lazy_tlb().

I'm confused on the need for this. We mark the CPU lazy, why do we still
care about this?

--nbjgUHX6eyHhY7pW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAltgKBAACgkQdkfhpEvA
5LpkOA/9HofxxAGk4yCPZieMG6ZtvJtm03yMFVawa69JXBQjBPODAXoeU0tWK4vt
JmutdWiY+mOzjTxUpYXHDl2b1ZLolfOPRorFRYbSa9mEVbeYDBJjqNKqmOhnJon5
bylGhZKMENE7WoRO8uHXuN7sItUnLEH0c9HB2oo6ko2RnhmWleyMnO21TMmRa1Ru
QTQexQaWm1wyUc47Ja6qnhEzfcwfvcZkJ34Ng5WJMPjbc9QREuwJ5E3BDTEt+rNd
Mk0EWyoUXIIAT4gvrJtGREwNc8IctUzkWIu4p9vwtzlpPUdbVyi/6AQJZKKyxmKb
x+tHKtUaYD9PxUZVwj8KceG8IXyQzyZZrkxGSdIdm5HppUGiBwryUhOvnI9ohaY2
83XIoSmZDr9PBJxhOgwXBA3DUwBucKxkUhvSjUSXSkJQJsx8+t/cgMsLsrJtf4x+
nXpYBm6PgfWJpEDnqcpLk64ZzC67jZ4OyvAb6ChM1k5pYbtEZtTBu0T2u9vwdApv
JVpLRf4NM9B+ecESLs3Qa/QlmrQtMdDuEdElq5842jao/pZV7SHB3efDUrfiGcfF
b4etfMvtUCbmiTtyCLcWRzo+8fwskdsdpiNGqkfKwx8BnpiX2r3FvHNuaaV/DVqW
/5ZHjIESpZicSamhEx3wIxjRoi/54Tu5U8z5KSBeduP6OHjDE2g=
=3wx1
-----END PGP SIGNATURE-----

--nbjgUHX6eyHhY7pW--
