Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6DC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC09427880
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC09427880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936745AbeF2Q4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:56:30 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35262 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbeF2Q43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:56:29 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fYwh6-0002bk-5Y; Fri, 29 Jun 2018 12:56:24 -0400
Message-ID: <1530291383.16379.6.camel@surriel.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, mingo@kernel.org,
        kernel-team@fb.com, tglx@linutronix.de, efault@gmx.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Fri, 29 Jun 2018 12:56:23 -0400
In-Reply-To: <75090b06-fd6f-eeaa-4cb8-8373673c8a5d@linux.intel.com>
References: <20180629142918.26601-1-riel@surriel.com>
         <20180629142918.26601-3-riel@surriel.com>
         <75090b06-fd6f-eeaa-4cb8-8373673c8a5d@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+maaLCvcuMBij16/K25k"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+maaLCvcuMBij16/K25k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-29 at 09:39 -0700, Dave Hansen wrote:
> On 06/29/2018 07:29 AM, Rik van Riel wrote:
> > The latter problem can be prevented in two ways. The first is to
> > always send a TLB shootdown IPI to CPUs in lazy TLB mode, while
> > the second one is to only send the TLB shootdown at page table
> > freeing time.
>=20
> I've read this a few times, and I keep having to remind myself why we
> "always send a TLB shootdown IPI to CPUs in lazy TLB mode".  It's not
> strictly CPUs in lazy TLB mode, right?  It's just the one that are in
> lazy TLB mode _and_ using the mm from which we are freeing page
> tables.
>=20
> If you revise these again, would it make sense to add a little blurb
> like:
>=20
> 	CPUs in lazy TLB mode are using the "wrong" page tables,
> 	generally from a process's mm while running true kernel code
> 	like the idle task.  This is just as problematic when freeing
> 	page tables from that mm as a real non-lazy user of the page
> 	tables would be.

If we get to a v4, I will do that.

> > The second should result in fewer IPIs, since operationgs like
> > mprotect and madvise are very common with some workloads, but
> > do not involve page table freeing. Also, on munmap, batching
> > of page table freeing covers much larger ranges of virtual
> > memory than the batching of unmapped user pages.
>=20
> Doesn't this also result in fewer IPIs because it *removes* the
> processor from the mm_cpumask(mm) and won't send IPIs to it any more?
> As it stood before, we'd IPI a lazy CPU over and over, but this way
> we
> just do it once, switch to another mm, and never touch for this mm
> again
> (unless that CPU becomes non-lazy and switches to that mm again).

With this patch series, we never remove a CPU from
the mm_cpumask(mm) while in lazy TLB mode, but we=20
also do not send TLB shootdowns too CPUs in lazy TLB
mode, unless we are freeing page tables - when that
happens, the CPU will remove itself from the mm_cpumask.

--=20
All Rights Reversed.
--=-+maaLCvcuMBij16/K25k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAls2ZLcACgkQznnekoTE
3oOFBQf+J3jNdDfT64L+/rk1Y9ioufhBq24m8BQ7F3xn6ZxXI4iQ+I2S8Xti70BB
9elCkyZvr1McY9SK36g4qeFK6/FaTDeXdOEmc0phSzIiNSenQdJ+gkE3l+vX/yTS
oiFuLoBW6DbveeQXMTEYJkpCHUUnsnRgzbXvezmE7241CCBFi6GzfmEMqhoPAcXv
Zt+HbmBYTEH7B2BAg3IgGVtRPeGuI9K9C1eaTAoLqw9DBitkO44OUbxkdjXSaDge
/uHdowqM0GKDViBFmaABzDsCft/cQD6cNdLQsWiRI5YpOwpv+HZW3wvJB3gKQQbV
bZSd8Zy8gmtdzn8cfQ2e5aCHkUnbqw==
=p9Vf
-----END PGP SIGNATURE-----

--=-+maaLCvcuMBij16/K25k--

