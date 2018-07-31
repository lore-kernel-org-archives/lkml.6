Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC574C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8871B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8871B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeGaQoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:44:04 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58124 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeGaQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:44:04 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkWAy-0005Hk-21; Tue, 31 Jul 2018 11:03:04 -0400
Message-ID: <1533049383.28585.61.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue, 31 Jul 2018 11:03:03 -0400
In-Reply-To: <C9664A02-AD53-4A6A-8A56-E729DC919E16@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
         <1532961011.28585.30.camel@surriel.com>
         <20180730162653.GM2494@hirez.programming.kicks-ass.net>
         <1532999155.28585.56.camel@surriel.com>
         <20180731091248.GS2494@hirez.programming.kicks-ass.net>
         <C9664A02-AD53-4A6A-8A56-E729DC919E16@amacapital.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DQXFWMDZjKgxDx2ESj82"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DQXFWMDZjKgxDx2ESj82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-07-31 at 07:29 -0700, Andy Lutomirski wrote:
> > On Jul 31, 2018, at 2:12 AM, Peter Zijlstra <peterz@infradead.org>
> > wrote:
> >=20
> > > On Mon, Jul 30, 2018 at 09:05:55PM -0400, Rik van Riel wrote:
> > > > On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
> > > >=20
> > > > So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and
> > > > therefore
> > > > ->active_mm =3D=3D ->mm.
> > >=20
> > > Close, but not true for kernel threads, which have a=20
> > > NULL ->mm, but a non-null ->active_mm that gets passed
> > > to enter_lazy_tlb().
> >=20
> > I'm confused on the need for this. We mark the CPU lazy, why do we
> > still
> > care about this?
>=20
> I have considered renaming enter_lazy_tlb() to something like
> lazy_switch_to_kernel_mm() (or an irqs_off variant) and making it
> take no parameters or maybe just task pointer parameters.=20

Of all the architectures, only Alpha uses the "mm"
parameter to enter_lazy_tlb.

It uses it to store the pgd address of the current
active_mm context into the thread info of the next
task.

If it can get that from a per CPU variable, we can
get rid of the mm parameter to enter_lazy_tlb.

--=20
All Rights Reversed.
--=-DQXFWMDZjKgxDx2ESj82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltgeicACgkQznnekoTE
3oOMuQf+NvhhBuYetEXNK5AdU/ugbzw3iuR8K0zUViFXScPrJ9v0pHyYrdHZeXaG
DgQWeoOb4MK+qrFUGmlew3jXiemwiyG4iJv15iaOnNUULVeOhcIA3s+OkG9vUYHi
tx60eYvsj1sfvlwzB826Bln+E3JpB8fzx3WCVGlsKR6Rw1WGmmlX3gg9tU8abPkk
KwZdt0SVQLrRGfkes7mlLYvR8Pr/AJugLu4GXAD68exrEM12QH332wmMNA8wAeWE
Z0cRL10mDXIMJ691bWrjXw5rdHjRjLrNJckhqQnLwNm2PYAbC9BJ6kc6OD2Jz5hW
MHDgONbx/qjxUD/CHcMlK2/dw5WOWg==
=T/cJ
-----END PGP SIGNATURE-----

--=-DQXFWMDZjKgxDx2ESj82--

