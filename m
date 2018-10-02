Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB4C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E8A2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gOH2g66T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E8A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJCFqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:46:16 -0400
Received: from ozlabs.org ([203.11.71.1]:39485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJCFqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:46:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PvkY4VwZz9s3x;
        Wed,  3 Oct 2018 09:00:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538521228;
        bh=uszHi0YP3NHd2A75uOyoWENmbNV/nKcyim4Q/kdSyq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOH2g66TFUBC5A5QiYzHieg0K/hofBu53ssIFUMikDjptaD6Tc2HaoUmGutekDf8s
         +zAn1bPRu04tHsktYoTZ5TmYGhzidu/AFyJt3+jBPV+zbr87bqhn41WIX0PlAeIpTV
         D697PmEzWDoD4owCHeddTAbdFX8DNR5ZS77UzEdDxOpJq3T0yoAO8Aunc/kwmmGdOe
         RlUre0miCEl9GV2xkjO6cGmMr855OhNggW60daykiOl8gHN+m88CNsHAVXukJbag1F
         PQOsgLJJhGkZrzSOWZ9FWdjgXkk6YIdGwTI00HuXybZdE37aTT6U9JQsNpIK/gbuOg
         FwLO9OWWPLLLA==
Date:   Wed, 3 Oct 2018 09:00:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, Ted Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Message-ID: <20181003090010.5150f914@canb.auug.org.au>
In-Reply-To: <20181002223652.GA4290@nautica>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
        <20181003071059.02b3fd6f@canb.auug.org.au>
        <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
        <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
        <20181002223652.GA4290@nautica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pi_fuJWlk3fcJlLoIKV/0xY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pi_fuJWlk3fcJlLoIKV/0xY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Wed, 3 Oct 2018 00:36:52 +0200 Dominique Martinet <asmadeus@codewreck.or=
g> wrote:
>
> Miguel Ojeda wrote on Wed, Oct 03, 2018:
> > As I have read, -next is supposed to be a vision of what the merge
> > window will look like after merging everything, i.e. ideally -rc1. For
> > that to work for files out-of-tree (like these ones, which are not
> > maintained by a single tree), changes should be allowed to be stacked
> > on each other; otherwise, we cannot handle conflicts :-( =20
>=20
> The rule is the same as with a regular mainline pull; I don't have the
> reference at hand but in some recent-ish pull request Linus said he
> prefers the stable version with the conflict, and optionally you can
> provide a second branch with the conflict resolved for reference, but
> the pull request should be based on something stable even if it has
> conflicts
>=20
> If there is a conflict Stefen will resolve it like Linus/Greg would, and
> the resolved bit will be carried over everyday so it's not much more
> work -- exactly like a regular pull request for inclusion in the main
> tree :)

Exactly what Dominique said.  I will fix up the conflict (unless it is
a very complex conflict, in which case the author(s) should help) and
the Linus (or Greg) will do the same.  If you do depend on a patch in
Andrew's series, what happens if that patch does not get sent to Linus
during the merge window or Linus rejects it?

--=20
Cheers,
Stephen Rothwell

--Sig_/Pi_fuJWlk3fcJlLoIKV/0xY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluz+HoACgkQAVBC80lX
0GwB6Af/QRmuvQ4ntPviR4hY99kAVf71n2hG+jM6yJp/+JjLvGaMxGSq+ZFAMk0V
qnVWGZKhMDjl8b1Z+UrEJU35kn5GoWIAIbaXsBSgGWo5Hc6Z9u3PDfF6/Z0pMUEw
KE8e8PS/1KVk24EBb5foc0l3VvVYKttUroqVfUglkYVgvizRV6kdzkMAbOaqdiVh
eMIWmB0ZxYoOyM2rAQt9ul4VhQLrLKiIPlzjUQa3pMJmcaHT38RuuZ/Cpv4M3L0a
uNbiOJCyY+hUp4Q6Twi69Srk9IWU5GdaSWwTOM0SvWRQhh1ge/K0mC+b21D8ANDh
utwC/WyGrQiXJcpRJKiQpefzWwcWbQ==
=9ecB
-----END PGP SIGNATURE-----

--Sig_/Pi_fuJWlk3fcJlLoIKV/0xY--
