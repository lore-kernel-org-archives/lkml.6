Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D7220859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550688278;
	bh=38gbWeL3FpimOfwmNpIuqvoslwNfb1vUXulpJHE65fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EEuN+xN4A3wJd1puHhfTuEAjDscrwt26SCePEMA7730ICp6KSUIWONrHFj0utoPlM
	 0Jv/pU2nJ0kXcOY0xef0DwTk+QAyv3u7aWoiucmqic/ye+K9tmyA4uOR86cLFPkAMx
	 EqVRFX5r58caKDsUkPQnVxSAnNN7932WmYDdAd1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBTSoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:44:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hV3H+2ZQmuY54Jacm/DIGEhaOiWr0C1HyO3Gx2OM4Dw=; b=PjRWEXZm7ktAvdo3u8Dd8leYz
        tAmd7JpbOa45g7GDpZ0PrfXe+xDCjlSso2W1swYqtLWuUVzQI7N9HC49p5RqIfNPRaa+AbXykhlo9
        2Ouy5kOQ1BG7jb55Bmka7BdFQqBrpIs0bn6UkQqrhvY8tG2Qh1O7+4SJQgEJbLMwxPHVY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwWqn-0005jT-An; Wed, 20 Feb 2019 18:44:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BC90D112882B; Wed, 20 Feb 2019 18:44:08 +0000 (GMT)
Date:   Wed, 20 Feb 2019 18:44:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
Message-ID: <20190220184408.GG9878@sirena.org.uk>
References: <20190219214940.391081-1-arnd@arndb.de>
 <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com>
 <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
X-Cookie: Is this TERMINAL fun?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2019 at 10:07:36AM -0800, Nick Desaulniers wrote:

> I like Evgenii's idea:
> https://bugs.llvm.org/show_bug.cgi?id=38809#c10

That's a suggestion to tune the inlining heuristics.

> While I myself share Arnd's goal of driving compiler warnings to zero,
> in general I'd prefer not to disable warning-producing-features or
> disable warnings outright for cases where we have some ideas of
> changes we can make to the compiler.  There's probably a list now of
> false warnings produced by old versions of Clang from bugs in Clang
> that we fixed.  I'm not interested in additionally trying to work
> around those somehow in kernel sources.

We do have infrastructure in the kernel for managing warnings based on
compiler version (Arnd was looking at some improvements to that IIRC),
if we've got a kernel that builds with a given compiler it's worth
looking at tuning what we do with that compiler.  If newer versions of
the compiler work better or have new options we can turn things on for
them.

> Qian previously pointed out that most drivers don't produce this
> warning under KASAN+Clang.  While 114 is a lot, what are the chances
> that someone NEEDS a KASAN+Clang build to compile warning free and
> happen to include one of these problematic drivers?  And if there is a
> chance they do observe the warning, are we doing a disservice by
> disabling the feature (-asan-stack=1) outright for the whole kernel,
> or disabling the warning (`-Wstack-frame-larger-than=`) which can flag
> issues unrelated to KASAN?

People doing treewide work and subsystem maintainers are a reasonably
important target for this sort of thing - for example people looking at
the kernelci output.  It's a lot easier to pay attention to problems if
you don't have to wade through large numbers of false positives.

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtn/cACgkQJNaLcl1U
h9Deswf9H9pJOYoYI9o2QYvAD2umHwK6sm4BMofiKM7joL+JwpcjRAdzX3KRWxkd
aiEOWHFnQb3d/vFeviMrDP4Ae6/lNVRiZunACiuSEdKKqCEFVsAaZVF45gOCL7SB
0ueazdJP3UqjcSV609M7msi1wrtG4i5D7M+9EWqSCozCgPGJ0WQ8rSg4keM0qZx1
CtD85T09ZfUtuaBAIFL1EpEO0D193eQz3mhnc/W438MyCiwDhg2q00NNMdWKGgfI
18xZpfNoKFaTHvYYhpvmGlOmB2+mtgoomE7FIGmrVJl4sHOAT+DCnBM6yZ/Lf4Y9
4cYZEC5YKBCb4HjUtEB1aCKJRv91WA==
=DFZI
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
