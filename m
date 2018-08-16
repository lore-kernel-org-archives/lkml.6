Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C78C21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C78C21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeHPI15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:27:57 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36210 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeHPI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:27:56 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fqAt2-0008Ew-Cj; Thu, 16 Aug 2018 01:31:56 -0400
Message-ID: <1534397515.28585.138.camel@surriel.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Date:   Thu, 16 Aug 2018 01:31:55 -0400
In-Reply-To: <CALCETrWhb4CU8BfjdYBe+QJ8CVa4pzAr3ME+HBe4=6y=Pi9pFQ@mail.gmail.com>
References: <20180716190337.26133-1-riel@surriel.com>
         <20180716190337.26133-3-riel@surriel.com>
         <CALCETrWhb4CU8BfjdYBe+QJ8CVa4pzAr3ME+HBe4=6y=Pi9pFQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2oDqfEy2y4FE1XCEbp4U"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2oDqfEy2y4FE1XCEbp4U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-15 at 18:54 -0700, Andy Lutomirski wrote:
> On Mon, Jul 16, 2018 at 12:03 PM, Rik van Riel <riel@surriel.com>
> wrote:

> Hi Rik-
>=20
> I was looking through this, and I see:
>=20
> > -static void tlb_remove_table_one(void *table)
> > +static void tlb_remove_table_one(void *table, struct mmu_gather
> > *tlb)
> >  {
> >         /*
> >          * This isn't an RCU grace period and hence the page-tables=20
> > cannot be
> > @@ -344,7 +348,7 @@ static void tlb_remove_table_one(void *table)
> >          * It is however sufficient for software page-table walkers
> > that rely on
> >          * IRQ disabling. See the comment near struct
> > mmu_table_batch.
> >          */
> > -       smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> > +       smp_call_function(tlb_remove_table_smp_sync, tlb->mm, 1);
> >         __tlb_remove_table(table);
> >  }
>=20
> But tlb_remove_table() doesn't always call
> tlb_remove_table_one().  Do
> the other paths through tlb_remove_table() do the right thing?

Urghhh, reading through the code it seems that
I got one case wrong.

The obvious cases, where tlb->mm->mm_users >=3D 2,
are both correct. The functions tlb_remove_table_one()
and tlb_table_flush() both get rid of lazy TLB users
of the MM.

However, there is one case where we don't but should:
        /*
         * When there's less then two users of this mm there cannot be
a
         * concurrent page-table walk.
         */
        if (atomic_read(&tlb->mm->mm_users) < 2) {
                __tlb_remove_table(table);
                return;
        }

I guess the obvious fix is to call tlb_flush_remove_tables()
in the branch above. The first time it might shoot down a CPU
in lazy TLB mode, while the second time it is called that CPU
will have already switched to init_mm and no IPI is sent.

Alternatively, we could always do the batching, even when
mm_users is 1, and examine the bitmap with the other CPUs
less frequently in the exit path.

I can send in a patch for this tomorrow, or early next week,
depending on what other stuff comes up...

--=20
All Rights Reversed.
--=-2oDqfEy2y4FE1XCEbp4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlt1DEwACgkQznnekoTE
3oNk1gf/cEh6uBKvwp6xXUbkRLFNCumPKvLsRxYFUNwP/VQJAEEHl1pRv56Wg+RS
YM4+KAWRaEJN/EhQT12zQseQsVzGO1KnRUTfOMQydZ4oONVTWHZCf1xX8ORVuLTM
IPd+BBoOypfZO/AvBlKoqOYgC+WHAnMUnT0yTSKO1zptbdaYnxJTMOYqvxXOtC/P
mj+EkZx3QjlvwXHdijTMPByCNAmxIhViRjxFAKMUfy+64w+tGhcA9bQ3ZEJw7SlU
IZQGv5+xZgh2V2gTjNoVZSYd99V3CbFux6t0qx5NUJW6zwzAZMbzYyGyAMhu+Wec
X6o/mLAAm9VkPgfLL5SkTre3Ag4Bgw==
=IWLL
-----END PGP SIGNATURE-----

--=-2oDqfEy2y4FE1XCEbp4U--

