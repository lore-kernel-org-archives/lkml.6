Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964A113C609
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C85020892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeG2TK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:10:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48052 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeG2TK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:10:28 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjpev-0000i2-Lr; Sun, 29 Jul 2018 13:39:09 -0400
Message-ID: <1532885949.28585.20.camel@surriel.com>
Subject: Re: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun, 29 Jul 2018 13:39:09 -0400
In-Reply-To: <E710FBA5-CC5E-4941-ACBF-4AB3424F1F68@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-4-riel@surriel.com>
         <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
         <1532865634.28585.2.camel@surriel.com>
         <E710FBA5-CC5E-4941-ACBF-4AB3424F1F68@amacapital.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YJ6J6367Vg/8hmVEmuKY"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YJ6J6367Vg/8hmVEmuKY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-07-29 at 08:36 -0700, Andy Lutomirski wrote:
> On Jul 29, 2018, at 5:00 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
> > On Sat, 2018-07-28 at 19:57 -0700, Andy Lutomirski wrote:
> > > On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
> > > wrote:
> > > > Introduce a variant of on_each_cpu_cond that iterates only over
> > > > the
> > > > CPUs in a cpumask, in order to avoid making callbacks for every
> > > > single
> > > > CPU in the system when we only need to test a subset.
> > > Nice.
> > > Although, if you want to be really fancy, you could optimize this
> > > (or
> > > add a variant) that does the callback on the local CPU in
> > > parallel
> > > with the remote ones.  That would give a small boost to TLB
> > > flushes.
> >=20
> > The test_func callbacks are not run remotely, but on
> > the local CPU, before deciding who to send callbacks
> > to.
> >=20
> > The actual IPIs are sent in parallel, if the cpumask
> > allocation succeeds (it always should in many kernel
> > configurations, and almost always in the rest).
> >=20
>=20
> What I meant is that on_each_cpu_mask does:
>=20
> smp_call_function_many(mask, func, info, wait);
> if (cpumask_test_cpu(cpu, mask)) {
>    unsigned long flags;
>    local_irq_save(flags); func(info);
>    local_irq_restore(flags);
> }
>=20
> So it IPIs all the remote CPUs in parallel, then waits, then does the
> local work.  In principle, the local flush could be done after
> triggering the IPIs but before they all finish.

Sure, moving the function call for the local CPU
into smp_call_function_many might be a nice optimization.

A quick grep suggests it touch stuff all over the tree,
so it could be a nice Outreachy intern project :)

--=20
All Rights Reversed.
--=-YJ6J6367Vg/8hmVEmuKY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltd+70ACgkQznnekoTE
3oM6xAf+LW3b7ytQ/AWHWbd/6imsPNnK7yJLQf6DN8SbORaONdPYkisg+8O0sHdM
5uyNh6LxZqHRGuL5pk4cVLeAVXvDxcjV0gb45yd3ieN1GyOyVGMyO3eV0huPhlGB
J26NfMJ4+wCKRwn9ZVclq3g9iUgZeUxb12aYqPam/aUKZ0HbbaF+VXhOxigqx7Pf
g/uM+Sp3M/4AZbmRwRfovsxiu7h0yY9C+BOf/SVLiR1wNkD6DhfWOWHCdqdfWYqT
wOGtt5SeGKobWa6NW+A6QBGyG+Rk5r7UnaUlnyo4+Vgc5pjP9+xXT2CxDgXB+tM3
d24Fwim3Cm8oVGoT+rYpX7ne8M9iNg==
=BNtc
-----END PGP SIGNATURE-----

--=-YJ6J6367Vg/8hmVEmuKY--

