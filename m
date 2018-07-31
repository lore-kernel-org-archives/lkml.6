Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECCA208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hm00SGsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECCA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbeGaQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:53:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeGaQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LZrG/HBVTb6pRuNydeR96f+sCwecTiVcU6sodqu+3ck=; b=hm00SGsYEzDZCaQ6WQFffhc0b
        sCZzzXVN3bFDc5VHElk9qZtLJIH/COrFZSJUdMzhQsgSz2tujadE7wHxsihc3lV6Y6IAr7HUSiuCi
        Cs+HdhT8hGC/6dpu7xlA5Knmu7xBzjesZjrkTeXeBsYHfdeho6Tg/sBYMhgXB/u2skCWjuS/gZB2W
        j4v/JOVmJK9eE5fNMVsoy5LY/YChZQb2Hi6Kw/0nCvbj6q08Rtoe1dsN6otkPcS8arYnQEk9eVLV/
        LolVk/ougR0q95SgIxjupmJuv2cKq5yea1MtcEmxGOUb6U/7+rVXpwVMybn69A4Q8rLbl6CFaIBly
        suaikFigg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkWKJ-0006dA-QN; Tue, 31 Jul 2018 15:12:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E40A2006F9D2; Tue, 31 Jul 2018 17:12:41 +0200 (CEST)
Date:   Tue, 31 Jul 2018 17:12:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180731151241.GF2458@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com>
 <20180730095502.GG2494@hirez.programming.kicks-ass.net>
 <1532961011.28585.30.camel@surriel.com>
 <20180730162653.GM2494@hirez.programming.kicks-ass.net>
 <1532999155.28585.56.camel@surriel.com>
 <20180731091248.GS2494@hirez.programming.kicks-ass.net>
 <C9664A02-AD53-4A6A-8A56-E729DC919E16@amacapital.net>
 <1533049383.28585.61.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <1533049383.28585.61.camel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 11:03:03AM -0400, Rik van Riel wrote:
> On Tue, 2018-07-31 at 07:29 -0700, Andy Lutomirski wrote:
> > > On Jul 31, 2018, at 2:12 AM, Peter Zijlstra <peterz@infradead.org>
> > > wrote:
> > >=20
> > > > On Mon, Jul 30, 2018 at 09:05:55PM -0400, Rik van Riel wrote:
> > > > > On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
> > > > >=20
> > > > > So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and
> > > > > therefore
> > > > > ->active_mm =3D=3D ->mm.
> > > >=20
> > > > Close, but not true for kernel threads, which have a=20
> > > > NULL ->mm, but a non-null ->active_mm that gets passed
> > > > to enter_lazy_tlb().
> > >=20
> > > I'm confused on the need for this. We mark the CPU lazy, why do we
> > > still
> > > care about this?
> >=20
> > I have considered renaming enter_lazy_tlb() to something like
> > lazy_switch_to_kernel_mm() (or an irqs_off variant) and making it
> > take no parameters or maybe just task pointer parameters.=20
>=20
> Of all the architectures, only Alpha uses the "mm"
> parameter to enter_lazy_tlb.
>=20
> It uses it to store the pgd address of the current
> active_mm context into the thread info of the next
> task.
>=20
> If it can get that from a per CPU variable, we can
> get rid of the mm parameter to enter_lazy_tlb.

We only really care for arches that select this new ARCH_NO_ACTIVE_MM
thingy. And x86 (the only one so far) really doesn't give a crap about
the argument.

We should just list/document that being one of the requirements for
selecting that symbol. All this will need semi decent documentation
anyway, otherwise the poor sod trying to understand this all in about 6
months time will go crazy :-)

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAltgfGkACgkQdkfhpEvA
5LrwMBAAtBUwCV4fqftsf0JPXHdMO3zqb76DLMO/pi8jObV09gf4RVta+mum4I8J
AaU7s76zhv3GHO3YSN6Ep6EJ1epnujbvGR9ifIE8wbfUWn7zSba3eyDAeb9+g/q1
z8+vOyciKsMJojJEljNMJkTb7u6bUlrtY2X+3esjIHIEFsftUw2qfmeTC4ZZLaI+
dPAWntSstVXSrsySecN1NplcftplEbrzr7OsUVq/PT43Su5DQWlNsMdAfM0Bj98c
ysTFIY4+stW3JuB+7AenqZc6is4LwNg26zl58auVLodqcpim96/gUJQR3uw1ecTq
ZL/oZMj3B7vy6Aq5qrks2hGDeR4rw4txQF4lUgmOz2Smb96cH0tgqaIDDDPziDhB
SRopwNEovp/2zcNFGU4ifTchyqyzSPxA8yN8UnvDrtsvx9dBwh367RWphXKQZXWg
DZ9hPyG/VQLIB2a62C8/zUahYMZ+5WFiGnGH1YBDPu84OVibibTxl1V0Yod/VdWJ
5lE6CYstvr43V1uenxvB/kjdsZ4lPLkzW/8o6YACU4rH2ZafjMc288b0TZUjmEGw
Ea3o/Wvb37dGrcxrKvN/928KsrnBUHs5j4O+83dNFvtCuYsDPFSOxctCFfv3edVA
TWnd3OF6k59+H4laIAD/VXUX7zAsfz4CsRzXnXpdEDlhyyeqIbc=
=MnU6
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
