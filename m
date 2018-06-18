Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E35FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB26820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Et2pugS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB26820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbeFREww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:52:52 -0400
Received: from ozlabs.org ([203.11.71.1]:51399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeFREwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:52:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418Jcb32bFz9s19;
        Mon, 18 Jun 2018 14:52:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529297569;
        bh=IbUwjOT7XkQoHbO/poxdscWaOnabfkhsCC6FnLHcPOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Et2pugS8ioU9PeYy+6t0z2ik4/U1JBAXeySMR5LArFlC4ovNQ6nsBVYrXIwsHR7tw
         yI4qkNY65Yhg/wKUbAhu/CVCy1cxM4E0dGiCWhK7z136rA/qRe2br7XwSFu70UIKa8
         xHL3TnhAy5PAzJ2+ThQvrJQIYOJu4PaOyLj0sQqzozna4ylzYsXqwhFCHMBDr1guu8
         aOGufbUvbEAJgeaSJ7djY9EEoNz5lpRyJNR3PJdomyfuzCrPipFT/F0n1pHL1G2Ey6
         7KKF1N67Cs/UmjDBUEqAZyill+b4Qjp/O6eF4IHu1SWf5QTStpzLwiBG/A14EhO/sp
         MmHOfDzW8VBow==
Date:   Mon, 18 Jun 2018 14:52:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: what trees/branches to test on syzbot
Message-ID: <20180618145246.7e143279@canb.auug.org.au>
In-Reply-To: <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
        <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
        <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
        <873735n3dy.fsf@xmission.com>
        <20180116173440.GA15893@kroah.com>
        <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
        <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
        <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
        <20180610015107.GC5020@thunk.org>
        <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
        <20180611012250.GD5020@thunk.org>
        <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vokJnPJiC/RY+Iik7_Ox5pl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vokJnPJiC/RY+Iik7_Ox5pl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, 15 Jun 2018 11:54:16 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Re backwards bisection (when bug is introduced), we can actually test
> linux-next-history instead of linux-next, right?

I don't see why using linux-next-history would be any better, it just
contains all the linux-next releases while the linux-next tree contains
the last 3 months worth.

--=20
Cheers,
Stephen Rothwell

--Sig_/vokJnPJiC/RY+Iik7_Ox5pl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnOp4ACgkQAVBC80lX
0GwCMgf/fwfAXLhXEKHOGrZrGQG8ai8ev6yibBw5a+qABsGmHvR34HNszTNHIcgQ
Kfqgl1yuQJXQyGvtwg70JbfkxvNs1ktg62Xlc2oa6CDQpiUKUfF5EgCuGG880wUa
9mpe4bDT7wXUOgi0JugMgY5Mdcg1Ys/QfjxDvbEJSeMOoxb6LRI1OONvvQDHpwIW
r6m0Fs8d+xan8oBUoJZU04ZddyvpvN8VynQnhZXONOCY02x+Tr7qsCBWAmUBIrI5
taUbYq0ZtIps5n2bOXZIbuFmtwLs6LKHR8ogg2PdAhizX765oO7Gz8r7SdnAiEYQ
a84izGXfR7/E+vA+SaSDMU0SQQIj1A==
=D18L
-----END PGP SIGNATURE-----

--Sig_/vokJnPJiC/RY+Iik7_Ox5pl--
