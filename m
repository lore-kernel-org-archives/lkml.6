Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA928208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA928208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH0RXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:23:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50090 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeH0RXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:23:46 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fuHhK-0007z0-MT; Mon, 27 Aug 2018 09:36:50 -0400
Message-ID: <405ba257e730d4f0ad9007490e7ac47cc343c720.camel@surriel.com>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
From:   Rik van Riel <riel@surriel.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Mon, 27 Aug 2018 09:36:50 -0400
In-Reply-To: <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
References: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
         <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
         <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
         <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
         <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
         <20180823133958.GA1496@brain-police>
         <20180824084717.GK24124@hirez.programming.kicks-ass.net>
         <20180824113214.GK24142@hirez.programming.kicks-ass.net>
         <20180824113953.GL24142@hirez.programming.kicks-ass.net>
         <20180827150008.13bce08f@roar.ozlabs.ibm.com>
         <20180827074701.GW24124@hirez.programming.kicks-ass.net>
         <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CjA5zgmeZESrmuJDh+sg"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CjA5zgmeZESrmuJDh+sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-08-27 at 18:04 +1000, Nicholas Piggin wrote:

> It could do that. It requires a tlbie that matches the page size,
> so it means 3 sizes. I think possibly even that would be better
> than current code, but we could do better if we had a few specific
> fields in there.

Would it cause a noticeable overhead to keep track
of which page sizes were removed, and to simply flush
the whole TLB in the (unlikely?) event that multiple
page sizes were removed in the same munmap?

Once the unmap is so large that multiple page sizes
were covered, you may already be looking at so many
individual flush operations that a full flush might
be faster.

Is there a point on PPC where simply flushing the
whole TLB, and having other things be reloaded later,
is faster than flushing every individual page mapping
that got unmapped?

--=20
All Rights Reversed.

--=-CjA5zgmeZESrmuJDh+sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluD/nIACgkQznnekoTE
3oPuoAgAgYYUxuaSllsIwNGF9TwctKvO64J9eWJukeqnJu357LE/C4ku0xwCXmhV
51RiEMNOpnTEQ/DWfPXjnCzY/Uah4nBXPTIwBjHCKC57tJGcIt1V9PsvnyRgtBDR
hf05gT/oO+Cuj4KAATK5gjfUpuNt3w/xg3Gsoxqv7fRcDH5czAu74JpSY1U1IrGP
Ck2UVC9AARlmeAhnonEnBw+dFkZsMgIvIZyvVSY9ZL01r3zdXuieEzeeDRV8t4IG
w0ccBoWSO07Si+zZNrvk7Bo3SpHolzZbov8SLGqi1jnNplO25xw/Fkx2kVgMMXmB
aTdmEoWMISm8Gr7LshmkZ1RhAVQWrA==
=vAtB
-----END PGP SIGNATURE-----

--=-CjA5zgmeZESrmuJDh+sg--

